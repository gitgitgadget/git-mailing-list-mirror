Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C17A208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 17:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbdH1Rcm (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 13:32:42 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33702 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdH1Rci (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 13:32:38 -0400
Received: by mail-yw0-f176.google.com with SMTP id s143so5909401ywg.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1KeztFa1gYSrfFvRUm8AzqO+oa9ASBWX+8UaVfEqc9k=;
        b=ZeJeRxpgLuxtxccmcbn44jeg9HVTEg30whkoeGSDbdXC9JQFnovQ8eIvgetV8e29qE
         pXFe+tZ1UjNUYkustqQwhcdgp0saX+Zfu21Xe4Lx8amn+zHIlUQYSWBdS+13Wr8CMQWx
         CtdVOp9+hf1aA23OaSqSfoVf081arGE4ZGh5pYj4aRv/UmIyWKB+EL1GxKEhVOFAx5eF
         8lvLmF+LTwgsdLUzifQQcUCNT9T8LXKioyzbUW/e8diCZg5wKDDmgY2sLYuEdqUwSida
         mgsUCAXWb/pnRDGwkODnSRNnRG4OTfCEFIFYEAlMAGcwrfXARsz1bRbSpll/Y7OrzG7h
         Xwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1KeztFa1gYSrfFvRUm8AzqO+oa9ASBWX+8UaVfEqc9k=;
        b=ZkZ5ocualVCQr1tgmsTaYSi+kBTHjl7JW523pNkziH5Hli+fPiPZmbdDGmD2zP1HJ2
         2qSAHKGz2hNmVy0o8UKww+QVgrBzxytTOS7v04s8OWII7UUYTYd0XF8bX1oPxMRId2XC
         IonSYpfqR4UOSX06uaUmN0evWdYO47fHXPxPlKLCyicibFyU2/NR4Jt6z+yzkfb+B+AR
         oNlilJ4FtMTbTQGS1IbpxkOGzVhXgsVbpp55oWaMb19sxHDNjwMG/92Agl33baGuKmQB
         B2yeka8jQtR1WkiuOB0YX2avHhSo8HiyzKPvJdtjGHi9LF5QhoxGjpn0COAocWHdy6V/
         gpow==
X-Gm-Message-State: AHYfb5gxcgW5YO+LmJDxLn/1+iCRswrfiMTZvtQbyFKB8BCeaB5lYnYa
        BnvuH7jSPLTvbKjcbfNf6Hio/45F2Hwg
X-Google-Smtp-Source: ADKCNb62F/ibg2vJ5SZ2ob50Xp6/lmeIJ1jqlZVdK9xv4M2i8jBcjjsboXNbsWW92vOB2lAKcMK8frWZIMOYcIOuVG8=
X-Received: by 10.129.79.196 with SMTP id d187mr1147116ywb.29.1503941557948;
 Mon, 28 Aug 2017 10:32:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.248.26 with HTTP; Mon, 28 Aug 2017 10:32:37 -0700 (PDT)
In-Reply-To: <8AF4A868-628B-42AE-B75E-4DF19F7C7A89@gmail.com>
References: <8AF4A868-628B-42AE-B75E-4DF19F7C7A89@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 28 Aug 2017 10:32:37 -0700
Message-ID: <CAGZ79kYKJo4hcBY=nEi6z2gSH=W322W_h3_68bb0ZzF+L8JUig@mail.gmail.com>
Subject: Re: Automatically delete branches containing accepted patches?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 27, 2017 at 11:44 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> I have lots of git/git branches and once in a while some patches make it
> into git/git master. If this happens I would like to delete my branch
> with the patch automatically. That's not easily possible as the hashes
> on my branches are, of course, not the same as the hashes on git/git.
>
> How do you deal with this situation? Do you manually delete your
> branches or do you have some clever script to share?

As soon as my patches are picked up, I rename my internal branch to
be the same as its remote counter part. Usually I rebase my local
branches on these remote branches, such that directly after queuing
they are identical.

Usually I delete (local) branches as soon as I am either confident
they go in as is or they are not very interesting to me.
(e.g. a one off typo fix is developed on detached HEAD, sent out
and I forget about it. In case a discussion ensues, I have to either
take my patch or redo it. There is no local reminder of these things
in the form of a branch)

Stefan

> Thanks,
> Lars
