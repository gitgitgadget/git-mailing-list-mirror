Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487AD1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 20:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbcJTU2A (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 16:28:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61855 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752333AbcJTU17 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 16:27:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5DA247773;
        Thu, 20 Oct 2016 16:27:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7w7q4zOAHg/k
        aetyAi9D5qA2+a8=; b=T0ImcVw/BFwrSt3OGL9E/nbckYCA7HW+gsXBZ4ZOp8RN
        GEfysJS7dAI18UBuv48Hsi9cW3Gja1DCoPDCa496cTroPd0nFE+x7T4lFnmBV0HB
        dEKWP7CIr1LVsAo3pWs5D/iJ6knG1LVDvH/o8DGoLLnwVukdXKroLg9en5Yzowk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pF4HZ+
        FDxDkvCESW4CQ0Kzw/15f3PbbI+Fte2oonMufzQqjs+gVAY55ECNkYxcAJ6gIfs4
        oP8zP5jRSJUgkd6qIJ4U/g1KvifjWGoqq4gfClZdTeiUiq5g2BCp+bRakxcHBCS6
        vXEl+XJigYzOYxXChIVFuCwwIGxPvS5WnRUVQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC9F947772;
        Thu, 20 Oct 2016 16:27:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 400BC4776F;
        Thu, 20 Oct 2016 16:27:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 23/25] sequencer: quote filenames in error messages
References: <cover.1476120229.git.johannes.schindelin@gmx.de>
        <cover.1476450940.git.johannes.schindelin@gmx.de>
        <930ea31d6f10973807276c7a9f35f0d692d1ada6.1476450940.git.johannes.schindelin@gmx.de>
Date:   Thu, 20 Oct 2016 13:27:56 -0700
In-Reply-To: <930ea31d6f10973807276c7a9f35f0d692d1ada6.1476450940.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 14 Oct 2016 15:19:19 +0200
        (CEST)")
Message-ID: <xmqq8ttig3zn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B078D5BA-9703-11E6-9596-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This makes the code consistent by fixing quite a couple of error messag=
es.
>
> Suggested by Jakub Nar=C4=99bski.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

These finishing touches in 21-23 look all sensible to me.
