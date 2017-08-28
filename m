Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59C7208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 18:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdH1SYV (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 14:24:21 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34572 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdH1SYU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 14:24:20 -0400
Received: by mail-yw0-f180.google.com with SMTP id t188so6573266ywb.1
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4NDFM0RTmZbb5IGxrBJyh+ChK4xOneJsmHTydlYl6wA=;
        b=e7sohahSKuUrMa9Ds8ejmjSQx4/BV+cjJvk5Fu6UTd/6uZddh2UO4g+Oksl0szr4uT
         9ni9hhfyyDI2n49fPvRl3oQBAR5MyZSPUveriF1ZRWP6cxfxhmejRZ3B5SqvBwo8GfO/
         +hnq7P0/RbjxIGGcxrvcF7Uj39NE+WaMRrx9aKYlwrdkGE0p7c68uAk+CCuSwP3SBzzf
         PENJ8pfDq/lyY8XZt6bAwwoOj0zeANsMXAIiZwFFGQv0an4RcvClRe57d5N53RWlBlvz
         KgcX3c82ebTHHIvw4WLSvjrgLjQdpfXhwMtWFHdGu+K/RjTpsDhirriO0rOpyTPBxYtP
         GR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4NDFM0RTmZbb5IGxrBJyh+ChK4xOneJsmHTydlYl6wA=;
        b=B6hDgGixfrcuwg8yNaqqhSoicFHs2Vc7tGsS9H/jd7UCqeyK2NA13QOzYN20QrVjlQ
         JJAK3WH2f5R1P0lvr/q23AyHVse662cwT6RsZIW7XM9ShSHRpXclah8xL6by3IzkX59y
         IyeAAfK6ummNLKRiGSSBfVvefgJasqL8YXqofZbdeBFGupKdvOBHteWJWhQmC2QPUycR
         Qc5FD4BUcDBKVEZGN6+ou/5+fXMpNCXr3mcmu8DPl1fj0Gc1FMEH48+15idFT5hdSav+
         x9SlK8eECySHt3aDp3q0Cvy2NLVpgMSZtQbF8dU3hvNPztWOpez35yWAYXiu+QHlDtcG
         rxDg==
X-Gm-Message-State: AHYfb5hxHqKqXCQDjEaT2olAEmPBaW5XJOF1+bbNcZsKmvC45EphuKNl
        Yjd7kqifc5t8Y2EfPiVn6HTDe7uGvJjakjqAdw==
X-Google-Smtp-Source: ADKCNb4HtaZoQIVzvbGybApx6/MkujJiRGBS6dyusvZfDVN5SnOHSITAGmzhsU3mpb4C6XdvpSIze4CnsvgtCiUoggg=
X-Received: by 10.13.225.71 with SMTP id k68mr1264228ywe.33.1503944659628;
 Mon, 28 Aug 2017 11:24:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.248.26 with HTTP; Mon, 28 Aug 2017 11:24:19 -0700 (PDT)
In-Reply-To: <CAOAAw7WsiwzQYhiU9xxcoteaEWgaXRQkiVb0Xa2WckR4=m-bFw@mail.gmail.com>
References: <CAOAAw7WsiwzQYhiU9xxcoteaEWgaXRQkiVb0Xa2WckR4=m-bFw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 28 Aug 2017 11:24:19 -0700
Message-ID: <CAGZ79kZSmJBnfcU=WWmq3VEHJBJLQJzzri07hSU-uA-VgT0t3Q@mail.gmail.com>
Subject: Re: git describe and "the smallest number of commits possible"
To:     =?UTF-8?Q?K=C3=A9vin_Le_Gouguec?= <kevin.legouguec@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 26, 2017 at 7:47 AM, K=C3=A9vin Le Gouguec
<kevin.legouguec@gmail.com> wrote:
> Hi,
>
> I've asked this question on the git-users Google Groups list[1], and
> while the answers there were interesting, I still cannot figure
> whether my problem comes from an actual bug, a misleading manpage, my
> inability to understand the code and/or the manpage, or a combination
> of the three.
>
> I noticed this problem on 2.1.4 (Debian oldstable); I can reproduce it
> on next (7ef03bb281b2220d0f2414365e4949beb2337042). Quoting
> git-describe(1)'s SEARCH STRATEGY section:
>
>> If multiple tags were found during the walk then the tag which has
>> the fewest commits different from the input commit-ish will be
>> selected and output. Here fewest commits different is defined as the
>> number of commits which would be shown by `git log tag..input` will
>> be the smallest number of commits possible.

Maybe relevant
https://public-inbox.org/git/20160421113004.GA3140@aepfle.de/
(specifically the discussion after this patch, it sheds light on the
heuristics used, though your case here doesn't use these heuristics)
