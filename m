Received: from joooj.vinc17.net (joooj.vinc17.net [155.133.131.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D0346FA6
	for <git@vger.kernel.org>; Tue, 12 May 2026 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.133.131.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620638; cv=none; b=ezBLYExLhue+bpqwym6NFYWc3x+3Klrh9C4B2y5RH+tiYjgNgWnYqks+cYY8JxaaCVD3LfH5wB+lnxROikawlJju9KyC3bDujkTgmnjxV+1054H2PBFqgHmwJVfzL1oTcqd0fM08DGWmQkw8CHp8QtcbCaAAQdhO/tIHcm4mE28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620638; c=relaxed/simple;
	bh=RdzawUSraO3P0HCiecvI33vv7W2ax3S+VUcvN98rk9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdG13BeAHrY4/o3dAv8OpW34nwdXkY4/StgbMAXYufW6g4ilOdRNSliudKxT1wrJRSwWyoP3bl9LGTDgOX47UQufLy7Qoqpzew9PXvuTz9BzARhmcLRj63czN+zBOkanla3CJPhYn5nCTqtrbfB6bdGQFrDGvT0EHrfbyxeCcgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=155.133.131.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from smtp-qaa.vinc17.net (135.197.67.86.rev.sfr.net [86.67.197.135])
	by joooj.vinc17.net (Postfix) with ESMTPSA id F3FDF469;
	Tue, 12 May 2026 23:17:07 +0200 (CEST)
Received: by qaa.vinc17.org (Postfix, from userid 1000)
	id 74B66CA3CA1; Tue, 12 May 2026 23:17:07 +0200 (CEST)
Date: Tue, 12 May 2026 23:17:07 +0200
From: Vincent Lefevre <vincent@vinc17.net>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org, j6t@kdbg.org
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
Message-ID: <20260512211707.GB1516810@qaa.vinc17.org>
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.3.2+113 (95d3615f) vl-188789 (2026-05-11)

On 2026-05-12 13:56:19 -0700, Michael Montalbo wrote:
> Maybe something like this would be worth adding to the docs:
[...]
> +Word diff works by finding word-level changes within each hunk of
> +the line-level diff.  The line-level alignment determines which
> +changed lines are compared to each other, which can affect the
> +word-level output.
[...]

Yes, this would be useful.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)
