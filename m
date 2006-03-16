From: Paul Jakma <paul@clubi.ie>
Subject: git-reset and clones
Date: Thu, 16 Mar 2006 14:34:42 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Thu Mar 16 15:35:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJtZZ-0008WS-NS
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 15:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWCPOfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 09:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWCPOfT
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 09:35:19 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:27520 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1751143AbWCPOfR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 09:35:17 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX18ZIgsO/9PGfPXikRcCnF/uhgxa5DHLdIE@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k2GEYg78031785
	for <git@vger.kernel.org>; Thu, 16 Mar 2006 14:34:54 GMT
X-X-Sender: paul@sheen.jakma.org
To: git list <git@vger.kernel.org>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17636>

Hi,

Next dumb question:

If a git repository has a reset HEAD~X done, then any later pulls in 
clone repositories get /really/ upset, with:

$ git pull
* refs/heads/origin: does not fast forward to branch 'master' of 
/home/paul/foo-git/;

Type of thing. This seems to be a similar issue to:

 	http://www.gelato.unsw.edu.au/archives/git/0510/10767.html

The question is has this improved at all since last year? Is there 
anything the origin repository maintainer (the one who did reset) can 
do to recover from this?

I'm guessing the answer is:

Yes:

1. where git-reset has already been done, manually update the
   refs back to the previous HEAD
2. then use git-revert, and continue to use git-revert only.

My question then would be, presuming some innocent repository 
maintainer has already done 1, what's the easiest way to accomplish 
1?

(they shouldn't have done it obviously, but assume they're git 
newbies, made an honest mistake and now need to recover, preferably 
without having to involve those who pull).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Be cautious in your daily affairs.
