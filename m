From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH RFC] git-send-email --expand-aliases
Date: Tue, 24 Nov 2009 11:46:29 -0700
Message-ID: <20091124184629.GB27418@ldl.fc.hp.com>
References: <20091123221628.GE26810@ldl.fc.hp.com> <7v6390sqhz.fsf@alter.siamese.dyndns.org> <20091124004554.GA27643@ldl.fc.hp.com> <b8197bcb0911232312l251dfbc9va671388cfb7fe57b@mail.gmail.com> <b0943d9e0911240243m13730f0bw34f2f18cf41f9079@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl Wiberg <kha@treskal.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 19:47:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND0Pl-00031b-Nm
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 19:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933834AbZKXSqu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2009 13:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933807AbZKXSqu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 13:46:50 -0500
Received: from g6t0187.atlanta.hp.com ([15.193.32.64]:28721 "EHLO
	g6t0187.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933785AbZKXSqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 13:46:49 -0500
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g6t0187.atlanta.hp.com (Postfix) with ESMTP id 8D4F1282E6;
	Tue, 24 Nov 2009 18:46:55 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0030.atlanta.hp.com (Postfix) with ESMTP id 564D6141CD;
	Tue, 24 Nov 2009 18:46:30 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 0B8AFCF000D;
	Tue, 24 Nov 2009 11:46:30 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wTtLXWoeYxdc; Tue, 24 Nov 2009 11:46:29 -0700 (MST)
Received: by ldl (Postfix, from userid 17609)
	id EACE4CF0007; Tue, 24 Nov 2009 11:46:29 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0911240243m13730f0bw34f2f18cf41f9079@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133585>

* Catalin Marinas <catalin.marinas@gmail.com>:
> 2009/11/24 Karl Wiberg <kha@treskal.com>:
> > On Tue, Nov 24, 2009 at 1:45 AM, Alex Chiang <achiang@hp.com> wrote=
:
> >> * Junio C Hamano <gitster@pobox.com>:
> >> > I imagine the internal implementation of stg mail would work
> >> > something like:
> >> >
> >> > =A0 =A0 prepare messages to send out
> >> > =A0 =A0 call git-send-email and have it send them
> >> >
> >> > What am I missing?
> >>
> >> Your suggestion is much better. I'll take a closer look at StGit a=
nd
> >> see how feasible it is.
> >>
> >> Unless Catalin has strong objections?
> >
> > I think that sounds like a splendid idea. It would be interesting t=
o
> > see just how thin a wrapper around git send-email (and format-patch=
)
> > stg mail could become, without sacrificing features anyone actually
> > uses. The main complication could be stg mail's templates.
> >
> > Catalin, how wedded are you to those? ;-)
>=20
> Historically, I think "stg mail" was implemented before git-send-emai=
l
> existed. It was also a good way to check who's using stgit for sendin=
g
> patches :-) (the message-id).

Heh, I like looking at that too. ;)
=20
> If there are no other users of the stg mail templates, I'm happy to
> let them go. Otherwise, we can replace the sendmail with
> git-send-email in stgit.
>=20
> It seems that git-format-patch and git-send-email have all the
> features stgit has. We would need to keep some of the interactive
> options like --edit-cover and --edit-patches since we use
> git-format-patch and git-send-email in one go.

So, is this something you (or Karl) plan on doing? Or should I
take a crack at it?

I don't mind doing the work, but it will definitely take me
longer than it would take you.

All I was doing was trying to get stg mail to understand my mutt
aliases. ;)

Thanks,
/ac
