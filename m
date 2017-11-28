Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7981320C11
	for <e@80x24.org>; Tue, 28 Nov 2017 02:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbdK1Cdx (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 21:33:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65200 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753285AbdK1Cdw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 21:33:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6970AA3F50;
        Mon, 27 Nov 2017 21:33:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=facYROR6VEM1Cu3Kqog0XC090vI=; b=IYFpp9
        WkkXZhe+gX10BxIoPosWPqk6N08Ug+B8U8u4D/Q8N0XpqaBzQAtQl0CFkasU/sFG
        g1qLelpcdqqNklrQsVfdCFPajN1C/oB+22aIV4U/1tOqQIYoTOuCbtcgqakQeHeC
        io5OsGh16Tx9NxqTkS3FdoCMq+Y4qrsfmXsn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I/SHry8r91VAe818Zk8pXujmx3QOmboW
        Ts68+EQwKKzrvyzyUL13oBKNlwS7gNmob6eUpThmj7EHWYLxTX7CgD9hh1JZ+szE
        /TFeM4C8oNUpmqmZdF6evJEdiwEMipGsJsONfqYQvIODaVhGidHBwTtI6im4B/aX
        hUl4l9seRAk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6097FA3F4F;
        Mon, 27 Nov 2017 21:33:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D115CA3F4E;
        Mon, 27 Nov 2017 21:33:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Doc/checkout: checking out using @{-N} can lead to detached state
References: <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
        <20171127172834.6396-1-kaartic.sivaraam@gmail.com>
Date:   Tue, 28 Nov 2017 11:33:50 +0900
In-Reply-To: <20171127172834.6396-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 27 Nov 2017 22:58:33 +0530")
Message-ID: <xmqqh8tf873l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 924E8282-D3E4-11E7-A515-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>  	any branch (see below for details).
>  +
> -As a special case, the `"@{-N}"` syntax for the N-th last branch/commit
> -checks out branches (instead of detaching).  You may also specify
> -`-` which is synonymous with `"@{-1}"`.
> +You can use the `"@{-N}"` syntax to refer to the N-th last
> +branch/commit checked out using "git checkout" operation. You may
> +also specify `-` which is synonymous to `"@{-1}`.
>  +
> -As a further special case, you may use `"A...B"` as a shortcut for the
> +As a special case, you may use `"A...B"` as a shortcut for the
>  merge base of `A` and `B` if there is exactly one merge base. You can
>  leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.

Looks sensible.  Will queue.

Thanks.
