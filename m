From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 16:57:32 +0200
Organization: eudaptics software gmbh
Message-ID: <46CC4EDC.F7A4FBEA@eudaptics.com>
References: <46CC3090.7080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 16:57:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INreZ-0003qV-W4
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 16:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759541AbXHVO5s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 10:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759460AbXHVO5s
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 10:57:48 -0400
Received: from main.gmane.org ([80.91.229.2]:36055 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758860AbXHVO5r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 10:57:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INreQ-0006bI-PX
	for git@vger.kernel.org; Wed, 22 Aug 2007 16:57:43 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 16:57:42 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 16:57:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56386>

Carlos Rica wrote:
> 
> This is the first version of the program "builtin-reset.c",
> intended for replacing the script "git-reset.sh".

You are my hero, Carlos!

git-reset.sh is the prominent script that does not grok "master@{1}" on
MinGW (because of mysterious bogus quoting of the braces). This should
be solved with this conversion to C code.

-- Hannes
