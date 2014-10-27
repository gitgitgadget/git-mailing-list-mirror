From: richard.palo@free.fr
Subject: Re: git ls-files -o seems to ignore .gitignore
Date: Mon, 27 Oct 2014 10:22:03 +0100 (CET)
Message-ID: <391421950.105620016.1414401723677.JavaMail.root@zimbra7-e1.priv.proxad.net>
References: <vpq8uk1lxqb.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard PALO <richard@netbsd.org>, git@vger.kernel.org,
	Charles Bailey <charles@hashpling.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 27 10:22:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XigVD-0003U8-Dg
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 10:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbaJ0JWK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 05:22:10 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:7521 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbaJ0JWJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2014 05:22:09 -0400
Received: from zimbra7-e1.priv.proxad.net (unknown [172.20.243.157])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 22DB64C80D7;
	Mon, 27 Oct 2014 10:20:26 +0100 (CET)
In-Reply-To: <vpq8uk1lxqb.fsf@anie.imag.fr>
X-Originating-IP: [195.6.133.80]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 ([unknown])/7.2.0-GA2598)
X-Authenticated-User: richard.palo@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Well, ok.  Not very intuitive, so I added an alias in .gitconfig...=20
'ls =3D ls-files --exclude-standard' and that seems to work now alright=
 for me.

Thanks

----- Mail original -----
> De: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
> =C3=80: "Charles Bailey" <charles@hashpling.org>
> Cc: "Richard PALO" <richard@netbsd.org>, git@vger.kernel.org
> Envoy=C3=A9: Lundi 27 Octobre 2014 09:31:56
> Objet: Re: git ls-files -o seems to ignore .gitignore
>=20
> Charles Bailey <charles@hashpling.org> writes:
>=20
> > On Mon, Oct 27, 2014 at 07:16:49AM +0100, Richard PALO wrote:
> >> Hash: SHA1
> >>=20
> >> I'm having an issue in that 'git ls-files -o' seems to ignore
> >> [parts of] .gitignore whereas other commands, such as 'git status'
> >> seem fine.
> >
> > This is, as far as I am aware, by design.
>=20
> I would not call that "by design", but indeed "git ls" was written
> this
> way, and it's a plumbing command for which we do not want
> backward-incompatible changes. So, --exclude-standard is available,
> but
> not activated by default.
>=20
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>=20
