Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AC9C433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 23:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB2C610E8
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 23:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbhIBXo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 19:44:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52847 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244285AbhIBXo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 19:44:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 755681539F7;
        Thu,  2 Sep 2021 19:43:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fgiJmq39iJDQMKbibr3/ehgCBnVl6f72csqqKp
        hYG0M=; b=FXVuPBjSQ1TovuabGlqGPE6DYSmXDi/9iXrXUqiNn3/3wZwAQtorr2
        xp5xQMRgPAwK23ObKpgkEkgKDyVjx6ZcKru20p4Uzw5an+QusS95q8Wj8otUVg2F
        EngGDEBhjllISLX3OLFTdAThIa3c9f3rWGsWUpT+0dkFCY4CImBJ4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B8801539F6;
        Thu,  2 Sep 2021 19:43:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95C731539F5;
        Thu,  2 Sep 2021 19:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 6/6] bisect--helper: retire `--bisect-next-check`
 subcommand
References: <20210902090421.93113-1-mirucam@gmail.com>
        <20210902090421.93113-7-mirucam@gmail.com>
Date:   Thu, 02 Sep 2021 16:43:24 -0700
In-Reply-To: <20210902090421.93113-7-mirucam@gmail.com> (Miriam Rubio's
        message of "Thu, 2 Sep 2021 11:04:21 +0200")
Message-ID: <xmqqpmtqh7c3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91944BAC-0C47-11EC-B170-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> After reimplementation of `git bisect run` in C,
> `--bisect-next-check` subcommand is not needed anymore.
>
> Let's remove it from options list and code.

Yay.  Nice.
