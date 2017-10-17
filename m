Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E966C1FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 21:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764295AbdJQVAU (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 17:00:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60397 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754896AbdJQVAT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 17:00:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DDED9A7A6;
        Tue, 17 Oct 2017 17:00:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fv6DlFVKLjlBd7EgrkEx6xGOZN4=; b=kxuOtQ
        zt11cT7l2ACxrnuygcSkZDfFdye/HUcmCHYexRKSQGvc9obIQGE11Vu43OqteWBp
        ESNEU5lCSKLN/AciHBJX7AKrPnTveCLshkX9LPaCfAACpA3AzNLsW7vkCTPghSGu
        ibTMPpmMGu0w2F1F58iudWzbrj6ZlGt0wQf3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Oan9PzCtMBqtAqvWc1ila5DgpCCrVdQc
        eQQd5a9rATJ9G27fFW0gqvMd3EKZLhDXK2DWhz2W/OWwR7iSs8PYdONPIdSJ+fSl
        PhPNoQwiNO/9IJds16nMNDijSEG6DFAIVipBapt/UZgedVz+XkKRLot17O4MMDyv
        D1zu/+ld9WY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65FD59A7A5;
        Tue, 17 Oct 2017 17:00:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBC999A7A0;
        Tue, 17 Oct 2017 17:00:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fetch doc: src side of refspec could be full SHA-1
References: <xmqqinfepguv.fsf@gitster.mtv.corp.google.com>
        <20171017193511.szbmrclju22a6p5l@aiede.mtv.corp.google.com>
Date:   Wed, 18 Oct 2017 06:00:17 +0900
In-Reply-To: <20171017193511.szbmrclju22a6p5l@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Tue, 17 Oct 2017 12:35:11 -0700")
Message-ID: <xmqqwp3tmqvy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EB7D33A-B37E-11E7-ABB8-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> nits:
>
> s/most typically/typically/
> s/an fully/a fully/
>
> With those tweaks,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
