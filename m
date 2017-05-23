Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4EC1FF30
	for <e@80x24.org>; Tue, 23 May 2017 10:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933116AbdEWKzi (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 06:55:38 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37559 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933034AbdEWKzh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 06:55:37 -0400
Received: by mail-it0-f48.google.com with SMTP id g126so17104123ith.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 03:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cPEze8/FpfaO+OEgpkfs49k6jl5Q9GOTvE3pN71uKjY=;
        b=t8fwse2TogHlCdsne/pvnBAMVCQJLbphj/0pIsZbt4YghLew7GD/HfxE0pxKmbyEHq
         vCov9EiCTNatOgl5joGar+Dg7FJ0IiopXXBmubFVIi7FY3UIvzfJMNPj5nBUwiWtz9Ow
         /CPprjssKOO1GZRKdpIP9IE9hXlHV5KMtvLXfU0irxwzYyu093XTRwMUMFHC9TKMn6f3
         bOP0SqExCBLx6PRCz+A61khF3boEI7wgNg3oKm9VPiJrBErQbzTsNLnu7zyksuj5ZaCk
         1jFg5vNDADZbezhEXrv/EEuqGltFvpRTPvK5bMWzQlY/X0XFdxBdd7q5xMnyDgaWyVLB
         dQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cPEze8/FpfaO+OEgpkfs49k6jl5Q9GOTvE3pN71uKjY=;
        b=s9jD7pgaqVXuBkcze9eBcRBHPRn1T1dbnWIGdJdcRKKDAl+08uBathNPP443fhMK7b
         igAivHHc6eWNr3z+4MGBzrD2HrHfTBR9n5aokqKr6ueckbb8oHTc9mZxrCjEiY6chR1o
         Bj0Qr8rdU3EfrxO69Z65E8IM3WuGVrJyUHdHPBeq+QrDFP23RBhHo5xdzGzdbReLy0mo
         tPh54TKf5vCe7LDY5DVg8AWk7BFaWPM2CjcClhztN+xFmlPNV/1T2JYQHNS9QXQBa8Wk
         myr+M3MuhVzBausQ6P8z0olqUNZRmuGia7WAYmJ+UZuHcskgpf3Z6Cie3IY7wm8vA63R
         34Cg==
X-Gm-Message-State: AODbwcBdKwDZuHx0ksleOIHrob+L3lqY69fDRSa46mJVfePAyd7Bm1+E
        vH7HaT6MrXoM0kD8ohyZO6+xrgFdIKVP
X-Received: by 10.36.53.79 with SMTP id k76mr1937019ita.71.1495536936461; Tue,
 23 May 2017 03:55:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 23 May 2017 03:55:15 -0700 (PDT)
In-Reply-To: <xmqqbmqko7c2.fsf@gitster.mtv.corp.google.com>
References: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com> <20170520115429.12289-1-avarab@gmail.com>
 <xmqqbmqko7c2.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 23 May 2017 12:55:15 +0200
Message-ID: <CACBZZX4d4-EGiUtJQT8cvuMzm0c5DUu5sxUb11kUnJu3ocuSHw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Update sha1dc from upstream & optionally make it a submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 12:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> I liked the suggestion to make the URL a relative path, but this would
>> require you to maintain a mirror in the same places you push git.git
>> to, is that something you'd be willing to do?
>
> After thinking about this a bit more, I know what I think we want a
> bit better.
>
> Relative URL (e.g. ../sha1collisiondetection that sits next to the
> copy of git.git) may be a good way to go.  I can arrange to create
> necessary repository next to git.git on k.org and github.com but I
> need to double check about other places

If the URL doesn't point to the canonical upstream how do we review a
patch to update sha1dc here on list? Doesn't change from "'git am'
this and it'll work" to "'git am' this and it'll fail, then do this
submodule config modification dance, and run some other command....".

I haven't tried repointing a submodule temporarily (and locally) to
another URL for such a use, how is that even done?

> Whether the submodule is referenced by a relative URL from the main
> project, the submodule should not come directly from the upstream,
> and various mirrors that sit next to git.git should not be blind and
> automated "mirrors".  This is because I do not want us to trust the
> security measures of https://github.com/cr-marcstevens/ repository.
> The consumers already need to trust k.org/pub/scm/git/git.git and by
> ensuring k.org/pub/scm/git/sha1dc is managed the same way, they do
> not have to trust anything extra.

I had the same comments Stefan pointed out below about this. So I
won't repeat any of that...

> Another reason is that we want to make sure all commits in the
> submodule that we bind to the superproject (i.e. git.git) are always
> in the submodule, regardless of what our upstream does, and one way
> to do so is to have control over _our_ canonical repository for the
> submodule.  In normal times, it will faithfully follow the upstream
> without doing anything else, but we'd keep the option of anchoring a
> submodule commit that is referenced by the superproject history with
> our own tag, if it is ever rewound away in the upstream history for
> whatever reason.

If we were talking about any other project but git.git I'd say "yeah
this makes sense".

But I think in our case we should keep in mind the main point of this
exercise is for us to dogfood submodule usage, not just so we get
whatever trivial benefits from updating the sha1collision/ directory
from upstream, but so that we run into issues with submodules that we
solve for all our users.

In this case you're basically concerned with:

 * We have N mirrors, but the upstream submodule URL is just one URL,
so let's not point to that, but to our N mirrors

Could also be addressed with a combination of 'pullUrl' for submodules
(inverse of pushUrl for push) to list the canonical one & list of
mirrors (or use the relative URL).

 * What if upstream say 5 years in the future rewinds their history,
github shuts down or whatever, can we check out and work with older
versions of git.git?

Seems like it would be useful to have a way to ex-post-facto say "past
history should use these URLs". i.e. if all git.git mirrors go down
and we have to re-host, then you can just clone git.git and off you
go, but the same isn't true of past submodule urls, or is it?
