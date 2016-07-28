Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637241F859
	for <e@80x24.org>; Thu, 28 Jul 2016 07:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205AbcG1HQY (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 03:16:24 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36751 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732AbcG1HQX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2016 03:16:23 -0400
Received: by mail-wm0-f52.google.com with SMTP id q128so239403913wma.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 00:16:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7BkVfLQSuxsGtUXUVS6SllpnxzuEGGj9To8rlitZ+m0=;
        b=VCRutTqLZ/qXcRTO51cFkxNswxUPhllkKkCKnx9lKh1ZVAUPlAgUvFHx0xSpsyacmS
         OD8JG7BI4sb7TFCkenaf36EIdu895eLHBYc3R+JadgfvxqnqCnd3TXFO8imeomZKWUYV
         +BGH7rY0t4lLwH5H4V00nxE75rCZWT1ijZ2dhRsTECSZc4M7qIqkZ1SZRmjsZ4xsChot
         sfz8t/AeEJAmLKUrIYO7dkrAWNyNUJzuEyiLBA8UWksc0rrEUIJyyrpeSFazEMDDKyk6
         ko9LBi7uH6Qk2O8ARuuVC8jHytNhLfG6ujUBTRvuUhnp1otbynxiZzkCjREvr3ao0GGm
         v4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7BkVfLQSuxsGtUXUVS6SllpnxzuEGGj9To8rlitZ+m0=;
        b=FuqCvRTEiWwvW/DpsMc3qmX9qDCjnc9oIWcjNxlpiS7rkeAGS8UHQ+nNeArmNcjFF7
         bV+9o2zzD8e1huNOwCBVVqlHanqh86jQ4HVndJOvvTfvBh8S9FMa6aCOLXSUEjmn8DV3
         Y3ilNeQgGefdUzD8I5PGBXubW6zEhmpK45tUDCrdsBpxvfFspKcADu1b4V5BVfsy7Vbm
         +PxEhcrE2saRgea2znnyJN2Ft/BI1uYlMIDMErMH1QupxehkiAAViXQclmLeWTdZDrKm
         h8kmZ0YX3oWpVrRC0rcafE+7b2Z124ZPdxpWrVT+6ZucQIMOLSQY/Kw7yEtDWU2Ub9be
         ZBoA==
X-Gm-Message-State: ALyK8tJE3Ojr3No0sCATVfbjMElQuTl0GQGv2jS14NJH++5iEBc40A28hZbztj01Xi6ynA==
X-Received: by 10.28.17.9 with SMTP id 9mr58442838wmr.73.1469690181568;
        Thu, 28 Jul 2016 00:16:21 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB442D.dip0.t-ipconnect.de. [93.219.68.45])
        by smtp.gmail.com with ESMTPSA id 17sm10766727wmf.6.2016.07.28.00.16.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 00:16:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 0/5] Git filter protocol
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <579906C5.1050809@gmail.com>
Date:	Thu, 28 Jul 2016 09:16:18 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <BFED7ED8-40DB-46B5-A1B7-4F49624D5A62@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <579906C5.1050809@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 27 Jul 2016, at 21:08, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 2016-07-27 o 02:06, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Hi,
>> 
>> thanks a lot for the extensive reviews. I tried to address all mentioned
>> concerns and summarized them below. The most prominent changes since v1 are
>> the following:
>> * Git offers a number of filter capabilities that a filter can request
>>  (right now only "smudge" and "clean" - in the future maybe "cleanFromFile",
>>  "smudgeToFile", and/or "stream")
>> * pipe communication uses a packet format (pkt-line) based protocol
> 
> I wonder if it would make sense to support both whole-file pipe communication,
> and packet format (pkt-line) pipe communication.
> 
> The problem with whole-file pipe communication (original proposal for
> new filter protocol is that it needs file size upfront.  For some types
> of filters it is not a problem:
> - if a filtered file has the same size as original, like for rot13
>   example in the test for the feature
> - if you can calculate the resulting file size from original size,
>   like for most if not all encryption formats (that includes GPG,
>   uudecode, base64, quoted-printable, hex, etc.); same for decryption,
>   and from converting between fixed-width encodings
> - if resulting file size is saved somewhere that is easy to get, like
>   for LFS solutions (I think).
> 
> For other filters it is serious problem.  For example indent, keyword
> expansion, rezipping with zero compression (well, maybe not this one,
> but at least the reverse of it), converting between encodings where
> at least one is variable width (like UTF-8),...
> 
> IMHO writing whole-file persistent filters is easier than using pkt-line.
> On the other hand using pkt-line allow for more detailed progress report.

I initially wanted to support only "while-file" pipe, too.

But Peff ($gmane/299902), Duy, and Eric, seemed to prefer the pkt-line
solution (gmane is down - otherwise I would have given you the links).

After I have looked at it I think the pkt-line solution is indeed nicer
for the following reasons:

(1) A stream optimized version (read/write in separate threads) of the filter
    protocol can be implemented in the future without changing the protocol
(2) pkt-line is a simple and easy to implement format
(3) Reuse of existing Git communication infrastructure
    -> code and documentation are less surprising to people that know Git
    -> you can use GIT_TRACE_PACKET to easily inspect the
       communication between Git and the filter process
(4) The overheads is neglect able (4 byte header vs 65516 byte content)


>> * a long running filter application is defined with "filter.<driver>.process"
> 
> I hope that won't confuse Git users into trying to use single-shot
> filters with a new protocol...

Yes, that was my intention for this new config.

Thanks,
Lars