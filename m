From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 1/2] git-submodule: move cloning into a separate function
Date: Tue, 05 Jun 2007 12:40:50 +0200
Organization: eudaptics software gmbh
Message-ID: <46653DB2.997A3ABD@eudaptics.com>
References: <11810357523435-git-send-email-hjemli@gmail.com> <11810357522478-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 12:40:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvWSG-0008Dl-8J
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763698AbXFEKjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763911AbXFEKjx
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:39:53 -0400
Received: from main.gmane.org ([80.91.229.2]:39449 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763698AbXFEKjw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 06:39:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HvWS4-0002XZ-8r
	for git@vger.kernel.org; Tue, 05 Jun 2007 12:39:48 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 12:39:48 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 12:39:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49189>

Lars Hjemli wrote:
> +               module_clone "$path" "$url" || exit $?

Minor nit: The idiom that is commonly used in situations like this (see
other git-* shell scripts):

		module_clone "$path" "$url" || exit

because exit without argument uses the code of the last command
executed.

-- Hannes
