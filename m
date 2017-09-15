Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F6F20A21
	for <e@80x24.org>; Fri, 15 Sep 2017 02:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbdIOCT0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 22:19:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62475 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751722AbdIOCSS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 22:18:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23241B3083;
        Thu, 14 Sep 2017 22:18:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=He3do3K6jM1LXI83wN8kjEV+oyE=; b=kAOC8S
        CUK2cQw9gZ4o5Aepd6AjvKADYCPtrFI3u177ki3wtV/oyLRtpcZH9uY223M1Gpfs
        fpbs9oTgFmz6IQIsYPWX8XfnZ7pHHTbdLU3G6q8KgMVGBuNXyIyMIiI8w0xRGniv
        7DjVLWXjdK/K1thpByD5lbV1tv+qtR6p1v7zM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xiclLlzgGUPA/kg2DoxGh9X5Vc9NN6bE
        DwuqWDpzYDUQuX/DXBFSGz95DjzcoO/aDa5P0t5UzrVePvqKj9MkR2o6s7JLK7C/
        MrtuPeDHKvZpUX6AalDFfUfNQPNhVVMzzbgEXDpQ6EHcqK+XNckhqJjWugX5fAz3
        rn11/7RsTow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B6DFB3082;
        Thu, 14 Sep 2017 22:18:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F73FB307F;
        Thu, 14 Sep 2017 22:18:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Subject: Re: [PATCH v2] commit-template: change a message to be more intuitive
References: <e656d1b4-c95e-e51d-5f48-bb3450580fa4@gmail.com>
        <0102015e7b585037-5f88e775-2696-49ec-8dd9-5e1635a34607-000000@eu-west-1.amazonses.com>
        <862e71a1-2dee-4a20-d828-69a0547fa5ec@grubix.eu>
        <2480c33b-7e44-5c7c-cd31-feae9168b9dc@gmail.com>
        <20170914144120.oqx2trhccweiu7qo@sigill.intra.peff.net>
Date:   Fri, 15 Sep 2017 11:18:13 +0900
In-Reply-To: <20170914144120.oqx2trhccweiu7qo@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 14 Sep 2017 10:41:20 -0400")
Message-ID: <xmqqefr8zouy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 210ACF70-99BC-11E7-8153-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   # ------------------------ >8 ------------------------
>   # Do not modify or remove the line above.
>   # Everything below will be ignored.
>
> (I might say "everything below it" to be more precise).
>
> I dunno. We are deep in bikeshed territory here, and I admit I don't
> overly care that much in the first place.

So should I drop this topic altogether?  My inclination is to
declare that "everything below it will be ignored" is the best
version and stop reading further updates to this thread ;-)

