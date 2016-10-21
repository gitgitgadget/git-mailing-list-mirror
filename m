Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5037220229
	for <e@80x24.org>; Fri, 21 Oct 2016 16:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934903AbcJUQMO (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 12:12:14 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32823 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934384AbcJUQMN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 12:12:13 -0400
Received: by mail-pf0-f176.google.com with SMTP id 128so59341506pfz.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0H8ZaJAix+hyCATgjZcwO44udClyHEbGiPPW6VtW4+Q=;
        b=QVKVMGEi9+AiqdQUkHrcURSYKDoljnwjnJHkwrpi86BrUFaU8Ga0qmcFvRUKiR0sZh
         CCR17XEZMk0RyHjvdo+x3GpnbCOinX103ucVWQhB3voov9Bxxd8YUhMiJdQXIgBh4Uel
         AFYR67zZOOuS0UAjetxLaU2D0QtFf373n6f8ErIrJIwRkmCDo+yfjmcgij1Y4fskv91G
         SA0z1s5Bsa8W0hVFXzPGNzRKpA5I9Ckhez+mTnpLDrVjLw8aGiZVZqDIQhM+1MYChJuB
         VkYS/sxQtsx0+fXFbc1UDjyhJtC428fR//9BRhkeokAkgF2mGiIXbkWA6KaKxASOVJ/j
         GE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0H8ZaJAix+hyCATgjZcwO44udClyHEbGiPPW6VtW4+Q=;
        b=iowRrxeLdxMSsPnXH59s9tc7k8ZCQ5vBFJfGLwEIblNsPhl2llpMOKHDzuChv24/Hd
         RD5hlJiRYLWwDq3SB3E1Uy499NOjL+sX74yV62OQjuUbQUw7AWXyQaZJ1GxFjaeVB9KG
         MxavLEIaoZygpo8YDcKIgMe2nTZvTK/m1HXeLARRsNMFhvwiYhkufyFHzCpUOvgbcUfw
         e+5amAukrhFYdYyg9Ak4zMlZc4RA++ySVZx2aorB6QKi3LidKrTwZMzaigRaH/qL3faB
         qb8NU1o/T3LrbU18ijrOGys1j3BBIxCaBTlDxZhbjXd2zzcOEqUggT7BzaMog0PymG3b
         1S5Q==
X-Gm-Message-State: ABUngvcui+SaqIO9pAibdy8fjRcavm+j8hJL2LjO9iRoseeLVveNPTdrF/BQRO7lFBsXBA==
X-Received: by 10.99.109.196 with SMTP id i187mr2507400pgc.164.1477066332645;
        Fri, 21 Oct 2016 09:12:12 -0700 (PDT)
Received: from [10.71.30.182] ([12.237.194.226])
        by smtp.gmail.com with ESMTPSA id f129sm6309464pfc.3.2016.10.21.09.11.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Oct 2016 09:12:12 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Oct 2016, #05; Thu, 20)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1610211457030.3264@virtualbox>
Date:   Fri, 21 Oct 2016 09:11:56 -0700
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBB70D30-49CA-4A86-AB0B-BA5A95B038AB@gmail.com>
References: <xmqqk2d2ein7.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610211457030.3264@virtualbox>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Oct 2016, at 06:08, Johannes Schindelin =
<Johannes.Schindelin@gmx.de> wrote:
>=20
> Hi Junio & Lars,
>=20
> On Thu, 20 Oct 2016, Junio C Hamano wrote:
>=20
>> * ls/filter-process (2016-10-17) 14 commits
>>  (merged to 'next' on 2016-10-19 at ffd0de042c)
>> + contrib/long-running-filter: add long running filter example
>> + convert: add filter.<driver>.process option
>> + convert: prepare filter.<driver>.process option
>> + convert: make apply_filter() adhere to standard Git error handling
>> + pkt-line: add functions to read/write flush terminated packet =
streams
>> + pkt-line: add packet_write_gently()
>> + pkt-line: add packet_flush_gently()
>> + pkt-line: add packet_write_fmt_gently()
>> + pkt-line: extract set_packet_header()
>> + pkt-line: rename packet_write() to packet_write_fmt()
>> + run-command: add clean_on_exit_handler
>> + run-command: move check_pipe() from write_or_die to run_command
>> + convert: modernize tests
>> + convert: quote filter names in error messages
>>=20
>> The smudge/clean filter API expect an external process is spawned
>> to filter the contents for each path that has a filter defined.  A
>> new type of "process" filter API has been added to allow the first
>> request to run the filter for a path to spawn a single process, and
>> all filtering need is served by this single process for multiple
>> paths, reducing the process creation overhead.
>>=20
>> Will merge to 'master'.
>=20
> This breaks in Git for Windows' SDK (I only now realized that t0060 =
was
> not the only thing breaking in `next` for a while now):
> ...
> -- snap --
>=20
> Unsurprisingly, bisect identifies "convert: add =
filter.<driver>.process
> option" as the first bad commit, although it only fails on the test =
case
> 15, but not on 17.
>=20
> I am unfortunately still busy with trying to figure out what exactly =
makes
> t6030 hang on `pu` (seems it thinks stdin is a tty and just waits for =
an
> answer), and then trying to reduce that insane amount of time wasted =
on
> running, and waiting for, the test suite, and for unrelated reasons =
I'll
> have to go offline for the rest of the day, so I will most likely be
> unable to assist further with this.

Hi Johannes,

thanks for reporting this. Looks like I misunderstood your comment when
you wrote the error is already fixed in GfW:
https://github.com/git-for-windows/git/issues/770#issuecomment-251426487

I think this patch series (referenced by the link above, too) should fix=20=

the problem:
=
http://public-inbox.org/git/20160905211111.72956-1-larsxschneider@gmail.co=
m/

Don't waste any time on this. I will look into it ASAP (traveling right =
now).

Cheers,
Lars=
