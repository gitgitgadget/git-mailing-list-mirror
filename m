Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A58B8202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 00:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbdJXAyf (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 20:54:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50673 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932170AbdJXAya (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 20:54:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C338495145;
        Mon, 23 Oct 2017 20:54:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sDcH4ELeJMVR/lOmQo1FWnAINTs=; b=v6dyLp
        XlcrhxqSPNxucYhCVRGVeo3Gz4tDfUgs58QkSAXeLW6xul6mIzltx9/A2w0sb3FM
        iKwfk3I/pGZgRqhQbFCevir0HKWEZhYtCkHK2wg/FHpUj9otDvRusu9ogSS0Uc1B
        vS+V0oU+lpvzjnogdl361h11lrVf6HvMlwuKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SBQtiPNJqnQMk7WjjSk/T2FI0ymyKHEk
        kj2BtZzFKmg44sQXOu62GI2Db9wxtl/8DboEMqe25P/TLkpMzH3UxKQUuieCpq10
        zSiCSg0GG9H2DOGF3z8r90rIf5Lw7tqUopmhIUwao0qBp9njiZk4F1xs/ADsOct9
        JioheYUPosc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBC6D95144;
        Mon, 23 Oct 2017 20:54:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EEC895142;
        Mon, 23 Oct 2017 20:54:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
        bmwill@google.com, git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 2/2] fetch, push: keep separate lists of submodules and gitlinks
References: <xmqqwp3sj7ov.fsf@gitster.mtv.corp.google.com>
        <20171019181109.27792-1-sbeller@google.com>
        <20171019181109.27792-2-sbeller@google.com>
        <20171023141259.GB85043@book.hvoigt.net>
Date:   Tue, 24 Oct 2017 09:54:27 +0900
In-Reply-To: <20171023141259.GB85043@book.hvoigt.net> (Heiko Voigt's message
        of "Mon, 23 Oct 2017 16:12:59 +0200")
Message-ID: <xmqq7evlbc1o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3C910C8-B855-11E7-8E5D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Why sorry? For me it is actually interesting to see you basically coming
> to the same conclusions.

I find it also assuring to see that two people not constantly
working together closely come to the same conclusion.  Thanks.
