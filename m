Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PYZOR_CHECK,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3921F463
	for <e@80x24.org>; Wed, 18 Sep 2019 17:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbfIRR3N (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 13:29:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55110 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387549AbfIRR3M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 13:29:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E495B72DD5;
        Wed, 18 Sep 2019 13:29:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=gJrr7G
        K3FvMLjd50AGFrTBtUmUe1h+1n+sFGZ8IDU8ieZwjSg78KrcncHSSeAUsK1kNMFe
        cwXOqonl11siYsiu4raAg/K6HecxlvWewW2SWZ7NVVvGl8o1320tXX89LYsMkhuB
        Vw0MNp9Qrp0j8QNYeTOExNYQW5eVeKI8w/HeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pWfQ6ED1z0T7+EFwXUvLXsyVBvqhqm8u
        bXB/XvMARVXX0d5hs7UbvFfTfUwETHjXOUEgrdithn5/drrURppYIKIUj4IC0I8t
        aPpCTCnpe6o+IzoALDn85enmo9knjN3zj6+iBInqpX6BaZveblMwDd5SAwuXwgpH
        T9WpExy4E1A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD77172DD4;
        Wed, 18 Sep 2019 13:29:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F237372DD1;
        Wed, 18 Sep 2019 13:29:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, Jens.Lehmann@web.de
Subject: Re: [PATCH] doc: fix reference to --ignore-submodules
References: <20190918070204.100144-1-alexhenrie24@gmail.com>
Date:   Wed, 18 Sep 2019 10:29:05 -0700
In-Reply-To: <20190918070204.100144-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Wed, 18 Sep 2019 01:02:04 -0600")
Message-ID: <xmqqk1a55x9a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1D76A06-DA39-11E9-8F39-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
