Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306DA1C28A
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="PieMnYxl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704302081; x=1704906881; i=l.s.r@web.de;
	bh=w142KK/NsXLaBtLY0ypgEuQzb2T7WBHPPjARUAwGyXc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=PieMnYxlkkZjbtGIhAZeIELhB2FKDvQPxrdjW+G6bjNjEwh49wXkd/y8+GbGVIJW
	 eFRdCZwfahObGE24X/wwdIUHzx3YMs53FQq08zCMkkmnlAJ4qQCubeCVB+LJ15KTg
	 2h0v0rcthvCl0x6p2I2zUA+MmCvQ5U5fZ8ZB6/jYtHm3r2VNEffLNNF9VMwXcmGl3
	 G0Wq6GLsDwil7Kv5FYnOK6LWomVZKhrf8xvlucAHXWhbG4sseeg4isM1DRmAp/mHK
	 hm/YJmcWeuOt9H8YnWexYJeQQV5TPlTZPxIh8pcxKPt9sjCIJkqoOB2olSlpp4Iqf
	 ZtC0OfMiP3oY3uPM5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4eGJ-1rBPi23UIh-011Hos; Wed, 03
 Jan 2024 18:14:41 +0100
Message-ID: <a81ecbb1-9ebf-4026-99c3-667ad28e2c80@web.de>
Date: Wed, 3 Jan 2024 18:14:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
Content-Language: en-US
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqq5y0bcjpw.fsf@gitster.g>
 <20240103090152.GB1866508@coredump.intra.peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240103090152.GB1866508@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tRllc9UC3azNYQ9tLspCJ8m4n3jKjEfATXlQ/sQCJVzQ2xv/efd
 9WwN5gRzEKYgJDhM03OGE9KzD28q/+HtiKvj5b4vQCKGKxmFi6J0lzKsQY/MRixe3lafK44
 TzEWhugrBmRamu6+XG8cDYaWAcGfZtFPzN5u8WWwv+h20/5AM+PLzrvBbPU5vFDwu+GFC+k
 uQ8Lsnuodqy3bqWevCJiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VJqWKEFV6hA=;qRqOGgY07JpfXvQhobZIOunrEEd
 thtuLl3kQJBmectrzbWLswOI3rPubIQUTY8xpAETy1rSQQNoU3idJH2ubPa9BdNOasB+MlF45
 d4tiysVuN197WEmOZSFfBesyULi27tQX434f8w8noepnPypxVRd0mn0c/Nj09kBlxIh6evx3w
 VPgytT13Pty3rIR57hTQrOUH/w6yS8rDIF4xQfrK1nEMODg5HPaiFiZQGZDfXyREe0yG5yD3V
 RovcmEh3ZWiAqmyEQZROiIl1f6Z2ammkXfgXv8pnWSjxXBBT0UW7fDwD7SSCIcjmoFwzq8y1g
 hS8qiskWivAjh4S9XXELh5mCjpfQ19EiSmF9JqCwThpzDPgWvzr5fHH+8nx0os6r3TpJLFaJO
 9OZEf2XcdDy86m70hNnAof+uMHmrBqxmBOqyiwIjEbOy+x5dVaGnAxZK2OIzOXzRFl7ZPRYBF
 EXZgwd/x87aKLtS5LMm5WBmX9fLeJKccfrPpK+VVjMVGSZGdp+vjpJzCm7UQBJp9ywRzr6vPU
 NuMmuIAy6rfDOx2o7bfMDCfv/uEBx3+4k4Y4WXVJ1se+mJ9/FK4zMcqH9TncF2G2DW0hRcB9D
 n66Zf207mmTU77pDMlRnNJjI/8Zz1Ohzu7gV4x54cpfQsn5CAiDYBDRfsKibYhZ3BYopVLuMy
 Hih8go9uOS6mFXx9u2LqJAZWwqRtzsX8ypSdBcAFDkwx4ibN2uUKnZBPdBDVF5gAz5L9/HhNv
 CyIuViaJtlUxI3y7dcWgwVZtmnKvnMkkKYtvtYznAi/nnq7NZ0KljIX7AM5hQWKvfosHxse0+
 H/dmNDon3U8i5uXl7nvD8WQCgWpxVxNNwv5u21+dgIHIpoSsn8KSbjAobiE+rYv62dUFosFfp
 j1esZK39SydW52jFx4O50IsYfk2mp4UIZytap7C5hTYuPYfXJUPqq0aL9Lj/jI/cv9ktvqv6e
 /cfTJw==

Am 03.01.24 um 10:01 schrieb Jeff King:
> On Tue, Jan 02, 2024 at 05:02:35PM -0800, Junio C Hamano wrote:
>
>> * jk/t1006-cat-file-objectsize-disk (2023-12-21) 1 commit
>>   (merged to 'next' on 2023-12-28 at d82812e636)
>>  + t1006: add tests for %(objectsize:disk)
>>
>>  Test update.
>>
>>  Will merge to 'master'.
>>  source: <20231221094722.GA570888@coredump.intra.peff.net>
>
> It looks like this is the original version. I posted a v2 that took
> Ren=C3=A9's suggestion to swap out the awk for shell, but it got overloo=
ked.
> I'm happy enough either way, but if we want to salvage that effort,
> here's a patch which could go on top:
>
> -- >8 --
> From: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Subject: [PATCH] t1006: prefer shell loop to awk for packed object sizes
>
> To compute the expected on-disk size of packed objects, we sort the
> output of show-index by pack offset and then compute the difference
> between adjacent entries using awk. This works but has a few readability
> problems:
>
>   1. Reading the index in pack order means don't find out the size of an
>      oid's entry until we see the _next_ entry. So we have to save it to
>      print later.
>
>      We can instead iterate in reverse order, so we compute each oid's
>      size as we see it.
>
>   2. Since the awk invocation is inside a text_expect block, we can't
>      easily use single-quotes to hold the script. So we use
>      double-quotes, but then have to escape the dollar signs in the awk
>      script.
>
>      We can swap this out for a shell loop instead (which is made much
>      easier by the first change).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I gave Ren=C3=A9 authorship since this was his cleverness, but obviously=
 I
> wrote the commit message. Giving an explicit signoff would be nice,
> though.

Alright, thank you!

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

>
>  t/t1006-cat-file.sh | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 0c2eafae65..5ea3326128 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -1117,14 +1117,16 @@ test_expect_success 'cat-file %(objectsize:disk)=
 with --batch-all-objects' '
>  		while read idx
>  		do
>  			git show-index <"$idx" >idx.raw &&
> -			sort -n <idx.raw >idx.sorted &&
> +			sort -nr <idx.raw >idx.sorted &&
>  			packsz=3D$(test_file_size "${idx%.idx}.pack") &&
>  			end=3D$((packsz - rawsz)) &&
> -			awk -v end=3D"$end" "
> -			  NR > 1 { print oid, \$1 - start }
> -			  { start =3D \$1; oid =3D \$2 }
> -			  END { print oid, end - start }
> -			" idx.sorted ||
> +			while read start oid rest
> +			do
> +				size=3D$((end - start)) &&
> +				end=3D$start &&
> +				echo "$oid $size" ||
> +				return 1
> +			done <idx.sorted ||
>  			return 1
>  		done
>  	} >expect.raw &&
