Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A77EB64DA
	for <git@archiver.kernel.org>; Sat,  1 Jul 2023 00:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjGAAmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 20:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGAAmx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 20:42:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8F83C02
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 17:42:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15CB71A39B8;
        Fri, 30 Jun 2023 20:42:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NNWNzhQ5wiaoMCYtYhXwg8WCDVLTvUKALpU2GP
        SXI6g=; b=awJuDUxHdS1KqmYngHkicdMJ04pSNtNnCv16xpU2lA9rIP9rQAYmtA
        aXSYTduwyj/GmpCAgPPpZQ90uMicmnsWaTvcIUHUu9NUL6uIwMDiiXr/isMsn/Mc
        DjJWUxiMptDwGALeO5LTs3R85X1WXRgUmjEGunvL4eYV7zilOVjsM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D1141A39B7;
        Fri, 30 Jun 2023 20:42:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 748FD1A39B6;
        Fri, 30 Jun 2023 20:42:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        sandals@crustytoothpaste.net, calvinwan@google.com
Subject: Re: [PATCH v4] unit tests: Add a project plan document
References: <20230517-unit-tests-v2-v2-0-8c1b50f75811@google.com>
        <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
Date:   Fri, 30 Jun 2023 17:42:46 -0700
In-Reply-To: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
        (Josh Steadmon's message of "Fri, 30 Jun 2023 15:51:19 -0700")
Message-ID: <xmqq8rc05unt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3322BAAE-17A8-11EE-8441-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

I'll normalize this one to match prevailing use.

> Coauthored-by: Calvin Wan <calvinwan@google.com>

$ git log --since=6.months --pretty=raw --no-merges |
  sed -n -e 's/^    \([^ :]*-by:\).*/\1/p' |
  sort | uniq -c | sort -n | sed -e '/^ *1 /d'
      5 Tested-by:
     15 Suggested-by:
     24 Co-authored-by:
     30 Reported-by:
     34 Reviewed-by:
     38 Helped-by:
     68 Acked-by:
   1786 Signed-off-by:

> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---

Thanks.
