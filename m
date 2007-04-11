From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW port of git downloadable from anywhere?
Date: Wed, 11 Apr 2007 08:35:24 +0200
Organization: eudaptics software gmbh
Message-ID: <461C81AC.68B64068@eudaptics.com>
References: <461C14D6.8080904@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:40:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbX1u-0005N6-TK
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 09:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbXDKHOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 03:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbXDKHOH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 03:14:07 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8756 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbXDKHOF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 03:14:05 -0400
X-Greylist: delayed 2333 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Apr 2007 03:14:05 EDT
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.44)
	id 1HbWQ6-0003ll-CW; Wed, 11 Apr 2007 08:35:06 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0A3C36D7; Wed, 11 Apr 2007 08:35:06 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: -0.7 (/)
X-Spam-Report: AWL=-0.733, BAYES_50=0.001
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44211>

"H. Peter Anvin" wrote:
> Just wondering if there is a canonical place to download the MinGW port
> of git for non-git users... ideally precompiled, since a lot of Windows
> users probably won't have MinGW installed?  Or is the port too fragile
> for that, still?

There is no such place, yet. Some work is still that makes the toolset
relocatable (i.e. independent of the prefix) - currently, the
installation location is compiled into the binaries, which is a big
no-no on Windows.

But I can't say that the port is fragile; I use it daily in a production
environment.

-- Hannes
