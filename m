Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11EE3202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 14:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934253AbdKPO6q (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 09:58:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58871 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932459AbdKPO6p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 09:58:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9708AAD812;
        Thu, 16 Nov 2017 09:58:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=idMllpRqhKNpUr4wWp0tn2oziFs=; b=h74EnM
        Xm3sV5sxLJLGgmi7ZMWFqCThHIrTo9naxIcoMO7XnpAQSxkDalTgbNhW8SS3DPPL
        c+/2j+7V00IRIDwLLQeWx+Kkdoald1EM4n9Uu3min3HiS726RKVuz2Q+qZ26XzZV
        B769ju+4djKlXoWR2uEcrrUVYj2kFNojbh55k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uCrXvhVdL+zbmtlPoUfmjT7OvZDDuPzK
        iE4uebcAMunLeUjKjhZLJNsTakLPYy4F+is25vVD0dbc5nO3kzjp690H5weugi4O
        dsd+ryWs9IuhYC2Va2QyFgLHpT+oyRiZ9Tp4M1U8Z8NMI68A5dIpB80+3Jqyol3l
        swHciX/pgLI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E433AD811;
        Thu, 16 Nov 2017 09:58:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09E12AD810;
        Thu, 16 Nov 2017 09:58:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] launch_editor(): indicate that Git waits for user input
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
        <xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com>
        <DAEC36C7-AE09-4C9B-ACC4-07F2C5F2B97F@gmail.com>
Date:   Thu, 16 Nov 2017 23:58:42 +0900
In-Reply-To: <DAEC36C7-AE09-4C9B-ACC4-07F2C5F2B97F@gmail.com> (Lars
        Schneider's message of "Thu, 16 Nov 2017 11:25:50 +0100")
Message-ID: <xmqqh8tuuv6l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3F7E30C-CADE-11E7-B4B7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 16 Nov 2017, at 07:04, Junio C Hamano <gitster@pobox.com> wrote:
>
> Wow. Thanks for the quick patch :-)

Heh, this is not exactly my itch, so if you are inclined to, can you
take it over from here on?

Thanks.
