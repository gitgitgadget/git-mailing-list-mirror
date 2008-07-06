From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: "make test" works again (sort-of) on cygwin.
Date: Mon, 7 Jul 2008 01:11:46 +0200
Message-ID: <20080706231146.GE17659@steel.home>
References: <486D0FFC.5090308@ramsay1.demon.co.uk> <20080703202637.GC3546@steel.home> <486FD4FB.6070803@ramsay1.demon.co.uk>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jul 07 01:12:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFdPU-00057w-46
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 01:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863AbYGFXLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 19:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754955AbYGFXLt
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 19:11:49 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:35828 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851AbYGFXLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 19:11:49 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44h+5V
Received: from tigra.home (Fa915.f.strato-dslnet.de [195.4.169.21])
	by post.webmailer.de (klopstock mo62) (RZmta 16.47)
	with ESMTP id v03a01k66Kglwy ; Mon, 7 Jul 2008 01:11:47 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D257D277BD;
	Mon,  7 Jul 2008 01:11:46 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A24DE56D27; Mon,  7 Jul 2008 01:11:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <486FD4FB.6070803@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87564>

Ramsay Jones, Sat, Jul 05, 2008 22:09:31 +0200:
> Alex Riesen wrote:
> > Ramsay Jones, Thu, Jul 03, 2008 19:44:28 +0200:
> > 
> >> Anyhow, the "sort-of" in the subject line, relates to the fact that
> >> I am seeing some test failures.  In particular, all tests in
> >> t0004-unwritable.sh and tests 21->24 in t3700-add.sh. All of these
> >> tests involve chmod/permissions ...
> > 
> > Don't run "make test" as root (or "backup operator" on windows).
> > OTOH, a windows machine is almost useless, unless you're a member of
> > local administrators group (which includes "backup" permission).
> > 
> 
> Ah, yes... I am a "Computer administator" aren't I ;-) I totally forgot!
> 
> Hmm, but is that really the reason for these failures? After all, (referring
> to the example you snipped) the permissions are respected for creating
> files in the directory, just not directories.  Is the "root" user on
> windows only selectively omnipotent?

It is (it is the backup operators who can read open, even locked,
files), but it is boringly hard to find when and where. You can try
reading MSDN (or better don't, you'll live longer if you don't).
