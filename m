Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE38C433E5
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630872078B
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aUHuRFP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHMSa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:30:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58875 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSaz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 14:30:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC0DE76718;
        Thu, 13 Aug 2020 14:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i8WeSYHzF6LVlsnC+etQUoy45YQ=; b=aUHuRF
        P2rnQofqP+DigIYOc/9AWqj7sVfdIG7X8J6z4frwIUK23aDut8c0ikIsPZ+ofxce
        NGi2yrUmYQLZaKaSH7gKqfj2Q+AIdz62PZZ7CIoBuAP+ZVeGmkjG/Az5MLwQyVVo
        VAMTK3ZQX+UJtUl35OiWLjE2/Ro79HpuDD88U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KcBuV54ahywmaEmbBD0G3knsB4bTlj9b
        nQgb9ceVFKkNY1AuLCef9KUVoz2kgE89WO3ZZ7X4YYyiAjz+x2cBiCpjrWzXn5om
        1DyeVIWltcmed0ovIc3DeQwbXOXXcrl7QCPo35JxEcKkb3im9pZuwUk3IZ2nuXzj
        McwTlxyuNdg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C322776717;
        Thu, 13 Aug 2020 14:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5022576716;
        Thu, 13 Aug 2020 14:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: commit-graph: fix some whitespace in the diagram
References: <20200813145053.43360-1-johannes@sipsolutions.net>
Date:   Thu, 13 Aug 2020 11:30:52 -0700
In-Reply-To: <20200813145053.43360-1-johannes@sipsolutions.net> (Johannes
        Berg's message of "Thu, 13 Aug 2020 16:50:53 +0200")
Message-ID: <xmqqzh6y1jqb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EB69B82-DD93-11EA-B4C3-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> In the merge diagram, some whitespace is missing which
> makes it a bit confusing, fix that.
>
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
>  Documentation/technical/commit-graph.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, will queue.

>
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> index 808fa30b99f2..f14a7659aa87 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -210,12 +210,12 @@ file.
>  			    +---------------------+
>  			    |                     |
>   +-----------------------+  +---------------------+
> - |  graph-{hash2} |->|                     |
> + |  graph-{hash2}        |->|                     |
>   +-----------------------+  +---------------------+
>  	  |                 |                     |
>   +-----------------------+  +---------------------+
>   |                       |  |                     |
> - |  graph-{hash1} |->|                     |
> + |  graph-{hash1}        |->|                     |
>   |                       |  |                     |
>   +-----------------------+  +---------------------+
>  	  |                  tmp_graphXXX
> @@ -223,7 +223,7 @@ file.
>   |                       |
>   |                       |
>   |                       |
> - |  graph-{hash0} |
> + |  graph-{hash0}        |
>   |                       |
>   |                       |
>   |                       |
