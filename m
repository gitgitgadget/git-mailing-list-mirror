Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_DNOT,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA891F453
	for <e@80x24.org>; Tue, 19 Feb 2019 13:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfBSNdb convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 19 Feb 2019 08:33:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:54474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbfBSNda (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 08:33:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A7D6ADE2;
        Tue, 19 Feb 2019 13:33:29 +0000 (UTC)
Date:   Tue, 19 Feb 2019 14:33:28 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Senol Yazici <sypsilon@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, jpyeron@pdinc.us
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
Message-ID: <20190219143328.20fce291@kitsune.suse.cz>
In-Reply-To: <87o97858ko.fsf@evledraar.gmail.com>
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com>
        <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com>
        <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
        <87o97858ko.fsf@evledraar.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Feb 2019 12:19:51 +0100
Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:

> On Tue, Feb 19 2019, Senol Yazici wrote:
> 

>  2) Any piece of software or technical tool is going to unavoidably need
>     to use some amount of jargon, or words that are lifted from a more
>     general vocabulary and intended to be understood in context.
> 
>     Thus, when we talk about e.g. "trees" in git, it's understood that
>     we're talking about something in the context of this software
>     project, trying to go by the first Google result of "tree" isn't
>     going to get you anywhere.
> 
> I for one thing those git-scm docs could be changed to eliminate those
> words for reasons entirely unrelated to them somehow being religious or
> militaristic. Specifically:
> 
>  * "blessed" is introduced in quotes and used twice. I think it would be
>    clearer to use "canonical" for what it's describing.
> 
>  * The docs already use "integration manager" and then introduce
>    "dictator" as a synonym in the context of explaining the workflow of
>    the kernel.
> 
>    They could instead use "main integrator" or something, since the
>    point of the example is to explain how git can be used to manage
>    distributed repositories that are integrated in a hierarchical
>    manner.

And that is a good reason to change the wording for once.

Thanks

Michal
