Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D89E555
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 02:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712370424; cv=none; b=kJfGtClQ+lR7pQ/c3xR7b0sqbG05iV8sHHvBjjuYPvt5x0Y/IxUtOQjzO6PJY1RaNi2y8AVqvApd+SCcaPCI2/FVrM9uk1igZJAZwY7aV0qdD5PYFxniagm40tdSUVtSgquIBXHkaFCFyZfrysBjgKA9v3WdbHWabGjuCO1NNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712370424; c=relaxed/simple;
	bh=EP09luZMCUMi0A6VkPL7xBLv5N8ve64l9Vb6iyBRUfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qPMnqhW0XXMZrgp3/7WDrtp6RN9mQratb+3eCFQsAZDrTYfOLI0pI1sVddTQaNNr8CkFI47YVC7/v9gIGpGXdQZAWLe5Mie/iBClQSAlcQZxHk7UwdRR2770sOBEN3Tc4WywCj8F2Q7xJtTIKLSRHu+/ivJT/kQmuStJd3Umtnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dLA8WtXS; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dLA8WtXS"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 47D9B1DC1A0;
	Fri,  5 Apr 2024 22:27:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EP09luZMCUMi0A6VkPL7xBLv5N8ve64l9Vb6iy
	BRUfA=; b=dLA8WtXS7jj7nb14wXrua+t41TDa09y0iHtShQC3jfHB2U5A+nPsuw
	vj/zKAc78rCL+QU33LcwpYXEdUXAzb/l37n6iISZADsoE38nW5rd3QSfNHh2yLAN
	16NWSBPv72cut7oV/7gyz42xqPY2bATlf/89rmuKxYcKEstLV50Sg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BD87F1DC19F;
	Fri,  5 Apr 2024 22:27:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C8871DC19D;
	Fri,  5 Apr 2024 22:26:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 3/8] SubmittingPatches: mention GitGitGadget
In-Reply-To: <6e6950afa6e6e884ee89ac24c05b50dcc722657d.1712366536.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Sat, 06 Apr 2024 01:22:11
	+0000")
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<6e6950afa6e6e884ee89ac24c05b50dcc722657d.1712366536.git.gitgitgadget@gmail.com>
Date: Fri, 05 Apr 2024 19:26:58 -0700
Message-ID: <xmqqy19rp6od.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 25A087E8-F3BD-11EE-B04B-25B3960A682E-77302942!pb-smtp2.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/SubmittingPatches | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index a33fe7e11f6..48b270b4c48 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -408,6 +408,10 @@ are optimized for the workflow of sending patches, avoiding many ways
>  your existing e-mail client (often optimized for "multipart/*" MIME
>  type e-mails) might render your patches unusable.
>  
> +NOTE: You can also use GitGitGadget (https://gitgitgadget.github.io/) to send in
> +your patches. The discussion here focuses on using `format-patch` and
> +`send-email`.
> +
>  People on the Git mailing list need to be able to read and
>  comment on the changes you are submitting.  It is important for
>  a developer to be able to "quote" your changes, using standard

Rather than giving the URL and have the readers figure out how to
use it for themselves, it would be more helpful to readers to refer
them to MyFirstContrib document.

    Note: we outline the procedure using `format-patch` plus
    `send-email`, but you can also use GitGitGadget to send in your
    patches (see MyFirstContribution document).



