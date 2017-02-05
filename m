Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED751FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 16:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbdBEQhJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 11:37:09 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36616 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdBEQhI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 11:37:08 -0500
Received: by mail-lf0-f52.google.com with SMTP id z134so33275346lff.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 08:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n+luyHqZTzIbOMPDUmvto+yLQPBr26YKL2k8IdzpgEU=;
        b=vIKSKoSZyfLK+COENZWak7nEx8Cush7oz9Yf3jtxbEzdT2HtFBpiopcdgqmpeuoG8B
         eTcNWkgeTBuq7LXQDYxybksC/cLxJueZh6+QN1y070Oli9yBLIYhaXJ5IIBPa0cudXgi
         agi3O4AVGLTE0BDx6mr1hB/0veCLYiTeS4ZJ00yRfvOrW6uAdB8mfG4pbozKMcQBQ283
         YPxc31kVi49GT4dbsbX1HyTPJCOHwkMZBm7wQ7J8ku32cLuuU6IxBloMuEnLJZ85mXw6
         qfsNIPolGeF6AZxFta5yaY1HiNZHqbyyidiSOb6t8injgJYZHu03f+mLt45mccKR+F3S
         2YAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n+luyHqZTzIbOMPDUmvto+yLQPBr26YKL2k8IdzpgEU=;
        b=Nz9NOHycZfMECLJkuT5cYhY7ohTwD8mL6/7OJZ4btmlTqRax4nrjfDeFrzlqBFD0wc
         bHgOb2PwGYWUJJm0M9v8ky0CWyN0HS00QGSBnKExPSk6I7aiHm6Raz7PCBmiNVZD00I0
         2JwzG2UnQZphDdl3DMHCGUrVpiDNHPslMT/VrMlsrARaMw8tfraYRQz9HRf/u5VnL20C
         F3ZaqgYHwRTqQXbHAwE1fxou0IsJHUtQohoelqPuaHCtLhjO4da/tTxByRdMY52K7TKU
         segWiPIyxTpZLpohuf4dV/gHdFFBskRPmZdUAn2QE9Ql4l1WxIEMz40Y+VZw9dqLzxTI
         IsZA==
X-Gm-Message-State: AIkVDXLRrw8uH5Hse2LHTcPhnbBpucmM5hlKzoco+/e3di7AWE5eqjaRWT+XCbtGSno8n2okNkscs6T97FwT7Q==
X-Received: by 10.25.203.3 with SMTP id b3mr2239963lfg.130.1486312627089; Sun,
 05 Feb 2017 08:37:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Sun, 5 Feb 2017 08:37:06 -0800 (PST)
In-Reply-To: <CAJo=hJsS6FmL9iNScaXqkWJumALfGr8Od5QkbfZ+ZG3osxkp7Q@mail.gmail.com>
References: <CADoxLGPFgF7W4XJzt0X+xFJDoN6RmfFGx_96MO9GPSSOjDK0EQ@mail.gmail.com>
 <CAJo=hJsS6FmL9iNScaXqkWJumALfGr8Od5QkbfZ+ZG3osxkp7Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 5 Feb 2017 17:37:06 +0100
Message-ID: <CAP8UFD2ffeHr0-z3xPFFODqRTTgVnrrWcYRbASpUOrp0QGnp6g@mail.gmail.com>
Subject: Re: Git clonebundles
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Stefan Saasen <ssaasen@atlassian.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 4, 2017 at 6:39 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Jan 30, 2017 at 11:00 PM, Stefan Saasen <ssaasen@atlassian.com> w=
rote:
>>
>> Bitbucket recently added support for Mercurial=E2=80=99s clonebundle ext=
ension
>> (http://gregoryszorc.com/blog/2015/10/22/cloning-improvements-in-mercuri=
al-3.6/).
>> Mercurial=E2=80=99s clone bundles allow the Mercurial client to seed a r=
epository using
>> a bundle file instead of dynamically generating a bundle for the client.
> ...
>> Prior art
>> ~~~~~~~~~
>>
>> Our proof-of-concept is built on top of ideas that have been
>> circulating for a while. We are aware of a number of proposed changes
>> in this space:
>>
>>
>> * Jeff King's work on network bundles:
>> https://github.com/peff/git/commit/17e2409df37edd0c49ef7d35f47a7695f9608=
900
>> * Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy's work on "[PATCH 0/8] Resum=
able clone
>> revisited, proof of concept":
>> https://www.spinics.net/lists/git/msg267260.html
>> * Resumable clone work by Kevin Wern:
>> https://public-inbox.org/git/1473984742-12516-1-git-send-email-kevin.m.w=
ern@gmail.com/
>
> I think you missed the most common deployment of prior art, which is
> Android using the git-repo tool[1]. The git-repo tool has had
> clone.bundle support since Sep 2011[2] and the Android Git servers
> have been answering /clone.bundle requests[3] since just before that.
> The bundle files are generated with `git bundle create` on a regular
> schedule by cron.
>
> [1] https://gerrit.googlesource.com/git-repo/+/04071c1c72437a930db017bd4c=
562ad06087986a/project.py#2091
> [2] https://gerrit.googlesource.com/git-repo/+/f322b9abb4cadc67b991baf6ba=
1b9f2fbd5d7812
> [3] https://android.googlesource.com/platform/frameworks/base/clone.bundl=
e

There is also Junio's work on Bundle v3 that was unfortunately
recently discarded.
Look for "jc/bundle" in:

http://public-inbox.org/git/xmqq4m0cry60.fsf@gitster.mtv.corp.google.com/

and previous "What's cooking in git.git" emails.

I am also working on adding external object database support using
previous work by Peff:

http://public-inbox.org/git/20161130210420.15982-1-chriscool@tuxfamily.org/

that could be extended to support clone bundles.

[...]
