Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F604202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 14:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbdJ2OSi (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 10:18:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64531 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751286AbdJ2OSh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 10:18:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6C0EB46F5;
        Sun, 29 Oct 2017 10:18:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uQLyIzAt6z9VCNmoAZvIUfU0VZE=; b=BqlNuX
        ONDSt3iL86pO4jzSWbHYYXWU8cu5OCCYuXdqXbngd9Y38CeBEQKE2me30fsvL6d7
        bAweXFaB7VQiQQWynEDM8gQNydoIkqgkERsATDys0nQYfU1/Q669z+YM0Wv2t/Tj
        KI804++RtF8eq9aS9tFQpKew9JwsvEYr5o6bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m0eMLZdLurxfw0jxXNtm8oqnHCb2Oqhs
        RpVpHIT83I1iIvbruR9jaRTinm1LIezHk78N7UJIAQAeBRE4D+NCE8wzwTc955Xc
        6jfbj/PYbblDaHs12lcyok6+9C7yGoD+Olqf21g9BYxkeSZLcGMraXx6w1cNOzxS
        VnqJ6Fyx9NU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEF38B46F4;
        Sun, 29 Oct 2017 10:18:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E4B8B46F3;
        Sun, 29 Oct 2017 10:18:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #06; Fri, 27)
References: <xmqq7evhc7nw.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710291409390.6482@virtualbox>
Date:   Sun, 29 Oct 2017 23:18:35 +0900
In-Reply-To: <alpine.DEB.2.21.1.1710291409390.6482@virtualbox> (Johannes
        Schindelin's message of "Sun, 29 Oct 2017 14:13:59 +0100 (CET)")
Message-ID: <xmqq7eve9gw4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D6B36B0-BCB4-11E7-AD56-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Would you terribly mind adding a SQUASH??? with my suggested fix for
> PERL_NO_MAKEMAKER?
> ..
> Likewise, this needs a SQUASH??? to remove the uplink$X before
> (over-)writing uplink, to pass the test suite on Windows.

Surely I don't mind; please just send me something I can "git am"
(or something I can "git apply --index && git commit -m SQAUSH???"
would be sufficient) for these; letting me construct and/or type a
patch from pieces of discussion messages is a sure way to introduce
further issues for Windows, as I don't have a way to test any such
change before I push them out.

Thanks.
