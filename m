Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E07EAD0
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726863436; cv=none; b=CT5yx1N2m6tf+zloI4ua9mbrMlU/N6Vimw3m1ra7NdbQV0aMUk6mrasQVk01q1UBwZ8j6bT8BvRHeXE2KEl5fhCSHKHiydc71XZAK54etta+0kZuCss9xA7L15oUcj78t1XjFWeumRf0pDBWb3bxrsww5Wc8+Y1nkrZ/LC/NBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726863436; c=relaxed/simple;
	bh=CjWK4hk9Aur3OGRj1nqVKQxvLtroJfsKKFMoHZSk89s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LhzNDlo66l77YbC9hJHJ3S4dPCR/9BoLUs+14MeXQg7Zgg3v7SK1RNrAVqRJnbGMv2NF38dE6addsT/KNC/CKH6eK7Ql2+P/HerAh325PvJjFWoLRith4mrpIF6cqjRQATpn9df2OYLnFb/UaNTUDjQwYAigaCrt2xGfSvrPRok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ARI1h1Wz; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ARI1h1Wz"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A865318C40;
	Fri, 20 Sep 2024 16:17:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CjWK4hk9Aur3OGRj1nqVKQxvLtroJfsKKFMoHZ
	Sk89s=; b=ARI1h1WzqOcjQX2+n9TeEMOxgIHXu1ADpqV8hQANS74GElntJ702nk
	4qcYq7lm2a/hTGRvpNxnL6+ed6Avo3DbTrEqE5mb6t7vpzK6JMJo5M8oMTwmAtKo
	ENYOyh/EqP9JWms+cBXDUkpa3E34aic7N16EkMpNIW/EA6gXOFJtA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A07F618C3E;
	Fri, 20 Sep 2024 16:17:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10F6718C3C;
	Fri, 20 Sep 2024 16:17:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: fix typos
In-Reply-To: <20240920082815.8192-3-algonell@gmail.com> (Andrew Kreimer's
	message of "Fri, 20 Sep 2024 11:28:15 +0300")
References: <20240920082815.8192-1-algonell@gmail.com>
	<20240920082815.8192-3-algonell@gmail.com>
Date: Fri, 20 Sep 2024 13:17:10 -0700
Message-ID: <xmqq7cb6f5bt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 528CCF06-778D-11EF-9B4D-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Andrew Kreimer <algonell@gmail.com> writes:

> Fix typos in documentation.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---

Some hunks have become irrelevant between 'master' and 'seen', it
seems.  Please separate them out and resend once these in-flight
topics are merged to 'master'.

Thanks.


>  Documentation/BreakingChanges.txt        | 2 +-
>  Documentation/CodingGuidelines           | 2 +-
>  Documentation/DecisionMaking.txt         | 2 +-
>  Documentation/gitformat-commit-graph.txt | 2 +-
>  Documentation/gitweb.txt                 | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
> index 2b64665694..112770a9da 100644
> --- a/Documentation/BreakingChanges.txt
> +++ b/Documentation/BreakingChanges.txt
> @@ -117,7 +117,7 @@ Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
>  
>  * The git-pack-redundant(1) command can be used to remove redundant pack files.
>    The subcommand is unusably slow and the reason why nobody reports it as a
> -  performance bug is suspected to be the absense of users. We have nominated
> +  performance bug is suspected to be the absence of users. We have nominated
>    the command for removal and have started to emit a user-visible warning in
>    c3b58472be (pack-redundant: gauge the usage before proposing its removal,
>    2020-08-25) whenever the command is executed.
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 3263245b03..8a5e0b7dad 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -838,7 +838,7 @@ Markup:
>   When literal and placeholders are mixed, each markup is applied for
>   each sub-entity. If they are stuck, a special markup, called
>   unconstrained formatting is required.
> - Unconstrained formating for placeholders is __<like-this>__
> + Unconstrained formatting for placeholders is __<like-this>__
>   Unconstrained formatting for literal formatting is ++like this++
>     `--jobs` _<n>_
>     ++--sort=++__<key>__
> diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMaking.txt
> index dbb4c1f569..b43c472ae5 100644
> --- a/Documentation/DecisionMaking.txt
> +++ b/Documentation/DecisionMaking.txt
> @@ -54,7 +54,7 @@ implementation, for very large changes).
>  
>  For non-technical decisions such as community norms or processes, it is up to
>  the community as a whole to implement and sustain agreed-upon changes.
> -The project leadership committe (PLC) may help the implementation of
> +The project leadership committee (PLC) may help the implementation of
>  policy decisions.
>  
>  
> diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
> index 3e906e8030..14d1631234 100644
> --- a/Documentation/gitformat-commit-graph.txt
> +++ b/Documentation/gitformat-commit-graph.txt
> @@ -122,7 +122,7 @@ All multi-byte numbers are in network byte order.
>        for commits with corrected commit date offsets that cannot be
>        stored within 31 bits.
>      * Generation Data Overflow chunk is present only when Generation Data
> -      chunk is present and atleast one corrected commit date offset cannot
> +      chunk is present and at least one corrected commit date offset cannot
>        be stored within 31 bits.
>  
>  ==== Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
> diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
> index 56d24a30a3..5e2b491ec2 100644
> --- a/Documentation/gitweb.txt
> +++ b/Documentation/gitweb.txt
> @@ -234,7 +234,7 @@ from the template during repository creation, usually installed in
>  configuration variable, but the file takes precedence.
>  
>  category (or `gitweb.category`)::
> -	Singe line category of a project, used to group projects if
> +	Single line category of a project, used to group projects if
>  	`$projects_list_group_categories` is enabled.  By default (file and
>  	configuration variable absent), uncategorized projects are put in the
>  	`$project_list_default_category` category.  You can use the
