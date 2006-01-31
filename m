From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 11:52:23 -0800
Message-ID: <7v7j8gyy2w.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<20060130185822.GA24487@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601310926330.7301@g5.osdl.org>
	<20060131181248.GE11955@fieldses.org>
	<7vbqxsyyym.fsf@assigned-by-dhcp.cox.net>
	<1138736666.24410.38.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 20:53:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F41YH-0002tJ-97
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 20:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWAaTw0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 14:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWAaTw0
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 14:52:26 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25582 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751414AbWAaTw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 14:52:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131194921.CZRQ20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 14:49:21 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1138736666.24410.38.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Tue, 31 Jan 2006 13:44:27 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15339>

Jon Loeliger <jdl@freescale.com> writes:

> I have done this style of "update-index on more-or-less OK
> files in order to clear up the diff.  And it is also in that
> time frame that I start feeling that certain changes belong
> to "one commit" or another.  The result is, I want to then
> pick the parts that get committed together.  But _really_
> being certain exactly which files, and _only_ those files,
> will really be committed is tough.

	$ git diff --cached

would help.  If you are _only_ comitting either all changes or no
change per path, 'git diff --cached --name-status' would be
sufficient.
