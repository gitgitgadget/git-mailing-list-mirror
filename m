Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B736147C78
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711926089; cv=none; b=uPo/Rr/VfXE6kZzC7UOvgXW3NvmcZVHa4EwoDvcvE2WDWOARvlWw6nQMSwsC4h3NJUJvYU8w9ZLA7ZXS2UxyzGVm7a1h76IhmWTQbTeeeIkdjcEVhIz+cZ/FVRUYqwuLHEwxJjqNsMGFZF1/AKfm3akjBQexlhyHMSjl2ETLt9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711926089; c=relaxed/simple;
	bh=U2DZSwmqFk9yi9tLTCWUZMc3jQPbjg+g8adm5ZbCFo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rDPfJOlKRXALwVUJ0bTNZjRR92jdE10YWenCGgE+cBrz9MjJXC34uWkx4MqwcdnB7Kfe7dOksPDX+/AekfIp8zjRaxNfgPF5TtuROv8DukWJ1ABcZW2vYBesJygJBFdE4HA+Ac38h6KymZ0HK22fqETxhfWBgOHFJTq3EPAaCR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PG8s6Zox; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PG8s6Zox"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D27E53779B;
	Sun, 31 Mar 2024 19:01:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=U2DZSwmqFk9yi9tLTCWUZMc3jQPbjg+g8adm5Z
	bCFo4=; b=PG8s6Zoxb2znP0BdPDcQTEH4J+MGEysr8dB5Gc32CC7x2I4RomSgs7
	PHjAgdi8VQD0YLpX/oTpsngljmD1u1Pn84Yp55aWgCD0j3lbUGK0XbsD6j8wZ+Qc
	Zlaj59Fpr4BlqvF1Ut82cbDV2bx3ZarK+MHowDpnuE6ORiyDDJTqw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CBD603779A;
	Sun, 31 Mar 2024 19:01:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 47F8237798;
	Sun, 31 Mar 2024 19:01:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] config: fix some small capitalization issues, as
 spotted
In-Reply-To: <26135b06c48565ee8ac6dcfc1ef5431511e6202c.1711918168.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Sun, 31 Mar 2024 22:49:30 +0200")
References: <26135b06c48565ee8ac6dcfc1ef5431511e6202c.1711918168.git.dsimic@manjaro.org>
Date: Sun, 31 Mar 2024 16:01:22 -0700
Message-ID: <xmqq34s6f1kt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 98E060B6-EFB2-11EE-9E78-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Fix some small capitalization issues, as spotted while going through the
> documentation.  In general, a semicolon doesn't start a new sentence, and
> "this" has no meaning of a proper noun in this context.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>
> Notes:
>      * Fix some small capitalization issues in the documentation.

Thanks.

> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 2d4bbdb25fa3..41b071d8851c 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -688,7 +688,7 @@ core.createObject::
>  	will not overwrite existing objects.
>  +
>  On some file system/operating system combinations, this is unreliable.
> -Set this config setting to 'rename' there; However, This will remove the
> +Set this config setting to 'rename' there; however, this will remove the
>  check that makes sure that existing object files will not get overwritten.
>  
>  core.notesRef::
