Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834D2C38142
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 22:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjAQWv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 17:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjAQWuc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 17:50:32 -0500
Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A3E18B06
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 14:35:07 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.102])
        by smtp with ESMTPA
        id HuXmpKGsBqh2JHuXnptraJ; Tue, 17 Jan 2023 22:35:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1673994905; bh=SLSgZNzt9MbN45T+AJe2B2xGFhZgfPNdmpS4yFiTslY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=i+8lbkScEY4Ne0QriUssbO62FJzFaRJWcwb3g2MQ4+af1AwB/H7RKq8B7k+0pubT4
         jj1S/yr0bjbbOItQBkXJykBwG23T5WGNJQ04bJ74XmKO6MvyviBRR8/jKh0r8kuhwD
         B2LyX6Laayt/9TjYi6KmGpfcMeqypyRakQTiwSubxx/FohZWU3/YTY8W1Jl3tq2z+d
         etcnPtsbY3bBfZxof+sBbxr8puC/2LHSJCa5gudmkk4/kFoWYOSGnroCvUg5r/hQyq
         krUgbOsnMa/T2HyYtn8CJOR2H3GLdeD4rJTpsDdQpdfCjZUPkYjhJFm8S/Q+t1Bif7
         TYVN5WaHlk/Dw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=c4O4/Dxl c=1 sm=1 tr=0 ts=63c72299
 a=O4HnXJxpn4bBnFCb4s/IkQ==:117 a=O4HnXJxpn4bBnFCb4s/IkQ==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=1XWaLZrsAAAA:8 a=KMDmhc-ymcroexx8lPAA:9
 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <3b79e8c2-ddb2-fa6f-db6f-1f3cae31a729@ramsayjones.plus.com>
Date:   Tue, 17 Jan 2023 22:35:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [ANNOUNCE] Git 2.39.1 and others
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, git-packagers@googlegroups.com,
        lwn@lwn.net
References: <xmqq7cxl9h0i.fsf@gitster.g>
Content-Language: en-GB
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq7cxl9h0i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFRjGNmg2apsNwH5XeP69YIjPmkjMu3rHMu192qIbFpPd2/wRBtB70/DFGHxoK3Y8AKdOUBzS8tEe4fm+Bo7w0St5QinAjyzmKYtznyxRkAjRw6bxCNG
 PhPrb4gBhtERyxuSsOhiFeFqP8KzwFMSpqXdQ2YovxJNTQjWZ/tL2rHEUon5tK0bzuCqzcmpkMGqdjOlvpVkKWV2XSsk7DqEUJw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/01/2023 18:02, Junio C Hamano wrote:
> A maintenance release v2.39.1, together with releases for older
> maintenance tracks v2.38.3, v2.37.5, v2.36.4, v2.35.6, v2.34.6,
> v2.33.6, v2.32.5, v2.31.6, and v2.30.7, are now available at the
> usual places.

FYI:

$ git tag -v v2.30.7
object b7b37a33711e64bf580ef3141878b12a36e28833
type commit
tag v2.30.7
tagger Junio C Hamano <gitster@pobox.com> 1670933134 +0900

Git 2.30.7
gpg: Signature made 13 Dec 2022 12:05:34 GMT
gpg:                using RSA key B0B5E88696AFE6CB
gpg: Good signature from "Junio C Hamano <gitster@pobox.com>"
gpg:                 aka "Junio C Hamano <jch@google.com>"
gpg:                 aka "Junio C Hamano <junio@pobox.com>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 96E0 7AF2 5771 9559 80DA  D100 20D0 4E5A 7136 60A7
     Subkey fingerprint: E1F0 36B1 FEE7 221F C778  ECEF B0B5 E886 96AF E6CB

$ git tag -v v2.31.6
object 82689d5e5d3f41da2ab1fbf9fbe7aacfd6da74c1
type commit
tag v2.31.6
tagger Junio C Hamano <gitster@pobox.com> 1670933242 +0900

Git 2.31.6
error: no signature found

$ git tag -v v2.32.5
object d96ea538e8dd0fcf381089a3b09c0a9af3617351
type commit
tag v2.32.5
tagger Junio C Hamano <gitster@pobox.com> 1670933456 +0900

Git 2.32.5
error: no signature found

$ git tag -v v2.33.6
object 7fe9bf55b84d2610a7ac09893b25ef188f145a21
type commit
tag v2.33.6
tagger Junio C Hamano <gitster@pobox.com> 1670933643 +0900

Git 2.33.6
error: no signature found

$ git tag -v v2.34.6
object 6c9466944c90c236217ec6f9ce5ed6b0e73903f9
type commit
tag v2.34.6
tagger Junio C Hamano <gitster@pobox.com> 1670933752 +0900

Git 2.34.6
error: no signature found

$ git tag -v v2.35.6
object 02f498172348f7ba9dceb169305b74c7eca7a38d
type commit
tag v2.35.6
tagger Junio C Hamano <gitster@pobox.com> 1670933877 +0900

Git 2.35.6
error: no signature found

$ git tag -v v2.36.4
object ad949b24f8d6ee4767c07794a2f01ada91b46b74
type commit
tag v2.36.4
tagger Junio C Hamano <gitster@pobox.com> 1670933982 +0900

Git 2.36.4
error: no signature found

$ git tag -v v2.37.5
object e43ac5f23d3231f6433558931296d555592e978a
type commit
tag v2.37.5
tagger Junio C Hamano <gitster@pobox.com> 1670934063 +0900

Git 2.37.5
error: no signature found

$ git tag -v v2.38.3
object 37ed7bf0f13d204ccb6b8e7e2fbcf7b3bf13e25c
type commit
tag v2.38.3
tagger Junio C Hamano <gitster@pobox.com> 1670934268 +0900

Git 2.38.3
error: no signature found

$ git tag -v v2.39.1
object 01443f01b7c6a3c6ef03268b649b119027743115
type commit
tag v2.39.1
tagger Junio C Hamano <gitster@pobox.com> 1670934343 +0900

Git 2.39.1
error: no signature found

$ 


ATB,
Ramsay Jones


