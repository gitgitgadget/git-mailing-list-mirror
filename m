Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C55530CF0
	for <git@vger.kernel.org>; Sat, 16 Dec 2023 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d/GQsLTM"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 18D8F1C6E18;
	Sat, 16 Dec 2023 12:34:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=StYDcT1WazFyohx1Oiv/zlypzuNlX9IlTD8Fnp
	3dk/w=; b=d/GQsLTMwetNr1MZBXGUwfmjXrDpeB8GrZh1DEa0RQ33XzK6juO0L+
	J6lCxx7L6z9CUIc4K0SzFL8s/8/Rh6kKpRETnBXM8fIwNzusDjQ5cH6R0RMzsieJ
	Rjje+McuKNZW4ymiPjCt232ngHTsbUgIot+Wh89PGfYBx9b80p3AU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 119AD1C6E17;
	Sat, 16 Dec 2023 12:34:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A9BD1C6E16;
	Sat, 16 Dec 2023 12:34:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Mohamed Mohey <mmi9433@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Question: rerere preimage format
In-Reply-To: <CAAY9aimx4X2jDaFz+jWtAj==g+J3QA8LKPQFePyGFhVvbwKNtQ@mail.gmail.com>
	(Mohamed Mohey's message of "Sat, 16 Dec 2023 17:46:15 +0200")
References: <CAAY9aimx4X2jDaFz+jWtAj==g+J3QA8LKPQFePyGFhVvbwKNtQ@mail.gmail.com>
Date: Sat, 16 Dec 2023 09:34:21 -0800
Message-ID: <xmqq34w2jbky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5996D7AE-9C39-11EE-A9FA-25B3960A682E-77302942!pb-smtp2.pobox.com

Mohamed Mohey <mmi9433@gmail.com> writes:

> My question is:
>
> Is there a reason rerere's output is like this that I'm missing? Or is
> it just there for convenience since it doesn't affect rerere's
> intended functionality?
>
>
> Thanks,
> Mohamed Mohey

Documentation/technical/rerere.txt would be a good place to start.

