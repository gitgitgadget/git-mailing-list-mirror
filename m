Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75370C33C99
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 23:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BF82464E
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 23:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KgW58wnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgADXvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 18:51:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61215 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADXvK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 18:51:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DA483DDE2;
        Sat,  4 Jan 2020 18:51:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hb7IjsNEHrWY7zzdDScFyomPKio=; b=KgW58w
        nr6UEyUdh/uuKRdmCR3WtP/wVWr0knF7BHXySt4kB0gAySlJvYkIHnFMVLxVhpJs
        tno81yuOwK9iNhD2DtaXorwQB71vIZFralZdBIc/w3grhhBM1ezzHlZ7QyxPzPN3
        Zr/ABvXyhkkzRwbWga7e8+IQXhr9ZcIlU4rZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ph5l4kXIXypbmSYJ1HRnfvAgZkkZ3yyH
        bsjMVFC7Oqs72umwGF1Z+PcFgywbTLZXcW8C7nBcQWop9UOIVz+c5W1h90eD/LhH
        EqMIMZodhe/RwiAezt3agrtHOiLRAZKVj9ZWS+Lz8qL+vW3uQNl5IN2qYwtZ8+Yp
        z5R/FVCmXyw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65C013DDE1;
        Sat,  4 Jan 2020 18:51:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C8F863DDE0;
        Sat,  4 Jan 2020 18:51:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denis Ovsienko <denis@ovsienko.info>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitweb: fix a couple spelling errors in comments
References: <20200104173923.45537050@basepc>
Date:   Sat, 04 Jan 2020 15:51:07 -0800
In-Reply-To: <20200104173923.45537050@basepc> (Denis Ovsienko's message of
        "Sat, 4 Jan 2020 18:39:26 +0100 (CET)")
Message-ID: <xmqqeewebx1w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1456CF44-2F4D-11EA-99C3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denis Ovsienko <denis@ovsienko.info> writes:

> Date: Sat, 4 Jan 2020 17:33:55 +0000
>
> Signed-off-by: Denis Ovsienko <denis@ovsienko.info>
> ---
>  gitweb/gitweb.perl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Both of these typofixes look correct.

By the way, please do not attempt to override the author timestamp
with an in-body header when contributing to this project, as the
time the general public sees the patch on the list is when they
perceive as the time the patch appeared in this world for the first
time, as far as this list is concerned.

Thanks.

>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0f857d790b..65a3a9e62e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -741,7 +741,7 @@ sub evaluate_gitweb_config {
>  	$GITWEB_CONFIG_SYSTEM = "" if ($GITWEB_CONFIG_SYSTEM eq $GITWEB_CONFIG_COMMON);
>  
>  	# Common system-wide settings for convenience.
> -	# Those settings can be ovverriden by GITWEB_CONFIG or GITWEB_CONFIG_SYSTEM.
> +	# Those settings can be overridden by GITWEB_CONFIG or GITWEB_CONFIG_SYSTEM.
>  	read_config_file($GITWEB_CONFIG_COMMON);
>  
>  	# Use first config file that exists.  This means use the per-instance
> @@ -5285,7 +5285,7 @@ sub format_ctx_rem_add_lines {
>  		#    + c
>  		#   +  d
>  		#
> -		# Otherwise the highlightling would be confusing.
> +		# Otherwise the highlighting would be confusing.
>  		if ($is_combined) {
>  			for (my $i = 0; $i < @$add; $i++) {
>  				my $prefix_rem = substr($rem->[$i], 0, $num_parents);
