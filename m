Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794324455;
	b=OD4XgObUKW8p3X0nyhtwk4HskVk9XAncpmr6Xl6SOw4dTFI7lC/KNRYlQuiR0vahxnQT
	 xmoR5Z6OaO3KRAcuCxklfvBX2qgpMUu61z9f2DDxTOUotVANeRB7htjIfkYBoTTaJhrFh
	 Viut/jZz47b7zTyG5D4cRNuIysWYP6wbpWB2Lfm8hkbnGnhxeEYCxwvv/KKvnEQ1gs+v5
	 rByiu+DeGHypAHowYRJnEEs2GB58RE3zloiQQL4qMaq5ZEoEdH3+44wlKYxgUBSpNvwBa
	 x4dmjt+xgFEfVTG8+HHvCikeoEuSi/P4ZE6AhEKmdXeTOwOUcyXNLH8koO6dXtJhNrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324455;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=J0nEDXnhqslXpWfg2ke0rbIXgW1XSpzt8JGLUL/b1hA=;
	b=Q7Lbi9GpTyiphg8di8QFL8OCjibMHQ8+zy4loV06gWbfzQ7HWKaVHpFwRzQgIbVKTGA9
	 A1tM+0r+EjV2cg5EM33AylGYFKevpGl6NrgkBU67Yl9xnEi7pCw5/rrq+SUcT4c/oS6Ss
	 wQVMCJGYwTv/0N+5Ekqs5akwMTnr4rv8DY+pvgjinYa8OtKBg+CuA8v3TjyLDSc5D++1m
	 JyuMgvSeGkVRimxYTtIH7qdiO+F3XFk7i9ipJnWcKeQ6aiBgonbZlxyoac4tqRV0FnhvT
	 oY6meV4R9pU/EdZ10GnAbbgZ+lkjhjvx2Led9dzk4Ja3zYNWxolqEB5K7q1R47/adDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=OWr96ac0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A2606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 15:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 202A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=OWr96ac0
ARC-Seal: i=1; a=rsa-sha256; t=1794324434; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=StrgNHULezz8voJ4dfYLFC13EtEQq0AN/8iT4DKDC1HIsK34gXOYdXHE6WsjesURZEY15wlEbLxeE6dj1Xc8o2A4GkXVHPSR+/08J4Xj/q7iHpJUQwc5f7m0f52izw+q/+h30u/9HGGLqx7CCrvM69g6caNA+8dil9o+8NpBeq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794324434; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J0nEDXnhqslXpWfg2ke0rbIXgW1XSpzt8JGLUL/b1hA=; 
	b=V/V8LUL51NghbgrBwstLR9QngWFnMg5y5/czpos6+J9DM+j2/x2IOZhLlGSfVrN281PKp9nLmm2XolDWT7gzq6KFQcwRiF/H2QZDdZZj+f+3q4b9Cy3M6ZGnS07sYW8yKVRHLe3HTLXkWZu9t3LwjNufr0bXuW9+p0qC13aPcs0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=OWr96ac0MwqyZih6nzk05E+saY06rp8ZzFeWaiX4OSmg56blEO5XC7IcD5EEuV3W//HaXuWab6ojZBqt5MG6C+AFedN64FJ2eYE8m/x3GCo5uRJ3ca5F0yMhy0QGH5wU6Hv8Hb0KHvTFV9zyVZVtABySzdIOs9JjipSHgxeezHQ=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=J0nEDXnhqslXpWfg2ke0rbIXgW1XSpzt8JGLUL/b1hA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794324417236268.68226940587806;
	Tue, 10 Nov 2026 07:26:57 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 0/2] builtin/reflog: expire each reflog only once
Date: Tue, 10 Nov 2026 07:26:39 -0800
Message-ID: <cover.1794324064.git.laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108012213.89468-1-laveeshb@laveeshbansal.com>
References: <20261108012213.89468-1-laveeshb@laveeshbansal.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This series makes "git reflog expire" expire each reflog only once.  1/2
puts the --all and the named-ref paths in one loop without changing
behavior.  2/2 skips a reflog that was already expired in this run, so
a name given twice, or one that --all also covers, is no longer expired
and reported twice.

v1 was the refactor alone.  I had kept it free of behavior changes and
planned to handle repeated reflogs in a later patch.  After the
discussion on v1 [1][2], I am bringing that change into v2 as a second
patch, which keeps the refactor separate.

Changes since v1: 1/2 only has a new commit message, and 2/2 is new.

I ran the full test suite, and the reflog tests with reftable, sha256
and SANITIZE=leak.  Against the base, the output differs only where a
reflog is reached twice.

Assisted-by: Claude Sonnet 5.5

[1] https://lore.kernel.org/git/avLDE1gGsjjy2ryd@pks.im/
[2] https://lore.kernel.org/git/xmqqwlqlydo2.fsf@gitster.g/


Laveesh Bansal (2):
  builtin/reflog: expire --all and named refs in one loop
  builtin/reflog: expire each reflog only once

 builtin/reflog.c  | 56 ++++++++++++++++++++++++++---------------------
 t/t1410-reflog.sh | 14 ++++++++++++
 2 files changed, 45 insertions(+), 25 deletions(-)

-- 
2.54.0

