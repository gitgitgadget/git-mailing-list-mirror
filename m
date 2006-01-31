From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 16:52:47 -0500
Message-ID: <20060131215247.GF16561@fieldses.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home> <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 22:53:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F43R1-0001BC-K2
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 22:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWAaVxD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 16:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWAaVxD
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 16:53:03 -0500
Received: from mail.fieldses.org ([66.93.2.214]:44267 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751546AbWAaVxB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 16:53:01 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F43Qd-00064E-JD; Tue, 31 Jan 2006 16:52:47 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15352>

On Tue, Jan 31, 2006 at 01:25:08PM -0800, Linus Torvalds wrote:
> So we could speed it up on cygwin (and yes, it would speed git up a lot 
> even on Linux, but since the cached lstat() case is so fast anyway, I 
> doubt a lot of Linux users care - the biggest win would be on a cold-cache 
> tree).  But it would require that you explicitly _mark_ the files you edit 
> some way.

You couldn't depend on a combination of lstat's and some kind of
filesystem change notifications?

--b.
