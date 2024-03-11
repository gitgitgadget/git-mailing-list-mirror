Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8068B3C46B
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176747; cv=none; b=m1Q113vz8iX7i6/yp4Lgk2wCO7R7NIHM8ge0vW8jYJoJHYcihO3adIz7artF/FOQc3k6QIXhIoTukiZNgi9+3/fwbNXSPa4yiewWkW85g47scQbGrwfgY9CBX7q22dkdKkz/KyX+gE6a09EJPJv1sLo2IbvYIy/hUPusfTKqC4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176747; c=relaxed/simple;
	bh=UvYnvNCFH4DPRWR/HLgJaL1CJiT1Va1Rhm8PzmaMFFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KgMy5nOGSBQ6r7Fn9xNg7hSML6U4OTRkZXZbu2t5zWAjNvFy6kNGhyZlRwgE3Qjc3UO+QLvC0XWZwNp70PcoZipXbSVn2Z5/kblImSWuhaFzcmtGqY5FmjH8xidlyIdJzE/l3A/fn3LxKMr3P0I2WWNKh2R8n7AHY/BlI4O/UsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IddavwKJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IddavwKJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0EEA025C69;
	Mon, 11 Mar 2024 13:05:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UvYnvNCFH4DP
	RWR/HLgJaL1CJiT1Va1Rhm8PzmaMFFM=; b=IddavwKJ48Dp3Iim/inPG3eXx+Tt
	f7lk3GfXjn92xEoEIpygz/LgJaKD2+IFlT4GyD7kRe6SFsE0FpPWTQZamg9pWGJv
	7KDDcj3Kt33xdvmWJj9GQ8FEUWO3YjX8jHxZ257b5ovw0yiJL/dK3s/+dPjabQog
	x6WEoPPJYAWzHdQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 076A525C68;
	Mon, 11 Mar 2024 13:05:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A24525C66;
	Mon, 11 Mar 2024 13:05:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 6/6] doc: git-clone: format placeholders
In-Reply-To: <9a949d98a3ec8b7730b5a6b66e8ef8bb62cd06aa.1710097830.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Sun,
 10 Mar 2024
	19:10:30 +0000")
References: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
	<9a949d98a3ec8b7730b5a6b66e8ef8bb62cd06aa.1710097830.git.gitgitgadget@gmail.com>
Date: Mon, 11 Mar 2024 10:05:39 -0700
Message-ID: <xmqqbk7ku2ak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 975B0CB2-DFC9-11EE-8BDC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  --bare::
>  	Make a 'bare' Git repository.  That is, instead of
> -	creating `<directory>` and placing the administrative
> -	files in `<directory>/.git`, make the `<directory>`
> +	creating _<directory>_ and placing the administrative
> +	files in `<directory>/.git`, make the _<directory>_

It is hard to decide what the right thing to do is to the earlier
one on this line, isn't it?  It is not fully verbatim, even though
its "/.git" part is.

Everything else in this entire series looked good to my cursory
read, but I'd appreciate extra sets of eyes, of course.

Thanks for working on this topic.

