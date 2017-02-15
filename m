Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6DC2013C
	for <e@80x24.org>; Wed, 15 Feb 2017 01:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbdBOBff (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 20:35:35 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:33446 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdBOBff (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 20:35:35 -0500
Received: by mail-ua0-f195.google.com with SMTP id d5so12525129uag.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 17:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nPSTJMgPqBighcrucw8/WKIXE8rGWNtNS4v7fHVNBk8=;
        b=m/rFyw+almiOg/DtUe1SO4BMamEdAmbl8E/GzK7kUOX3wyTGo6e1XOD/GFnLQlWfQV
         FM+FN5SjXvLrYfmn7XlSFc9A+xMtTuMWzVsHo7eWhEbmIsLTzvGNGV/+Xe61p6Rbm0+P
         La4fRFIDdFS/1FN6OxBTViuTWlvc331WAKzrp5B3pJjDDCKJea+uEW+25bymfikut+RU
         I3vHO3rjhYzbZkgIa8n+Ep0GGmqQhC5uXNSLukijelAHP5t3gqsQtF9f7bTz7DREzLFl
         K9xRGOQT14meEq6WaO5LXSOjCXZ2D4HNTPwOMaar6ZH/kGjziv6iDf3sOp5/wEAes3eh
         WGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nPSTJMgPqBighcrucw8/WKIXE8rGWNtNS4v7fHVNBk8=;
        b=PB1/6Nz4RIcBb33QjCD2Z14c1LtyWHE7q5L4vg+As13MmiL9XAMBgxNnhpD0QPL5sS
         bWqWiawXFQGr2vDm3bhJeGI2szTTwglGCA14Ys4dy7hOElSQrX5+imE6+vfTHBhEyBMy
         kMA2jC64GffKEIbejOyO311mOSQSn8vOFCxPxROi5qRZL9oZIokSto2nvji3cznqBGqY
         st13483W1WpfdZrfGOzYaxU4u+kEBJria63E6hmDGPYDXsHlr8qgf0+yaBaNKd5yk7Ed
         C3VLF4tqP76R3cuOekTNwQVb/Zn+6ybI47NKImGyM5MIUd7qOhOyC3m39fQjjLZlp6Yb
         7B7Q==
X-Gm-Message-State: AMke39n51J5qQ9UPL2j9imuWmNd7QFZT9bo4GheNG3d8vOU8B81HpVZDY0snBxwtM/8TQ/EXkv4N7y8ZgbVELQ==
X-Received: by 10.159.48.69 with SMTP id i5mr16679907uab.121.1487122528748;
 Tue, 14 Feb 2017 17:35:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.22.131 with HTTP; Tue, 14 Feb 2017 17:35:28 -0800 (PST)
In-Reply-To: <xmqqfujhddl2.fsf@gitster.mtv.corp.google.com>
References: <20170213192036.10671-1-szeder.dev@gmail.com> <xmqqfujhddl2.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 15 Feb 2017 02:35:28 +0100
Message-ID: <CAM0VKjmU57saSfyRuoWfC+UZFNypH1Wp9X33VgzPq9fatD=qtg@mail.gmail.com>
Subject: Re: [PATCH] completion: restore removed line continuating backslash
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 9:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> Recent commit 1cd23e9e0 (completion: don't use __gitdir() for git
>> commands, 2017-02-03) rewrapped a couple of long lines, and while
>> doing so it inadvertently removed a '\' from the end of a line, thus
>> breaking completion for 'git config remote.name.push <TAB>'.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>>
>> I wanted this to be a fixup!, but then noticed that this series is
>> already in next, hence the proper commit message.
>
> We get "--format=3D... : command not found"?

Yeah, that's the one.

> Thanks for a set of sharp eyes.

Heh.  Sharp?!  It took over five minutes to notice after I first got
that error...

Furthermore, that '\' was already missing in v1, almost a year ago :)

>> I see the last What's cooking marks this series as "will merge to
>> master".  That doesn't mean that it will be in v2.12, does it?
>
> I actually was hoping that these can go in.  Others that can (or
> should) wait are marked as "Will cook in 'next'".
>
> If you feel uncomfortable and want these to cook longer, please tell
> me so.

Well, it was mainly my surprise that a 20+ patch series arriving so
late that it gets queued on top of -rc0 would still make it into the
release.  However, I have been using this series with only minor
modifications for the better part of a year now, so it's unlikely that
there will be any big issues with it.  Maybe something small, like
this missing '\', but we will deal with it when it arises.

G=C3=A1bor
