Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EF610788
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720912906; cv=none; b=kicCgZQA69OcuMdjKmNw9kRB9qOGzCCVWeruvfTefkpItUWkLM7suhEa9UE4F/qQEfKUzrHdGgur2X90myquAoQrw2qFViGgGBkUhC3C5XeToaCKNiOmaoKgDqbw6TF8psB+dbnjTPdsWdOZQJd0BBQq8075okGbsCLT1QF/pKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720912906; c=relaxed/simple;
	bh=HlETb7Z6Nj1X3HYq/AvjSlL/6YukL6oDB7BVdCD6VsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqQLLXRKDKEKAM+HM4b3xQ5VUzyp9GBR0xtgoVrb4n2qo7PTArutl7JyPu2lAY1Z1A1Px36eSxWLsmoQtYIvD3wPbjVZfqOigMI3GmXw8PQk4GaukvbzYUC3u6qb4NwDlBzlEXjGm68oeZtC7SH8yLidRzfTXJDDPE90JaZFLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=fail (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Vy7cr59Z reason="signature verification failed"; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Vy7cr59Z"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id Sm0esebQ0ItnuSm0fsJit5; Sun, 14 Jul 2024 00:18:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1720912714; bh=YxRZNGvMNiyXqKCdSGw6xB0K5ZCB1L9Fs7lXjtGpOMg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Vy7cr59Zq79inA1A2gH1naV6wm9yIJcZoJa1Y7BpJIKdwCp4wKwMQoJwhrTSNCJHn
	 yovp5qIP8eojT/uXLj6Xk2h3JYkGMmbL8e7tAGXSaIWQYusgKVDxhXSU0yWJiD5edD
	 EGcJugQ5QBNVqYUDMuykmj0vBygBSM0ZzdBpE8B/3FXxWamlpvXHT1dmbKMJaP5kOi
	 Z5bLFVXmSt2bLyEe6A51GdoHo1zAHOclX8TVj3uPO34/drhrt59DjVmT71amnjNitf
	 swf/lS30lKxduVnbGd4AxnGwP1Gpoh9zBrksoOYy6+NX46uWdyk42NsPIDMail7h5M
	 /tavMKE6bc94Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=XMWTShhE c=1 sm=1 tr=0 ts=66930b4a
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=LtpAsZ8yp8vebK9HaCYA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <cccf899d-12c4-4046-a958-33374bb870c6@ramsayjones.plus.com>
Date: Sun, 14 Jul 2024 00:18:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] ci/style-check: add `RemoveBracesLLVM` to
 '.clang-format'
To: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com,
 phillip.wood123@gmail.com
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com>
 <20240713134518.773053-9-karthik.188@gmail.com> <xmqqa5ilcngi.fsf@gitster.g>
 <CAOLa=ZTkYs_Wz2YM82Nm0yPJX8-hYV3WC-aMEqYNRoS+2ZpG3A@mail.gmail.com>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <CAOLa=ZTkYs_Wz2YM82Nm0yPJX8-hYV3WC-aMEqYNRoS+2ZpG3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGpRbV7drAD7PONeUNnG6WJJWRE+fmIADKk5qwPqNmDnzboEy/CAfs7+9QMUmgzJML4IHQ/4imxABTNXwE3Oo9J1r8fnFH0pFhsi/5Y13LisUGtUoLgk
 UJTNRmuvKa5xZk1ACV3dC7vLh/U//+yD5WaCrrUb+CwmdpkdHpq6EcEVzzPTCmr6zyEfHBR45bFjSAOdZWEybYVDjH6gb5LktVY=



On 13/07/2024 17:46, Karthik Nayak wrote:
> Junio C Hamano <gitster@pobox.com> writes:
[snip]

>> I unfortunately couldn't find an option to "git clang-format" to
>> tell it to read from an extra file in addition to the usual
>> ".clang-format" file---if such an option existed, we obviously could
>> use an untracked/ignored file to prepare the custom format file and
>> use it without making the working tree dirty.
>>
> 
> This was also something I looked for, but couldn't find. I should have
> added that to the commit message. Will do so in the reroll.
> 

I had a need recently to try applying the git '.clang-format' file to a
different project:
 
  $ pwd
  /home/ramsay/sparse
  $ clang-format --style=file:/home/ramsay/git/.clang-format sparse.c >xxx.c
  $ meld sparse.c xxx.c # oh my lord :)

Note that I had to specify '/home/ramsay/' rather than just '~', since it
does not get recognized/expanded in that position:

  $ clang-format --style=file:~/git/.clang-format sparse.c >xxx.c
  Error reading ~/git/.clang-format: No such file or directory
  $ rm xxx.c

Also, as you can see, this was 'clang-format' not 'git-clang-format' (which
is what would actually be used in this situation), but the '--help' text
claims that:

  $ git-clang-format --help | grep style
    clangFormat.style
    --style STYLE         passed to clang-format
  $ 

.. so it should work (but I have not actually tried it, so YMMV ;) ).

[So, munging the .clang-format file with sed (say) to a temp file and
using the --style=file:tmp-file syntax should (hopefully) work]

ATB,
Ramsay Jones

    

