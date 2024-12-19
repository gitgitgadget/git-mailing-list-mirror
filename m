Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B019F133
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628008; cv=none; b=juZ2qCz6wYmjUpXrf7KBXuuOZ68Pnf4mLmJO8Qtiedz2JPfvAP2Ud90OEdn+6TM1MqF9xpxda77WgiS+qRAIOTT49E7TtAEs0u/LVQ9jhDnQJL8jjwYsjJNE7HR6ZzRoLv5EzGoSwKRQo2nboBdqXXKjK16fNXqxoVTA6prECwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628008; c=relaxed/simple;
	bh=830ha8pDVRco2jVi+vrB0Arv3yKjNK57O1YyZklR22E=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fBmkk53Pn5Si6bGu8/6rfRoQNPicIpP9ZtN3rA6dL5E8C2Vxj8Ba2SVoN8O2Vfg1RVClXR3LXsJuN5TjDN3hyGOUKZnze4TFF3p00BwkHBmG4aoaVgHxnSzZhJKZyea8hwihwsXuJ/3fMqyg5wnACnufSJOxmc8nFi5WYVTv4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=TRVJvFfB; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="TRVJvFfB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734627998; x=1734887198;
	bh=830ha8pDVRco2jVi+vrB0Arv3yKjNK57O1YyZklR22E=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=TRVJvFfBMKwudTcbPQoBZt0r0sArWf7a1dEFiAENSV8qJsItGlqJOgYQb9A5QJYCa
	 yZOsZ+Ssoe5H0Qv9avCd6F/yqKZq1ZSxrWXul8L3polfyi7DqcBK4vFvRy8Wd5EY9U
	 HiYtyt9O0Q6L1RVA2o+qAgwenMEe012ja/jzlgrgBdJGDD5m5zBTBNQNQbXjQGvW/C
	 o22SlncT/x9ywsYYlLZMH2nuMKjIJd6GxVL4FVMLs/3WLXJAyr0kKsOb2XOZDQIEvm
	 PbNcHrxRyoSyn4kAxccGstLl8h7eIdg8kb7oqWtGCe/a/46GRTXSJTxAcCW6sjUVy7
	 2as1NUjZUlgjw==
Date: Thu, 19 Dec 2024 17:06:32 +0000
To: Bagas Sanjaya <bagasdotme@gmail.com>, Git Mailing List <git@vger.kernel.org>, Git l10n discussion group <git-l10n@googlegroups.com>
From: Caleb White <cdwhite3@pm.me>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: OK to submit l10n PR with signed commits?
Message-ID: <D6FUAW0WHD9P.EKNH75JAR157@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 48b977ebcf6c287f0dabd8dbad1a4eecf0959475
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Dec 18, 2024 at 4:08 AM CST, Bagas Sanjaya wrote:
> So I'm interested in GPG-sign my commits (that is, ``git commit -S``) for=
 l10n
> pull request (which I should submit in this cycle). Is it OK to do that?
> Drawbacks?

The GPG signature is lost when emailing patches---so unless the PR is
actually being merged directly (and not using GGG) then it doesn't
matter.

Best,

Caleb

