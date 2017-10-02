Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3682D20A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdJBAMO (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:12:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56018 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751101AbdJBAMN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:12:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03D6CB6018;
        Sun,  1 Oct 2017 20:12:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jl7/k9qFEMdoeYtUn4sp1xcL44w=; b=mxeVhE
        i4c96mIuqqR/KssgAzLbLjGMPZfQ6axbfqlMk0h/cpkdCLOW/BtQ+3RI4NAxyBLH
        kkY+d4uLTcq5E8k1kbbI9wOyEUo2/PXNX+8PLuWl5YsDkljnrF3qGJNYmAn5p6yn
        FL0AyJvCqsKdH6hA2Vl3iwiafi5Hs9KmO52+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vQckAotPbRoXwXvZxhbKt1YQ82T/0kj7
        aPQKsNKijy0Mzef5XQdgECf97f5fDJuF8MpZxE/XdjI0Bvh9crdeWWSpI+Nyy4Av
        329bT8kUcXVXm6obYTPcnW4pKKs2XQ42Bv7/AZx0k5fHiDO47bwMpM/S/HIpMpsq
        8Y6+s6GOebU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDF72B6017;
        Sun,  1 Oct 2017 20:12:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A5DDB6016;
        Sun,  1 Oct 2017 20:12:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 2/6] t6300: refactor %(trailers) tests
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
        <20171001161852.84571-1-me@ttaylorr.com>
        <20171001161852.84571-2-me@ttaylorr.com>
Date:   Mon, 02 Oct 2017 09:12:11 +0900
In-Reply-To: <20171001161852.84571-2-me@ttaylorr.com> (Taylor Blau's message
        of "Sun, 1 Oct 2017 09:18:48 -0700")
Message-ID: <xmqq7ewetnl0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 568E57BE-A706-11E7-929A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks good to me, thanks.
