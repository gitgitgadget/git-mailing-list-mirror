From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 21:49:37 +0200
Message-ID: <4852CF51.10902@free.fr>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net> <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net> <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org> <bd6139dc0806130333n2cfbc564k79ed5562f14fc848@mail.gmail.com> <7v3anhuonj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sverre@rabbelier.nl, Jeff King <peff@peff.net>,
	Andreas Ericsson <ae@op5.se>,
	Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 21:50:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7FI0-0000Lq-6c
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 21:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbYFMTtN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 15:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbYFMTtN
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 15:49:13 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:51268 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbYFMTtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 15:49:12 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id ED22312B71D;
	Fri, 13 Jun 2008 21:49:11 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 0B15312B723;
	Fri, 13 Jun 2008 21:49:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7v3anhuonj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84937>

Junio C Hamano a =E9crit :
>=20
> To stash is like putting something in /tmp on a system that runs a cr=
on
> job to clean out cruft from there once in a while.  Another analogy i=
s to
> spitting an information out to syslog, so that it is kept until logs =
are
> rotated.

Are you sure about the "temporary" thing? I'm not a native speaker but =
all
the dictionary I tried, define stash as:

  "to put or hide away (money, valuables, etc.) in a secret or safe pla=
ce,
   as for future use."

Are they all wrong?

> I however mildly suspect that the stash configured as such would end =
up to
> be a lot worse than the current behaviour in practice.  It would make
> crufts easily accumulate in the stash, making it harder to find gems,=
 [...]

Why not encouraging the usage of "pop" then?

Olivier.
