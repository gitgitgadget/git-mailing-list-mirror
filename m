Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BD13C8E8
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714238696; cv=none; b=ZtJLfhkWKz/dfk0neo1cg3YaAjGKtmU2k4gap/rw3cMLrM9xQt1O8cM6rVJHZcJQdNxbJSMQcinhVN+bneYSTN82rMzxePCkzZQX2ggUT+Xzc0UDFglJ3OXxiNsmnLJEcyM9MButF+IB8ZZsX9mUhzj2V9RA/RLYTyu316cJ1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714238696; c=relaxed/simple;
	bh=+LEYUuHjRNnpVejwZe9MJa+dqiuS3WkFZFWTs33sRj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQYqJyMcpMzISXwEJC726lNaHi0hPR04mBT556quqO+CHPW2MGKEriSG583iTGEevA5mEQQQNiarz6Rh8wb8CVB27Bvsd+lbiWhLaThEbS57NibsYWGYoKZa+1VJDxDtmlpVpOyFyypcRlf1K43lq6VEoCRYsWYo/Ij56gyS3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dvLnRY72; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dvLnRY72"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F18334024;
	Sat, 27 Apr 2024 13:24:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+LEYUuHjRNnpVejwZe9MJa+dqiuS3WkFZFWTs3
	3sRj8=; b=dvLnRY72esSTSjw2w9wNihjcWw9akNbx68YEifY6RPp+Lo1Cx95ffs
	yk4XT+uko3YyJ7UAcy0dCo8Vhfwo0j1uLJedTFJiKX9k8Gw4jfk63cmhiSqg5F3U
	vdMvuX728xYvkkLS/+oTNHqvAMIv0IUIDkqTodCA3qnmjPNZtUBqs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 17AF734023;
	Sat, 27 Apr 2024 13:24:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 34DDE34022;
	Sat, 27 Apr 2024 13:24:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,  Pratyush Yadav
 <me@yadavpratyush.com>
Subject: Re: Git-GUI change of maintainership
In-Reply-To: <0241021e-0b17-4031-ad9f-8abe8e0c0097@kdbg.org> (Johannes Sixt's
	message of "Sat, 27 Apr 2024 16:27:52 +0200")
References: <0241021e-0b17-4031-ad9f-8abe8e0c0097@kdbg.org>
Date: Sat, 27 Apr 2024 10:24:40 -0700
Message-ID: <xmqqedaq67mv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08A7007C-04BB-11EF-8B7F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> In [1], Pratyush has expressed the wish to hand over maintainership of
> Git-GUI. Since Git-GUI is an important tool in my toolbox, I would
> volunteer to pick up the task.
>
> Pratyush, please let us know if this would be OK for you.
>
> I will let you all know if and when I have set up a repository to pull
> from or to fork.
>
> [1] https://lore.kernel.org/git/mafs0wmxkcs3o.fsf@yadavpratyush.com/

Nice.  Thanks for volunteering.
