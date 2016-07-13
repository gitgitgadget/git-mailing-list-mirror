Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3EF1F744
	for <e@80x24.org>; Wed, 13 Jul 2016 07:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbcGMHrX (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 03:47:23 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37777 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcGMHrW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 03:47:22 -0400
Received: by mail-wm0-f51.google.com with SMTP id i5so55271570wmg.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 00:47:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZTjluC7ribzU9VCt+YkxGRJ3DM/28PO1P/bI4pPPc1E=;
        b=W7zhIpEQSDrDJKEhiGjdrXXjd0eS4dh8fIIkLHPD9GnruZ1YixroGHbkKdC2Zm5x/G
         Lj3N8iFiEVgD5F2pcafYEXzLqmlRtDN4+oI+KFT9a482W7lUkPmXprvwUw63tmTFTk+R
         WsynaBEWyqQNJe2lNr+jl/6AdEutcFfa7e78S5FP+WIMwsthIkzsIq77BDKKQfKuf7fF
         uCIGpL9+3QzECudNLsXG0xulrjSmUeTEKgWECvElaSfOkb0Jbrxby3PJCKHHRcrg8hQY
         eInNx5bp6s4ggT9vNLOSHb8so4ssrTbgGwUqDZ4Ggh3yg1MPfswnWUgXjDgJdzS3vWCL
         xqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZTjluC7ribzU9VCt+YkxGRJ3DM/28PO1P/bI4pPPc1E=;
        b=Nw3QR3IOqK5FMP4Eocjw7FAF8JTSy2YvMNDMUbieEFzi8WXy9iPMhpI5mMV0/+XjaK
         6y34It2VapGlB/W0Vsk1en+rrp20rejlH1m5zW5kPLeEWln8Xz7FMlWXmx9TLP3S3Jtz
         Qbw0Jc4Ors6LRFew7AYYfqbRwMjoQs+MV3u+948Y9Hm1jIMJXifp41581rV3dqZDLDoL
         PCtiVTzHvGxwJqNchiSGQgz/EdnOptTLFn5v3FoZ4VMFaoymf9hny3VJDpXKqSosZa6n
         3RjXzzyo4sRAYudMP6L76G50PdIwkegu/mslkw3wUDefViG48tZIfR+vU7ryUWzgbi7f
         PXUw==
X-Gm-Message-State: ALyK8tJ9oXhFtKTdLQbJ/OI/aaY8yXuQ5p/cvC7PvhrxOV2FXK1z5DjDY3KJppv6TRYFi4e2sHL2Q4y1dPTFcg==
X-Received: by 10.28.142.144 with SMTP id q138mr8891465wmd.30.1468396040858;
 Wed, 13 Jul 2016 00:47:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.151.134 with HTTP; Wed, 13 Jul 2016 00:47:20 -0700 (PDT)
In-Reply-To: <20160712223538.28508-1-pranit.bauva@gmail.com>
References: <20160712223538.28508-1-pranit.bauva@gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Wed, 13 Jul 2016 09:47:20 +0200
Message-ID: <CAP8UFD0T3+BEq2JO_zA8-n1322VP=EUxOfmP3U5i-4jQJ6WtUA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Resend of gitster/pb/bisect
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Pranit,

On Wed, Jul 13, 2016 at 12:35 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Hey Junio,
>
> A small mistake got unnoticed by me which Lars recently pointed out.
> The naming convention is "git_path_<name_of_file>" and underscore
> instead of spaces.

It's a good thing to resend when you find mistakes, but please use a
version number for your patch series (like "PATCH v3" or something).

Thanks,
Christian.
