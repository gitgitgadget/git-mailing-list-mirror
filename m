Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9CA20D09
	for <e@80x24.org>; Mon, 17 Apr 2017 01:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757172AbdDQBg4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 21:36:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60002 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757167AbdDQBgz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 21:36:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D86998B357;
        Sun, 16 Apr 2017 21:36:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=38HeYd+Rv2PlC+n8GGoR3DVZDsA=; b=WGB/Iw
        xb+XL1GRC8EZtTLNp1F8rTYSEBBRsi02pDEetzRuwR3PL05QYWauYrw67/+XiaSc
        9XSKgBrmUJt4rM0/7+/1vdMSvhIIvY6Pt1kz/TOKJesodkoKjCBfNeBwX4k4bDrn
        2oUs9guxGyo1Tg7y5sIbBBTC4jWCkMVW1RKmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EhM7Owhkn8r3czGvhQH+NFnscEA1JaHr
        hxyZXjYB26Tv5zq/0BPdsIkXI6Z/vGFKsVXChp8V0TGi5Oq5QV4BoHgLA8bL1AjB
        hreRIX8qFZQqtyQKLsUZF1fKqndnGo8BC1xzXjrltD0JU64LYwnosKlBx8csC4l4
        lp2gNUoqnYc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFEE78B356;
        Sun, 16 Apr 2017 21:36:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 464298B355;
        Sun, 16 Apr 2017 21:36:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 0/5] Kill manual ref parsing code in worktree.c
References: <20170318100206.5980-1-pclouds@gmail.com>
        <20170404102123.25315-1-pclouds@gmail.com>
        <xmqqk26nojfm.fsf@gitster.mtv.corp.google.com>
        <xmqqd1cfoifl.fsf@gitster.mtv.corp.google.com>
        <20170414124512.GA20466@ash>
Date:   Sun, 16 Apr 2017 18:36:51 -0700
In-Reply-To: <20170414124512.GA20466@ash> (Duy Nguyen's message of "Fri, 14
        Apr 2017 19:45:12 +0700")
Message-ID: <xmqq37d7lsr0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55BC691A-230E-11E7-ABDA-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> This is embarassing. I worked on and off on this series over a long
> period of time. I guess at the end I thought everything was ok "since
> the last time" and just sent it away without realizing I hadn't
> actually run the test suite, because it does fail here, now.
>
> This fixup patch should make the test suite pass. I'm sorry for
> wasting your time on this.

Thanks.  Will squash it in.
