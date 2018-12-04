Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD852211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 02:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbeLDCtm (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 21:49:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62688 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLDCtm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 21:49:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70E1E10DADB;
        Mon,  3 Dec 2018 21:49:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eHL20teeIfob
        PPtmgSJhG4l1w9M=; b=cyxmKewS9AQMR78PCrv24pWfAZlcdEulakWVltYFyR0I
        YBhCU9Ib04WVjU2xQgz5GojXnjifPUbH6hnOUAnk7I5Lt+sOG7jRNIQGBxSkJasg
        S4rRiBHeHScE/GFi24QgdoTrT/6ahFqWVEyNcTSk31vghVpWw12CQZmT3LjzyPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Pu+ixi
        BXVBGlTANjTHaIMhvZZv2rXNxRwWlz2M5sehfymQorCa1tFr83S0CBf9a02wWxy5
        V4mrdgM1ek5OLE6P66DBtJl/t0NUncQVrtxBoH/K1Rppy8Nnjz3iy18NrYRHbqWm
        I/I3FAY18uK1Gqpjvfi6o7Eov3Fw5Fa5WG+kQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6946710DADA;
        Mon,  3 Dec 2018 21:49:41 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D763010DAD9;
        Mon,  3 Dec 2018 21:49:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section Behavioral Differences
References: <f26b53e3-e7d1-f0fe-cdd3-dd734beb1628@kdbg.org>
        <CAN0heSqfgu2A7Hg5b1Td-m_5gXtmd-8_ZBC5Fq9BDMaJD0yMqA@mail.gmail.com>
        <3d8da8da-755f-7114-2274-77bd92720a83@kdbg.org>
Date:   Tue, 04 Dec 2018 11:49:39 +0900
In-Reply-To: <3d8da8da-755f-7114-2274-77bd92720a83@kdbg.org> (Johannes Sixt's
        message of "Mon, 3 Dec 2018 21:50:05 +0100")
Message-ID: <xmqqftvef1ks.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F399316-F76F-11E8-B639-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 03.12.18 um 21:42 schrieb Martin =C3=85gren:
>> On Mon, 3 Dec 2018 at 18:35, Johannes Sixt <j6t@kdbg.org> wrote:
>>> I actually did not test the result, because I don't have the
>>> infrastructure.
>>
>> I've tested with asciidoc and Asciidoctor, html and man-page. Looks
>> good.
>
> Thank you so much!
>
> -- Hannes

Thanks, both.
