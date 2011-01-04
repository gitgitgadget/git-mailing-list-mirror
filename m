From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] gitattributes.txt: mention exceptions to gitignore rules
Date: Tue, 04 Jan 2011 15:50:40 +0100
Message-ID: <4D2333C0.702@drmicha.warpmail.net>
References: <iftvu6@dough.gmane.org> <1294147915-1475-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?TWFyY2luIFdpxZtuaWNraQ==?= <mwisnicki@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 15:54:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa8HJ-0003i2-93
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 15:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162Ab1ADOxN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 09:53:13 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41689 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750991Ab1ADOxN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 09:53:13 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1384020AA3;
	Tue,  4 Jan 2011 09:53:12 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 04 Jan 2011 09:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=hz8QFPBD4uDPlIjoHITtQU5g7I4=; b=LXaKb5Uq2Ntu4ActV7DMPh1pUihAFpy3wKIK8UK+7SCf/c1rXYJ0ncN5oaHfZm9EGsR7lTfAMWCnv5v5xU9U80n78QIZJEu0f6TNQ/bcqR7HT4v+5hYalDQ9+RmmUeyqHt8Ll/d+YNBmDmT0UrD1MEnvJPpcNhMN5HvcOVdeTDc=
X-Sasl-enc: Il/yCYIIH8FNjP3z34CaloKle3hiXYnICykilxgmbF5O 1294152791
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 51DCB443769;
	Tue,  4 Jan 2011 09:53:11 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <1294147915-1475-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164496>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 04.01.201=
1 14:31:
> gitattr and .gitignore are supposed to use the same rules for matchin=
g
> patterns. Unfortunately it's not exactly the same in reality. Mention
> the differences so users won't be surprised, until gitattr gets
> updates.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  2011/1/4 Marcin Wi=C5=9Bnicki <mwisnicki@gmail.com>:
>  > I think that for the time being at least the manual page must chan=
ge to
>  > reflect reality.
>=20
>  Looks like changes will be more than just a few lines because path_m=
atches()
>  needs to learn about directories (iow less likely to get fixed right=
 away).
>  So, yes, good idea.
>=20
>  I skimmed through excluded_from_list() (gitignore) and path_matches =
(gitattr).
>  Seems no other differences.
>=20
>  Documentation/gitattributes.txt |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattri=
butes.txt
> index 5a7f936..cfaf107 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -56,6 +56,7 @@ When more than one pattern matches the path, a late=
r line
>  overrides an earlier line.  This overriding is done per
>  attribute.  The rules how the pattern matches paths are the
>  same as in `.gitignore` files; see linkgit:gitignore[5].
> +However patterns that end with a slash is not supported.

+However, patterns terminated by a slash are not supported.

> =20
>  When deciding what attributes are assigned to a path, git
>  consults `$GIT_DIR/info/attributes` file (which has the highest

Cheers,
Michael
