From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] completion: complete --move for git branch
Date: Tue, 7 Jun 2016 11:16:03 +0200 (CEST)
Message-ID: <1120818262.376555.1465290963431.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1465218971-14118-1-git-send-email-ville.skytta@iki.fi> <582640631.360243.1465222588996.JavaMail.zimbra@ensimag.grenoble-inp.fr> <CABr9L5AK5KhFvAW4dah3Hji_VStgYKesnD+Ljari7ihJX8Y7fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jun 07 11:04:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bACvo-0000qr-QR
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 11:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbcFGJEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 05:04:11 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:57451 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932184AbcFGJEJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 05:04:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E806A259B;
	Tue,  7 Jun 2016 11:04:05 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1FrSxK6SIbe; Tue,  7 Jun 2016 11:04:05 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D8EC22129;
	Tue,  7 Jun 2016 11:04:05 +0200 (CEST)
In-Reply-To: <CABr9L5AK5KhFvAW4dah3Hji_VStgYKesnD+Ljari7ihJX8Y7fg@mail.gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: completion: complete --move for git branch
Thread-Index: WgawunuRCMJ5tTZCOKReTEt/VQmaHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296619>

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:
> On Mon, Jun 6, 2016 at 5:16 PM, Remi Galan Alfonso
> <remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> >
> > Hi,
> >
> > Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:
> > >          while [ $c -lt $cword ]; do
> > >                  i=3D"${words[c]}"
> > >                  case "$i" in
> > > -                -d|-m)        only_local_ref=3D"y" ;;
> > > -                -r)        has_r=3D"y" ;;
> > > +                -d|-m|--move)        only_local_ref=3D"y" ;;
> >
> > "While you're at it" you might want to do the same thing for
> > `--delete`.
>=20
> I'm afraid the "while I'm at it" would never end if I start looking
> deeper into missing things there, so I'd prefer this self contained
> one I keep running into myself applied first.

I understand, though adding `--delete` here makes sense since there is
already the short-hand `-d` that is tested (like you added `--move`
since the short-hand `-m` is tested).
However adding it here means that we should also add it in completion
list below. Thinking about it, it might be better to have it in a
separate patch, so no further objections with this patch.

>=20
> > > +                -r)                has_r=3D"y" ;;
> >
> > You are introducing an additional tab here that you probably didn't
> > want.
>=20
> It was intentionally added it to keep "only_local_ref" and "has_r"
> tab-aligned the way they already were.

Ah indeed, my bad, I didn't see it.

Thanks,
R=C3=A9mi
