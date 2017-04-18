Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93E31FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 03:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbdDRDU6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 23:20:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59371 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754602AbdDRDU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 23:20:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAB3B74455;
        Mon, 17 Apr 2017 23:20:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vj7fib2ObeBKtHyLzrIgXWU5Hn4=; b=LIB5Ft
        Cj3k1JXgghDyS7WZ1WWuFH+wfk2Qwx0KhNgUEPn8e6kVhp1IeoYWebYcn76bpQnw
        GZw5RsPf1zS8djKi/qsGNJ7b9PS4Dlz4vzhA/pTokpGRtZEHyDhDPFV2+FfNfcRy
        ulSo5bwm6b6dmTnySIfo0y2s2xFg8sboPlVD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jkTQdVIMYdhL0C2rEIT0RBbKU/6nW3pd
        +iC+YNFAj9k2q7+3uOMu8+sE+zOjHpNkGDmg6g+UoxOwysWzDHb1FpK6WGl8dPxO
        XpHW/LJV6NOmnPxODMEdM/InOboJEGh7YwjLqeOap9FrrgktE6xpiXsh5cdLA5zU
        Rgc8o24eTXE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D20CF74454;
        Mon, 17 Apr 2017 23:20:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3827A74453;
        Mon, 17 Apr 2017 23:20:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Urs Thuermann <urs@isnogud.escape.de>,
        Git mailing list <git@vger.kernel.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>
Subject: Re: How to keep log history when renaming and changing simultaneously
References: <ygfpogbb711.fsf@tehran.isnogud.escape.de>
        <f456df1f-cda2-4681-8f01-b693655e79a7@gmail.com>
        <ygfefwqzph7.fsf@tehran.isnogud.escape.de>
        <CA+P7+xpWMdoQj5FxkN=7QKc3UvW77HsTDs5RRZiCg4WVnB4wqA@mail.gmail.com>
Date:   Mon, 17 Apr 2017 20:20:54 -0700
In-Reply-To: <CA+P7+xpWMdoQj5FxkN=7QKc3UvW77HsTDs5RRZiCg4WVnB4wqA@mail.gmail.com>
        (Jacob Keller's message of "Mon, 17 Apr 2017 18:15:42 -0700")
Message-ID: <xmqqr30qflk9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08A2FD28-23E6-11E7-AA59-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Unfortunately I don't have a ready link to the message, but there is a
> very good post from early on in Git's development where Linus explains
> why Git does not store rename and copy information in the history.

One of the most important message in the list archive, gmane:217 aka

http://public-inbox.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/

