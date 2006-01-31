From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 15:56:22 -0500
Message-ID: <20060131205621.GC16561@fieldses.org>
References: <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <20060130185822.GA24487@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org> <20060131181248.GE11955@fieldses.org> <7vbqxsyyym.fsf@assigned-by-dhcp.cox.net> <1138736666.24410.38.camel@cashmere.sps.mot.com> <7vd5i8w2nc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 21:56:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F42YG-0002ZA-JO
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 21:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWAaU41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 15:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWAaU41
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 15:56:27 -0500
Received: from mail.fieldses.org ([66.93.2.214]:27536 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751475AbWAaU40 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 15:56:26 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F42Y2-0005Wl-2X; Tue, 31 Jan 2006 15:56:22 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5i8w2nc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15342>

On Tue, Jan 31, 2006 at 12:41:59PM -0800, Junio C Hamano wrote:
> On the tutorial front, maybe we could start teaching people to
> always use "commit -a", and not tell them about update-index nor
> "commit paths.." at all.  Have them do "hello world", review
> changes since the last commit with "git diff", and make commit
> with "git commit -a".  Next tell them about index, and after
> they understand index, finally tell them "commit paths..."  is
> there merely to reduce typing.

Yeah, I think that's approximately what you get right now if you read
tutorial.txt followed by core-tutorial.txt, though the two currently may
not really work together well as sequels.

So I'm inclined to start by revising the two to make them read well as
sequels, then maybe moving some of core-tutorial.txt into the earlier
tutorial.txt.  By the time we're done the two might end up being one
document.  Or they might still be two, but with the split being more
clearly beginning/advanced instead of high-level/low-level.

Feedback from people who'd actually worked through the two would
obviously be useful.

--b.
