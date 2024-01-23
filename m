Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C281AAA
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035303; cv=none; b=FhApJjMRetVJ1vy+qqKdbLvt3sNjBX7jkVH+IV6G5USWKttuGZo09t17lRcGExSBA7ArcRJTVPE+5amCbx9Kc2kfTJ7D5WYiE0sh0tIQ3NeQkplxKx049xVgDXKeCylhsQdJeGQzbwe5ZKZllnhJQU0EFGsN9WOehGFtGXMR2vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035303; c=relaxed/simple;
	bh=qn6xqCcCio98sYyieu/c+TEoQ0WWYbqPbJ0D4KGgYsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F8Iwn4l6V9lhFozj5PqutJYFGJ4Zz5IeKrVc/pMb3Ryf3KU8VgdsuB88zU8Hs9nkfHh2m7iZGdgCSvgFxMwZMh6DdVk1tjXpnneS82S7TpXEaCF3ZdckpQmjVy1/ES8cVTZuDGgsQvyHubTyx6tuL9Lf1U+tYw/BJvVbMMmZL0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=A/u4692o; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A/u4692o"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA7201DBD64;
	Tue, 23 Jan 2024 13:41:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qn6xqCcCio98sYyieu/c+TEoQ0WWYbqPbJ0D4K
	GgYsQ=; b=A/u4692o1hCXize/LhjLj8sXlhEWvmWQKk/fABK2Njxt1AzrXE9GjO
	my/XHuzjjhPEtIQumrbrRarGOVU5aSavB6ipf3KHj4xW2sGx9AZTatdwmcokrCAN
	pDYnDJuWpD05CF9i5VdgdTZxRNC2yLTaEwklQDnwp9Iteh0Q3Efbs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C20BC1DBD63;
	Tue, 23 Jan 2024 13:41:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2543F1DBD62;
	Tue, 23 Jan 2024 13:41:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Taylor Blau
 <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>, Brian Lyles
 <brianmlyles@gmail.com>
Subject: Subject: [PATCH] CoC: whitespace fix
In-Reply-To: <xmqqa5owot07.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	23 Jan 2024 09:32:24 -0800")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240119060721.3734775-5-brianmlyles@gmail.com>
	<06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
	<CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
	<10838549-c364-429b-a086-68a41b7369de@app.fastmail.com>
	<CAHPHrSd8rLj_TDE11dYQW+51--8YC4rumnfT+v2bYr+K7AMQrQ@mail.gmail.com>
	<xmqqa5owot07.fsf@gitster.g>
Date: Tue, 23 Jan 2024 10:41:38 -0800
Message-ID: <xmqqmssvnb8d.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0BEA2D4A-BA1F-11EE-98C8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

> For example, CODE_OF_CONDUCT.md has these two (shown with $$$)
> I think can be removed without breaking markdown:
>
>     Community Impact Guidelines were inspired by $$$
>     [Mozilla's code of conduct enforcement ladder][Mozilla CoC].
>
>     For answers to common questions about this code of conduct, see the FAQ at
>     [https://www.contributor-covenant.org/faq][FAQ]. Translations are available $$$
>     at [https://www.contributor-covenant.org/translations][translations].


Before I forget...

------ >8 ----------- >8 ----------- >8 ----------- >8 ------
Subject: [PATCH] CoC: whitespace fix

Fix two lines with trailing whitespaces.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 CODE_OF_CONDUCT.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
index 0215b1fd4c..e58917c50a 100644
--- a/CODE_OF_CONDUCT.md
+++ b/CODE_OF_CONDUCT.md
@@ -130,11 +130,11 @@ This Code of Conduct is adapted from the [Contributor Covenant][homepage],
 version 2.0, available at
 [https://www.contributor-covenant.org/version/2/0/code_of_conduct.html][v2.0].
 
-Community Impact Guidelines were inspired by 
+Community Impact Guidelines were inspired by
 [Mozilla's code of conduct enforcement ladder][Mozilla CoC].
 
 For answers to common questions about this code of conduct, see the FAQ at
-[https://www.contributor-covenant.org/faq][FAQ]. Translations are available 
+[https://www.contributor-covenant.org/faq][FAQ]. Translations are available
 at [https://www.contributor-covenant.org/translations][translations].
 
 [homepage]: https://www.contributor-covenant.org
-- 
2.43.0-386-ge02ecfcc53

