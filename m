From: David Kastrup <dak@gnu.org>
Subject: A few contributor's questions
Date: Fri, 31 Jan 2014 14:04:55 +0100
Organization: Organization?!?
Message-ID: <8738k44808.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 31 14:05:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9Dmf-00066D-Ms
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 14:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbaAaNFR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jan 2014 08:05:17 -0500
Received: from plane.gmane.org ([80.91.229.3]:40936 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932409AbaAaNFH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 08:05:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W9DmL-0005th-SX
	for git@vger.kernel.org; Fri, 31 Jan 2014 14:05:05 +0100
Received: from x2f510f7.dyn.telefonica.de ([2.245.16.247])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 14:05:05 +0100
Received: from dak by x2f510f7.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 14:05:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f510f7.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:uP0kTO678Rc0f9xbHEA7MimyKGE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241296>


I'm still in the process of finishing the rewrite of the builtin/blame.=
c
internals.  Now there are various questions regarding the final patch
proposals and commit messages.

Point 1) signing off implies that I'm fine with the licensing of the
file. builtin/blame.c merely states

/*
 * Blame
 *
 * Copyright (c) 2006, Junio C Hamano
 */

which obviously will not match the authorship of my contributions.
Since Junio has given blanket permission to reuse his Git contributions
under other licenses (see
<URL:https://github.com/libgit2/libgit2/blob/development/git.git-author=
s#L58>)
that I=A0am not going to license my work under, the first commit in the
respective series would replace this header with

/*
 * Blame
 *
 * Copyright (c) 2006--2014, Junio C Hamano and others
 * Licensed under GPLv2.  See Git's COPYING file for details.
 */

That should be reasonably accurate boilerplate, I think, and should
avoid code from multiple authors to be erroneously assumed subjected to
agreements other than the default Git project licensing.

Which brings us to further nitty-gritty details.

Personally, I'm fine with permitting licensing contributions of mine
under GPLv2 or later.  Is there any clearing house where I can have thi=
s
sentiment recorded in a manner where potential heirs (which according t=
o
copyright law will retain control over my works even when born after my
demise, so I=A0cannot in good conscience vouch for their common sense)
cannot contest it?  Like putting

Permissable-Licenses: GPL Version 2 or later

in the commit message?


And finally, the ugly: I don't have any income apart from volunteers
paying me for writing Free Software, so a contribution like this one,
having taken substantial time, will make for a rather tepid report of m=
y
GNU LilyPond activities in January and a corresponding slackening of
volunteer payments for what I could have been doing instead.

It's not the first performance shortcoming of Git I have worked on.  In
contrast to most other contributors, I=A0won't be able to afford follow=
ing
a whim for addressing such deficiencies in future without a chance for
recouping my losses.

My experience with GNU LilyPond has led me to conclude that the best
chance of getting voluntary payments is to appeal to those who are most
invested in the well-being of the software.  It's a sad reality that
they tend to be identical to those who are already investing substantia=
l
amounts of time and effort into the project themselves.  So I'll put th=
e
respective begging notice into the cover letter of the patch series:
I=A0don't think it belongs in the commit messages, and it's not likely =
to
be effective anyway.

While I could put a "Prepaid-by:" footer into the commit messages, the
main effect would likely be to trigger the "somebody else's problem"
effect.  My experience with this kind of polite notice is that it's goo=
d
for the equivalent of a case of beer every ten years.

If the performance enhancements are mentioned in a release announcement=
,
adding a notice along the line "The performance of git blame has been
significantly improved by David Kastrup <dak@gnu.org>.  If this affects
you, consider contributing to his reimbursement."  would of course also
be welcome.

Ok, this should be about covering the bad and the ugly.  I'm still
working on the -C and -M replacements given the new code.  Hopefully
finished this weekend.

All the best

--=20
David Kastrup
