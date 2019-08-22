Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5BEA1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 20:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbfHVUBt (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 16:01:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53088 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbfHVUBt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 16:01:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89EDD166CBA;
        Thu, 22 Aug 2019 16:01:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+YOyb0SXRVjC8RE5h/tXjuC/MrQ=; b=j1feP4
        LGkZlsSCcq0h/mPwlmRc47hT6YW81uCbvEHQwtsSieDYZuVoN5wuUVGwszBRKd0i
        ek+HFj14b4/CidP4/fMWTa6ot1scJteWUePIHsGy5gq0fpEEVyOz1OTLux7glQMw
        KDP1c9TbNqV2Niic1azxget+KBxXBNwWY7Qq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cf+b1HGuzU65aKs8CZ12zN5HQHxrFPc8
        ZlyubyXTEqzEeFA6VGPrgDGginj5gfvph0JJ31Kz8W99fHMcWKj18vLfsF9aix9S
        qWukxHx+p7CbsHl3NJVfyirsUr80H1N4ZM8RyMhj79RESQIrVslohrPGL0nIrPVc
        Vrn7Xf/kc5c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E4EF166CB9;
        Thu, 22 Aug 2019 16:01:47 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4A24166CB8;
        Thu, 22 Aug 2019 16:01:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        johannes.schindelin@gmx.de, larsxschneider@gmail.com,
        szeder.dev@gmail.com, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] t0021: make sure clean filter runs
References: <20190820065625.128130-1-t.gummerer@gmail.com>
        <20190822192240.GA4077@cat>
Date:   Thu, 22 Aug 2019 13:01:45 -0700
In-Reply-To: <20190822192240.GA4077@cat> (Thomas Gummerer's message of "Thu,
        22 Aug 2019 20:22:40 +0100")
Message-ID: <xmqqzhk1nf4m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABD87566-C517-11E9-832E-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Fix the test by updating the mtime of test.r, so git is forced to
> check the contents of the file, and the clean filter is run as the
> test expects.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> v2 adds the comment as suggested by Szeder.
>
> Junio: I saw this is marked as "merged to 'next'" in the What's
> cooking, so if it got merged already I'm fine with just keeping v1,
> but otherwise I think adding the comment would be nice.

I think it was marked with "Will merge to ...".  Replaced.

Thanks.
