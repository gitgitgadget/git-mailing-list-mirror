Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B01EF09B
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777112541; cv=none; b=NedfpK8txi9cnhQGRBlbqeYiHPHOUsRCMNArQN1iukoI82gDuWi3XdXUHbFGjODgRK0HbdchoR7hr4JQPf7NGQXevwAE+OFRMXinuhsrJb74WEbFHvrPmdJD7cjps+3LxssjlUES2i+MOG8Bzup3D0Kq4BR+wh0fEhmcMGZ6OmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777112541; c=relaxed/simple;
	bh=qAdDwiROfvu3ALurjOcTmquhbXl8ATTyAF/eP5yMQuc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FwPJW4or/m5PoOubB3Eqic0K5o0v9L6NTVtoRVaOePrDjUHIbIgUfSPSZ1NH5x/W0fuhTbFGFLww+oFYS2D6CVcBaI9vrb8aIn0a9/ULvIsmdwS2tAGfPFm2oyHeZvnE9mvBeJdM0fUtjxSC3dUtzVJpS9g14XtsFfmkQ1krRtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=p0ItI72s; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="p0ItI72s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777112537; x=1777717337;
	i=johannes.schindelin@gmx.de;
	bh=CDHrUtmHdriil4abdCgBvzlOoDdqIUeJZ2QCSdi7ZoE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p0ItI72sOc+NyfBfoD7MH4H5xA2aZLErq6R++9pV71CbhuHXj7uAAu9QZPy776QL
	 3IazvKDDjify3cojYUAt3PXnDxyOOlSrmg6cw8gcUooOCZ/Ifet8t39taBSaBW7/h
	 sCcOTBmRtKqZWHgchgwx8S7y5g1ZBTTplyz6J+2OKvrCoiduzaATrszXsaLqNOP56
	 alkSbg4584k+RUknmpVFDvm1Rys/N/FEW9I8fnvf//vT1cpoJnVqndeBFKD4nYDxS
	 OXBm10WGFRLukbo4qgL3VNH3cIu+vYS8cMRp5NrPNuitXsVuI9zWmG2CoA+Fg9ITR
	 bskENbjFRr3/RIMb2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9T1-1w85hw2JOL-0023aU; Sat, 25
 Apr 2026 12:22:17 +0200
Date: Sat, 25 Apr 2026 12:22:16 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?Christoph_Gr=C3=BCninger?= <foss@grueninger.de>
cc: git@vger.kernel.org
Subject: Re: [PATCH] [ci] Update GitHub Actions to latest major release /
 GitHub #2278
In-Reply-To: <b3238847-91c1-42fa-b87a-b9d10daa6066@grueninger.de>
Message-ID: <44549a1f-d5e5-fb2b-bebb-a7fa05e10076@gmx.de>
References: <b3238847-91c1-42fa-b87a-b9d10daa6066@grueninger.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-110119082-1777112538=:10129"
X-Provags-ID: V03:K1:irmhnBjQZq+Cpz3MQ2mVAgUM7frdZDr4J4XtmR8A2zbPa3B0tkP
 4wvTBFuS8WRzZ2XIIlxPgecvDs0q3d262+aFiQe2fsYUeLV0jPZySXHNulQ5I0E3iNYsq2I
 //WqdeYJY0OGQOfahTlKmXLM9w/wotS0pTq1LSb9znonv9B25pwjGKZTJbJvGZpuM2SOeob
 nZtmocp1IUWIpQKfpz/dg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f22ivemLdtc=;aSEqG4MdmWEby9mcvXJg5hkLM03
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-110119082-1777112538=:10129
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Sat, 25 Apr 2026, Christoph Gr=C3=BCninger wrote:

> I repost my suggested contribution from:
>=20
> https://github.com/git/git/pull/2278
>=20
> I updated all GitHub Actions to their latest major release. In contrast=
=20
> to "ci: GitHub Actions updates" (brought to you by Dependabot=20
> (https://lore.kernel.org/git/pull.2097.git.1776775319.gitgitgadget@gmail=
.com/T/#t),=20
> I update some more standard actions and mshick/add-pr-comment.
> They fix deprecation warnings that GitHub Action deprecated Node20.js.

Sorry, I was unclear in my suggestion at
https://github.com/git/git/pull/2278#issuecomment-4302349600: I did not
mean to just throw out a diverging patch. What I meant was to analyze what
the differences are, and to work toward a combined, improved contribution
that is better than either of the original ones.

Lucky for me, it is easy to compare the contributions via:
https://github.com/dscho/git/compare/dependabot-updates..gruenich:git:feat=
ure/update-github-actions

This diff shows that I had missed an update of the `mshick/add-pr-comment`
Action from v2 to v3. Or, more correctly, Dependabot had not yet reported
this in `git-for-windows/git`...

I will add a patch to my patch series, crediting you with the find.

Ciao,
Johannes

--8323328-110119082-1777112538=:10129--
