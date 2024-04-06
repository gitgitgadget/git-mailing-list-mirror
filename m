Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0630911CA9
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712370143; cv=none; b=gVyuDnlmzakpNUmHQkRnmA2QAawxImZz64qmHEUof+lGkwx8HTe+MdNh1gOLW5x8HrtDks8XiuyG0RKnFI1PXJMLI7cJqXJqY3DUu4GNdkCUFMLuFxKSHip3d6RStx6Q4SV+Xw8XByIG1yIcqvciEOAupzW7iuk8bDXZ8qoDmvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712370143; c=relaxed/simple;
	bh=LdSpUy9qJwWoufqU3Hry8/EWk4jAgeGl4tnm8Do633M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E1VXwc9C0Xrw/bujU9W/sd+3Qxcdi4QSXM6Gx648p6E5somr/xhWmr13uAZme5XldjvyqeXO9BV3LdB5D4dM4XsvNU5orr2qD9Mio+3HQ0u3PH1T443oIQtvInoGjOFnGCgu7a2DxluIqghsm48l8NFxV4IDN1tp3Q+YLADqSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rxTH/4p7; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rxTH/4p7"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A90624D61;
	Fri,  5 Apr 2024 22:22:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LdSpUy9qJwWoufqU3Hry8/EWk4jAgeGl4tnm8D
	o633M=; b=rxTH/4p73DVqQ4Emdq4HQpxb2Am5M60Q3JwNcMMUiz/KWYvSuvoS55
	baFotHjFHwTpNUBSNO+FsPeGoq09K10IeRsczc33cP7gcBQo0zeGwFppQXbY990L
	+J5KLXrpXRqCpW+cGhGci60FzmkRgki0RPRDu1exCkc7YM/2YM3Oc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6350724D60;
	Fri,  5 Apr 2024 22:22:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DD98724D5F;
	Fri,  5 Apr 2024 22:22:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 1/8] MyFirstContribution: mention
 contrib/contacts/git-contacts
In-Reply-To: <3817e7f3cd007fe26b8bfdec6babed1c17ec3795.1712366536.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Sat, 06 Apr 2024 01:22:09
	+0000")
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<3817e7f3cd007fe26b8bfdec6babed1c17ec3795.1712366536.git.gitgitgadget@gmail.com>
Date: Fri, 05 Apr 2024 19:22:16 -0700
Message-ID: <xmqq8r1rqlgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7D747D22-F3BC-11EE-931B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Although we've had this script since 4d06402b1b (contrib: add
> git-contacts helper, 2013-07-21), we don't mention it in our
> introductory docs. Do so now.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/MyFirstContribution.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index f06563e9817..ad3989f53e5 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -1116,6 +1116,11 @@ $ git send-email --to=target@example.com psuh/*.patch
>  NOTE: Check `git help send-email` for some other options which you may find
>  valuable, such as changing the Reply-to address or adding more CC and BCC lines.
>  
> +NOTE: Use `contrib/contacts/git-contacts` to get a list of reviewers you should
> +include in the CC list. In addition, you can do `git send-email --cc-cmd='git
> +contacts' feature/*.patch` to automatically pass this list of emails to
> +`send-email`.
> +
>  NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
>  please don't send your patchset from the tutorial to the real mailing list! For
>  now, you can send it to yourself, to make sure you understand how it will look.

Nice.  

I personally find "you should" a bit too strong and authoritative,
though.  Is the tool precise enough that we are confident that we do
not end up spamming those who are not actively helping others?

As I prefer not to be too assertive, something like

    The `contrib/contacts/git-contacts` script may help you coming
    up people you may want to ask to review your patch by adding
    them to the Cc: header.

is as far as I would go, but for those who are not familiar enough
with the project, perhaps it would be OK to assume that the script
would do a much better job than these contributors would do
themselves, I guess.

Thanks.
