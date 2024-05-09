Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5571A291
	for <git@vger.kernel.org>; Thu,  9 May 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267102; cv=none; b=aVmKV6osStVHwzKmD5fKthJiWzHwnnTLa9oJLfV/QqB0/WQtw9yvRsnf9XpDf5zVfbKRUdS8Dtn2f8tokcxMzn3uk78/mS3l6tz+3/ir3lcu6oHlVnIAWisFyKKYgnw7jAps1emSg7xIzH6eJvNjBsWFry/Ax9+84F+lNlfmC5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267102; c=relaxed/simple;
	bh=Ds4VMf3K6dy/k+c9HaKODDcWQzJIl8R+6Glyy0eGyeU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXNrhgaAkJZbVqWZ/UBQfDL4GpVdhxrnqjcY2967KHQkLzWCHbALdnh3iKn00eLdkWdNaIWqmWD6uCPaLj78WEJW1jboIQircUKk7HZbCqc4qooRuawELn7VKG1btuA71mqOGxah98OH4phWGSV71YtOjEOTx8CcmH0Tkw6UoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 46598DF9033
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:56:28 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:941e:d1e1:dccf:27d2])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 7FEE613F8AE;
	Thu,  9 May 2024 16:56:18 +0200 (CEST)
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <avila.jn@gmail.com>
To: Helge Kreutzmann <debian@helgefjell.de>, git@vger.kernel.org
Subject: Re: i18n of git man pages
Date: Thu, 09 May 2024 16:56:18 +0200
Message-ID: <8450777.T7Z3S40VBb@cayenne>
In-Reply-To: <Zjuokc2H0zI1JCVH@meinfjell.helgefjelltest.de>
References: <Zjuokc2H0zI1JCVH@meinfjell.helgefjelltest.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, 8 May 2024 18:30:09 CEST Helge Kreutzmann wrote:
> Hello,
> I'm maintainer of manpages-l10n[1], a collection of translations of man
> pages for over 100 projects into many languages.=20
>=20
> Our policy is to move translations into the upstream project where
> possible. Only where projects are not interested in maintaining the
> translations for their man pages themselves we host them[2].
>=20
> Recently one of our translators approached me to translate the man
> pages for git. Before adding them, I want to check with you if you are
> interested in adding translations of the man pages directly in the git
> project.=20
>=20
> (Technically, po4a has been proven to be a good tool to maintain
> man page translations).
>=20
> Thanks for considering i18n your man page part.
>=20
> Greetings
>=20
>          Helge
>=20
>=20
> [1]
> https://manpages-l10n-team.pages.debian.net/manpages-l10n/index.html
>=20
> [2] We collected many translated man pages from the web in the past
>     and transferring them upstream is a (very) slow process.
>=20

Hello,

I took in charge to provide translation of the man pages of git. The projec=
ts=20
lives on https://github.com/jnavila/git-manpages-l10n=20

As explained in the README file, the strategy has been to translate the sou=
rces=20
asciidoc files, instead of managing the resulting man pages. Translating th=
e=20
source files of the man pages  is needed in order to publish them on git-
scm.com (single source principle), as well as because the sources files use=
=20
asciidoc features such as dedicated macros, conditionals and includes. In=20
order to lower the difficulty for translators, the repo is coupled with the=
=20
online translation tool weblate[1] .=20

Right now, I'm using a slightly modified version of po4a  for asciidoc (mer=
ge=20
request pending). This translation gave also way to some improvements of=20
asciidoc support for po4a. That's a two way development.

The project was submitted for inclusion in Debian, but lacking more support=
,=20
the process was never achieved. I would be delighted to have the git-manpag=
es=20
included in the main distros. For Windows, the inclusion in the main packag=
e=20
was rejected as it would make it even fatter.


Jean-No=EBl

[1] https://hosted.weblate.org/projects/git-manpages/


