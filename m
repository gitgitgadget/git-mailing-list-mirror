Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D7D1F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 17:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbdBDRjm (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 12:39:42 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35345 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdBDRjl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 12:39:41 -0500
Received: by mail-vk0-f45.google.com with SMTP id x75so32752090vke.2
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 09:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hB77hudqRKYgtJPRO5dTeN5xPAop7baWw2v5OnT1n48=;
        b=ea6hHpOPh7hcy+pvRyARnj5uvzuqrRbb2n0ZdP7bYlhwyeYXpzgZMKIcSkAjZ1ySiM
         g+HuPxZYaybU2ON1zA052s3KESua3d8JGfJU8V5hqIUSaLetGpzmqlzFxyhhUvwTGdRZ
         L0qH3jwUO28K1GSFY0QlLTVcRqfnnlcI+cuYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hB77hudqRKYgtJPRO5dTeN5xPAop7baWw2v5OnT1n48=;
        b=r8RTDpfxBNY0pX3kJXoGeCm8eU8LpF9rez3SBH1f/ksNQ4TiwPmdJaUUQBb7b4CN9Y
         WKeDje3BdkOhh3XpTPJg+koGvhl+jCZ/70fnAhTy9+RKkxIX7l/chkYXcd/kd1neJDJf
         IxOh0gYzWd0EkXDmYM8wY3HrJv8UcvYAOo+/RZuaT4HZndwUw3MoYDB73uQBcomHvQ6a
         AwbL++0Q78CvOWYwc+pyv8wVM+Sww2dlzc5J5WPPe1SpCY/7JjGNblOHyLLi1pcFoJt1
         w9y/UexxyOeNStydEW/0+KCWfn+4jjaOSGHI7zcHrHIKb9OXz16Qpdpv0hO0LBsIX2Yq
         hJOQ==
X-Gm-Message-State: AMke39lmMk7DdyAEJINYKqOnuqeg1YgYNMnnIEAyWMPEJDfiU86NfXzRVoqSHHRTKju+RnZulUdlD2oCh8vs4w==
X-Received: by 10.31.180.1 with SMTP id d1mr1030078vkf.112.1486229980515; Sat,
 04 Feb 2017 09:39:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.145.76 with HTTP; Sat, 4 Feb 2017 09:39:20 -0800 (PST)
In-Reply-To: <CADoxLGPFgF7W4XJzt0X+xFJDoN6RmfFGx_96MO9GPSSOjDK0EQ@mail.gmail.com>
References: <CADoxLGPFgF7W4XJzt0X+xFJDoN6RmfFGx_96MO9GPSSOjDK0EQ@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Sat, 4 Feb 2017 09:39:20 -0800
Message-ID: <CAJo=hJsS6FmL9iNScaXqkWJumALfGr8Od5QkbfZ+ZG3osxkp7Q@mail.gmail.com>
Subject: Re: Git clonebundles
To:     Stefan Saasen <ssaasen@atlassian.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 30, 2017 at 11:00 PM, Stefan Saasen <ssaasen@atlassian.com> wro=
te:
>
> Bitbucket recently added support for Mercurial=E2=80=99s clonebundle exte=
nsion
> (http://gregoryszorc.com/blog/2015/10/22/cloning-improvements-in-mercuria=
l-3.6/).
> Mercurial=E2=80=99s clone bundles allow the Mercurial client to seed a re=
pository using
> a bundle file instead of dynamically generating a bundle for the client.
...
> Prior art
> ~~~~~~~~~
>
> Our proof-of-concept is built on top of ideas that have been
> circulating for a while. We are aware of a number of proposed changes
> in this space:
>
>
> * Jeff King's work on network bundles:
> https://github.com/peff/git/commit/17e2409df37edd0c49ef7d35f47a7695f96089=
00
> * Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy's work on "[PATCH 0/8] Resuma=
ble clone
> revisited, proof of concept":
> https://www.spinics.net/lists/git/msg267260.html
> * Resumable clone work by Kevin Wern:
> https://public-inbox.org/git/1473984742-12516-1-git-send-email-kevin.m.we=
rn@gmail.com/

I think you missed the most common deployment of prior art, which is
Android using the git-repo tool[1]. The git-repo tool has had
clone.bundle support since Sep 2011[2] and the Android Git servers
have been answering /clone.bundle requests[3] since just before that.
The bundle files are generated with `git bundle create` on a regular
schedule by cron.

[1] https://gerrit.googlesource.com/git-repo/+/04071c1c72437a930db017bd4c56=
2ad06087986a/project.py#2091
[2] https://gerrit.googlesource.com/git-repo/+/f322b9abb4cadc67b991baf6ba1b=
9f2fbd5d7812
[3] https://android.googlesource.com/platform/frameworks/base/clone.bundle


> Whilst the above mentioned proposals/proposed changes are in a similar
> space, I would be interest to understand whether there is any
> consensus on the general idea of supporting static bundle files as a
> mechanism to seed a repository?

I don't think we have a consensus on how to advertise a bundle file is
available, which is why there are so many instances of prior art. In
2011 I just threw together /clone.bundle on HTTP because it was easy
to make the Python wrapper ask for the file and handle 404 gracefully
as not found and fall back to `git clone`.
