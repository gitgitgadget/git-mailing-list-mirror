Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A610C207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 23:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbcILXxt (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 19:53:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56136 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750747AbcILXxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 19:53:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E747B3D23D;
        Mon, 12 Sep 2016 19:53:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J7qzrX30rWk7qWAOd+p3Nlj32jE=; b=Newj7M
        yR/M0cEA2DVfvJ/Jm47qW2ECIZshEdaIvOlNygG+rsDdnOf4Tul6eCuHmGRuNGpH
        Iqs4vMXBrvC+oMZJKHuyDX819uaXk0ffwIidBb1FK0L8ajtRXRw0lFXkt21wISIH
        zg3CuMwjuD/RMMMnOmZvADS44QRr8GMT0Ezzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QqLtJsEyfzGBRIP8wB15Ecw09K8fm2ny
        Aajx/WmoiqiToWtK4PKdMuCo7skk39Pofa4iGSrQbbUmOkCeT9ebkhdNEiN2o9PE
        pzc+UBUEwmdk2NJgVKjLlD+xribaPQuqTUA2T+PW7dcB/otTL8VDPaikdb/9e8K6
        1UVyr5h3R7U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF32F3D23B;
        Mon, 12 Sep 2016 19:53:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78E913D23A;
        Mon, 12 Sep 2016 19:53:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <stefanbeller@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 04/10] diff.c: rename diff_flush_patch to diff_flush_patch_filepair
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
        <1473572530-25764-5-git-send-email-stefanbeller@gmail.com>
Date:   Mon, 12 Sep 2016 16:53:45 -0700
In-Reply-To: <1473572530-25764-5-git-send-email-stefanbeller@gmail.com>
        (Stefan Beller's message of "Sat, 10 Sep 2016 22:42:04 -0700")
Message-ID: <xmqqwpigwu7q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 257D41A8-7944-11E6-9C0C-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <stefanbeller@gmail.com> writes:

> From: Stefan Beller <sbeller@google.com>
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

The reason being...?

