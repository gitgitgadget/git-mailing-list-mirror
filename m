Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371091FF34
	for <e@80x24.org>; Tue,  9 May 2017 04:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753888AbdEIELp (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 00:11:45 -0400
Received: from mout.web.de ([212.227.17.12]:50727 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753679AbdEIELp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 00:11:45 -0400
Received: from [192.168.88.106] ([194.47.243.242]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQedF-1dbLJ12tJ7-00U2Rl; Tue, 09
 May 2017 06:11:38 +0200
Subject: Re: [PATCH v2 1/1] t0027: tests are not expensive; remove t0025
To:     Junio C Hamano <gitster@pobox.com>
References: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
 <20170502155631.24848-1-tboegi@web.de>
 <alpine.DEB.2.20.1705021809340.3480@virtualbox>
 <xmqq8tm67r89.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, larsxschneider@gmail.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <f1183dc1-e2e5-f189-2df5-e46ec8930faa@web.de>
Date:   Tue, 9 May 2017 06:12:16 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tm67r89.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:8P8METgo0QoLk4nOa15dLcI00icwEC/HeM495eKelfXtEkn4PJh
 tpRq5IGJeCQjE1wsbQNlrKq+mtpT7APYowbRhlUSJ1aAjNOwLrMyD9wOv2Rp2IjkJhTLHlh
 hS8JH9YvHSJMVT3l84na81NLDKc8n85Zpj3H/cght0dGNlzCAZJ5K4LJC2FTAnBxCM+eN9U
 Le2J6g+PnJ7P4uPQCx/aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CBH1ncM7HG4=:ZxNCukd9rKuLguUJV1dw7G
 XqGvzFlTPom5xQeFOZ9ddcjcsvfne5/Og1SJXFD9I2FJt0a3kD6hjawHAntnHMKXJp5wScA93
 SxfKtA3sGnRRtj0VFcI4K1fyFM8g3bY5m1pnZ2s4rN4Toi4zCcIvn6JMqzQ/16JncM6tPXNqo
 M/CMe6c4AwO9lVWJJ0qnvlOI1dB4gL6TtUU2iqCg2IFOeOf+zSZID75Nofxyh9cC70vAVM1tj
 zfQ/FcM4fnU1JlNfVkEDvVRujJTD8Kuu/wQAYmXRm4yGEKVp6A4LFMoo5ZEv0cwz1AfevZU+v
 7nN519PppB4P2SBeBpwcJ0CLyAtDPNr/EEOVKJksLqyODuB1w3+8OZHmVO2AkAYj4lnGpjhlq
 WcidgFqPq/PgkYzLQuBjZIdsyqF5g9HrZJxGyfstF1wDOxUELZLXyS5YD2KuMoaTLejermyg9
 mvORZukiG5vDehUop4Q71oMgAQczd9k7FuqjYAf/FvbvbdGITpBcpRx7eY2O+14D2T5oRAghN
 CRtlaOq1+JUtXUh5P46lE8ESqxXq5CSmqZQt1Rx1Eer81dwh3ZWM+sATrTpFhO6C5EeTzv13R
 DLxYOVtMuWmg82xSq0ykj80snLsprIT2mfjmDMOvGm+xA18ODIwxz4DFAl5ARmXNRqgONug9f
 v2B0JsFNo9NTnXw0OxJQMxJwN0nQ4rpfVV4plE/2O6P1pfp7G9HE/naqonh3n923dtVnET2yQ
 4vGko7egBibmAlqnnBtQsVJzUKVkJYw3HfwtjXdt6Hq8RkYF1APIYVr3Ul5Ksqu6P6P+4HQTx
 nEKharD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 09/05/17 03:29, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> Recent "stress" tests show that t0025 if flaky, reported by Lars Schneider,
>>> larsxschneider@gmail.com
>>>
>>> All tests from t0025 are covered in t0027 already, so that t0025 can be
>>> retiered:
>>
>> s/retiered/retired/
>>
>>> The execution time for t0027 is 14 seconds under Linux,
>>> and 63 seconds under Mac Os X.
>>> And in case you ask, things are not going significantly faster using a SSD
>>> instead of a spinning disk.
>>>
>>> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
>>
>> Thank you for this patch.
>>
>> Apart from the tyop, would it be possible to fix the formatting to look
>> less strange? (Unless you use this to transport a super-secret message
>> steganographically to an alien planet or some such, of course.)
>
> Ping?

I didn't had the time to send a patch yet -
so either you feel free to amend the commit message locally and queue
that - or I send a new version in  2 weeks.
