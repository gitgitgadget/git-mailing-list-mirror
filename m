From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Sat, 13 Aug 2005 17:48:09 -0700
Message-ID: <7vek8xl4xi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org>
	<E1E35vU-0004nP-JR@highlab.com>
	<Pine.LNX.4.58.0508110915210.3295@g5.osdl.org>
	<E1E3IOG-0005HO-AK@highlab.com>
	<20050811201558.GA2874@mars.ravnborg.org>
	<20050811202410.GB5411@kiste.smurf.noris.de>
	<42FBCD73.3090507@chandlerfamily.org.uk>
	<pan.2005.08.12.08.34.45.679778@smurf.noris.de>
	<Pine.LNX.4.62.0508120139230.19902@qynat.qvtvafvgr.pbz>
	<20050812103555.GG5411@kiste.smurf.noris.de>
	<20050813235716.GB6844@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 14 02:49:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E46fk-0005GP-Qx
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 02:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVHNAsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 20:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVHNAsQ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 20:48:16 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:23794 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751362AbVHNAsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 20:48:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050814004811.OYGJ1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 20:48:11 -0400
To: git@vger.kernel.org
In-Reply-To: <20050813235716.GB6844@mythryan2.michonline.com> (Ryan Anderson's
	message of "Sat, 13 Aug 2005 19:57:16 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

    Debian folks on the list: We had to make this ugly hack in
    our Debianization because Debian heavyweights did not like
    to see "Conflicts:" and us lowly new maintainers needed to
    obey their wishes.

    Linus: The alleged name clash appears to be a Debian
    specific problem.  No other distribution seem to ship GNU
    interactive tools and hence have this name clash.  Debian
    folks have not even substantiated their claim that the other
    GIT is so popular that name clash with it is a bad thing.

    JC: Well, here is the popcon numbers.  I'll let people
    decide if these numbers illustrate that the other GIT is so
    popular that we cannot take over its name.

In a sense, both Linus and myself have been unfair to Debian
folks on the list.  Worrying about the name clash with the other
GIT so much to change our name was not something they liked to
do to begin with.

> Personally, I'm a mugwump, and I don't care who yields as long as it
> takes place and things can then proceed at their usual pace.

Yes, and that is what Linus and myself are saying.  We would
rather stay outside the name politics, which is internal to a
particular distribution.  Linus and I were trying to give
ammunition for the Debian folks on the list to make an argument.
Linus said that our GIT installs /usr/bin/git everywhere else
without the name clash problem.  I said that the other GIT does
not seem to be used that much even on Debian.  From these facts,
they could make an argument that, if Debian as a distribution
wants to stay compatible with other distributions, either (1) it
should tolerate Conflict: and let us install /usr/bin/git, or
(2) get the other GIT renamed.  It is up to the folks pushing
Debianization of our GIT to the Debian official archive which
recommendation to make and deal with the Debian heavyweights.

Another thing to note is that it is not unusual for an official
Debian package to have a patch to debian/* files even when the
upstream sources have some such Debianization files.  The Debian
folks on the list could take that approach without first
proposing to change the name of /usr/bin/git worldwide.  I, as a
Debian user [*1*], would be perfectly happy if the Debianization
of our GIT did not ship "/usr/bin/git", and told the user to
copy "/usr/share/doc/git-core/examples/git" to $HOME/bin/ and
put $HOME/bin at the beginning of the PATH [*2*].  Maybe such a
Debianization would ship with a modified tutorial that has a
paragraph to remind the user about that as well.

[Footnote]
*1* I do not have a single RPM machine at home nor
workplace. Practically everything I touch run Debian.

*2* Even install script offering a choice to make a symlink
/usr/local/bin/git pointing at /usr/bin/git-core-scm would be
possible, but that would only be acceptable on a single-user
machine.
