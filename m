Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2431F859
	for <e@80x24.org>; Wed,  7 Sep 2016 16:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758074AbcIGQkm (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 12:40:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50630 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758050AbcIGQkh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 12:40:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CF6E388DD;
        Wed,  7 Sep 2016 12:40:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H7XZwBPAw0XANXD7GrFfcEQ0Kgs=; b=IVqM8+
        O/PbZpIV9Phr9Mjfmp5ExWRWftuGXHhDjFrVqXDj2DgBHLmN+rnXS9GiwHQ4dgx6
        4ktu/WvAeF14PdIzlNyYAu6AN7+Ia+2WI3fQSmpDrVWE2wpJRc1YhEKRgMvXHC72
        PZStQeOzfC43tPo3WgESXzksSPTiFuyFS3YKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Am0OQiPaimXiH1vnbHFMe4kbU+YDoKgs
        XczN4HmJUfJnf0JQ1biuAWvDuqLkNAL2PuNQ4zbhKx6DEF/4GHhxNhwUg5n2Ekrl
        6j3OqPsvWO6R+XLelvdyDtKtdIPPOosNzo87KQiaY176r9U2o+UUZ95pwcENLFmR
        Qq0u0l+HEfw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74C37388DC;
        Wed,  7 Sep 2016 12:40:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F2E42388D9;
        Wed,  7 Sep 2016 12:40:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] xdiff: remove unneeded declarations
References: <20160903031648.14465-1-sbeller@google.com>
Date:   Wed, 07 Sep 2016 09:40:34 -0700
In-Reply-To: <20160903031648.14465-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 2 Sep 2016 20:16:48 -0700")
Message-ID: <xmqq8tv3pssd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD48325A-7519-11E6-9975-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  xdiff/xemit.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index 49aa16f..b52b4b9 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -22,15 +22,6 @@
>  
>  #include "xinclude.h"
>  
> -
> -
> -
> -static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec);
> -static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb);
> -
> -
> -
> -
>  static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
>  
>  	*rec = xdf->recs[ri]->ptr;

Thanks.
