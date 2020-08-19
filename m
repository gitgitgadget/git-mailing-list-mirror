Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAE6C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1669220639
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UCKbv4Hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgHSPnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:43:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62677 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgHSPnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 11:43:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47534F2EE4;
        Wed, 19 Aug 2020 11:43:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JHo5ZwbJPVAQVYJkdkwRUihlUWU=; b=UCKbv4
        HnCLjHyClZs0m/8l14v2fd/6nEDeZDd7xxMeNTRe28qm2U6boNsjcEtH3kvWQbyB
        jRw3EHkZpp7V5q8KlinAi28Hc2iK8pe1ZY2uiXOwoek3ZjtPGOTYEKKubv0YCJsA
        Rmct04bKd35QQ82DgdfxYXOQdY7F8+rNj2UFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZY3OXPN60LoGdyYFbOlCz5ijDSvPvy9y
        Ny2QqrZTdmoTjXwUS8J2BEL5b2SzvO7KA702oj/S46HIX//UG8iBJ3zheUDcibTA
        Bdeh6L6Uu03HfuYfXGFKzBn1I8IxAe5xK2Xy1hXKtf8/v5QHv3JGivxG079b/kfM
        CIogbFRFJNY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4080EF2EE3;
        Wed, 19 Aug 2020 11:43:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 83B2CF2EE2;
        Wed, 19 Aug 2020 11:43:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Carmen Andoh <candoh@google.com>, git@vger.kernel.org,
        git-inclusion@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Inclusion Contributor Summit Registration
References: <CA+Twho+nyERK1Ljdy6MnXA=iK6SiU85v4yLQc+fRmW83JVa+hQ@mail.gmail.com>
        <20200819095109.GA60828@cat>
Date:   Wed, 19 Aug 2020 08:43:01 -0700
In-Reply-To: <20200819095109.GA60828@cat> (Thomas Gummerer's message of "Wed,
        19 Aug 2020 10:51:09 +0100")
Message-ID: <xmqqy2mavdyy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB215BEA-E232-11EA-BB0D-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 08/14, Carmen Andoh wrote:
>> Registration is now open for the Git contributor summit dedicated to
>> inclusion. The summit will take place online over two half days on
>> Monday, September 14th, 16:00-19:30 UTC (9am-12:30pm PDT) and Tuesday,
>> September 15th, 17:00-21:00 UTC (10am-2pm PDT).
>
> I've taken the liberty to add the event to tinyurl.com/gitCal with the
> link to the registration form, to give it some more visibility.
>
> Should that be unwelcome please let me know and I'm happy to remove
> it again :)

Thanks.  My earlier question wrt the registration deadline (by the
way, in case you missed it, the answer is Mon Sep 7th 17:00 PDT) was
exactly for gitCal, but it sounds like that you beated me to it ;-)

