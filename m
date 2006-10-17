From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 15:27:36 +0200
Message-ID: <vpqlknf3wdz.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr> <4534C5CF.3000508@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 17 15:28:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZozw-00069k-QE
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 15:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWJQN2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Oct 2006 09:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWJQN2q
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 09:28:46 -0400
Received: from imag.imag.fr ([129.88.30.1]:16039 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1750915AbWJQN2p (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 09:28:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9HDRauB008377
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Oct 2006 15:27:37 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GZoym-0000sD-Iw; Tue, 17 Oct 2006 15:27:36 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GZoym-0002O2-Fk; Tue, 17 Oct 2006 15:27:36 +0200
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4534C5CF.3000508@op5.se> (Andreas Ericsson's message of "Tue\, 17 Oct 2006 14\:00\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Tue, 17 Oct 2006 15:27:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29068>

Andreas Ericsson <ae@op5.se> writes:

> What about
>
> 3) getting the repo with all the history while still not having to be
> online to actually commit to *your* copy of the repo. When you later
> get online, you can send all your changes in a big hunk, or let bazaa=
r
> email them to the maintainer as patches, or...

Well, the discussion was about checkouts, so I was talking about
checkouts ;-).

What you mention is the default behavior of Bazaar when you use=20
"bzr branch" or "bzr get". BTW, it's also possible to do this with a
heavy checkout, that's "commit --local".

> It appears we have different ideas of what's handy. Perhaps it's just
> a difference in workflow, or lack of "email-commits-as-patches" tools
> in bazaar,

You have "bzr bundle" in Bazaar, and there was work to have it
actually send the email ( http://bazaar-vcs.org/SubmitByMail ), but I
don't think it's finished yet.

And yes, this is a great feature, the first time I used it was with
Darcs, and I was impressed how easy I could submit a patch without any
setup and with a 5-lines tutorial. Even wiki seems complex after
that ;-).

> but the ability to commit to whatever branch I like in my local repo
> and then just send the diffs by email or please-pull requests to
> upstream authors is what makes git work so well for me.

Sure. Once again, Bazaar does it this way too. There's an _additional
feature_ called checkout which allows you to work in another way,
though. As most "feature", it's not useful to everybody.

And I repeat that I'm in no way arguing against the git model :-).

> Side-note 2: Three really great things that have made work a lot
> easier and more enjoyable since we changed from cvs to git and that
> aren't mentioned in the comparison table:

Sure. And regarding this, hopufully, most modern VCS go in the same
direction.

> * Dependency/history graph display tools =E1 la qgit/gitk

http://bazaar-vcs.org/bzr-gtk
http://samba.org/~jelmer/bzr/bzrk.png

> * Bisection tool for finding bug introduction revisions.

This took time to come in bzr, but that's the bisect plugin:

http://bazaar-vcs.org/PluginRegistry

> * Tools for sending commits as emails.

(Surprisingly, I had added this in the table, but has been removed for
some obscure reasons)

--=20
Matthieu
