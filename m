From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: cygwin: t3200-branch.sh fails with "List form of pipe open not implemented at -e line 22."
Date: Sat, 15 Oct 2005 23:18:08 +0200
Message-ID: <20051015211808.GA3497@steel.home>
References: <81b0412b0510140546ya10bc8fg3dd5eaab429eba6f@mail.gmail.com> <434FF189.3080806@zytor.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 23:20:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQtQW-0000yx-2I
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 23:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVJOVSY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 17:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVJOVSY
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 17:18:24 -0400
Received: from devrace.com ([198.63.210.113]:64521 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751181AbVJOVSX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2005 17:18:23 -0400
Received: from tigra.home (p54A0EFC1.dip.t-dialin.net [84.160.239.193])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j9FLIArd099068;
	Sat, 15 Oct 2005 16:18:11 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EQtPs-00018F-00; Sat, 15 Oct 2005 23:18:08 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EQtPs-00021k-AB; Sat, 15 Oct 2005 23:18:08 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <434FF189.3080806@zytor.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.6 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10145>

H. Peter Anvin, Fri, Oct 14, 2005 19:57:29 +0200:
> >Now, how broken is that:
> >
> >The message comes from one of the hooks, which are executed even
> >though they never meant to, because cygwin apparently uses file
> >content or name to detect executability (on FAT).
> >
> >I just remove the hooks from repositories atm.
> 
> I think the bottom line is "don't use FAT".
> 

I'm afraid I have to. NTFS isn't much better (newly created files
still have no correct attribute) and is slower (sometimes much
slower). Not that I have a choice, anyway: it's a typical corporate
workstation locked as down as possible.
