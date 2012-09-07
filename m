From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] doc: move rev-list option -<n> from git-log.txt to rev-list-options.txt
Date: Fri, 07 Sep 2012 10:50:23 +0200
Message-ID: <5049B54F.7020301@drmicha.warpmail.net>
References: <1346941683-24832-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 10:51:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9uHA-0002JI-Ie
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 10:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933160Ab2IGIub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 04:50:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57531 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932949Ab2IGIuZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2012 04:50:25 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9649621230;
	Fri,  7 Sep 2012 04:50:24 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 07 Sep 2012 04:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=VNL4jSo10b8nV3E4WLBcvL
	GPNzc=; b=NBDJFvVebownKE9hYT1g5dHr4w0Yf8zIkDD/ZwYLwranGWkGsVDvH6
	KS6qgrG0pCck8R/btJxGfi8kXe38EeZYf2qi7r6ILTt42eT3bkYl0tDNpHgKwzHO
	keT8eX3HHNZ91xzWQOF0MJ8aDd77b7yXBJW6gXXe9WeGBRUGuSLqc=
X-Sasl-enc: SJfpVhMAjOcpZtc57QRUjo1yo1viaPQOnNiZBNv7Tzka 1347007824
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 133CC8E03C1;
	Fri,  7 Sep 2012 04:50:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <1346941683-24832-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204952>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 06.09.201=
2 16:28:
> rev-list-options.txt is included in git-rev-list.txt. This makes sure
> rev-list man page also shows that, and at one place, together with
> equivalent options -n and --max-count.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-log.txt          | 6 ++----
>  Documentation/rev-list-options.txt | 3 ++-
>  2 t=E1=BA=ADp tin =C4=91=C3=A3 b=E1=BB=8B thay =C4=91=E1=BB=95i, 4 =C4=
=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o(+), 5 b=E1=BB=8B x=C3=B3a(-)

That is one reason why "core.local=3DC" (repo specific) and "git -c
core.locale=3DC" (can be used in an alias) would be useful ;)

>=20
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 1f90620..585dac4 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -24,10 +24,6 @@ each commit introduces are shown.
>  OPTIONS
>  -------
> =20
> --<n>::
> -	Limits the number of commits to show.
> -	Note that this is a commit limiting option, see below.
> -
>  <since>..<until>::
>  	Show only commits between the named two commits.  When
>  	either <since> or <until> is omitted, it defaults to
> @@ -137,6 +133,8 @@ Examples
>  	This makes sense only when following a strict policy of merging all
>  	topic branches when staying on a single integration branch.
> =20
> +`git log -3`::
> +	Limits the number of commits to show to 3.
> =20
>  Discussion
>  ----------
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-l=
ist-options.txt
> index def1340..1b15ea9 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -8,7 +8,8 @@ ordering and formatting options, such as '--reverse'.
> =20
>  --
> =20
> --n 'number'::
> +-<number>::
> +-n <number>::
>  --max-count=3D<number>::
> =20
>  	Limit the number of commits to output.
>=20

This looks OK.

I noticed though that the man pages of git-log and git-rev-list still
look more different than they would need to, e.g. regarding the way
limitting by paths is explained more prominently with git-log. But that
may just be being more user friendly for git-log's man page than for gi=
t
rev-list's, which is OK.

Michael
