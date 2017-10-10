Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67BE620372
	for <e@80x24.org>; Tue, 10 Oct 2017 01:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755606AbdJJBGi (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 21:06:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55659 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755457AbdJJBGh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 21:06:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E29D1A9115;
        Mon,  9 Oct 2017 21:06:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qF+dy/e3RqhGxBL1yz0rjzfeoZE=; b=deVFTK
        EvSJZj5/vqn9Q18ybBrxdvyZ93HMZC4He1XCa9hMNm4KQ4dNYbvOks5flmttC5Or
        Zx+/VZ7SmrZrM8lQHWa/f7rWMTr7YOI7JU0eDaXM2MIhaw1B5EbV+E8FDj0rBNSy
        XYpVUn91FvhOIB6uwM9Iiowm52fycaOyj39WM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U0Jb3jafhCGYMQ5fUOTV0+qmzG2CEXPA
        /arf8giz2zh4poLJAbp/47JO8seDHMqlDNRepXwk0TgqSWV8oHnj5dPVLMcZy3Hc
        7evUYBatr65O8iB2kZD9wtFbJxikSKgeuDXcOU28S3nlaRXr+XLKjoAbENg8mrBx
        REIFYeaD6yk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAEE5A9114;
        Mon,  9 Oct 2017 21:06:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 411BBA9113;
        Mon,  9 Oct 2017 21:06:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] submodule: spell out API of submodule_move_head
References: <20171009220615.27541-1-sbeller@google.com>
        <xmqqtvz7rh68.fsf@gitster.mtv.corp.google.com>
        <20171010002731.GM19555@aiede.mtv.corp.google.com>
        <xmqqmv4zrfye.fsf@gitster.mtv.corp.google.com>
        <20171010005520.GN19555@aiede.mtv.corp.google.com>
Date:   Tue, 10 Oct 2017 10:06:34 +0900
In-Reply-To: <20171010005520.GN19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 9 Oct 2017 17:55:20 -0700")
Message-ID: <xmqqinfnreud.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43698936-AD57-11E7-A09F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> All that said, I want this function to go away completely. :)

Oh, if you are planning to replace it with something else, then I
wouldn't bother wasting my time trying to understand the updated
comment, or making it more understandable by others.

