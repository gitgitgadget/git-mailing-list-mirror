Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA62239BA0
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913902; cv=none; b=sjQZpQ5BXAesWEL36EjWi5box8+AVcWsg1dxdPDjXrODJyO6o6qlfvNO/L/BTsGDQ20ZLcwqhuzQD+XvMoVyycpkKorRnDkTZR0FT1+Nvs3jBFzUBYR0X5yb2XwIcn6QKECQs8PNMJk3bQfjW7xDx/y/Ze1K+76sTc5gZfxXLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913902; c=relaxed/simple;
	bh=4/NzzdQsQ6KD+wUoYEyvnCpUVHh2V8tHdMwHZbhLFa0=;
	h=MIME-version:Content-type:Date:Message-id:Subject:To:From; b=cb4OK0X+fxrwZci+lG581bqpVOyXT2laGhshUzcPMKMVXsrYYCpnIByF/QyQ1f6QDU/tZB47VC0msUyAj9qF7UHU4gWqO9tgOJOXy47PuM3baRugW0eQcJIn0yTyV4HtPw1axokB3ri/C55cPLGwEiZobpro5yuMNGyIKdZ782g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=gXfMM+Xm; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="gXfMM+Xm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=4/NzzdQsQ6KD+wUoYEyvnCpUVHh2V8tHdMwHZbhLFa0=;
 b=gXfMM+XmbuxTkJUzJ1aAf9KZPaVNwxIBH4YeioYarcyBVVaMLZbV8YCnngrOKjRRTniUEIplTD6I
   6J5HFB2ik77H+89hXxti6j+Myy3/Lr0a8zv0B7MaJMRcnc7YMZ5226PvcGtDMNqJIH64/cWmaU6M
   z8f5ct/JDEq6M3rBZuu+G8QPQkFfXUWmBP1wWKmalKQ1hS73+kRsKns27GKki3mHMYLVNMF/jsoZ
   lX7h+KQ+LO18SE9hj1WtP1Z9AIMXWjnN53b6ePt+Gh7svmOD+cF/gcQvUMFz4CKAATtaNjRwHawc
   Uj8KDvDY6i+AtOhftM2KqCwNcatEuhAJV0BbUA==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SOB00G3VSAEEZ30@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 11 Dec 2024 10:39:50 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 11 Dec 2024 11:39:28 +0100
Message-id: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
Subject: branch description as a note?
To: <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Reporting-Meta:
 AAFowE9C87N57ks25sm8QCx8fXvT7q7DYe4VeQZUYMKpd91lGqM09cWKyi8v3S4w
 UsLIRAmVg/SE4NSn2Ag24UBJk+19MwKhop9IKoePpjxRQGmu4kQ2jQsrhe7ticbp
 VF+2p9hE6ovsK6Py8o9ZAhSS/+6YDScYAlc8WJMsUCReXukiWLoL4/JMKouMV2k/
 +YeH8z0QbBINauSHvc/s+ngbkaAdfhxH1iK4//T77v74pus5g9A534Q/XKGLxI6i
 50UqUIImOOHjy0+VMrqBoxHoKokaZtIUTpO+jKb54R2Hv7zJArfk3qCPPuk2NPOS
 fFQTVJtaAIE/Kuzzd7sFHo3G9F4sJr2cF630UfC688TjSfboc56HV3Zh2y8erQt0
 xp8i4jP8jYdlY3zR2zmDHeNeZZyQ2kiV7DhUTjHrL0hOixT71Rxf4Qu0anpwWkxM
 GkOHYtPsN2Mkgt79TwNo0mA6oH5Rkg4amDhPYRsc3Gu0d0J1jc/2A7DQ

Hi,

so I've been wondering about branch descriptions being just a local
configuration. The only use-case I know for them is generating cover letter=
s
and request-pull, although I could imagine maybe the maintainer uses branch
descriptions for storing the - well - branch descriptions for the "What's
cooking" emails and the merge commit messages.=20

Now my problem with the description being a local configuration, is that
I often work on patches on two different computers. I can easily share my p=
atch
notes with myself, but not the branch description. If these could be pushed=
 and
fetched like a note, I think that would open up some other nice possibiliti=
es
as well, like having a standard place for MR/PR messages for forges, sharin=
g
proposed merge commit messages, maybe other things.

For my personal issue of sharing branch descriptions with myself, I could
probably just make up a convention for myself, say using refs/notes/branche=
s,
but it would be nice to have this built in, instead of the local config bra=
nch
description.

From usage perspective I could imagine a new `--branch` flag for notes, whi=
ch
would tell `git notes` to operate on notes attached to branches instead of
specific commits, probably stored under refs/notes/branches by default. May=
be
add an `--edit-branch-note` to `git branch`. And of course have the option =
to
use this note instead of the description configuration wherever it makes se=
nse.

What do you think?

Thanks,
Bence


