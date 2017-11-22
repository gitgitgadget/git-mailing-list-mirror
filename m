Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CABC202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 07:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdKVHz1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 02:55:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58526 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751469AbdKVHz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 02:55:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54337BE0A8;
        Wed, 22 Nov 2017 02:55:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l3c+ECwMenSbeIuOPHmm24KX34E=; b=C0PuNg
        pHsDcP4fVrE1ZmsscOu8QFKIEUVxpPcBoxm/jjW5nNbJj89pW2KkYl+iW/ZgEZwN
        imWUUD+zjnyafhcnnrUSBd+077PNh1rQPcKXlDrbovDsjbuGS2dmehcHwp1Ih/VN
        P5mFyQqKu8S6Gzo7O3oUtGNbS9j3racXF9lkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GNpAo6QKs8xHahxiEELxaCMFQvaTn7lg
        x/Eo9Q6p41VqoxDtcU9XVr2as3qSGLORT30GD5083kh/opJmcKn+V/6rwYQa+1fD
        sS/EeA+DqE4jxxV+4w2GlxnEkXr0bkwYlIODJ89EG8elchjJ2U6y6uHMQcAf/+Ya
        8echwyuSVOk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 311CCBE0A7;
        Wed, 22 Nov 2017 02:55:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACDC0BE0A6;
        Wed, 22 Nov 2017 02:55:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCHv5 7/7] builtin/describe.c: describe a blob
References: <20171116020039.17810-1-sbeller@google.com>
        <20171116020039.17810-8-sbeller@google.com>
        <xmqqwp2qx5w6.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaGGUJSGG6OdfaTepDrvGBGFd17paBNNYuQt7t8XnDfHw@mail.gmail.com>
Date:   Wed, 22 Nov 2017 16:55:23 +0900
In-Reply-To: <CAGZ79kaGGUJSGG6OdfaTepDrvGBGFd17paBNNYuQt7t8XnDfHw@mail.gmail.com>
        (Stefan Beller's message of "Thu, 16 Nov 2017 11:34:12 -0800")
Message-ID: <xmqq7euiu4r8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F434580-CF5A-11E7-B9CF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> ...
> fixed.
> ...
> fixed the text...
> ...
> I am not fully convinced all descriptions are in recent history, but I
> tend to agree that most are, so probably the trade off is a wash.

So what do we want with this topic?  I think the "teach 'git log' to
highlight commits whose changes involve the given blob" is a more or
less an orthogonal thing, and I suspect that it is something users
may (although I personally do not) find valuable to have a related
but different feature in "git describe".


