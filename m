Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0AB1F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbcHFUky (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:40:54 -0400
Received: from mout.web.de ([217.72.192.78]:61590 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbcHFUkw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:40:52 -0400
Received: from macce.local ([217.89.153.218]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Ljrlt-1azXWr1425-00bolS; Sat, 06 Aug 2016 22:40:24
 +0200
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
To:	Junio C Hamano <gitster@pobox.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-12-larsxschneider@gmail.com>
 <2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de>
 <xmqqfuqivpjv.fsf@gitster.mtv.corp.google.com>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Message-ID: <526d5219-525b-457b-b533-1721a055b32c@web.de>
Date:	Sat, 6 Aug 2016 22:40:16 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqfuqivpjv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:W89BiHEou+vryFXpg8Ax7YrSM3oO+sktbukHQwFAtN7Z06K/y6H
 SaqUOKoILZdQHFHsmMy9l2+oBmLELn3f/lsKnNThIPpojNO6u9PJ9RdJzbGMSkCbg+D3fkM
 FtE49PIAmn5DRZIBQ7EEqsBbcqoVVI7MYS1zIHknA8Mm7Pr2N9OUK90m1oWlDHnqS89jvbB
 gw87/aGsoIqWuvzvGZIlA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:C760xDGOFOQ=:oZnK1O+NxPTy1NqWWDbRnW
 BMW3fuPCPhGEy/q2waskPN3NFQITSqATbiL5NE947ldr5BWQAw/iuzZlRG+nGz6kJB5oUw0oF
 Qe0p8QYIp5XzyS1GyZYGVw4LOtRgf8zzj6ITX1scdSf8NQjdaEUZchjALkv4Ob7/uLYhlh24h
 M0fJWZVCVkvmUp+pc+7lKiif7qnj/Ce1edql2mXn+qkJnvps//ZIgjFIq/G4GxoWTn38VW6lL
 eWOD/Lu1xfQlmjLP++684t8l55MN6V6PHFsW7e6BxeBPJ1XahBiGKOfj4D+HFKuYdWtx3Ipm3
 Nq7BqiHi6eluwqUs9OcVsrWCPTaIaSqETPjSRm6stts4X+IpRToMYQMdNyEug4AKDGOlrfxw5
 BF9SOObWd6XmdEOv50Ia5iKbEHk/fQz3cqK9+yaXGCP7HqJM8ElHLADSFZn2oNNBKwJXa4Snd
 vvbjV27oG2CMyTmYn5N34pVxTfdR2UtumgM31fI6A6Tcq1aLzmJNvq/l0rAArwbGFe1H5RTM8
 CJnhz4V30vhhuwXsNseRQSVWDs6WRuhYx6/XhongnhiuRX/MqXb5+5J8xpr4hpJaRtaYoNQe4
 4Tf3gb6Lf2ApWb8IOWFS1OM3vOOs1Udz71SZOkZZMF+Vkm9H/JGzLks6ywd10pRhUgZmUh8fF
 3WJbFMBg0MEEsLFOnkNTFTXt6Pnl4GmrlJxMytVLzCRPQcnogISxP8VLyqf3Znhu/ekp1Y5bN
 9ZAqDxqKxzX0r57NjhiF3R8OIqUNwSl3SAHKZeYUspiVzD9cRLFiG3TyNiqnNCsMTUKxibMvR
 2ejXbz1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-06 00.06, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
>
>> On 2016-08-03 18.42, larsxschneider@gmail.com wrote:
>>> The filter is expected to respond with the result content in zero
>>> or more pkt-line packets and a flush packet at the end. Finally, a
>>> "result=success" packet is expected if everything went well.
>>> ------------------------
>>> packet:          git< SMUDGED_CONTENT
>>> packet:          git< 0000
>>> packet:          git< result=success\n
>>> ------------------------
>> I would really send the diagnostics/return codes before the content.
> I smell the assumption "by the time the filter starts output, it
> must have finished everything and knows both size and the status".
>
> I'd prefer to have a protocol that allows us to do streaming I/O on
> both ends when possible, even if the initial version of the filters
> (and the code that sits on the Git side) hold everything in-core
> before starting to talk.
>
>>> If the result content is empty then the filter is expected to respond
>>> only with a flush packet and a "result=success" packet.
>> ...
>> Which may be:
>>
>> packet:          git< result=success\n
>> packet:          git< SMUDGED_CONTENT
>> packet:          git< 0000
>>
>> or for an empty file:
>>
>> packet:          git< result=success\n
>> packet:          git< SMUDGED_CONTENT
>> packet:          git< 0000
> The above two look the same to me.
Copy-paste error.
i see that we need a status after the complete transfer,
and after some thinking I would like to take back my comment.


