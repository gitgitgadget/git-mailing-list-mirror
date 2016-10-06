Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59FC9207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 13:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbcJFNNY (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 09:13:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34096 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbcJFNNW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 09:13:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id b201so3491678wmb.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fbzovT2Wg92bn975Coo2YpQuKmL/RJZUirOesQfd8OM=;
        b=oYRVsawYSQ7N/MGzhEyqYOEFwHn0XoOXc36fcfCeedta1dkD6dwU/5DzjdXcU5/w3P
         B/zMKgfT5CC4+XLRt4z1qnGKip67qlhnoqUxvrSFX/v0Nh3jkf7I8KRsNeFLcD/DvNcb
         y4qxRInQf4A2XHLSddAktiRWPhoItrmudnaGYzM/+2UZ3NCCoFeJCLBx0tuLuJd2FIdo
         ck4nfiVescPL0DbYUqLkD4zqjhkglt4Q21eFwcIF6M3WQVztp3uxMQye4D2wiKsYV1sg
         NeqVvZzZqGE0e2vD8+dXr8rhtBqY0aPxEBdq5+mfGsEw0jZ4Nm145twlebvLyW4+aO46
         q+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fbzovT2Wg92bn975Coo2YpQuKmL/RJZUirOesQfd8OM=;
        b=B9EiEArkgbLLth+axvtizESqEbNwuSijZqJCeOU208CpRNcsdTRpNrwZxD7AR/H+Q1
         XVIcBfTFmDiBQdchoy/ojhW9ty7NnJIjDM7BSWmkY3B8aaWV5AnncBQ9730cc92vi3Kv
         dUYOXGSUijD/EuOjIEHHGcZ0T6Es+rH+pArtUBeyjl23qOGy4EV4tM1A+uqSyIIW9Cy6
         KuiuGfx6gXNBxv9ARS0ZzwK6KU9B7t/SclHK9fFU2IExlsD9/INDLBa4m44yDcHcBUjB
         5urByQTxx9JjGiKCHYqJPwdNQE77F56ek9JTVacYbh18oaTf1WFU1wbUcW8rMmoEcDAA
         rjvw==
X-Gm-Message-State: AA6/9Rlt/GR8mjH2D5rJQv/4BD3Ndxp1nlRczx92co6Msz3/g8mGV185nYNupM7NrtEvFA==
X-Received: by 10.194.161.193 with SMTP id xu1mr299576wjb.67.1475759600712;
        Thu, 06 Oct 2016 06:13:20 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w138sm37451619wmd.1.2016.10.06.06.13.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 06:13:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 00/11] Git filter protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <f7f9ca4c-229c-390a-beb0-a58e0d3d66b3@gmail.com>
Date:   Thu, 6 Oct 2016 15:13:19 +0200
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C30800A-C821-4B39-BEB7-7D55D86BD7EA@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com> <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com> <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de> <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com> <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com> <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com> <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com> <15ff438f-ec58-e649-b927-b1de4751cc45@gmail.com> <E9946E9F-6EE5-492B-B122-9078CEB88044@gmail.com> <f7f9ca4c-229c-390a-beb0-a58e0d3d66b3@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Oct 2016, at 21:04, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> W dniu 03.10.2016 o 19:13, Lars Schneider pisze:=20
>>> On 01 Oct 2016, at 22:48, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>>> W dniu 01.10.2016 o 20:59, Lars Schneider pisze:=20
>>>> On 29 Sep 2016, at 23:27, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Lars Schneider <larsxschneider@gmail.com> writes:
>>>>>=20
>>>>> If the filter process refuses to die forever when Git told it to
>>>>> shutdown (by closing the pipe to it, for example), that filter
>>>>> process is simply buggy.  I think we want users to become aware of
>>>>> that, instead of Git leaving it behind, which essentially is to
>>>>> sweep the problem under the rug.
>>>=20
>>> Well, it would be good to tell users _why_ Git is hanging, see =
below.
>>=20
>> Agreed. Do you think it is OK to write the message to stderr?
>=20
> On the other hand, this is why GIT_TRACE (and GIT_TRACE_PERFORMANCE)
> was invented for.  We do not signal troubles with single-shot filters,
> so I guess doing it for multi-file filters is not needed.

I am on the fence with this one.

@Junio/Peff:
Where would you prefer to see a "Waiting for filter 'XYZ'... " message?
On stderr or via GIT_TRACE?


>=20
>>>>> I agree with what Peff said elsewhere in the thread; if a filter
>>>>> process wants to take time to clean things up while letting Git
>>>>> proceed, it can do its own process management, but I think it is
>>>>> sensible for Git to wait the filter process it directly spawned.
>>>>=20
>>>> To realize the approach above I prototyped the run-command patch =
below:
>>>>=20
>>>> I added an "exit_timeout" variable to the "child_process" struct.
>>>> On exit, Git will close the pipe to the process and wait =
"exit_timeout"=20
>>>> seconds until it kills the child process. If "exit_timeout" is =
negative
>>>> then Git will wait until the process is done.
>>>=20
>>> That might be good approach.  Probably the default would be to wait.
>>=20
>> I think I would prefer a 2sec timeout or something as default. This =
way
>> we can ensure Git would not wait indefinitely for a buggy filter by =
default.
>=20
> Actually this waiting for multi-file filter is only about waiting for
> the shutdown process of the filter.  The filter could still hang =
during
> processing a file, and git would hang too, if I understand it =
correctly.

Correct.


>> [...] this function is also used with the async struct...=20
>=20
> Hmmm... now I wonder if it is a good idea (similar treatment for
> single-file async-invoked filter, and multi-file pkt-line filters).
>=20
> For single-file one-shot filter (correct me if I am wrong):
>=20
> - git sends contents to filter, signals end with EOF
>   (after process is started)
> - in an async process:
>   - process is started
>   - git reads contents from filter, until EOF
>   - if process did not end, it is killed
>=20
>=20
> For multi-process pkt-line based filter (simplified):
>=20
> - process is started
> - handshake
> - for each file
>   - file is send to filter process over pkt-line,
>     end signalled with flush packet
>   - git reads from filter from pkt-line, until flush
> - ...
>=20
>=20
> See how single-shot filter is sent EOF, though in different part
> of code.  We need to signal multi-file filter that no more files
> will be coming.  Simplest solution is to send EOF (we could send
> "command=3Dshutdown" for example...) to filter, and wait for EOF
> from filter (or for "status=3Dfinished" and EOF).

That's what we do. EOF does signal the multi-filter to shutdown.


> For full patch, you would need also to add to Documentation/config.txt

Why config.txt?


Thanks,
Lars=
