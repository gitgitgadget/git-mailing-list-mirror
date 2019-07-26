Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5A11F462
	for <e@80x24.org>; Fri, 26 Jul 2019 20:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfGZUXo (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 16:23:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53638 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfGZUXo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 16:23:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B98D6B8E8;
        Fri, 26 Jul 2019 16:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1e++Kt9M/eTZnMEE4bCMY9d+ygI=; b=gRWSjN
        3vlwxdoIa7E3ZEWDPN5GSh6fVQrQBvZeSWgk929Tih9ADD2yaRnLPpNB19ldd9S8
        aU+5jyhbHcTmPss8G9Rb2cUjTBGCGQx8EyXdxWU3Ga/IwiQunxvcmEj9rA+QkJBD
        nAbruf9KA7+KdXfiANHrtZwxwjAp9OPMGaYS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cmg9YaC5TtJo3WZ1zgM855tHJ3qK0kPM
        ByrN8dyIQ6fgtqMvNT9uq4nu4vFYwvNhRrdp17Qqw1zsrcpPIt6ti7L+vuA7bP64
        Jc9nGuaSSt8eExZA+uKvR4y5YfjchEzeCSsD9OGCWZj/YZTCJwheu1U9I/pLgb0H
        2n9+NEItKmc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D92CC6B8E7;
        Fri, 26 Jul 2019 16:23:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1251F6B8E4;
        Fri, 26 Jul 2019 16:23:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907261624130.21907@tvgsbejvaqbjf.bet>
Date:   Fri, 26 Jul 2019 13:23:36 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907261624130.21907@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 26 Jul 2019 16:33:00 +0200
        (CEST)")
Message-ID: <xmqqtvb8mto7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40C98EFC-AFE3-11E9-A4D1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 25 Jul 2019, Junio C Hamano wrote:
>
>> The seventh batch is in; I've merged fix-up topics that has been in
>> 'master' for some time (i.e. up to the third batch of this cycle)
>> down to 'maint'.
>
> Would you terribly mind also merging `js/gcc-8-and-9` into `maint`?
> Otherwise, the CI build is broken after my upgrade of the Git for
> Windows SDk to GCC v9.x.

I do not mind.  I am just taking things in smaller batches than just
the whole ball of wax.
