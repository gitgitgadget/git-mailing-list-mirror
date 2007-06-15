From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [CORRECTED PATCH] Introduce file with the common default build-time 
 items.
Date: Fri, 15 Jun 2007 09:15:43 +0200
Organization: eudaptics software gmbh
Message-ID: <46723C9F.4EE044F9@eudaptics.com>
References: <20070613054316.GN86872@void.codelabs.ru> <20070614043633.GV6073@spearce.org> <20070614095654.GT86872@void.codelabs.ru> <20070614150929.GA18491@spearce.org> <20070614190739.GA3779@void.codelabs.ru> <20070615032204.GC18491@spearce.org> <20070615054002.GD3779@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 09:16:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz62l-00024x-OQ
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 09:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbXFOHQY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 03:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbXFOHQY
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 03:16:24 -0400
Received: from main.gmane.org ([80.91.229.2]:49052 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbXFOHQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 03:16:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hz62C-0008R3-Aq
	for git@vger.kernel.org; Fri, 15 Jun 2007 09:15:52 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 09:15:52 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 09:15:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50250>

Eygene Ryabinkin wrote:
> OK, let us wait for the other's reaction.  May be you're right and
> it doesn't worth it.  But I always felt that if I can change something
> by changing it only in one place, then it worth it.  Otherwise I
> should remember all places where it is used and this leads to errors.
> But maybe the 'wish' and 'tclsh' are not worth it.

Huh? This "one place" already exists. Its name is 'config.mak'. I have
this in it:

TCL_PATH=tclsh84
TCLTK_PATH=wish84

-- Hannes
