Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724337A49C
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704944; cv=none; b=ID24D6bopL9TZqUDY6Z3GNCqiod8yItLIZ4Fa4+tyeavYKQOc7ngmoqjCNvrcFYngARMcxSz0iVrdvqMxTijYVD//VedylNRa+2H/j75d0s+Qc8N8a0fD5zW5n+Ia6PTzut8vefxQ6tIAncgOm7CSg6h20ofLggBx8mdwkdajns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704944; c=relaxed/simple;
	bh=bimdGDGSQKlQ9TiefYToEUrK0vmtrRGGmuK+whhr8Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+u7p150Ay6fxgkiNlkkLFezupcl0nIC4+1QZvYN5pxr+UgxQZBQQNN3sKAy3BYAeczswNdth4gDRkTGI+P1GL5UZqdxyN91G3n6d6mvBp0MWfdgEjyaHBF+idOCtXe0kVaGLd/TzTMaLpRTinQBHTDyh2jzvsC3tuxPtYDQzcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=dA4XWAeR; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=QVonOIhW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="dA4XWAeR";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="QVonOIhW"
DKIM-Signature: a=rsa-sha256; b=dA4XWAeR/gevbcmMR8OkUaRpXjMhHKCD4od54acmexZD4PP1c0tVsK2DRcBKWzTckoOK4nNmMkqAARuc1+YNWrYJKOh8JP9oFQ/wdy3EztAKH/u8wbHNfVX8cZTSNXRwpWHRpuPfkw6VsYeP1R9+xk8OpDwnLdg1Jcht2yPAI7yyvsG9NYwwtOppkdNAMEmPxaNsQvdg5PWj8g2NyWrOoQTzgtBZwRtYBUP2Lu2NT+UmPxcwR2Vk7fFEjWV3Z/TlHelDroD6r31SLjLs8jEEoLFxfxqBAs79IuriIdzS4fY9V+ZHxoJYoXUjqCSS5yYpTvFzUl9F8BzTMto4MgHbEA==; s=purelymail1; d=malon.dev; v=1; bh=bimdGDGSQKlQ9TiefYToEUrK0vmtrRGGmuK+whhr8Mc=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=QVonOIhWdbRe6b054ngm6P8WiWobV+tbIASilwr8dOriWiVDu4g74W84Lt0Ag44o4vKKCsPploeUSOsMtajG5/BnA1hQeO/PPJI8IkkHnW9NnXykCgUcErLdyiYwrCz6EsZGS7rHHm33s39nUIp0PDA3Am2I2MRVLULV3nge56RoxJp+GF0/JC8FCUPiTvJ6giLAn7a1vBjOYZmebHY/huMVp8JbFq4oU063GfHZdyigET8nzUru1mPeBo4G50JK3jN4/XxJm8Jd4VzsUtdvZJkY/7c2fKoPsRq3iFMaiu6qcSuRwCiITVM50q3uFvCwuatZc69aB/srXbsN9eXRig==; s=purelymail1; d=purelymail.com; v=1; bh=bimdGDGSQKlQ9TiefYToEUrK0vmtrRGGmuK+whhr8Mc=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1441823019;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 20 Apr 2026 17:08:56 +0000 (UTC)
Message-ID: <e071f152-c718-4680-ad15-769591080ac8@malon.dev>
Date: Tue, 21 Apr 2026 01:08:52 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Mirko Faina <mroik@delayed.space>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Jean-No=C3=ABl_Avila?=
 <jn.avila@free.fr>, Jeff King <peff@peff.net>
References: <20260418164736.2367523-2-mroik@delayed.space>
 <fbea5f1c-946b-400e-a9a2-2c6d7b088d46@malon.dev> <xmqqv7dlr4yz.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqv7dlr4yz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 4/21/26 00:06, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
>=20
>> I think the space complexity here could be reduced a little. After all,
>> since we=E2=80=99re only retrieving a few commits, there=E2=80=99s no ne=
ed to load the
>> entire reversed commit history into memory.
>=20
> Does "we're only retrieving a few commits" come from the fact that
> the command example is "log --reverse -3"?
>=20
>   - What should happen when you give "git log --reverse=3Dbefore"
>     without "--max-count=3D3"?

I still wanna talk my way out of it ;)

If we maintain a window of length K out of N nodes:

   - If K is small (e.g. 3), The space complexity is strictly O(K),=20
which saves a considerable amount compared to the unoptimised one;

   - If K is huge, reduce to traversing all N nodes. At this point, the=20
space complexity is the same as when unoptimised (O(N)). At most, there=20
is an additional time cost of O(log N) for stack operation, which can be=20
disregarded.

It seems like a strategy that could be applied consistently, but...

>   - What should happen without "--max-count" but other limiting
>     options, like "--author=3DTian" or "--min-parents=3D2"?

I must admit you=E2=80=99re absolutely right on this point.

If we were to introduce a new state machine and data structure for every=20
type of parameter, it would indeed be rather cumbersome to maintain and=20
not particularly cost-effective.

> It might be that the right way to look at this new feature is not
> that "we are changing where reverse is applied", but "count limit is
> applied much later than usual", which may mean at the UI level, it
> may not be good at the conceptual level to sell this as an extension
> to the "--reverse" option?  I dunno.

That's what I meant to say earlier in the 'nit' section. I couldn=E2=80=99t=
=20
quite put it into words at that time :((

Thanks, Yuchen

