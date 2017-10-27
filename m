Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F1DA1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 12:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbdJ0MYr (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 08:24:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55328 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbdJ0MYr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 08:24:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id y83so3408332wmc.4
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7DJQbuUNBkCA/TxdlWHkbKuPmnOFQ8Ss7B9xmq6fmnA=;
        b=Lz0LlXyIlbGCVaQqs3Vm1ORCXOXmV2daxNT1GWoJUjb7tbQJDTD5r6Xus/7cJEU+6P
         g/TP+c8LuhHQfWxwsVaHFMeHdfF4BJ1g6SG8RL5ME91KoqKJILzEXCFmjm73esOUVhD9
         HmuquhBNp8NWXr2Bq0OqjvD3LphnjEebE0XV53NJGIi2BkEtn265llZg7LMyw5KykM98
         XxeKosz/clAKOBItV7pHH8gSXmNb85DRQQg4LedSzjixcuQdtb/qfOv29B1ASAHZy37d
         xeqLVEt/bxdyF9eAGv7gQrzz031ymnOB4rreObg3b64cMeL5oPL3xMCDiqYp5p1FPCpe
         x4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7DJQbuUNBkCA/TxdlWHkbKuPmnOFQ8Ss7B9xmq6fmnA=;
        b=FTeV0fF91msKSR9RnC+APjWNsE4p3wVJr9CEyOWw1/xu1MCzwhwRhl0KGqn8qqzI3s
         JDpnGyhhy6KM9fQwVC7bJwI7qjASUh5ja033rX+yGBC2Sg28aujp9qa2jom4bzgvZLWA
         ma3Wbf+fLL5PIoqlIH0PhpnD1rToYn7+Bu/0S3kjdYhDCATfOH0CKmDnGmvUJmmbXr7Z
         6M45ITLzUpj6FD1Pa6HxGnJonh2ZR4LkOl/1wLKaALqaTH52UjOFsbpqpWGZjn5wJbHd
         ZGHUTMcleDxzoptm3/CrkQ8V+wEXcd4ESju1pioauSbQHH4ftuaz/zqgb40UBSTqNmT3
         LN7w==
X-Gm-Message-State: AMCzsaW4siSMmja7E7zwkfQLGYOTGz2jqYv6o+pw1HzIs7UDYVJMwXvM
        Z76uXmeOItbMRCttRutytaU=
X-Google-Smtp-Source: ABhQp+QexdJHdjBvaU5qaWyuevqjN6tiuIm1TDU6prMvg1ZO8t5TNcaXIT9pW/7EnhJwyShbYFrjIg==
X-Received: by 10.28.125.139 with SMTP id y133mr282715wmc.25.1509107085733;
        Fri, 27 Oct 2017 05:24:45 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p23sm12358338wrb.76.2017.10.27.05.24.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 05:24:45 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [git-for-windows] Git for Windows v2.15.0-rc prerelease, was Re: [ANNOUNCE] Git v2.15.0-rc2
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <18E24F0C-D518-46B6-A8D5-71B0E1B05DE0@gmail.com>
Date:   Fri, 27 Oct 2017 14:24:40 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC84FB2E-A26E-4957-B5FA-BE6DDEC3411B@gmail.com>
References: <xmqqr2tygvp4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710210020290.40514@virtualbox> <18E24F0C-D518-46B6-A8D5-71B0E1B05DE0@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Oct 2017, at 14:11, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>=20
>=20
>> On 21 Oct 2017, at 00:22, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>>=20
>> Hi team,
>>=20
>> [cutting linux-kernel]
>>=20
>> On Fri, 20 Oct 2017, Junio C Hamano wrote:
>>=20
>>> A release candidate Git v2.15.0-rc2 is now available for testing
>>> at the usual places.
>>=20
>> The Git for Windows equivalent is now available from
>>=20
>>   =
https://github.com/git-for-windows/git/releases/tag/v2.15.0-rc2.windows.1
>=20
> Hi Dscho,
>=20
> I just tested RC2 on Windows and I don't see my "Filtering content:"=20=

> output if I clone a Git repository with Git LFS files (and Git LFS=20
> 2.3.3+ installed).
>=20
> The feature was introduced in the following commit which is be part of=20=

> your RC2 build commit (b7f8941):
> =
https://github.com/git/git/commit/52f1d62eb44faf569edca360ec9af9ddd4045fe0=

>=20
> On macOS everything works as expcted with RC2:
>    ...
>    remote: Total 15012 (delta 0), reused 0 (delta 0), pack-reused =
15012
>    Receiving objects: 100% (15012/15012), 2.02 MiB | 753.00 KiB/s, =
done.
>    Filtering content:  43% (6468/15000), 33.30 KiB | 0 bytes/s
>    ...
>=20
> Do you, or other Windows experts, spot something in the commit linked
> above that could cause trouble on Windows?

Well, it turns out the output works for my real life repos but not for
my Git LFS testing repo.

    git clone https://github.com/larsxschneider/lfstest-manyfiles

... prints the filtering content output on macOS but not on Windows.
The progress function has some delay feature that suppresses the output
if it is only shown for a second or something. However, in this test =
case
the output should be visible for several seconds at least...
I am still puzzled.

- Lars=
