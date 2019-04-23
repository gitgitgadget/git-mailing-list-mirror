Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D581D1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 06:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfDWGwc (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 02:52:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35287 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWGwc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 02:52:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id y67so11610452ede.2
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aJUan0ekfxoBud41zU9hK6bcieKGc+HQkgBNbTW3iJg=;
        b=iX0FF+xrJJ7ahiArZAFaKu0EEAaWHi9RIPARS0EKViPWHUDnFFVY5GiNHOwTFWUCY7
         HuofrqMDAfkHQlKHcm7550cOeBaEyFixfy8rYy6rUWx6AZC9pf4t+iVK1R9+hSqaBep3
         l8dbsdcWRXim8mJCJNB1le16BFF9R6Ub3yuy7NJBKCONJM4bMcox545Ke9DZ5b/jK4g7
         WaYz32klssmFy67LXyZ0mLtmiez88AnNX6U0AGr3d+kji1/BH5sXAk+21EHffEGQbMai
         /DPcIo81IhvAnOjZKUJQK4zRRZ7h7oOd3Znn4TGhvLrg9UDVoFGQWu01nde8muE+aHqW
         RhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aJUan0ekfxoBud41zU9hK6bcieKGc+HQkgBNbTW3iJg=;
        b=ne4cKMyWWG7VZ91frSN6G1C8yYgzLBiDf+9+S7GuZWfTQvCJQvfc5J4PZgYZaHZ1a1
         d+FvRN7gxg3RUxtii1vnGk5L2yoy4V5wO8kDbTHV6r/HxAFQ/HT3A0LlYlKk/8OSXuUM
         jF8O4I1LSMfxebU6XR7gMCrzFETgc5WwcPJVTSCxegHZIdFSoyLuDKNVDQSTeZ3xJ6UM
         KW9pTprh0DXwssSgslErz2+FuECw1jOcNdFiHiMeXHyEgu/r7TTKzjwk2VgBVm7DVXZl
         9WNm9XMI5AX7bWIteGdiCgS/giBed3rS8iXwuD/WrvwHGTFLG/RQLKESxoq+NHdi+55X
         hSNw==
X-Gm-Message-State: APjAAAWATj9HWMaQ64/JEsc1Kdcn4RW+fXjD5s5IZpLl/yHRdZ+v/vLI
        HmZt6SgUVijpmt8YrEtxLRJn12lh/Z8bG7Xfdr0=
X-Google-Smtp-Source: APXvYqxp1RofP5pr+moWa1TYbLHwerkkHZf1djUC9VRXI+FbDG1V3qA5/ZEtCGVlGW2ybB2dn/FzVGM5C3gxZjcntQg=
X-Received: by 2002:a17:906:3fca:: with SMTP id k10mr6256092ejj.126.1556002350339;
 Mon, 22 Apr 2019 23:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0le8t9l.fsf@gitster-ct.c.googlers.com> <20190422175104.15471-1-jonathantanmy@google.com>
In-Reply-To: <20190422175104.15471-1-jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 23 Apr 2019 08:52:18 +0200
Message-ID: <CAP8UFD1EwUbjSx3+q=9T8KgDz=vv5UH9ObV2z-8VRaQejera7w@mail.gmail.com>
Subject: Re: jt/fetch-cdn-offload (was What's cooking in git.git (Apr 2019,
 #04; Mon, 22))
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 7:53 PM Jonathan Tan <jonathantanmy@google.com> wro=
te:
>
> > * jt/fetch-cdn-offload (2019-03-12) 9 commits
> >  - SQUASH???
> >  - upload-pack: send part of packfile response as uri
> >  - fetch-pack: support more than one pack lockfile
> >  - upload-pack: refactor reading of pack-objects out
> >  - Documentation: add Packfile URIs design doc
> >  - Documentation: order protocol v2 sections
> >  - http-fetch: support fetching packfiles by URL
> >  - http: improve documentation of http_pack_request
> >  - http: use --stdin when getting dumb HTTP pack
> >
> >  WIP for allowing a response to "git fetch" to instruct the bulk of
> >  the pack contents to be instead taken from elsewhere (aka CDN).
> >
> >  Waiting for the final version.
>
> Sorry for getting back to you late on this. The current status is that
> v2 (this version) looks good to me, except that not many people seems to
> be interested in this - I sent out v2 [1] with a relatively significant
> protocol change to v1 (requiring the server to also send the packfile's
> hash, meaning that a workflow that =C3=86var has described will no longer
> work), but nobody replied to it except for Josh Steadmon (who did give
> his Reviewed-By).

There has been no answer to my comments in:

https://public-inbox.org/git/CAP8UFD3SWNu=3DbtPxV2vV=3DneYrofbgKPzz_WLvsJbv=
6bKjRoCpQ@mail.gmail.com/

especially the part related to the "-o avoid-cdn=3Dbadcdn.example.com"
example that Jonathan Nieder gave.

[...]

> If this version is good with everyone, then this is the final version.

It is not good for me as I think the "-o
avoid-cdn=3Dbadcdn.example.com", or even "-o usecdn=3Dgoodcdn.example.com"
options, (that has been the only thing suggested to work around
problems with CDNs that people cannot use or don't want to use,) will
likely end up to be some other kind of promisor remote but not quite a
real promisor remote.

In a more general way I don't understand why I was repeatedly asked
(especially by Jonathen Nieder, you and Junio) to dump ODB remotes in
favor of promisor remotes because promisor remotes would be more
unified, and now you develop something that is not unified with
promisor remote, though it could very well be. (And you haven't yet
taken the time to review the multi promisor work I did following your
suggestions, though it is the first item in the future work plan you
wrote in  Documentation/technical/partial-clone.txt)
