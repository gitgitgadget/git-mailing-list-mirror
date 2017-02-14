Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7351FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 23:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750816AbdBNXA7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 18:00:59 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36417 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdBNXA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 18:00:58 -0500
Received: by mail-lf0-f67.google.com with SMTP id h65so12085975lfi.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 15:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WtTE5jB3DuJvPOx3qL9TAY2ZoJo+JeHba+xh+OvQSZM=;
        b=uaRL8FKJsH4qvSe103xl5srYK7rBFukNc6V0XgsDWiOeZli+7RhyPTKTN/DJR9YegF
         cRvp2kfaRGSV1PsgJhfPTJ72us78jPSp0qXgSf+3o1AMvqZuKdKSRhJNTU9JGRGRN2ox
         RVjzHxU9ZniCPgDuqGtZA+0RWRdeLQ69PCpqDeUTp6E9xmgXDTaxvJgPRAJ3jFXIsMMZ
         0/uEb9s1V5imdR0R/QXV4+ZzSmhwFKZO6PlPAUpq6jMT7Dn43WQacqZzL3ZQu5TFyzBW
         sVFu698u17MD50DqGowqY4c1BF6Z1M02iTEZMwTAm4NBwGQgT+NNClLncA+MupRuJ6Iv
         +Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WtTE5jB3DuJvPOx3qL9TAY2ZoJo+JeHba+xh+OvQSZM=;
        b=p6Qd723MAkCziFA8ktY7tAcuc5Fo6SKqv2O+Vf8RzPq9RI6uOnrdf7rx0m4/vWD2So
         go8xTkoo5PSoGtx1m28W/+dcrl8p7RoCYIWW+FA8qIsqrksjLZhU6o+X4jueq69whv32
         Mv3V4oCSCfypCFgenlPg4zTqrSdwSecwVBhOUvdPQJje5BFXqZfJj1ZSrMToYkgztzFy
         /wg8kulaydNa0MyvGXLqXgaDpGNVksC37Kk+fnccofs8V93s+BQZtoDPMfiNQ9G0YE3S
         ictD3XBLVop2VDYa8xwTobGRqbt8Vo6EqLtQZPfYtRoZVNATowywP/gFEAWhAKHCqTzo
         cPOA==
X-Gm-Message-State: AMke39mr3xQW6n7Ejm98z/2ILgW1vpRmDkcLzSy5wVmoHd684KcYpMX+5kh8RloxD8Vrj71DZ1jsg2dRQEblEQ==
X-Received: by 10.25.157.146 with SMTP id g140mr9880718lfe.123.1487113256625;
 Tue, 14 Feb 2017 15:00:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Tue, 14 Feb 2017 15:00:56 -0800 (PST)
In-Reply-To: <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox>
 <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702142150220.3496@virtualbox>
 <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 15 Feb 2017 00:00:56 +0100
Message-ID: <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 10:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Mon, 13 Feb 2017, Junio C Hamano wrote:
>>
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>
>>> > That is why I taught the Git for Windows CI job that tests the four
>>> > upstream Git integration branches to *also* bisect test breakages and
>>> > then upload comments to the identified commit on GitHub
>>>
>>> Good.  I do not think it is useful to try 'pu' as an aggregate and
>>> expect it to always build and work [*1*], but your "bisect and
>>> pinpoint" approach makes it useful to identify individual topic that
>>> brings in a breakage.
>>
>> Sadly the many different merge bases[*1*] between `next` and `pu` (which
>> are the obvious good/bad points for bisecting automatically) bring my
>> build agents to its knees. I may have to disable the bisecting feature as
>> a consequence.

Yeah, this is a bug in the bisect algorithm. Fixing it is in the GSoC
2017 Ideas.

> Probably a less resource intensive approach is to find the tips of
> the topics not in 'next' but in 'pu' and test them.  That would give
> you which topic(s) are problematic, which is a better starting point
> than "Oh, 'pu' does not build".  After identifying which branch is
> problematic, bisection of individual topic would be of more manageable
> size.

It is still probably more resource intensive than it couls be.

[...]

> This is one of these times I wish "git bisect --first-parent" were
> available.

Implementing "git bisect --first-parent" is also part of the GSoC 2017 Ideas.

By the way it should not be very difficult as a patch to do this and
more was proposed a long time ago:

https://public-inbox.org/git/4D3CDDF9.6080405@intel.com/

> The above "log" gives me 27 merges right now, which
> should be bisectable within 5 rounds to identify a single broken
> topic (if there is only one breakage, that is).
