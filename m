Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBEC62095B
	for <e@80x24.org>; Sat, 18 Mar 2017 17:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbdCRRmO (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 13:42:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57578 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751653AbdCRRmN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 13:42:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C82E287281;
        Sat, 18 Mar 2017 13:42:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=usE5JloETXakfNdfCAr/2odevhI=; b=rVuzbM
        7X/6gNzMPqPKL8NXUxpPQ9s3xNLKRPitc/6pF/jPBzAR6Qyg2FwNFBHiaAMfsQBU
        k8IbmDAUdb6VfdNMA0MBv/EeyI9jOdnZZb0vgu1LNNXLL1TdHZi2hUYjew1i3yaE
        S4lNNof07GMOu3MH9l+2ZZAxHpForKju7hwmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j2jSyCSiTYqWw1u4N6b4smNpEyGup057
        VCEdSebb56CMlVj/Hp3ChcIBUB/eFY+KoWHceOjIwWIe5ghAa6wbVne7d+qK+f05
        EDbMKWA2OIpHz40BIAB60VC0AoODzYjYoQMnV98VYyXHLCr9kwHx7JkfaAX0gi4L
        aOYZDUHSm5g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFDBB87280;
        Sat, 18 Mar 2017 13:42:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D4058727F;
        Sat, 18 Mar 2017 13:42:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
References: <vpq1svtstud.fsf@anie.imag.fr>
        <CACsJy8D+VKGEtq6yMe+ZhfxKX2peCVXGZfZFckkZF_L=bWBqTg@mail.gmail.com>
Date:   Sat, 18 Mar 2017 10:42:10 -0700
In-Reply-To: <CACsJy8D+VKGEtq6yMe+ZhfxKX2peCVXGZfZFckkZF_L=bWBqTg@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 18 Mar 2017 16:01:50 +0700")
Message-ID: <xmqqk27m4h3h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 371A0DE6-0C02-11E7-9820-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Probably too late for GSoc 2017, but another idea for microproject (or
> microprojects) is make use of dir-iterator.h more. For recursive
> directory walking, this would make the code easier to read and
> potentially avoid too deep recursion. There are three or four of them,
> I think.

Throw it on the microproject idea page anyway, as it is likely that
the leftover bits will be migrated to the page created for the next
year and that way we won't forget.
