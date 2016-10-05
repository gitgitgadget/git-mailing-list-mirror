Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57851F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 16:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbcJEQX1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 12:23:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54428 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751128AbcJEQX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 12:23:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0672343A3F;
        Wed,  5 Oct 2016 12:23:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8f7IAC3SgLp26BgUeaflq+WXHZQ=; b=RjoJ72
        Ah3FAQ/3w8Q8xlEZTkVu5MHLbMWzaUJgrJjbG4j7+93HpfVYPsCXbjcLbR381gCI
        8nMQSmrQF6hdVZzfUhU15Ng+MGQbAdqGAonih7tsY4BD9WGynKL/TEwK2wVivS2V
        GvMkjysKhLr7OSDvUHM60m5fsliOE6nrzgxLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KiOlULKK9OTSNUzG9+DQzn6kV0NsszCu
        x64yjxuS8ky4kXg0kluWm56DJlhu1OkBoPfRtubwrBCU9eK7yIfEB85uRp4GUpV4
        ae753HJBIf17W4MAIlRNx6Em7mpy6QZDjhQ6BUePT2gu06lO2b24CcX6pr6fWm9A
        DSO8AddC4X4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3AB743A3E;
        Wed,  5 Oct 2016 12:23:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 707D643A3D;
        Wed,  5 Oct 2016 12:23:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/6] Make the require_clean_work_tree() function reusable
References: <cover.1473580914.git.johannes.schindelin@gmx.de>
        <cover.1475586229.git.johannes.schindelin@gmx.de>
        <3b4f46b761589d84b7713c869d00d3231ab346fd.1475586229.git.johannes.schindelin@gmx.de>
        <xmqqy424t097.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610051324270.35196@virtualbox>
Date:   Wed, 05 Oct 2016 09:23:22 -0700
In-Reply-To: <alpine.DEB.2.20.1610051324270.35196@virtualbox> (Johannes
        Schindelin's message of "Wed, 5 Oct 2016 13:25:02 +0200 (CEST)")
Message-ID: <xmqqd1jerchx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A01A118-8B18-11E6-B39C-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>     The function "git pull" uses to stop the user when the working
>>     tree has changes is useful in other places.
>
> I stumbled over this sentence. How about
>
> 	The function used by "git pull" to stop [...]
>
> instead?

Perfect. Thanks.

