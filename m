Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FFC3EA66
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E3wbA93c"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A78861BC4E9;
	Fri, 15 Dec 2023 11:47:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TbOVWjTkrNO8bRzKfrSnOCRPN4XRcYA+VYCaxV
	aJkJo=; b=E3wbA93cP+wirGTMlx7xEcfoHRwxwZJMUQJqOIBnjdmDQPCVIoZLLL
	4DNXt/yU2xDFBOrUCadO+ToUMq+me+Hz5jehlbWCgx92gOYVxqrSeJJ332Q5jtTP
	c9hIoCKe/Zv9DYYyhApUBi9KVjwrrC1XutnSixT4J5l4/MbHdCfbA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E05E1BC4E7;
	Fri, 15 Dec 2023 11:47:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15E901BC4E5;
	Fri, 15 Dec 2023 11:47:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Git List <git@vger.kernel.org>,  Jiang
 Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 1/2] t5574: test porcelain output of atomic fetch
In-Reply-To: <CANYiYbGaJjnuVx7wJshgqiwvpGTmdq2JiOe4S_ph1bgiZ7XTJg@mail.gmail.com>
	(Jiang Xin's message of "Fri, 15 Dec 2023 19:16:36 +0800")
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
	<cover.1702556642.git.zhiyou.jx@alibaba-inc.com>
	<210191917bcfa9293622908c291652059576f3e5.1702556642.git.zhiyou.jx@alibaba-inc.com>
	<ZXwi2MA-KUxszfGj@tanuki>
	<CANYiYbGaJjnuVx7wJshgqiwvpGTmdq2JiOe4S_ph1bgiZ7XTJg@mail.gmail.com>
Date: Fri, 15 Dec 2023 08:47:09 -0800
Message-ID: <xmqq1qbnmn02.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 96ED368C-9B69-11EE-9EDC-25B3960A682E-77302942!pb-smtp2.pobox.com

Jiang Xin <worldhello.net@gmail.com> writes:

>> Nit: you could also do `for opt in "--atomic" ""` directly to get rid of
>> this case statement. Not sure whether this is worth a reroll though,
>> probably not.
>
> Yes, your code is much simpler.

Yup, thanks for careful and helpful reviews, Patrick, on both
patches.  And of course, thanks, Jiang, for working on them.

