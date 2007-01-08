From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Suggest use of "git add file1 file2" when there is nothing to commit.
Date: Mon, 08 Jan 2007 12:13:25 -0800
Message-ID: <7vps9pwa3e.fsf@assigned-by-dhcp.cox.net>
References: <20061216025309.GA19955@spearce.org>
	<1168029891.11130.18.camel@ibook.zvpunry.de>
	<7virfldryw.fsf@assigned-by-dhcp.cox.net>
	<7vodpcae9s.fsf@assigned-by-dhcp.cox.net>
	<17823.42284.620000.476920@lapjr.intranet.kiel.bmiag.de>
	<7vfyao58a7.fsf@assigned-by-dhcp.cox.net>
	<17824.10780.295000.771566@lapjr.intranet.kiel.bmiag.de>
	<7vslemxe5e.fsf@assigned-by-dhcp.cox.net>
	<17826.8186.10000.584890@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 21:13:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H40s8-0003Z7-JV
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 21:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbXAHUN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 15:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbXAHUN1
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 15:13:27 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:35770 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422727AbXAHUN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 15:13:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108201326.MVKH25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jan 2007 15:13:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8kCb1W01H1kojtg0000000; Mon, 08 Jan 2007 15:12:36 -0500
To: Juergen Ruehle <j.ruehle@bmiag.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36277>

Juergen Ruehle <j.ruehle@bmiag.de> writes:

> Junio C Hamano writes:
>  > Juergen Ruehle <j.ruehle@bmiag.de> writes:
>  > 
>  > > Junio C Hamano writes:
>  > >  > If there is something you are missing, it is that I am
>  > >  > overloaded these days ;-).
>  > >
>  > > I'm sorry. As a rather unsuccessful former maintainer of
>  > > http://www.openarchitectureware.org/ I can fully appreciate git's luck
>  > > to have such a dedicated maintainer.
>  > 
>  > Actually there is one difference that I found practically
>  > important.  It usually is a norm for me to have a handful
>  > untracked files that I do not even bother adding to .gitignore
>  > in the repository.  My patch does not suggest "add" when there
>  > are untracked files but no locally modified files.
>
> Yes. I don't have a real preference. I have a slight suspicion that
> the hint is useful for newbies because having only untracked files is
> the initial situation, but the hint in my patch is actually wrong
> because git-commit won't help in this situation. Do you want to revert
> the patch and apply yours or should I send a correction?

I think it is Ok to give hints for untracked files -- with
experience eyes will learn to ignore them but by then they do
not need hints.  Please send in a correction as appropriate.
