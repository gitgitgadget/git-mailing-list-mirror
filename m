Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2ABD1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 21:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754664AbcIIVQL (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 17:16:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58767 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752040AbcIIVQK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 17:16:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98E9A3AF62;
        Fri,  9 Sep 2016 17:16:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J2w9gqoEDew/DAqSHi7Tjdb2Upg=; b=h9Dre5
        4q7O7zsa8TTxYuXzrgNfSs+vuVsOqMnN5IKxQc3qGAqQ2vgMVXvaPYWi3giNEPOJ
        XGsG/p/k6L4QD2HAFkvQmr+nZ5vdout+trd0U2MwiGeg1TUnQ7z1S/WBoo/r8uE/
        Kjqba9lwin1pKSmGg7zsxfq1ryhp2/lSjHxtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mgQipalUelArGBYVGKIzyP6QaIyxB4fz
        wihezI6QVuqGMQetzSzFrJPW0lsSRN5Wa2MyrIcsNZMtl1Vf39Ii77wThElTST3E
        9PKJE5XY5Wgpc48pyUDfeZyqzo+DAFVDEW1lmTjnP2j7eTT3gBRa2LaZOCpsmhls
        ekEk2oWSihM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 915F63AF61;
        Fri,  9 Sep 2016 17:16:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DEA53AF60;
        Fri,  9 Sep 2016 17:16:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before email signature
References: <20160908011200.qzvbdt4wjwiji4h5@x>
        <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
        <20160908185408.5qtfnztjbastlrtw@x>
        <20160908200819.pkg7jqcvxjpdqr3a@sigill.intra.peff.net>
        <xmqqd1kef5k5.fsf@gitster.mtv.corp.google.com>
        <xmqq7fakc12z.fsf@gitster.mtv.corp.google.com>
        <20160909200721.xfkbud377ja4wkrt@x>
        <xmqqpoocajbb.fsf@gitster.mtv.corp.google.com>
        <20160909210040.zlsczhcotrxnu4e4@x>
Date:   Fri, 09 Sep 2016 14:16:07 -0700
In-Reply-To: <20160909210040.zlsczhcotrxnu4e4@x> (Josh Triplett's message of
        "Fri, 9 Sep 2016 14:00:41 -0700")
Message-ID: <xmqq7fakai5k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A09E9EB4-76D2-11E6-9341-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> It doesn't seem like a functional issue, but aesthetically it
> doesn't look good.
>
> Do you plan to make that change to print an additional blank line
> (likely inside print_bases), or should I?

I do not mind doing it myself, but I am already in today's
integration cycle (which will merge a handful of topics to
'master'), so I won't get around to it for some time.  If you are
inclined to, please be my guest ;-)

Thanks.
