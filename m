Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45761CD21
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590354; cv=none; b=f30ciZWtd7fGXynhm0AZkqkTRr0AFxpwhQqimiV7Nn+IXPEx6Qr/tzmwfGd4LA2mN5ZjPiPIwkNlXDs/dSNc7fk1kNDl60EPC6u5Tka23e5488n1ng4AzAf9LL3p9vKGs9Kj60zt479V+es0zRIjf60szeWtWfB+rXl1GhlsdeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590354; c=relaxed/simple;
	bh=S0q1pAdQaY0H/KdQMFZARmdZiEB4AtiXEz4PdGA95A0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WPag1BYa0o1QpQPphP4wdGn+EhIOwMw59410XYaV2VLOr+j5zPKbRcWw0tGvvD63/P2MGgBg+yp4qaffzVl6xA/xZewMgUwfVK9m7njM0YnU1hmOHlQ3wstXaLmAKqt+HLO2RO0W90sai05ZxZtjIWgh0Hs2wzpZklMmT7ONsUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] diff: copies-harder support
In-Reply-To: <20240311213928.1872437-1-sam@gentoo.org> (Sam James's message of
	"Mon, 11 Mar 2024 21:38:52 +0000")
Organization: Gentoo
References: <20240311213928.1872437-1-sam@gentoo.org>
User-Agent: mu4e 1.12.2; emacs 30.0.50
Date: Mon, 08 Apr 2024 16:32:29 +0100
Message-ID: <875xwr27le.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sam James <sam@gentoo.org> writes:

> range-diff:
> ```
> [...]
> ```
>
> Sam James (2):
>   diff: implement config.diff.renames=copies-harder
>   diff: whitespace cleanup
>

It was pointed out that
https://github.com/gitgitgadget/git/pull/1606#issuecomment-2002137907
that I forgot to add the changes in v2/v3.

v2: Documentation phrasing fixes.
v3: Split out whitespace & formatting changes into their own commit and
apply missed documentation phrasing tweaks.


>  Documentation/config/diff.txt   |  8 +++++---
>  Documentation/config/status.txt |  4 +++-
>  diff.c                          | 14 +++++++++++---
>  diff.h                          |  1 +
>  diffcore-rename.c               |  6 ++++--
>  merge-ort.c                     |  2 +-
>  merge-recursive.c               |  2 +-
>  7 files changed, 26 insertions(+), 11 deletions(-)
