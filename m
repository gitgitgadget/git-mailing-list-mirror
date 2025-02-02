Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCB2AD11
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482417; cv=none; b=TmCRkyRFVt+g5OJQJj7FLgzy0VaJxzDgUYIiatTmnsn6Q9rLcma7cJFO6QCr+BYuowSeDAbDVTmH2s6euT9oMa80ygw6tHorX4RjjAdQjuBQY8aayAhXw8FSMWv0IzJf24OceX9Q9RjCcOt2d1wn52cz1u0PuV38SRv1DKQcDVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482417; c=relaxed/simple;
	bh=qjy2CmrpGBBWi3GUVLVdady3nMFVfWXWRx68w5AbQYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyUktyACU1tAZhz2XfKFsgLKG0LrGU33pt7DgcbhqgmfW4uohbir1zHqLSHewI1DJ9dU1uqjZk2/SGPaQTv3R2+ljA1aXbnQsy6GD35RjD+LrwGoZS9rTkrj8H+BwMwIJCp1QnDT8HrtDEuwVEhOkQWoOjCOOyXX3RjUlEWR1HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Ym1sy5lqQzRnmM;
	Sun,  2 Feb 2025 08:46:46 +0100 (CET)
Message-ID: <89612095-6b10-44a1-a29c-b143d67ce7da@kdbg.org>
Date: Sun, 2 Feb 2025 08:46:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "meson test" very slow on Windows
To: M Hickford <mirth.hickford@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, soekkle@freenet.de,
 Git Mailing List <git@vger.kernel.org>
References: <CAGJzqsmmq1R9_q=p_AsuFMFr3UzyQ4H186CpfWTnCoAnHu_OXA@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAGJzqsmmq1R9_q=p_AsuFMFr3UzyQ4H186CpfWTnCoAnHu_OXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 01.02.25 um 23:56 schrieb M Hickford:
> Hi. Has anyone else found that "meson test" is very slow on Windows? I
> built Git using "meson compile" with compiler MSVC and backend ninja.

The tests are very slow on Windows in general. Please clarify: when you
say "very slow on Windows with meson", do you then mean "slower than
with a Makefile build"?

-- Hannes

