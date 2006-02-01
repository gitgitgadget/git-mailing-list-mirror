From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 16:52:46 -0800
Message-ID: <7vek2noq75.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<20060130185822.GA24487@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601311750270.25300@iabervon.org>
	<7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 01:52:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F46Eu-0005rI-J0
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 01:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWBAAwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 19:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWBAAwt
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 19:52:49 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34447 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750924AbWBAAws (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 19:52:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201005119.UUMQ20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 19:51:19 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 31 Jan 2006 16:38:50 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15371>

Linus Torvalds <torvalds@osdl.org> writes:

> One thing to be careful about is merges.
> ...
> So the current "git commit filename" behaviour is actually the only 
> possible correct one for a merge. Nothing else makes any sense 
> what-so-ever.

Agreed 100%, and I kind of feel silly about not mentioning that
myself.  It _might_ even make sense to reject explicit filenames
when MERGE_HEAD does not exist ;-).

> Oh, one final suggestion: if you give a filename to "git
> commit", and you do the new semantics which means something
> _different_ than "do a git-update-index on that file and
> commit", then I'd really suggest that the _old_ index for that
> filename should match the parent exactly.

That is also a good safety measure.
