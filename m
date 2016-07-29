Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F461FF40
	for <e@80x24.org>; Fri, 29 Jul 2016 08:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbcG2IO0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 04:14:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34699 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbcG2IOU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2016 04:14:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so14590600wma.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 01:14:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TLdbpYYOTp7c1Y3qG2ZsWBKgITuwI+TNNbGAFjjedoM=;
        b=XXumFOSXZtXnih80stBBuBgkVdyR2s1/tn2UnSH1ibguRQpX2dy5jhXwgNR60S7exg
         yBeZwMQD0nA0uiqL/b2CQquOa5ZPhVu9G2C1yJ1TBrDkIA2wm8nd+uSgROLJCfAPzuYn
         haobkI0MCYjXG3I9xFYJ9lrlnT+JpIw1GembSo2ZoNObHQ3HsrhBzz2W4dKProHGHCs4
         GhiEIVw3ASNUgMrA4kqqLk52QJ3adIRi6JBRmRAH69PbtL2eVoXeRgqrpURiTMj7zLbg
         0CsU+H/gEAoajFaT7rBUtPpLLFcjtETeKFXjx0QCwcXBEA25tde+BgGCBBz0iGK64/kH
         B9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TLdbpYYOTp7c1Y3qG2ZsWBKgITuwI+TNNbGAFjjedoM=;
        b=HJdyGGtq7R0AkPTuN1zooIquKEt4e1iJMikaPSla1d4EirTJScw+BIiNNETVSCJiNv
         sUpTQMH9ETonyyzAS6faCbVZu0f+NfeFJQUKc2hBP/jG/d1dkKr4Yvo9E//9aZO5H/Q7
         MK/byTMhoho9MwEquYCzTEGrU8Q1X2g7bjao8fT25nCotlqE04Hod7hYLnyQ6raxYIjr
         h2FqKGTCcWXTaoR0vz9L7B+yST7Acpx9WEPTZU9JRnHFCgUzYWVofnhq424Jb3pDL6Zh
         /FI5RcHLTh615h6RUINuu8UqdbSbQ0GoQfbSDxUaJ/jUusty0sVNwJuRndWHNVUrKVih
         EIIA==
X-Gm-Message-State: AEkoouth0WaYse+FPceMhdt71NFEqPC2KoimaCOem+fvvCJaTTAFTpCccTQVYwjkHFU6QA==
X-Received: by 10.194.136.196 with SMTP id qc4mr41331416wjb.136.1469780058827;
        Fri, 29 Jul 2016 01:14:18 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id i8sm1795665wmg.21.2016.07.29.01.14.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 01:14:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 0/5] Git filter protocol
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <579B087F.7090108@gmail.com>
Date:	Fri, 29 Jul 2016 10:14:17 +0200
Cc:	Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>, e@80x24.org,
	ramsay@ramsayjones.plus.com
Content-Transfer-Encoding: 8BIT
Message-Id: <31219A33-CA8A-44D1-9DE0-6448AA1A7571@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <579906C5.1050809@gmail.com> <BFED7ED8-40DB-46B5-A1B7-4F49624D5A62@gmail.com> <20160728132906.GA21311@sigill.intra.peff.net> <579B087F.7090108@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 29 Jul 2016, at 09:40, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 2016-07-28 o 15:29, Jeff King pisze:
>> On Thu, Jul 28, 2016 at 09:16:18AM +0200, Lars Schneider wrote:
>> 
>>> But Peff ($gmane/299902), Duy, and Eric, seemed to prefer the pkt-line
>>> solution (gmane is down - otherwise I would have given you the links).
>> 
>> FWIW, I think there are arguments for transmitting size + content
>> (namely, that it is simpler); the downside is that it doesn't allow
>> streaming.
> 
> And that it requires for the filter to know the size of its output
> upfront (which, as I wrote, might be easy to do based on size of input
> and data stored elsewhere, or might need generating whole output to
> know).
> 
> I don't know how parallel Git is, but if it is parallel enough,
> and other limits do not apply (limited amount of CPU cores, I/O limits),
> without streaming new filter protocol might be slower, unless startup
> time dominates (MS Windows?):
> 
> Current parallel:
> 
>   |   startup   | processing 1 |
>    |  startup    | processing 2  |
>   | startup |  processing 3 |
>     |  startup  |  processing 4  |
> 
> Protocol v2:
> 
>   |  startup  | processing 1 | processing 2 | processing 3 | processing 4 |

Based on the current filter design the "single-shot" invocations are
not executed in parallel.


>> So I think there are two viable alternatives:
>> 
>>  1. Total size of data in ASCII decimal, newline, then that many bytes
>>     of content.
>> 
>>  2. No size header, then a series of pkt-lines followed by a flush
>>     packet.
> 
>    3. Optional size header[2][3], then a series of pkt-lines followed
>       by a flush packet[4].
> 
> [2] Git should always provide size, because it is easy to do, and
>    I think quite cheap (stored with blob, stored in index, or stat()
>    on file away).  Filter can provide size if it is easy to calculate,
>    or approximation of size / size hint[5] - it helps to avoid
>    reallocation.

Agreed!


> [3] It is also a place where filter can pass error conditions that
>    are known before starting processing a file.

I am not sure I understand what you mean. Can you think of an example?


> [4] On one hand you need to catch cases where real size is larger than
>    size sent upfront, or smaller than size sent upfront; on the
>    other hand it might be a place where to send warnings and errors...
>    unless we utilize stderr of a process (but then there is a problem
>    of deadlocking, I think).
> [5] I suggest
> 
>        <size as ascii decimal>
>        "approx" SPC <size as ascii decimal>
>        "unknown"
>        "fail"

My current implementation supports only two cases. Either the filter
knows the size and sends it back. Or the filter doesn't know the size
and Git reads until the flush packet (your "unknown" case). "Approx" is 
probably hard to do and fail shouldn't be part of the size, no?

That being said a "fail" response is a very good idea! This allows
the filter to communicate to git that a non required filter process
failed. I will add that to the protocol. Thanks :) 

- Lars


