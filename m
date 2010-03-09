From: Yann Droneaud <yann@droneaud.fr>
Subject: Re: wishlist: git send-email improvement
Date: Tue, 09 Mar 2010 18:49:07 +0100
Message-ID: <1268156947.4277.26.camel@localhost>
References: <1268155306.4277.14.camel@localhost>
	 <7veijtz9kn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 18:49:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np3YU-0007T5-CU
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 18:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113Ab0CIRtN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Mar 2010 12:49:13 -0500
Received: from smtp21.orange.fr ([80.12.242.47]:31500 "EHLO smtp21.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753902Ab0CIRtL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Mar 2010 12:49:11 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2111.orange.fr (SMTP Server) with ESMTP id 5CF362000C63;
	Tue,  9 Mar 2010 18:49:09 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2111.orange.fr (SMTP Server) with ESMTP id 4E0A22000CCE;
	Tue,  9 Mar 2010 18:49:09 +0100 (CET)
Received: from iago.mandriva.com (LPuteaux-156-16-100-40.w80-12.abo.wanadoo.fr [80.12.80.40])
	by mwinf2111.orange.fr (SMTP Server) with ESMTP id 334982000C63;
	Tue,  9 Mar 2010 18:49:09 +0100 (CET)
X-ME-UUID: 20100309174909210.334982000C63@mwinf2111.orange.fr
Received: by iago.mandriva.com (Postfix, from userid 10001)
	id B7E34517; Tue,  9 Mar 2010 18:49:08 +0100 (CET)
In-Reply-To: <7veijtz9kn.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.2-1.1mdv2010.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141837>

Le mardi 09 mars 2010 =C3=A0 09:30 -0800, Junio C Hamano a =C3=A9crit :
> Yann Droneaud <yann@droneaud.fr> writes:
>=20
> > Here's a little wishlist for send-email
> >
> > - Use From: field extracted from patch:
> >   If there's no configuration for user.email and From: field is=20
> >   different than default auto generated From: address,=20
> >   git send-email should use the one in the patch as default.
>=20
> I cannot judge how sensible this change is; please justify the motiva=
tion
> by adding "it currently does _this_, which is not good for _such and =
such
> reasons_; instead" between the third and the fourth line.
>=20

Sometimes, i'm too lazy to setup a valid git config user.email,=20
so i'm commiting with a default, broken author name which get used late=
r
by git format-patch to fill the From: field.=20
Each time I'm doing this, I'm manually fixing the From: field in the
mbox file, hoping it will be used by git send-email, and each time I'm
disappointing to see git send-email use the broken author name as
default value.
Obviously, the proper fix would be for me to remember to set up git
config user.email before issuing any command ... but the so-called huma=
n
nature tells me it's definitely not my fault, the tool get it wrong and
should be fixed :)=20
Perhaps I should learn to use git send-email --from instead.

> > - Use To: field extracted from patch
> >   I've setup format-patch to add a default To: field with
> >   format.headers=3D"To: xxx@yyy". But git send-email did not use it=
 and=20
> >   ask for a To: value.
> >   If there's no --to or sendmail.to, send-email should use To: valu=
e=20
> >   extracted from patch and ask for user confirmation.
>=20
> With the recent addition of format.to that is cooking somewhere, I th=
ink
> this one is probably sensible.

Great.

Thanks for your time.

--=20
Yann Droneaud
