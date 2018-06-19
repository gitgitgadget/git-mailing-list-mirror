Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6BA51F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030400AbeFSRoZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:44:25 -0400
Received: from mout.web.de ([217.72.192.78]:56147 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030330AbeFSRoW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:44:22 -0400
Received: from [192.168.209.18] ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhleR-1freZB0Ved-00Mscg; Tue, 19
 Jun 2018 19:39:10 +0200
Subject: Re: t5310 broken under Mac OS
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <b9dfbd6d-60fb-056a-0f06-b5c3350c7623@web.de>
 <CAPig+cQJBw5D7K97VGtdi+iKxgf0D96LFzvZ+SGZVTpAWszOdQ@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <536e3abd-688d-24c2-ffeb-0ff2db32af04@web.de>
Date:   Tue, 19 Jun 2018 19:39:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQJBw5D7K97VGtdi+iKxgf0D96LFzvZ+SGZVTpAWszOdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:KRSdMPMGh5rJf5pqvYc8pTHEKgbO/6h5Aysi2Jw/f24/GOZk/LM
 hUn8+h5uX6zDpfFsQEoSykqp3F6K+pDjhWNS2AaHlErk6IMI/dZg+8Kg+GdkMfpi0fX1pWZ
 8B/4hbDloVNylfT5dzqRF11wg0GEf1iKNf/7KpzKuE8IpwoO7AmBeB0Wao6OkQ4fkg/eZD+
 yf8T0dcJwN7VHNIt3csGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dUUPpUPkHP0=:dbOHqqJJ3c7FphAF/AnDtR
 zMA2E4ImoVmwjTic8YA+4SE4Tpq4I0x7bSRjGWnwGXSTfWAZ02JvpDuTOoDcUpVgVRvGb8Kw7
 AhtFW12M78AQS7eyyLjBMJi5+yA/FBynFlyNiv1dBcBPPpHsBNiJk5GZvHe7AiCfSNuQ5NWyA
 Edp2LFhhbAdCzk1aFNBNEcbAruz8JrX8TXsGRU681lBb9juyc4V0/B8HmMyoolnyfIL+XhCy5
 XhvjFVEWz6CWfHwkSD+ycavRz+Xf7aJtiBaFfY8Wz2+5WBJ3evxp/VzhML+I7d10WkVA++vgm
 pDaFlnVLtSjk9+/g06dCQjE7PbDj4k0/snxzEmxiqNmAGM4jhblDMcARsCZ+v3TbKNtXXPcFc
 FObt+d7c1WlepDp3gjwPfM7QikPpWiZnA9QK4eecc+SswxcTTfLH48hvJm7J6uQ0wb9ltD9Lq
 pZzsNvLGmNTfFShOtPwxebFDXNOsN4ymcRVLqeDAIptG/OuWSp/QzqmZMXE0Yv0aO6+Rz1XvI
 bpnnig7aEV7octxqB2C4BuHmBlJYG6QC3SmGEPlRcNXEr0EgxKF+94GgXP1cUSeT1cPwnjvlA
 FK4qadNi8Pi6B2Zca2FZdDmmd0UVn2JlyYpfhhdZqN5TNCnH+zDdUaMNVBpLSZ45gf0xyJtu0
 66MXYVbroA3yb5pkBbgqbRshWpBEUqZcl0QQWwEByKbiiEnG5PszZ9wg7G94iczDYVfbOP6vU
 IkfPdzHqlx/Uv6QU8zUBNUYW+iK68H92r/SrQIHDbl6KAEAlg/15rej2ydQCkWnEsOfcahLxT
 ZuGA0XS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/19/2018 07:35 PM, Eric Sunshine wrote:
> On Tue, Jun 19, 2018 at 1:33 PM Torsten Bögershausen <tboegi@web.de> wrote:
>> expecting success:
>>       git repack -ad &&
>>       git rev-list --use-bitmap-index --count --all >expect &&
>>       bitmap=$(ls .git/objects/pack/*.bitmap) &&
>>       test_when_finished "rm -f $bitmap" &&
>>       head -c 512 <$bitmap >$bitmap.tmp &&
>>       mv $bitmap.tmp $bitmap &&
>>       git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
>>       test_cmp expect actual &&
>>       test_i18ngrep corrupt stderr
>>
>> override r--r--r--  tb/staff for
>> .git/objects/pack/pack-8886db3fce4f9657c1a43fee7d3ea4f2a4b5be2d.bitmap?
>> (y/n [n]) not overwritten
>> error: 'grep corrupt stderr' didn't find a match in:
> This is fixed by [1], isn't it?
>
> [1]: https://public-inbox.org/git/20180616191400.GB8914@sigill.intra.peff.net/
Most probably: yes.
I just ran pu if the day (which is 15th of June)
Thanks for a fast response, sorry for the noise

