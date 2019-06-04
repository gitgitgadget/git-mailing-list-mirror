Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A0531F462
	for <e@80x24.org>; Tue,  4 Jun 2019 20:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFDUWl (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 16:22:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53627 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDUWl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 16:22:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54858647B3;
        Tue,  4 Jun 2019 16:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ijanPeGzqqwuuTXDy3VkL/ZbkAY=; b=pdwYr8
        qwmQvse2lFD67K38Z+G4Deug6xiLXNMYXnT1vjT8xVJN/NoV8/I/+NKnc0FrJoDr
        qsC2QzoFHW6z/fjUIZ3rxVaegcvQSRnGWSq5sINZB+sX5zn9AleM7NXfjS2ULI8p
        w4PXD9BKH/LzYRwZgkvf5vsZHaI5iZYRHd40I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KiP4VecMKSKDWQU0g457/6M+h+VoXsCn
        fZoBbugHIGQYBIc3Q+wu6XUD+uVj53S/Nkv/t7hXKGADrwJ3m4omcFUGSw1jzaOb
        cp/XiCJvRjt63hUbLdYiVGU/pls1LSJU4YfiA7pcm5i07Jcp0C8sDAMnTO8mWsC6
        tOi4mIBOzTk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CDC0647B2;
        Tue,  4 Jun 2019 16:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7F5E2647AD;
        Tue,  4 Jun 2019 16:22:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: pw/rebase-abort-clean-rewritten, was Re: What's cooking in git.git (Jun 2019, #01; Mon, 3)
References: <xmqqsgsqto3n.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1906042205360.1775@tvgsbejvaqbjf.bet>
Date:   Tue, 04 Jun 2019 13:22:33 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906042205360.1775@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 4 Jun 2019 22:06:47 +0200
        (CEST)")
Message-ID: <xmqq8suht81i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E0563F0-8706-11E9-B4F9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  On hold.
>>  cf. <20190514180349.17245-1-phillip.wood123@gmail.com>
>
> Maybe you meant to say "Will cook in `next`" here?

I meant to label it as "On hold" (as the author asked us not to look
at it during the -rc freeze; see the reference), and haven't found
an excuse to change the label for the topic (e.g. another respose to
the discussion thread indicating renewed interest in the topic) yet.
