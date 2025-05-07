Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C6B1D6DB9
	for <git@vger.kernel.org>; Wed,  7 May 2025 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651708; cv=none; b=J27e9h03j0kPzdhi4P6+ZVnR55pwWkjjHkUseXOXN+buWLyBr+YC9UU9aBV/El4koCH3SS+1ntqoPFe4kF7xgEhqH7SXZCXDzGxJLx6Hw9MV4z5eUlhBrisgedIX79rIjRA84cFxc/+3S59Zn0OLuethz3Gdzqo4AcwwMfRyEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651708; c=relaxed/simple;
	bh=71v0vjximV+LBwYAGVxwmAj1O8+opR70P3JkLCTBGSc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3a2IjjF2Q+G1IhU9zTG8nb8N6z/Yj6R2GTEJqx8tg5RVMfpUsolU22ckNRGnoBetKuhbX6k9ujZRfSZRdp7mteyuPpUVw4poJQZ7D0TWoq5z6ovZbJ9CzB/F90AhYzss2nlQnI4O3TNFgV4LEnki0RRXHbfKU8ZP/nP3cpdRL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id E2A3C835A73
	for <git@vger.kernel.org>; Wed,  7 May 2025 23:01:35 +0200 (CEST)
Received: from cayenne.. (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8C86013F86E;
	Wed,  7 May 2025 23:01:26 +0200 (CEST)
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Additional changes
Date: Wed,  7 May 2025 22:58:15 +0200
Message-ID: <20250507210104.26709-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250503011537.3035416-1-gitster@pobox.com>
References: <20250503011537.3035416-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thank you for helping out with this dull task.

Here are a few additional changes after reviewing the manpages.

Thanks

Jean-Noël

