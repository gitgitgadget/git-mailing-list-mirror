Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69531F935
	for <e@80x24.org>; Wed, 21 Sep 2016 23:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756848AbcIUXN1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 19:13:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60662 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756259AbcIUXN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 19:13:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A50040A83;
        Wed, 21 Sep 2016 19:13:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TyO5ItaXVaNwyEqlHLKCgpeJA2s=; b=NqfA3B
        ZAOoANYKWXyskd9fh1dTsJx0Z4ZwMsGs8us2/+WPR0jULtrpHumA1HPgyCSlxbbH
        fIREKiLnbLc1ZDZFLoZqVeGCRXGDL+FT+19UW0PD7izOtkosjBDhsvyiJcg98871
        e/y8KKxbN62/YB2HIp702+lbU8HJGalXzCenQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eZJkAxGDpqZdKe0Y/m9TiZQK3r3BFnaa
        hmQ0vpNRDkGqbfsDg4RK+UCCUJGY3plzTyQAHb2vMPe+8Fco9h/RtnHPsPfkgnog
        GoyNgUUgqG3W+fmGMruVCwLb6HGRZoOosnzvw8t0BadjiTWrw1mWWCco+Lnk9Awf
        m8DgzTRppN8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D3CF40A82;
        Wed, 21 Sep 2016 19:13:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB95540A81;
        Wed, 21 Sep 2016 19:13:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
        <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
        <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
        <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
Date:   Wed, 21 Sep 2016 16:13:22 -0700
In-Reply-To: <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
        (Brandon Williams's message of "Wed, 21 Sep 2016 15:38:22 -0700")
Message-ID: <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF3A37BC-8050-11E6-A485-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> yes you mentioned this and I meant to change that before sending it out.
> Looks like it slipped through have slipped through.

I already fixed it up locally when I sent the reply, but thanks for
resending (which assures me that your local copy is up-to-date and I
do not have to worry about having to repeat me in the future, if
this ever needs further rerolling ;-).
