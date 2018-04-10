Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3524D1F42D
	for <e@80x24.org>; Tue, 10 Apr 2018 17:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbeDJR55 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 13:57:57 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:42861 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeDJR5y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 13:57:54 -0400
Received: by mail-yb0-f180.google.com with SMTP id t8-v6so1085421ybo.9
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TEfhxvoT73DSh8Y0/SV8cqd0ImNn1A8CJZYjgUS9jBs=;
        b=plhm44IdaCMvccuTj4GWVY5/wxRnE2lYubMEHvkZFPyHRx39XyuiR0uIKnLDkoy3lw
         10fIMgzmzmzRWxTilVj2bYSI62qSN6J+2LPvgMyS8vSeJGWtsaa7eNswiQIBtmjc6Bcx
         xdjCdQ4ybbb2AqTOhjXIttJabOoy8Xl/UcTUZFiyqc8c3LVv6x6R+FuMeZIc5KKGn3TH
         hNstRyFm1ZvwlZDbZhsOLQTzoS6Xx2OMk4IhjTDWCOs8kaG80wi/6wYBcIdqvn7ivM0g
         8FXSYHKwl9GfP7gcWQmmMjp2f8Pm6iUrhpc5mSWojJnKA6+bNshmF32qMoXKfLfH0chR
         v8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TEfhxvoT73DSh8Y0/SV8cqd0ImNn1A8CJZYjgUS9jBs=;
        b=TPh+V4UsvP8ywdbLzTzlAvQvDHc4uxYgahAbHSc0OCVn5cyFZxbZBZ63Q+FCzi/R9Q
         lmDiId8U1+qsR+388uZfmWya/UhkJJIRklkIbVBlPqfTgSU2676+vU6AHqspWcV6qAjG
         IaDVA0rv8ymXMp23dD4FUgILnz1mqgSyTqY9g6RO8Wpj7ygupy97l93DG3VAZtyVK/5o
         RydYSmqu0fGX0qbKlZnY+KsI/GMSLfGjpteajVN9Xi4EswDEMQdY7dEeXRHTL2TQVuqd
         ZKS5j9dWlU/sH34innYsotu1CjaHJQXpcWgf2s4TvKmOfXu/y39ClVoHcpDW2xuIbr+n
         5PcA==
X-Gm-Message-State: ALQs6tCpn7pGxcik+iL/QCgHMycu6PP65bbnMzkZ6bdCN4x8O2I7Z/+W
        5SkxebUkHzEAEF0hIlSgshveVdUL2ooYi1TPPnqcpA==
X-Google-Smtp-Source: AIpwx49kOTgEOT/ugK/m4hPRyp/2xAUzd7iJg+UCp9n5C28Ufga4dH+7NY4XD5+NgldCVzkPIoEyuRcgwP6w0LI+jCA=
X-Received: by 2002:a25:c713:: with SMTP id w19-v6mr881883ybe.515.1523383073196;
 Tue, 10 Apr 2018 10:57:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 10 Apr 2018 10:57:52
 -0700 (PDT)
In-Reply-To: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com>
References: <20180406232136.253950-1-sbeller@google.com> <20180409224533.17764-1-sbeller@google.com>
 <20180409224533.17764-3-sbeller@google.com> <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Apr 2018 10:57:52 -0700
Message-ID: <CAGZ79ka2TQ99WiWYD2Cx2Czo=UhE_o5HRCwfeArLMX79-_KQXA@mail.gmail.com>
Subject: Re: [PATCH 02/16] replace_object.c: rename to use dash in file name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Apr 9, 2018 at 8:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This is more consistent with the project style. The majority of
>> Git's source files use dashes in preference to underscores in their file
>> names.
>>
>> Noticed while adding a header corresponding to this file.
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> Hmph, is this authored by Jonathan?

This one (as well as other patches that are also signed off by Jonathan)
was cherry-picked from the long series[1], which was done partially
in a pair programming session or by passing patches back and forth.

Most of the mechanical changes were done by one author and we
just added the others sign off to have the whole series look like pair
programming.

This patch is [2], as-is, so I did not mess up the original authorship.

We decided to not use another trailer, such as co-authored-by or such
as we'd have to sign off anyway.

[1] https://public-inbox.org/git/20180205235508.216277-1-sbeller@google.com/
[2] https://public-inbox.org/git/20180205235735.216710-19-sbeller@google.com/

>
> There are sha1_{file,name}.c, exec_cmd.[ch], and unicode_width.h
> remaining, though ;-)

Noted.

Thanks,
Stefan
