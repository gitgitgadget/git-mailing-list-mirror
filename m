Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77E51F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760040AbdLRSWV (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:22:21 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:44055 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760032AbdLRSWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:22:16 -0500
Received: by mail-qk0-f180.google.com with SMTP id h19so19500411qkj.11
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 10:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r72uhj1khnkh2ja3dPzocP0QNwvZVPneZ95gVvs2TdE=;
        b=NNyBxPRovWPAq3Dfy+DpNaqSdH/7sTOBKSZe5sfq3u2RM6dPZFhcjD5CH0nqcgYfmQ
         ed7e4eAIYZ5Q5NOLXFDPxgj8hS1mPHl8Sl8JiD5H3wSBcJ2LN3QWlXN2TOMQthwa1bGb
         2++GYBiZg5fwPO/76FrkBN+APaawajj9xCKNiCRXpsVDaD3t3W5Vhee9eVU9CkNel60B
         Kz6dh5im3NE2Pv8a6bAtTBUdeGYjwwHO6SHgKiUSAzvXEJevaLmSqUC6slIH8H9ETfXE
         kwn/KcEGkOeWuKC5FvAFAVPeZhBK4VWEJmJk6N0122XECGMarpPa1xkYJhxs5e5mnsiP
         ZJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r72uhj1khnkh2ja3dPzocP0QNwvZVPneZ95gVvs2TdE=;
        b=YwHs6b5vuKOTAjQAdF7DODsHqPDX3yZVCQdZDu9iC6Cg9rsrs8KIqeM4W5xwxTGsWr
         5CeVhokhz2eM022O287eXsITDmGBH1BWlOMK9e4KfPpcHOJ30SY5pz9SU7f1C9iERArr
         8SbDZ/e7pioEJDGTgeUtsUhHhgvS3oqAoOjZkYbdybYn+DS20L0rv6iPAj2Ya2fBlTq+
         oSvfbhA75vXuSdQUGH1qS8Ip5l1831Sy3Kx3KEA897zlJL3NJzukczCll1sPnFx7UMWU
         j5ZB32J137/bJp8nchzX1hc+23cxkrL550OyD2TtZ1tG3p1SN7u7HsC7oSnR+5td2Zex
         +C+g==
X-Gm-Message-State: AKGB3mJLB0VrOg4NjqFKLcJ6B4YL7PpWxGkwKHR7w3elmudd7R1xztkk
        TZ44kBAahRMigGfp+GSx7coaupV4Hu08Z6FYLg4utQ==
X-Google-Smtp-Source: ACJfBovCpK/oAI48LrV6ojwot8azcb/4o4uLcPJyl/GseOQLGwcOYtQtzvwdmRGHfEpDnMowwQBokc2y7eVkDbQj/L4=
X-Received: by 10.55.9.145 with SMTP id 139mr931646qkj.336.1513621335768; Mon,
 18 Dec 2017 10:22:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 18 Dec 2017 10:22:15 -0800 (PST)
In-Reply-To: <1513600223353.28799@arris.com>
References: <1513600223353.28799@arris.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Dec 2017 10:22:15 -0800
Message-ID: <CAGZ79kaePjuN3fEOAj=0-qn=_3B_3AQXDMnNPPEbNLOVSWS0mQ@mail.gmail.com>
Subject: Re: Fetching commit instead of ref
To:     "Carlsson, Magnus" <Magnus.Carlsson@arris.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 18, 2017 at 4:30 AM, Carlsson, Magnus
<Magnus.Carlsson@arris.com> wrote:
> Hi
>
> I am involved in the git-subrepo project (https://github.com/ingydotnet/g=
it-subrepo/). It's an attempt to simplify the inclusion of repos into other=
 repos.
>
> In a certain situation I would really need to fetch all commits related t=
o a specific commit (SHA). I have read the git fetch documentation and foun=
d nothing regarding this. It only seems to support fetching references.
>
> I found some traces on stack overflow:
> https://stackoverflow.com/questions/14872486/retrieve-specific-commit-fro=
m-a-remote-git-repository
>
> Following that recommendation it feels like it almost works:
> $ git fetch subrepo 50f730db793e0733b159326c5a3e78fd48cedfec:refs/remote/=
subrepo/foo-commit
> remote: Counting objects: 2311, done.
> remote: Total 2311 (delta 0), reused 0 (delta 0), pack-reused 2311
> Receiving objects: 100% (2311/2311), 703.64 KiB | 0 bytes/s, done.
> Resolving deltas: 100% (1174/1174), done.
> ----> So far so good, but then an error message appear:
> error: Server does not allow request for unadvertised object 50f730db793e=
0733b159326c5a3e78fd48cedfec
> ----> And nothing seems to be fetched.
>
> Is there a way to fetch a commit and any ancestors to that commit based o=
n a SHA?

Ask the server operator to configure the server to allow fetching commits,
specifically "git config uploadpack.allowReachableSHA1InWant 1"


>
> Why do I need this?
> In git-subrepo we try to recreate another repo within our main repo. Crea=
ting the necessary parent references when they appear. In some cases we nee=
d to make sure that we have access to the correct commits from the subrepo,=
 but we don't have any references except a SHA.

A very similar issue happens with submodules, which tries to fetch the
branch(es) first and then by SHA1 as a fallback, but this fallback may
fail as well due to the miss-configured server, at that point
submodules just error out.
