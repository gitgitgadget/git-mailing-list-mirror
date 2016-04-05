From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Tue, 5 Apr 2016 00:03:06 +0000
Message-ID: <20160405000306.GA4746@dcvr.yhbt.net>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
 <xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com>
 <20160327220002.GA29057@dcvr.yhbt.net>
 <CAKqreuzE6G0WO4gn2_R7-QfZYfVS2tuAMEnwiVE8FyNviJGD+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Javier Domingo Cansino <javierdo1@gmail.com>
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 02:03:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anESh-00079g-7v
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 02:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbcDEADJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2016 20:03:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56033 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbcDEADI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 20:03:08 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED06320437;
	Tue,  5 Apr 2016 00:03:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAKqreuzE6G0WO4gn2_R7-QfZYfVS2tuAMEnwiVE8FyNviJGD+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290739>

=E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> wrote:
> 2016-03-28 6:00 GMT+08:00 Eric Wong <normalperson@yhbt.net>:
> > While Gmail provides SMTP access, it was (last I was told)
> > incompatible with two-factor auth; so I've encountered users
> > unable to send patches with their normal 2FA-enabled accounts.
>=20
> That's the origin of this idea of `mailto`.
>=20
> In fact, you could send mail via 2FA-enabled accounts via
> "app password" metioned by Javier. But it's annoying to create
> "app password" for every client.

Since it seems possible to use 2FA with gmail, can either you
or Javier submit a patch to Documentation/git-send-email.txt
to update the Gmail-related section where
"Use gmail as the smtp server" is to describe how to use this
"app password"?

It's much easier to do than your entire GSoC proposal and would
be immediately useful to 2FA gmail users out there who don't
know this, yet or aren't running the latest git.  Thanks.





>=20
> If there is a `mailto` method to send patch, you could type something
> like
>=20
>     git send-patch --mailto origin/master..HEAD
>=20
> Then, gmail is launched with the content of patch in it. You could ed=
it
> the list of `to` and `cc`(You could even take use of gmail contact). =
Then
> just send. That's all. No need to SMTP config or "app password" any
> more.
>=20
> > Maybe git hackers at Google have enough pull to lobby Gmail's
> > web interface to make it easier to send plain-text patches;
> > but I would love more to see users running local mail clients
> > and even running their own SMTP servers.
>=20
> Yes, this should be free with user to pick their favorite mail client=
=2E
>=20
> >> That may not be a "Git" project, but GSoC is not limited to Git ;-=
)
> >
> > Completely agreed; email is critical to decentralized development;
> > but I don't believe decentralization is in the best interests of
> > any large and powerful corporation.
> >
> > IMHO, what we need is a SoIS: Summer of Independent Sysadmins :>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
