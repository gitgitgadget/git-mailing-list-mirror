Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3EF41F404
	for <e@80x24.org>; Wed, 27 Dec 2017 20:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbdL0UdM (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 15:33:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55532 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751881AbdL0UdL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 15:33:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 313B4BDB7F;
        Wed, 27 Dec 2017 15:33:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U2yglkP4ccR2sGxclspUF+0jPF8=; b=vxx1vE
        /U15gy9RiKW9oSWA/gcPSrM58W+WsTApWKqX/w5ftijOd3bxfixCcx4JL8xsfhQr
        2FCUalgfZ9qNH5tF67ItXMDmP4i5rQYpuBedCW8unwX1EyDYUp6x5EkUneaK3WGy
        J09ODvtjZD/3+IrcLTwA5iiv03j+yXLTADCGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M+mGo8m4ev1tXytmkTEm70d/27og5zGD
        xqFMPlDvPvhxb3dmaKXO/K4qCofdAWxZtX94sxyI5TDtW/ha2E0OANGlLGpnuMhf
        1gmx+IAhP+ykIX/KqztwdQX7EI3sXeXCw9tSU9glkkzL2RxCJBXhShO/ablnLK+s
        7OqRGDiiQok=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27E77BDB7E;
        Wed, 27 Dec 2017 15:33:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82CB7BDB7D;
        Wed, 27 Dec 2017 15:33:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH 0/5] A couple of sequencer cleanups
References: <cover.1513986836.git.johannes.schindelin@gmx.de>
Date:   Wed, 27 Dec 2017 12:33:09 -0800
In-Reply-To: <cover.1513986836.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Sat, 23 Dec 2017 00:55:33 +0100 (STD)")
Message-ID: <xmqqa7y3nc6y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2777FFD8-EB45-11E7-B2E6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Johannes Schindelin (5):
>   rebase: do not continue when the todo list generation failed
>   sequencer: strip bogus LF at end of error messages
>   sequencer: remove superfluous conditional
>   sequencer: report when noop has an argument
>   sequencer: do not invent whitespace when transforming OIDs

All looked obviously correct and good clean-up changes.  

Thanks; will queue.


