Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 427D81F461
	for <e@80x24.org>; Mon,  1 Jul 2019 16:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfGAQFn (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 12:05:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60139 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfGAQFn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 12:05:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09FCB149C6C;
        Mon,  1 Jul 2019 12:05:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aadKNPNWpsjstoEHFStXczfcBss=; b=yU0wUL
        5uVGQ6BJ8NZFLQ8tMlq2EkMnkJrAJQ2Qf0WggsPahBfn6MObg1bbE3a7do6hK8BS
        x+5OfJEGI8u76DBHM2L+zy/J7Y8WzHXjvdMgv8Jr9ePJJM9a6DLVRA5gYykG9v0a
        QGpX1OU7y77vMmmbw90nKJoM467SnSnZ/Gsnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yJCp7LrRgsVAjnCsqo7dH4t4WRjgGwPJ
        TgP6EfWzXiRGD999t4eHNA2RRxu4sV05Mff4CXFWBuHJJh2EKwFANWaY5EdwTOvW
        fE+RUPfh5sSj3BxcZiW8RWgWiACUxdsRVwnAFl0L8EJy2yiq4eIS+2Mqr4PCEjMG
        M01bdJEJdBc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF9B7149C6B;
        Mon,  1 Jul 2019 12:05:40 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53BF0149C69;
        Mon,  1 Jul 2019 12:05:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2019, #07; Fri, 28)
References: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com>
        <20190701152215.GA43911@TaylorsMBP5815.attlocal.net>
Date:   Mon, 01 Jul 2019 09:05:39 -0700
In-Reply-To: <20190701152215.GA43911@TaylorsMBP5815.attlocal.net> (Taylor
        Blau's message of "Mon, 1 Jul 2019 10:22:15 -0500")
Message-ID: <xmqqr2797nak.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 126B0838-9C1A-11E9-A7A4-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hi Junio,
>
> On Fri, Jun 28, 2019 at 03:17:42PM -0700, Junio C Hamano wrote:
>> * tb/ref-filter-multiple-patterns (2019-06-27) 1 commit
>>  - ref-filter.c: find disjoint pattern prefixes
>>
>>  "git for-each-ref" with multiple patterns have been optimized.
>>
>>  Will merge to 'next'.
>
> Thanks for queueing this patch. For what it's worth, we have had this
> patch in GitHub's fork for the past month (?) or so, and it has been
> running without issue.

Thank you for working on this.  It does look like a good thing to
do.

