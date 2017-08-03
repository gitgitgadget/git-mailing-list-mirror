Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D14B1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 19:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdHCTOk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 15:14:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62248 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751600AbdHCTOj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 15:14:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4F4A887A1;
        Thu,  3 Aug 2017 15:14:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=99/YMYbw4SkEmr1l96OyrlnAHGk=; b=qsycu4
        6oWiUHe7yL7Uak1XhDQmbAVx5B7UOS7vtyhDGRbLuf+sUhQ7HTQ26OUeKC2nKPDr
        03Ryt9QyCNehM78BSNRX+Dg7aF4T8x8bbO9TQX9Ku57mK9UlYyvxK2MSAAE6plNJ
        isqlM4XVX6l97isj6i4/+1lNCpjB3ZtEW7Gtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ueaGFQtg6FgMu8YtqmWQQKnQPwJYdNJP
        s8046g180zIFfRfPvCaaJTX9W/mJ50c1fyFJCzRHSisH3yJ8WVoPkVY/ySAw/wqp
        7sA2GiC/PVhYdPmwBtCFJL+5E/bnYjLqCzcXZo58txGG/ryxAtfNtA1p551klr6W
        uq7q1aE7dAU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC30F8879F;
        Thu,  3 Aug 2017 15:14:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 371F88879E;
        Thu,  3 Aug 2017 15:14:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 08/40] Git/Packet.pm: add capability functions
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
        <20170803091926.1755-9-chriscool@tuxfamily.org>
Date:   Thu, 03 Aug 2017 12:14:37 -0700
In-Reply-To: <20170803091926.1755-9-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 3 Aug 2017 11:18:54 +0200")
Message-ID: <xmqqk22kxy3m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE7102C0-787F-11E7-8E1F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Add functions to help read and write capabilities.
> Use these functions in 't/t0021/rot13-filter.pl'.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

Steps 06-08/40 all look sensible to me, but they probably fall into
the same bucket as step 03/40, i.e. better done before step 04-05/40
(which should probably be a single patch, as I earlier said) as
preparatory steps.
