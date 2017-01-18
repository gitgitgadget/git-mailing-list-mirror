Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3014A20C2E
	for <e@80x24.org>; Wed, 18 Jan 2017 21:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbdARVXX (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:23:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58432 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751076AbdARVXV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:23:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32CE061112;
        Wed, 18 Jan 2017 16:23:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JsXoWRymj8KpznVoxLPPKZnTCeA=; b=RW1E6y
        5EaHH2B8mOr3btcxc+9E+gN3KqtzoXDDx0oOVYqGMQk3zACjHu4zrh8Xj9BC5HF0
        LEMS9BgTddUgW2yBA1dCuA48zI5vhDAWbcVYNpYdjxVk0i8rg1naqTfR79EhtTnb
        0QqjC/RqRdQgvN9mMUjqtQWnhlf2qU3EqrJXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BFkT0KDO52VNLxOoLqxa9bm3ukVu6Dwg
        yUPVZWKLuXeVboAPptujWW4n3Vph59y/YXN08ZONoyWOP35Icb607EPzjvo33A/c
        9rP6tmcnu1ztA85JxEyTTcH877GnR20hMEvYECLYR7rjzEMUjK+Z9Ui33QAsnbdJ
        uXbn9sKafjk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B87661110;
        Wed, 18 Jan 2017 16:23:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E73A6110F;
        Wed, 18 Jan 2017 16:23:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] documentation: retire unfinished documentation
References: <20170117233503.27137-1-sbeller@google.com>
        <20170117233503.27137-5-sbeller@google.com>
Date:   Wed, 18 Jan 2017 13:23:19 -0800
In-Reply-To: <20170117233503.27137-5-sbeller@google.com> (Stefan Beller's
        message of "Tue, 17 Jan 2017 15:35:03 -0800")
Message-ID: <xmqq7f5s3vw8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55E80BAE-DDC4-11E6-A011-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When looking for documentation for a specific function, you may be tempted
> to run
>
>   git -C Documentation grep index_name_pos
>
> only to find the file technical/api-in-core-index.txt, which doesn't
> help for understanding the given function. It would be better to not find
> these functions in the documentation, such that people directly dive into
> the code instead.
>
> In the previous patches we have documented
> * index_name_pos()
> * remove_index_entry_at()
> * add_[file_]to_index()
> in cache.h
>
> We already have documentation for:
> * add_index_entry()
> * read_index()
>
> Which leaves us with a TODO for:
> * cache -> the_index macros
> * refresh_index()
> * discard_index()
> * ie_match_stat() and ie_modified(); how they are different and when to
>   use which.
> * write_index() that was renamed to write_locked_index
> * cache_tree_invalidate_path()
> * cache_tree_update()

Thanks.
