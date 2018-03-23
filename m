Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627991F404
	for <e@80x24.org>; Fri, 23 Mar 2018 20:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeCWUJ5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 16:09:57 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34121 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeCWUJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 16:09:57 -0400
Received: by mail-lf0-f65.google.com with SMTP id c78-v6so15339453lfh.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OqUbsgjXIydiYil09HmLCBshZtheJFpj4YsWu2KHkVY=;
        b=AHnMNbkF+eYoskbENzY1WSqZZUd97PaJBZMjE6iQia2pCVnfO1KQWUUFheFqui2Ar8
         32FJJzLSNDZflUTgXS5KBqiezci5JeidJX8+qaOXfHfpg1JcdqIcYOAEkD3rC5tT+2Tr
         MH59yYCkw4SrxxHq7MLqgiBdnOdayQM/4REaVAwpoiyOh1jkmiDzfiQ1h7Alk5WWVy8q
         a4Qis40Uan8akkOfUlx5V+Ctw/vEOyjVlwWiBkPGMlFk7CU+r5TRn9uc7hCgqX/k6DG1
         wYAvVzZwUEHURuUGTOiRQDHncmotFp6o6Ogyzh46eo7ye7VQMKh/cEJ5X/5BjGsh+Vr2
         T3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OqUbsgjXIydiYil09HmLCBshZtheJFpj4YsWu2KHkVY=;
        b=o5s0z2Wyr3B0Ja26/5vkujZQEx1Q/W/JUa0kydn9PWe53dhw9Sml+cRlDLiQ8qtjw6
         L77HN7Vw3P+zTYXy4DHytA6qBphx41HwqWdYxdfnVdJw9IQ5guuMCPjCAJiXIYdiS1OQ
         ymzRXhocoVXeRcHuBnyYW7yegyWI4TQCxJeqK/F+pxCaR97JI32S/zgF644LhX6DM/oV
         ppq5RXCeEvc/eVuZCaWKiOknMcgK9siqmXErulP06eVPTCLX+u0/OwFekd6VVguZo3Uj
         n9mAlolQkR8wuC1gZ5gfzGs4LHj59ffPTmlLl/we++FMM27yVwaJGwBQngrMPdXmyX9l
         HqaQ==
X-Gm-Message-State: AElRT7EpvopzHVLBjxD7i/nd7tMWPVFR2N60LFQ7X1lAziz0mbCx9VTP
        FOAMEUJrUsyLov07CCgl1T0G/kyApaCtREcIz0+eIA==
X-Google-Smtp-Source: AG47ELt0WTXy2Wq2GZukUsvEH6ji53QzWdm6Ppd8mehf6VfZeCdImuSo/Xkf0TEW5lxORkph1l631M3iwuxwHLN3/5k=
X-Received: by 2002:a19:9e95:: with SMTP id h143-v6mr21603314lfe.129.1521835795565;
 Fri, 23 Mar 2018 13:09:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Fri, 23 Mar 2018 13:09:34
 -0700 (PDT)
In-Reply-To: <xmqqzi2yiraj.fsf@gitster-ct.c.googlers.com>
References: <cover.1521690197.git.wink@saville.com> <387b3dc01562fd30f5894c91109d1a9d00d07720.1521690197.git.wink@saville.com>
 <nycvar.QRO.7.76.6.1803231838020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqzi2yiraj.fsf@gitster-ct.c.googlers.com>
From:   Wink Saville <wink@saville.com>
Date:   Fri, 23 Mar 2018 13:09:34 -0700
Message-ID: <CAKk8isqYW5-f8LUQQ5fAybV89gE_pDMWRZe=p7YoCn8ta235YA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/9] Use new functions in git_rebase__interactive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 11:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> If you fold this into the previous patch, I am sure that after your 3/9
>> indenting the function properly, the splitting into functions will look
>> more or less like this:
>>
>> -git_rebase__interactive () {
>> +initiate_action () {
>> +     action="$1"
>>
>>       [... unchanged code ...]
>> +}
>> +
>> +<next function> () {
>> +     [... setting up variables ...]
>>
>>       [.. unchanged code ...]
>> +}
>> [... more of the same ...]
>> +
>> +git_rebase__interactive () {
>> +     initiate_action "$action" &&
>> +     <next function> <arguments> &&
>> +     ...
>> +}
>>
>> In other words, it would be easier to review and to verify that the
>> previous code is left unchanged (although that would have to be verified
>> manually by applying 3/9 and then looking at the diff with the -w option,
>> anyway).
>
> We are on the same page on this.  A series structured to have a step
> that looks exactly like the above would be very pleasant to review.
>
> Thanks for a great suggestion.

SG and I'll rebase on top of my v5 for the first two commits which
I rebased on master.
