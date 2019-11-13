Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC0C81F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 02:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfKMB7J (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 20:59:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59613 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbfKMB7I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 20:59:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6B15230D6;
        Tue, 12 Nov 2019 20:59:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/bk1CGeeS0mUr4zWLTgdTA+TuqE=; b=iuchRH
        QrWQEHMbdA04bVFl5LouMFEHMxI8lnBXKiHYf+PZeaq1OI3bLLsLxlp1YhD2Uh1v
        jmBzvMFpLVgXQ5sYuAoBx5HvTjZRcg1DF2UL8eyTn4Nr2L0ffQuTwpGnUTwIdn2U
        H+Qu/9pj0OaFH8AdK4ynVYa6bRhqwmNY9h6aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gmu9sSb2mJvxV36elB1wkeh6zFK28bfK
        wLeLYim5/DPRNL8bVZq23UW3psiPmKnix65i5ZUcmnEFfJkJOfxuSBBxQKTXfUg0
        xEc0U9yznKrc9Q/cELTlO4y5aRYKEQ2ZHRBxMpB2TgadpsmcxqaCAsQY93adOpph
        I1/awIq7uZk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF41F230D5;
        Tue, 12 Nov 2019 20:59:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 931FF230D4;
        Tue, 12 Nov 2019 20:59:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 00/14] t5520: various test cleanup
References: <cover.1573517561.git.liu.denton@gmail.com>
        <cover.1573595985.git.liu.denton@gmail.com>
Date:   Wed, 13 Nov 2019 10:59:02 +0900
In-Reply-To: <cover.1573595985.git.liu.denton@gmail.com> (Denton Liu's message
        of "Tue, 12 Nov 2019 15:07:43 -0800")
Message-ID: <xmqqimnocza1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B912B54-05B9-11EA-8E29-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Like earlier patchsets, I want to implement a feature that involves
> modifications to the test suite. Since that feature will probably take a
> while to polish up, however, let's clean up the test suite in a separate
> patchset first so it's not blocked by the feature work.
>
> 1/15 is a general improvement to test_rev_cmp() that will be used later
> in the series.
>
> Changes since v5:
>
> * More test_cmp_rev() cleanup
>
> * Changed instances of "subshell" to "command substitution" where appropriate
>
> * Change instances of "Git" to "git" when we are referring to the command

Looked reasonable.  Will replace.

Thanks.
