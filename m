Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8522320A40
	for <e@80x24.org>; Sun,  3 Dec 2017 00:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbdLCAqK (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 19:46:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58648 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751533AbdLCAqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 19:46:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A5F6B37DF;
        Sat,  2 Dec 2017 19:46:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/HS4JkcvaoykTTsA5bm53EB7SDQ=; b=RfjB+e
        RvUSxeVns5XFeWkoT6gq8UYLAvGZXEwuplmICZ5fQmdpC8oECAtLFn28+lB0aVtj
        A28HmlxoWX4uEOslov2RbVcedf0BwfxROefUZlvzb+rHVZ6SC6pb0W66L4jS3LaJ
        xrEB0aJrM7C430staKxaOQjtReLE0ZMs0mxkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hk6y7puH7QUhREUeWWc/6lt7Nt0o0JvR
        uo/T6EeEbZsSwPVCAktPqgjNULYWLXRiB3Qr7IunRokBjX9brPARnA1bnx8H4NO0
        FNWU29IIU0kT7MYKIgfyaFNjcjaIng0esm4/zvNLX/JKgV4Dwfo2HLbnJvRqhnaD
        VROMsD+CbNM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 212A6B37DD;
        Sat,  2 Dec 2017 19:46:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85DF9B37DC;
        Sat,  2 Dec 2017 19:46:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases
References: <20171126193813.12531-1-max@max630.net>
        <20171126193813.12531-3-max@max630.net>
        <CAPig+cROFS+3Yon2CFr-aPUGzDY4WVbU8kHbBx68O3M8k5eeug@mail.gmail.com>
        <20171126224051.GF26158@jessie.local>
        <20171129032632.GC32345@sigill.intra.peff.net>
        <20171129051919.GH26158@jessie.local>
Date:   Sat, 02 Dec 2017 16:46:07 -0800
In-Reply-To: <20171129051919.GH26158@jessie.local> (Max Kirillov's message of
        "Wed, 29 Nov 2017 07:19:19 +0200")
Message-ID: <xmqq374smyeo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59FB70A6-D7C3-11E7-B405-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> If nobody objects changing the user-visible behavior, I'll
> consider using this.

What user-visible behaviour?  A user tries to use a new test helper
introduced by the previous round and does not find it?  That's OK.

> PS: I'll respond to your other reply a bit later.

Thanks.  
