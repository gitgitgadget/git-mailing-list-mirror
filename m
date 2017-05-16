Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DEDE201A7
	for <e@80x24.org>; Tue, 16 May 2017 03:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbdEPDrQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 23:47:16 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35070 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdEPDrP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 23:47:15 -0400
Received: by mail-oi0-f51.google.com with SMTP id l18so10638212oig.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 20:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Tow3FnkUdyavAvUNFBzqSHxmgcLwRzDI1Qeo2btjRG8=;
        b=Tsub9PjJ0cPam0TlOPm1/oOba8crs8Oqoy329LZdN0gFr2nOgMVIRED29hp+E3EGpF
         6JCrR525Wi6+C1F9Mb5Fnb0BDaOn/YUd1W0xmaoHMN1ghVR4Bw+tbboc4/9UUD7HLmid
         WO/MOkv+qo/ox8PHhiCmcv10zKMMsRwO30QRMlYzeftmv6m7WuLVT5KlZ6uIchR2W3O/
         JlyjnJzPoFJqpLKpWSOufxggHSbk/Zln0WAtOX8A93Fnm+8PoBpUtryZlQ4ttFl9zFrL
         73ZXumyy43Rjyfs5kPsdfSxOLRlvTDWamSo5dK0MBXXJpJ3hMX5yGbQqW06QLEIMehGS
         I2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=Tow3FnkUdyavAvUNFBzqSHxmgcLwRzDI1Qeo2btjRG8=;
        b=dRfIHPjwbEgbc/e+lStI0nX/ppepela3NyLgQ2EjWRye95JML/o3Co62TzOb4D1oVL
         5CzuVb4cU77+MEYxmA8nAKrRvNifNPAlC9YI9PBIJTPyNPleHWlPda0qxueVdrNGrzan
         ppOHIiPi4S9ZpYzY8zdpeVQNrv42IYWqXgR9zIttL+7H1r5PwEskHJWyYKSIRyPUqt10
         3vsEjVNXXP6wfOWR71fHWh6oddItDass7+DlG0BQAIEAx8XXpAMPQAWeoyqOWevCJIHg
         rWGb8nV8QsVw9wSQWNFVUalIxKuoHITbdfc4fGOGt0WG3k+tyKfwz+ZnT7KKZAar3Ygd
         JhPQ==
X-Gm-Message-State: AODbwcBOcuCD1kbeTfv+Ts+gjcleN39zcXSHlr8IIzO8ZIFKJm+5GTcW
        PUM8ZPLDh+124U5GUUlSjFeNwF2m0Q==
X-Received: by 10.202.91.198 with SMTP id p189mr725189oib.117.1494906434628;
 Mon, 15 May 2017 20:47:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.22.199 with HTTP; Mon, 15 May 2017 20:47:14 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <xmqqmvad31sr.fsf@gitster.mtv.corp.google.com>
References: <CAH8yC8k8sTGDA=C8vLCE090Y1B4TK86bOnZMNjj13C-JXVEBHQ@mail.gmail.com>
 <xmqq8tlx4h1y.fsf@gitster.mtv.corp.google.com> <CAH8yC8mOc68A-0uM8b3AKAYo9VqYNUjHkGw0knbXL0suM25tfA@mail.gmail.com>
 <xmqqmvad31sr.fsf@gitster.mtv.corp.google.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 15 May 2017 23:47:14 -0400
Message-ID: <CAH8yC8kVFGe9gnj8P+=Pp1ToDvMPXiViVM-HzhkZ6SAteoPZaQ@mail.gmail.com>
Subject: Re: How to force a pull to succeed?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 11:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeffrey Walton <noloader@gmail.com> writes:
>
>> On Mon, May 15, 2017 at 11:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jeffrey Walton <noloader@gmail.com> writes:
>>>
>>>> I scp'd a file to another machine for testing. The change tested OK,
>>>> so I checked it in on the original machine.
>>>> ...
>>>> How do I force the pull to succeed?
>>>
>>> Git doesn't know (or care) if you "scp"ed a file from a known to be
>>> good place, or if you modified it in the editor.  When it notices
>>> that there are differences you may rather not to lose in these files
>>> (because they are different from HEAD), it refrains from touching
>>> them.
>>>
>>> So the way to go forward is for you to make sure that you do not
>>> have such local changes in the repository that your "pull" is trying
>>> to touch.  An easiest way would be to do
>>>
>>>         git checkout HEAD -- <paths>..
>>
>> Thanks. That's an extra command. Is there any way to roll it up into
>> one command?
>
>         git checkout HEAD -- <paths>.. && git pull
>
> ;-)
>
>>> before doing a "git pull" to clear the damage you caused manually
>>> with your "scp".
>>
>> There's no damage. Its expected.
>
> The fact that you think it is expected is immaterial. Git doesn't
> know (or care) how you made the files different from HEAD, so it
> looks like a damage to it.

'git pull' fails and its expected, but 'git pull -f' is supposed to
succeed. That's what -f is supposed to do.

Is there a way to add intelligence to Git so that it sees they are the
_exact_ same file, and it stops bothering me with details of problems
that don't exist?

It seems like adding the intelligence is a good enhancement. A version
control tool has to do three things: check-out, check-in, and
determine differences. Its not doing a good job of determining
differences considering they are the exact same file.

Jeff
