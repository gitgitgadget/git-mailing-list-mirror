Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E421FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 20:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754453AbcKUUsg (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 15:48:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58336 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753566AbcKUUsf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 15:48:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76172503EB;
        Mon, 21 Nov 2016 15:48:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0BJ6nZoV7dpFdeaUi7l09KODEBA=; b=PvE0Ai
        QKoDJ/WDI0+SB5Zz/WvxMMYOf+dhf0IMeQQEdtmDghus4Gm0zFHWcPOXLGefrCi5
        s088CiEagRWat4ptlqD2DMDKpEASL79mAJcXfBUsaAr1XkyjTAKmUSd2g00RTh2W
        f8N2h5lZFaDlTPQNBg6G2pt0y/LHLTXRpWBxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OZOPWCon8Gyoo3bl6VV/nvnAl8VNz0Yf
        jXLU7AP28B7yWltUZ+gD1uxjYQoiceOP20KBegCsz565EoxaDyKnxnrFm+fzBh+Q
        UK9p4RoZsXAJR875wwTrFGAQotw2MGoJ+L7JQYe0HtYB15eMbWYs1E5dnU0nT/47
        jr1yE8yUPJo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E173503E9;
        Mon, 21 Nov 2016 15:48:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4CC0503E4;
        Mon, 21 Nov 2016 15:48:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, jrnieder@gmail.com, git@vger.kernel.org,
        Jens.Lehmann@web.de, hvoigt@hvoigt.net
Subject: Re: [PATCH 0/3] Introduce `submodule interngitdirs`
References: <20161121204146.13665-1-sbeller@google.com>
Date:   Mon, 21 Nov 2016 12:48:32 -0800
In-Reply-To: <20161121204146.13665-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 21 Nov 2016 12:41:43 -0800")
Message-ID: <xmqqd1hoimov.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE2C644A-B02B-11E6-A483-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The discussion of the submodule checkout series revealed to me
> that a command is needed to move the git directory from the
> submodules working tree to be embedded into the superprojects git
> directory.

You used "move" here, and "migrate" in the function name in 3/3,
both of which make sense.  

But "intern" sounds funny.  Who is confined as a prisoner here?
North American English uses that verb as "serve as an intern", but
that does not apply here.  The verb also is used in Lisp-ish
languages to mean the act of turning a string into a symbol, but
that does not apply here, either.
