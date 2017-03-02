Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56F241F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbdCBVVY (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 16:21:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55772 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751132AbdCBVSy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 16:18:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4ED49828B1;
        Thu,  2 Mar 2017 14:41:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=guoueh9PSus1I7eVH4hyOuGOroA=; b=gcDHMU
        9OpFr8VloRIzxBjXqnBzD6pKwKk+o0xjfaSvhaY+V8BhhGWMMhMAUP2jDZeebi+y
        j0vMa6L/zAEu1KcBa9ASuZtY07ccjCV+8UcGr7Fdekvp3VvooD4JT54LMCbN+2bq
        fiB15/L5lWXGuOQlYkdAggTN/UbfcdbcO9mdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p/VpcE/YE6KcSkFXQxLG22+MldVLM/T2
        aGw7qQmk5MrztkMHtazcfM6uAHM+nNlExgGzKVUQXEcycGhHzGQWm9ynF8ktwf5p
        wjz00gmOlonjLc2WuK+i+OGov1EiU4aXagMHSop4UMhSApxHEOX8pmyKVXUCljES
        48v/GdJ+ht0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47F43828B0;
        Thu,  2 Mar 2017 14:41:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AFF96828AF;
        Thu,  2 Mar 2017 14:41:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: Improve description for core.quotePath
References: <1488481432-25336-1-git-send-email-asheiduk@gmail.com>
Date:   Thu, 02 Mar 2017 11:41:51 -0800
In-Reply-To: <1488481432-25336-1-git-send-email-asheiduk@gmail.com> (Andreas
        Heiduk's message of "Thu, 2 Mar 2017 20:03:52 +0100")
Message-ID: <xmqqo9xjbh4w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49047E58-FF80-11E6-A0C3-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is now a single-patch, which makes sense, too.

Let's merge it to 'next'.

Thanks.
