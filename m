Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B66207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 16:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbcJCQSr (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 12:18:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58263 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751111AbcJCQSp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 12:18:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FCDA4267F;
        Mon,  3 Oct 2016 12:18:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FgW3z4oFWqFVEnYXfBIct8tKi/o=; b=TSJJ++
        8SqXb07PmuIZ7wiZGyMf50OOszeBq5mPgLRKUYqhwv7Ks5z5zJq4gu6UgfCI5dH/
        MBKkIN7C+lnxxUCqXNT+CDBD0QPNAWCsgMqRb3o693xkGjGgj2RYDteXdAQ17ROu
        lV4gqN84RgqoTjVmtbDy4v7PF2HMUTRZNMWWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gHQ2arOoWqwisIJ+t9TcLA8rHI2MPcDI
        LYpq6XHMmqoDns31L5dLUW/d6nYmkrIsUaVbhbrtNW4gRqdpmqllk6B6FkigkR/C
        Tkc4Jfdze4kqj/Hbx7lRx80/QYpcYJMTkamzL8RWVM8uHMMQsvl7bEbFyY1OKyWt
        3/6Peb5tfEc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7594F4267E;
        Mon,  3 Oct 2016 12:18:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F26B64267D;
        Mon,  3 Oct 2016 12:18:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pat Thoyts <patthoyts@users.sourceforge.net>
Cc:     "Satoshi Yasushima" <s.yasushima@gmail.com>, <git@vger.kernel.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 6/6] git-gui: Update Japanese information
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-6-git-send-email-s.yasushima@gmail.com>
        <048AF5D4DC044BDC9F3A75A3BABD00F1@Yasushima>
        <xmqqk2enobol.fsf@gitster.mtv.corp.google.com>
        <87int9x1lp.fsf@red.patthoyts.tk>
Date:   Mon, 03 Oct 2016 09:18:41 -0700
In-Reply-To: <87int9x1lp.fsf@red.patthoyts.tk> (Pat Thoyts's message of "Mon,
        03 Oct 2016 09:45:22 +0100")
Message-ID: <xmqq60p98kym.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E021DC2-8985-11E6-B778-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> I'm just starting to catch up once again. hopefully I can be
> a bit more reactive than recently. Merging 52285c83 looks fine. I'll
> stick that onto the 0.20.0 head and see what else I can pick up on top.
> There are a few from the git for windows set among others.

Nice to hear from you again.  I think I have a few topics I merged
to my tree bypassing you in the meantime. Let me get back to you
with a list of topic tips to bring your tree in sync with what I
have later.
