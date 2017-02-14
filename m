Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A4B31FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 20:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdBNUgY (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 15:36:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:52824 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbdBNUgR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 15:36:17 -0500
Received: from [192.168.178.43] ([88.71.237.147]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlVZv-1c4xNL09cl-00bILO; Tue, 14
 Feb 2017 21:36:04 +0100
Subject: Re: [RFC PATCH] show decorations at the end of the line
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
 <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
 <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <8cf9e548-bf6d-7cbc-f538-da2fbf489bc7@gmx.net>
Date:   Tue, 14 Feb 2017 21:36:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:BHjrHhD9m4/liRjz4lUsjV79d6NObd6GjwJ277zTBO4wW8s11P3
 Q9T6yfokpr7WlHQ/r4pYPDGYztIwputtNW5JgQl9nl4YKDExTf7LN1y643OViDxtyX3zPKj
 mP2je+jAqFSbNR9bUti5GRQOAblXPf9UKZHKnDAhWL9H8eoouyUJ8Lrldm0ZoGwqeW1AlN5
 zDgY4+JbqP4lxWNwG198Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zyYixY5Qm4g=:F2NR+y/p8QcDG4oA0fEzn2
 jj91X20m2YyWIuqPEXksoVdKfRy/KSnnwkuJ5MT5M5qh1Py6rlnpzizjUTd11Sl7xCjD5uyVp
 ewSWeuVzuMafaTvp5noHscVVKZ1ewMN+KoPZMF2c1kIjx3KnvHWAL5LSEmHWFoRdV80TI1tVj
 JIjVbvVkE2H/eBEnnZ/kNZNHuoI2b9MsN1OmF/BlCVTVHbCGqWIwEXFTnFbjxXyYO9ROWC7h0
 3JKSv7DKKZ5oy9Gxmv8AlRV4p69/KExHfZPL6xZjSW2xn5013n/DyYDm27WybYbRV8qTxBV05
 LGDT2xBoAhxl+UZazHcTEVaJ5x0+Rb/p4zs+j/B2sRZRLK3dcp5SxJKiFzg02unWv0chFEhA6
 8IUDffjtfNv0LG8aMVYcVMoo8yfAmDFWaEhOmQ0hgOg49hXCfeHFnl6IT8MX926DBUkvnyWwK
 1jvkxo1aN2T3CKC1dZouFkoa9s8D0PFC0+Z5enu10boPi9KQ/VJlWcLJyHEMM1F/Oljxw3VKt
 ZHGjWhFJuS+0VbVGZSW+ZdNIhuFJChrKJIhi+xc2kJZIDxyXbFIeHj0skTFkmMnadT405lmZA
 55n5Z7e59wocPoacEo2jIdgyRExv6E7+mc0ucpxrDjeu/5J3jU7G7zjZEApjwAO4Kf3XIWODO
 4qsXNQxudy6DieFGipLwentSoMrOyMMlUfexoJgU3XmvGywBsWi+M0v1eLmnS4JqLxnb5gLRH
 6xAJRdmyJOAV8O98UBggRI4wcO3fQfSYnOa3ul5fak6dkAAkFkNKxQpf9g1k3KfWxaiWse63S
 4WRonpU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 02/13/2017 09:30 AM, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> On Sat, Feb 11, 2017 at 10:02 AM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> I've signed off on this, because I think it's an "obvious" improvement,
>>> but I'm putting the "RFC" in the subject line because this is clearly a
>>> subjective thing.
>>
>> Side note: the one downside of showing the decorations at the end of
>> the line is that now they are obviously at the end of the line - and
>> thus likely to be more hidden by things like line truncation.
> 
> Side note: I refrained from commenting on this patch because
> everybody knows that the what I would say anyway ;-) and I didn't
> want to speak first to discourage others from raising their opinion.

A further side note: the current behavior of

	git log --oneline --decorate

is equivalent to

	git log --pretty='format:%C(auto)%h%d %s'

and Linus' preferred version is equivalent to

	git log --pretty='format:%C(auto)%h %s%d'

Most Git users I know have their own favorite version of git log
--pretty=format:... sometimes with --graph as an alias ("git lg" or "git
logk" (because its output reminds of gitk) or something).

I don't know what the main benefit of this patch would be, but if it
gets accepted, it should probably be mentioned somewhere that the old
behavior is easily accessible using the line mentioned above.

Cheers
Stephan
