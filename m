Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4131DDCE
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146084; cv=none; b=lVLIE6+PncK9D6xVNFvLSPxoOWnSzpBihzeCuIcUUnH38NL3JSQc4ZdVMj8DsSH2qB+SKqsZWxZYBPaSbjPohlxew12ZewBSk254WIz6zZjEprSlYi+itQ8/gbFRNpbkQC1JJcfEA/YQB7lFPlozANB1fw0S3urVzUkAzzJmMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146084; c=relaxed/simple;
	bh=VQwKRurPEsIux2mB1hRsLjZWb6WM1i8tqsku7o7QS64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kFANWhwoSV4S6+rNH/ivj27GATE/PdCU89qBCYrHUpED5U6rQr70IRu5ve5sXGBeHoNAck0QBKsUhLBIH4+bv3Hu+IQDo9RGuBjFgreJI5U44ktA7UzW3juw9ohOBf0dflG2UeC2J5ZxM94Cerok1nl6RiZTvwDgTyMjD4S+RdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fQbs0fed; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fQbs0fed"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 821153D77C;
	Tue, 16 Jul 2024 12:08:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VQwKRurPEsIux2mB1hRsLjZWb6WM1i8tqsku7o
	7QS64=; b=fQbs0fedW6viypBXv4pldYYKJy1VkXYhc39eyit3YStKNqlHMraz9a
	LOQqH3Y87ESv9JvNabwUsfTzcMTHLBf3B1FvtiIFYp+1Cki3nnAPt/0M+6dUPH+5
	lZAa0xLDfiq+81ovdZVkmircIeOvowMwh8YHWkMHJLtIglVPfWTnc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C6E3E3D77B;
	Tue, 16 Jul 2024 12:08:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A72103D77A;
	Tue, 16 Jul 2024 12:07:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Hesse <list@eworm.de>
Cc: Git Mailing List <git@vger.kernel.org>,  Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] refs: update the version numbers...
In-Reply-To: <20240716095544.65931-1-list@eworm.de> (Christian Hesse's message
	of "Tue, 16 Jul 2024 11:55:44 +0200")
References: <20240716095544.65931-1-list@eworm.de>
Date: Tue, 16 Jul 2024 09:07:58 -0700
Message-ID: <xmqqle219v6p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9260C544-438D-11EF-B069-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Christian Hesse <list@eworm.de> writes:

> From: Christian Hesse <mail@eworm.de>
>
> ... as they were one off.
>
> Signed-off-by: Christian Hesse <mail@eworm.de>
> ---
>  refs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/refs.h b/refs.h
> index 0ecba21b4a..b3e39bc257 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -1087,10 +1087,10 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  				    struct strbuf *err);
>  
>  /*
> - * The following functions have been removed in Git v2.45 in favor of functions
> + * The following functions have been removed in Git v2.46 in favor of functions
>   * that receive a `ref_store` as parameter. The intent of this section is
>   * merely to help patch authors of in-flight series to have a reference what
> - * they should be migrating to. The section will be removed in Git v2.46.
> + * they should be migrating to. The section will be removed in Git v2.47.
>   */
>  #if 0
>  static char *resolve_refdup(const char *refname, int resolve_flags,

Right.  "git blame" says this block came from c8f815c2 (refs: remove
functions without ref store, 2024-05-07), which is v2.46.0-rc0~119^2,
and will be published as part of v2.46, not v2.45.

Will queue.  Thanks.

