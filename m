Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648B1C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 00:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D07D206E2
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 00:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MfWQHSl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgGGA74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:59:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60443 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgGGA74 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 20:59:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF333685DB;
        Mon,  6 Jul 2020 20:59:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MJkMYYZxPmdWn9RlCrKn6kQViT8=; b=MfWQHS
        l8vJ2Jp/v9b1vH2npxv9z8o2jkG5Jw5ux5Eblrwvj21kF+iZEwnZLtYeht0b1+Ho
        HAdnWjQWxUl7wvSf3s+HbVsP1LPQREixzKSmtxeZQzGB2icInj4t4u8KG8Ca39DA
        5+W7ZeYG2V3UsXzH/Dq+02yIzhCQU3LMX8ljU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T0Z3/jNyqSeTabVxjDDcsgpp5VJYVS+Z
        tmHIJdGm01BesiVjYO4GJrTjXdJFNK8EyHqLp6dyCycXbjj3BPWj4lJt/uF1Yq9v
        SyWwnfJGlnEI2AMA9mhOp9HpSXOHQDLEJVfR1YX5uivfyCTRFBLUbdE1aZY4kJuJ
        xikhqWuAADk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6049685DA;
        Mon,  6 Jul 2020 20:59:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 595D9685D9;
        Mon,  6 Jul 2020 20:59:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 4/4] rev-list-description.txt: fix Asciidoc syntax
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
        <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
        <3b923780c1f38ee183397b5766aae65933eec4aa.1593747509.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Jul 2020 17:59:52 -0700
In-Reply-To: <3b923780c1f38ee183397b5766aae65933eec4aa.1593747509.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Fri, 03 Jul 2020
        03:38:29 +0000")
Message-ID: <xmqqeepo87hz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AC34420-BFED-11EA-A3FE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Using '{caret}' inside double quotes and immediately following with a
> single quoted word does not create the desired output: '<commit1>'
> appears verbatim instead of being emphasized.
>
> Use a litteral caret ('^') instead.
>
> Also, remove the leading tabs in shell examples to bring them more in
> line with the rest of the documentation.

These should be done _before_ 2/4 as a preliminary clean-up, I
think.

Thanks for a pleasant read.
