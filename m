Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC7E1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 21:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbfHBVGN (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 17:06:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59490 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfHBVGN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 17:06:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E51016ED0D;
        Fri,  2 Aug 2019 17:06:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0mkUJ5d6iqhoqbjkNXHAQY736d0=; b=V3Mz+T
        L8E8v/WA4gpYjuGoPIpd3Ol4ephDkpUPcXVymXdYMwPEBeY3IjtXc6U7xFdD0xOE
        MA3Uf6s50Ev0FhiGOOLNhuIRsqEvvVfK9e9OzlZlMwDy2d3Hi2G2n44leSqlptTx
        m5TZ/G70vtcbXtjMsrZm4NuGLfdkiNSLIrAFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VszgEkdUELteBfwoOzRT7HDn1Jwpt9pw
        w16449Hc9KMaaXpG7bZ1RkuV4G+Ur/SmCPZua621UbcwxPZQOfTUW+8DZl75KCzh
        p0B+0jHn1bJhYD42IeKVYWWC1sM1wy/liP2SbVFnpSk7ZAM9zKKFJEO4/pwY5KtD
        ypbqWFutvHE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95C2B16ED0C;
        Fri,  2 Aug 2019 17:06:10 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03C1816ED0B;
        Fri,  2 Aug 2019 17:06:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/11] git add -i: add a rudimentary version in C (supporting only status and help  so far)
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1907162037430.47@tvgsbejvaqbjf.bet>
Date:   Fri, 02 Aug 2019 14:06:08 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907162037430.47@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 16 Jul 2019 20:38:20 +0200 (CEST)")
Message-ID: <xmqqlfwbjn0f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A28E880-B569-11E9-AE89-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> As I am a heavy user of git add -p myself and use a patched version for
>> weeks already (it is so nice to not suffer over one second startup until the
>> MSYS2 Perl finally shows me anything, instead it feels instantaneous), I
>> integrated these patch series into Git for Windows' master already, as an
>> opt-in feature guarded by the config variable add.interactive.useBuiltin
>> (and Git for Windows' installer is prepared to detect this version and offer
>> the option in the graphical user interface).

I've sent comments on a few patches in the series; overall it was a
pleasant read.

Thanks.
