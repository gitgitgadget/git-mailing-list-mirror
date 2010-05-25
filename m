From: =?ISO-8859-1?Q?D=E9vai_Tam=E1s?= <devait@vnet.hu>
Subject: Re: [PATCH] Man page section reference should be in uppercase
Date: Tue, 25 May 2010 20:45:22 +0200
Message-ID: <1274813122.1178.8.camel@localhost.localdomain>
References: <1274756484-27867-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 20:45:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGz8R-0006io-JR
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 20:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667Ab0EYSpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 May 2010 14:45:30 -0400
Received: from a.relay.invitel.net ([62.77.203.3]:60043 "EHLO
	a.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932294Ab0EYSpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 14:45:30 -0400
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id 49FFC11A21B;
	Tue, 25 May 2010 20:45:28 +0200 (CEST)
Received: from [192.168.0.2] ([91.82.29.244])
 by mail.invitel.hu (Invitel Messaging Server)
 with ESMTPA id <0L2Z000GJO3NRT11@invitel.hu>; Tue,
 25 May 2010 20:45:24 +0200 (CEST)
In-reply-to: <1274756484-27867-1-git-send-email-ayiehere@gmail.com>
X-Mailer: Evolution 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147721>

2010. 05. 25, kedd keltez=C3=A9ssel 11.01-kor Nazri Ramliy ezt =C3=ADrt=
a:
> From: nazri <ayiehere@gmail.com>
>=20
> The advice given by git push when doing a non-fast-forward push refer=
s
> to the section 'Note about fast-forwards' in the git-push(1) man page=
=2E
>=20
> The section name should really be all in uppercase, as in 'NOTE ABOUT
> FAST-FORWARDS' because that is how it is shown by git push --help.
>=20

I don't really agree with this, but it might be only my personal
preference. Reasons:

The section title in the man page is "typeset" in a "different font" to
be easily distinguishable from the surrounding text -- therefore it's
all capital. On the other hand, changing the reference in the advice
given by git-push to be all uppercase will give a needless emphasis on
the referred section title. This is wrong IMHO, because the main point
of the advice is not this reference, but the earlier sentences (i.e. th=
e
push was rejected).

> Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
> ---
>  builtin/push.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/builtin/push.c b/builtin/push.c
> index f4358b9..0694200 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -130,8 +130,8 @@ static int push_with_options(struct transport *tr=
ansport, int flags)
> =20
>  	if (nonfastforward && advice_push_nonfastforward) {
>  		fprintf(stderr, "To prevent you from losing history, non-fast-forw=
ard updates were rejected\n"
> -				"Merge the remote changes before pushing again.  See the 'Note a=
bout\n"
> -				"fast-forwards' section of 'git push --help' for details.\n");
> +				"Merge the remote changes before pushing again.  See the 'NOTE A=
BOUT\n"
> +				"FAST-FORWARDS' section of 'git push --help' for details.\n");
>  	}
> =20
>  	return 1;
