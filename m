Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C8420282
	for <e@80x24.org>; Wed, 14 Jun 2017 19:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbdFNThE (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 15:37:04 -0400
Received: from mout.web.de ([212.227.17.11]:62199 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752133AbdFNThD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 15:37:03 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lmu2K-1e1yy70wyi-00h8EH; Wed, 14
 Jun 2017 21:36:43 +0200
Subject: Re: rs/strbuf-addftime-zZ, was Re: What's cooking in git.git (Jun
 2017, #04; Tue, 13)
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706141245520.171564@virtualbox>
 <20170614111043.xlfsgclbyrqektb3@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e9260c40-c49f-d7f6-70c2-a28c1b3104a2@web.de>
Date:   Wed, 14 Jun 2017 21:36:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170614111043.xlfsgclbyrqektb3@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:wd66Vmx/zd5aDzSok648vA0eumDPy6Brsf4FW12ThEAtoNKorpM
 lgf914chl9DFTDoJFMvbOrcoPtwjBBb5p9N8tOIO6TGJQ2o531/1b9RG9GJ4dxpt9luxwcT
 MfdBT461MZGqapifpaAwhPAkdKEIPfWpwhiKJqMTf68HLvpkCrgStnlMLKE2m+AcDRNHsO+
 1Nuaw03QdvHb6hyrExNfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:81DeLAvtdU4=:4h02LyUJ8yylwuWlmsGN/0
 nixEHouirDKNBFKVWTyBHHdV+uJnBfYwyRPbVhynFGtMfvE/uG1u4Xe91prwHLrUX2pIrCbj0
 Ow/Ky9XwEkU8rt8XVaBlsZsT4viWgJ3wCp0RtKGiW2QKJ3OlVY6fLdTth+mDYZj36p0O9jn7s
 83bIhIrdFpMWAzPQ/n/24dlnCoMhxhOEY2FLdj/PUgkbS7UH9edqhozSFR7KtRlZ1UZskWs2E
 xeE/1cjAUhxXXLmZCQIV9AqUUhLlajQWE4+hG0wTE8iqot+3aPUhjeFsf4PeoQg1AO5WDcJ9b
 ZTpOpW6AiKToRpM2vGJwr45fmPizN71Hts3z3GF4pAsiQLgTTBaODRBgcFVJZuHfLCfsrPQa4
 +91ie1LHsDUGZLRK2gsxZADBcMXc86HL3yL4mOaVZXeRbTmxGgQeYApCCpEi5QR7AvCgM8n/q
 EPCvi1tQ1s3Ixe4/eYnvfLIg7h150pKYVom+xIpdXmJBXiT9ZbvCBq9QZbXwGDA81156iKaDw
 oS6C396F6+bGKYOYsPR4yd+Ui4m8+ahRYkPiHJMyocneeRpekeMjyWvcjMb2J+DYEikyFwR/t
 CmKZzQfIaVKpygsOhfxDDUEdheZa533DBhWWViD+cgJIdNk/PA0ZHSFqW5BKuhaBxQ4SZszoa
 4x3YnSzqkJC7QD8AxxAIUkUYvrc5vLmWojBE2V96eyLiZiGiCH3kFZP2qTrdHcklXynoUeRuM
 8aFC+X97vk78YH4HvaJzc1KrqGSyHr2D6+jAmnZ3RKQYgCk+t4HM6DW7D9eadX6LmAH7BIqDH
 jiaqzQK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.06.2017 um 13:10 schrieb Jeff King:
> On Wed, Jun 14, 2017 at 12:57:06PM +0200, Johannes Schindelin wrote:
>> But even then, it fails in t0006 on Windows with this error:
>>
>> -- snip --
>> ++ eval 'diff -u "$@" '
>> +++ diff -u expect actual
>> --- expect      2017-06-14 10:53:40.126136900 +0000
>> +++ actual      2017-06-14 10:53:40.171146800 +0000
>> @@ -1 +1 @@
>> -1466000000 +0200 -> 2016-06-15 14:13:20 +0000 (UTC)
>> +1466000000 +0200 -> 2016-06-15 14:13:20 UTC (UTC)
> 
> Ugh, I was worried about that some systems might display timezones
> differently (that's why I _didn't_ check %Z in the EST5 case). But I
> must admit this was not an incompatibility I was expecting. It looks
> like your system strftime() turns %z into "UTC". POSIX says:
> 
>    %z
>      Replaced by the offset from UTC in the ISO 8601:2000 standard format
>      (+hhmm or -hhmm), or by no characters if no timezone is
>      determinable.
> 
> So it seems like the mingw strftime is violating POSIX. I don't see an
> easy solution beyond marking this as !MINGW. Though if we wanted a
> partial test, we could test %z and %Z separately.

Hmm.  The patches currently either let strftime handle both %z and %Z
(in the local case) or handle both internally.  Perhaps we need a third
option, namely to handle %z internally in all cases for systems whose
implementation violates POSIX?  Nah, it would be easier to always handle
%z internally.  Any downsides?  Does someone actually expect %z to show
time zone names instead of offsets on Windows?

René
