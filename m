Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88675184E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 00:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729469862; cv=none; b=uhRMau5rgubjT6E5MC4IZ1PEkAgHsJeiI6lasCLuHP+sFiVOZFKQ7+AVSsHUlD4/ZnR3bDGtmC8rDpsYqZRrzoOc4Als4FMje61aeTQ7okhHgT5eUckMLU3x8hKnCg/7T0Nh2ykFzJPhW8vSvKVUiUxAr24E2miozvXsOAWUOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729469862; c=relaxed/simple;
	bh=4SoQlQyb8gtBkbToSZnSeHUXJ3aVjsznbziw7GuvTUM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7iTT9SFb5jZXj91ntHb6Mo/o6jsuvFhV2kME6QKU9BchzamOg3wJVwqlWuT30ti23CnWKiVkOw0ZDCAQAEU2NabA4NY3SMnKlXePKkvpCqwr14Cmb1z34XZO2JZyYmW3kISY+AsT03Jg6stcAnbxTT7zlkEudlhp9sw//bRJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dhubX3iL; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dhubX3iL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729469852; x=1729729052;
	bh=4SoQlQyb8gtBkbToSZnSeHUXJ3aVjsznbziw7GuvTUM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dhubX3iLsBn7B04M8VsnWRpj5QBn/FL3aiWCGggj3V3Lc9FjkJ5rPFWPxECTxKcwj
	 ZQyCTWXC68l9yyoHfp17bQQpdufDsIwbPUzsOjbVpGzt8i++IOTkMeKOmz9VySPnsN
	 iBTGBRKCuNniQLJtxrEGNCqVpB8P28N5XH3VLP6gfLhNUfJP9awqM5c4l7JXSRFRjb
	 gD3YLfhnUgslycpqYAge10tQQmntcqe9YhAxsu2WnN09Msbzd89jA7gddf+U7PWmzj
	 cW8CBmqgLbfJy3/mWhJhdBkUnvYguWV7g/KLMn3UxgnbLnc4omNHP1uGZgaaXpfo9G
	 AouG7KZU9vRWQ==
Date: Mon, 21 Oct 2024 00:17:28 +0000
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
From: Philip Yung <y5c4l3@proton.me>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: setup pager only before diff contents truly ready
Message-ID: <R7cWZCIlTr03dRb1ETcVUc62FHFAZT5_U8lWX4Q3QtJsqmtwFr7hmOtPq4yNfdzHgBXnv52HXFqiG6VqFQ5MFk60TpnvnR1DPdIrT2YTMgo=@proton.me>
In-Reply-To: <348f4415-77cb-4893-8388-a2495a391a39@app.fastmail.com>
References: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com> <348f4415-77cb-4893-8388-a2495a391a39@app.fastmail.com>
Feedback-ID: 50531228:user:proton
X-Pm-Message-ID: abac45db599ae5c4a052bf4c3c9bd7cfafb9aab6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> s/starts a/start a/
>
> Any argv error? Maybe =E2=80=9Can argv error=E2=80=9D?=20
> =E2=80=9Cany argv error=E2=80=9D looks like there isn=E2=80=99t an agreem=
ent on plural/singular.
>=20
> --
> Kristoffer Haugsbakk

Appreciate your revision, thanks!

Philip Yung
Best Regards
