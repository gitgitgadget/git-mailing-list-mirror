Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C471F463
	for <e@80x24.org>; Fri, 20 Sep 2019 17:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405231AbfITRv2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 13:51:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54958 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404985AbfITRv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 13:51:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10C762F3F1;
        Fri, 20 Sep 2019 13:51:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sw9ObVaVsJ4pECILxEYriQn5Vag=; b=SpboE5
        N+MV5jSMA6MpIRGhlb1qxSeMNqoQ8ok2fkD/vrwUUkKLJdO+/kDllfzrJJ2887i3
        SefVUDIcb1IZxyJwTh/QZQPSDqTPJEwMb0s45vjYvR7xOChH2G7bFfZ9VPNSsMTW
        1atgWYmqoMCn9MQ2nJqgbR/TLJ5v9idTeZr5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a7TntlgORiP8s1C51oAhCMdS9hFiCoT0
        oD4lu/guzWGKpcLpUD3Gkc+KpQ7He9hamN33rK208krpc8qrh31d7bORyiz3FukT
        UUWNLyOWonSLD2f/bRgaNNFcbQ9uDAk9/XBijWtVJiws0MbicEWIRw/KRFRFqDVs
        8TkYz5y0EmE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0855D2F3F0;
        Fri, 20 Sep 2019 13:51:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69DCB2F3EE;
        Fri, 20 Sep 2019 13:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [DISCUSSION] Growing the Git community
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
        <20190919173423.GA70421@dentonliu-ltm.internal.salesforce.com>
        <7819b52e-9222-8158-d26d-bf4ab2eec498@gmail.com>
Date:   Fri, 20 Sep 2019 10:51:23 -0700
In-Reply-To: <7819b52e-9222-8158-d26d-bf4ab2eec498@gmail.com> (Garima Singh's
        message of "Fri, 20 Sep 2019 11:22:37 -0400")
Message-ID: <xmqqk1a2votg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4340DC90-DBCF-11E9-92FE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:

>> could get people to tag with [FIRST PATCH] or something when sending in
>> their first patch.

I personally think that the [FIRST PATCH] thing will add distraction
without helping much, so I am mildly negative on that idea.

>> If the patch is not desired, then we should explain why it wasn't
>> desired instead of just leaving them hanging. I know Junio is too busy
>> to say "hey, I'm picking this patch up" to every single patchset,

It's not busy-ness but more of forgetfullness, or being human.  I'll
try harder ;-)

>> but if
>> a patch is desired, perhaps the rest of us could pick up the slack and
>> say, "hey, your patchset was picked up by Junio in his gitster repo on
>> this branch".

OK.
