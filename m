Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD11B20A04
	for <e@80x24.org>; Mon, 17 Apr 2017 13:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbdDQNJY (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 09:09:24 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35256 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdDQNJW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 09:09:22 -0400
Received: by mail-wm0-f49.google.com with SMTP id w64so33595330wma.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2bI48FIhg3/AbDVrzspJ8OE8huntoNJHAIOS0gkHah8=;
        b=fJWpnv9xUmmJa0eZK2AnEU9JpEP6o33Py2/dxq7MpjCY2OIxcY0Rkn/FHfzV5LktN3
         3LwnTX9oQQfcobz0dRfemMofOXmrIY2EiXCsSDiiWmKZ1/KMbxvsw+c9i76Q7reAeN4M
         GDCkQDoLZ6tymuwbEcDoK/pyhsoHurj8FQjruTBMrof6wZ7biCaEA7y76qQQHwfJDHZA
         Lgc5MTygz+pCr03wOcOV99YmMHuEZX3dmxmJ3tbSwQr280MUXD+1TsRA6ervrfn8H3eZ
         puJc+wF4fj0GBXYOUqBTNuvN2EsQ7u/Ozcgxs3VgH/rwMHlqV3P5WKEniwiGwEsXwv/9
         TW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2bI48FIhg3/AbDVrzspJ8OE8huntoNJHAIOS0gkHah8=;
        b=som4nKo8xP49Fo3+pGXfoaHYZ71sd7Z0iUKtBGBYKsaNLd1hHxfh02cPYIvEzBYjS0
         QwaBhSwD3aMIeJT7ffUcytiu82xqLjhcPCqy7almvprR1ut6PlDBK9yBAd5nIqJgepm7
         cnJH5VcrFlPJL/ylqwAm9s76a+LeCWHQn7w/DTJGT9QdfsjYg7knll3RnR6brRWRNXay
         4/UI9Ep/p8M2VKgj4a4T72lnx0mhe9pC5mphExFuJ9WWqOGEz48rlAmRJUaGTYUwiejM
         PxiiCnxoFgH5wEeeVElqnSE3rLlI54yzd8X+LBJCPylFsdboLJffmzfXrcs9rS4SNVlt
         v9ow==
X-Gm-Message-State: AN3rC/5LES6O3P71GXMrNi3abwQCM5UUX3N/IwyghHk/fo1/NGETOZJC
        Rtw58xykLpf4PlPuiD0nMd3HEwYU5A==
X-Received: by 10.28.9.76 with SMTP id 73mr8201095wmj.93.1492434561323; Mon,
 17 Apr 2017 06:09:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.142.26 with HTTP; Mon, 17 Apr 2017 06:09:20 -0700 (PDT)
In-Reply-To: <CACsJy8BASVSxJ4RzNKVpj9MyD=fMR-fpspMdET1bT45yMrf_0w@mail.gmail.com>
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
 <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
 <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com> <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
 <CACsJy8BASVSxJ4RzNKVpj9MyD=fMR-fpspMdET1bT45yMrf_0w@mail.gmail.com>
From:   "Fred .Flintstone" <eldmannen@gmail.com>
Date:   Mon, 17 Apr 2017 15:09:20 +0200
Message-ID: <CAJgfmqW4ck9SwBrT_Z7bTOzM2zG==_ONUhTfhbLJtRu=vT+wyg@mail.gmail.com>
Subject: Re: Feature request: --format=json
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I would either have to do:
git rev-list --all
Then iterate over each line and do git-cat-file commit <commit-id>.

Or do:
git rev-list --all | git cat-file --batch

If I do it in a batch, then it will be tricky to reliably parse since
I don't know when the message body ends and when the next commit
starts.

JSON output would have been very handy.

On Mon, Apr 17, 2017 at 2:59 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Apr 17, 2017 at 7:44 PM, Fred .Flintstone <eldmannen@gmail.com> wrote:
>> So I did "git rev-list --all --pretty" and it looks like "git log".
>> Which outputs a human-readable format.
>>
>> However, if I want something more suitable for machine parsing, is
>> there any way to get that output?
>>
>> Example maybe I want another date format like ISO dates, or maybe a
>> serializable format like JSON or CSV or something. Maybe I want more
>> data than commit, auhor, date, subject and body?
>
> "git cat-file commit <commit-id>" should give you a machine-readable
> format of everything (it's the same thing that git-log parses and
> shows you; not counting options like --diff, --stat...). <commit-id>
> is from rev-list output (without --pretty, that's not for machine
> processing). You probably can use "git cat-file --batch" too, just
> pipe the whole rev-list output through it. You don't get to choose a
> convenient format this way though.
> --
> Duy
