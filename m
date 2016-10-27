Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28E120193
	for <e@80x24.org>; Thu, 27 Oct 2016 17:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936090AbcJ0RI0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 13:08:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65119 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934208AbcJ0RIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 13:08:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41AF8496D3;
        Thu, 27 Oct 2016 13:08:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QjlmatL+bsSHNtIA+t/5pzBs9uM=; b=IZgaw8
        4Y3wk2eY4ElJyqABbRSRTeFJLWQ5OMzulj6XCr1HHQ2akeJ+f5JEKTod8LcHCb5h
        zHRh2fEGJGHeDDZXI67JVnhkM/VVUDS5SUeavxZalsgYo4mXmE/XCByqpK6hGvbN
        B5bXAzYzwSC65LndJqEoVv92KgNAM63TA7SOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CvYe4U0qbi4h9/JUHz7Lry50Ocqn5o5v
        RzUna0M5ZKfdJ11w5SNU5Zq25txAemnntDAYuieihmniVMHOgwRrI2mD8Jkb8BVN
        HduhztnQvbJA0Cu1SUjiZCrqRLIaZm/EkGMPBrCcuUauxG0Xx+AO8RTA60ddHgeS
        xZ22G6vYRbI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39B5A496D2;
        Thu, 27 Oct 2016 13:08:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE157496D1;
        Thu, 27 Oct 2016 13:08:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v4 00/14] Mark strings in Perl scripts for translation
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
        <20161010125449.7929-1-vascomalmeida@sapo.pt>
Date:   Thu, 27 Oct 2016 10:08:21 -0700
In-Reply-To: <20161010125449.7929-1-vascomalmeida@sapo.pt> (Vasco Almeida's
        message of "Mon, 10 Oct 2016 12:54:35 +0000")
Message-ID: <xmqqmvhp7m9m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8036814-9C67-11E6-8E0C-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Vasco Almeida (14):
>   i18n: add--interactive: mark strings for translation
>   i18n: add--interactive: mark simple here-documents for translation
>   i18n: add--interactive: mark strings with interpolation for
>     translation
>   i18n: clean.c: match string with git-add--interactive.perl
>   i18n: add--interactive: mark plural strings
>   i18n: add--interactive: mark patch prompt for translation
>   i18n: add--interactive: i18n of help_patch_cmd
>   i18n: add--interactive: mark edit_hunk_manually message for
>     translation
>   i18n: add--interactive: remove %patch_modes entries
>   i18n: add--interactive: mark status words for translation
>   i18n: send-email: mark strings for translation
>   i18n: send-email: mark warnings and errors for translation
>   i18n: send-email: mark string with interpolation for translation
>   i18n: difftool: mark warnings for translation

It seems that nobody has anything to say on this series, either
positive or negative?

The topic has been in "Waiting for review" pile but I'll mark it as
"Will merge to 'next'" unless I hear otherwise within a few days
(positives may make it faster, negatives may require a reroll).

Thanks.


