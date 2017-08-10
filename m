Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520DB208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbdHJSnR (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:43:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56130 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752504AbdHJSnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:43:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27E8790E51;
        Thu, 10 Aug 2017 14:43:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IiCNUYWeN+zg2FwnsU8hfDmQDVg=; b=Fk0kri
        LMFQbS8yoCbfYky1ydbelhumNyoVpMDqIE7jwcH1xXWiJJdBW9lkAmmX334Fmhlm
        sh3zoLTDlaIL+XB54O+HSrOPdGDE3tCaif4Xt6E/ausZ1LWkt1/AnS22Knh4Gzvv
        c5QtQJeDrhpbks9UEBe0we2dSgC2mj7HdtzjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tXcYum87CTe2f20MCOSCLVXWRQa5A4+C
        DVcIRPINAMWuE2p7El33xgruguIuZjt2XAfGoEngtJHxuBt5Hd0Jyk1fRL20hRWC
        FULYfFs9Mn4fYHz6J+duxBoxft3NQ5NNacjdZ+84GELFuK9Mwc+97jM95TMK6fWS
        i83jWr/FZmg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2000390E50;
        Thu, 10 Aug 2017 14:43:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56D9890E4C;
        Thu, 10 Aug 2017 14:43:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] interpret-trailers: add an option to show only existing trailers
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
        <20170809122439.fscozhyvxcx2oq2n@sigill.intra.peff.net>
        <CAGZ79kYqq_EhRxckM4iV=99r59Y7_y94j+-65xXLUF4y2vNUUw@mail.gmail.com>
        <20170810073239.ny64rqmwb3yqbpb6@sigill.intra.peff.net>
        <CAGZ79kYHPhaZLSsBq2vM=D+_QMP9MY=xYjRwfG5q36neFyNH3w@mail.gmail.com>
        <20170810173328.xfrswan6tijwkaex@sigill.intra.peff.net>
Date:   Thu, 10 Aug 2017 11:43:14 -0700
In-Reply-To: <20170810173328.xfrswan6tijwkaex@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 10 Aug 2017 13:33:28 -0400")
Message-ID: <xmqq8tir462l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C503C85C-7DFB-11E7-B1EF-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Perhaps "--exact-input" hits all of those. Or maybe "--only-input" to
> match the other "--only".
>
> I think I like that last one the best. It makes it clear that we are
> looking just at the input, and not anything else. Which is exactly what
> the feature does.

Sounds good.  Thanks.
