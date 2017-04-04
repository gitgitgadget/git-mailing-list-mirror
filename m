Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58B120966
	for <e@80x24.org>; Tue,  4 Apr 2017 10:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753425AbdDDKpQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 06:45:16 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34467 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753163AbdDDKpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 06:45:09 -0400
Received: by mail-it0-f66.google.com with SMTP id e75so10778506itd.1
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 03:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+SWQ+a9/XCEpIxkdvnuYv1HdM/aplKVaoLuy9cHMaHI=;
        b=YfJZWy5/GQSPHrpR4We6+j7i+eUrRecvxyn8Zr/HRE+zRGVWS6VMfcXjtz9X4vr/D/
         aANvJpg6Zk090jzfA/leC04iLVjJz2HMwHnXHBynEjxITTMGWuSGxFpsOT2oPbgGOSd9
         xHwd26/XBONh++HJbUTfdo7wznvXCu2dg0NVkY0VUT8JECqyazjrvva7X6n0vZHPvMDQ
         ivA4zblGbogf4tCViG3fah/L1Ql8OqbWJY4Q084d6YGHe/xkG6cVkukEdUUDSK9byXdI
         dZqbme3NJToTulTbhFNfy1rw27rA9ZXj7rF2Xfs81l5ll6wue2jI457+cyq8V1kDhCPS
         1rpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+SWQ+a9/XCEpIxkdvnuYv1HdM/aplKVaoLuy9cHMaHI=;
        b=glJbQVqqckj9buTSVLVMti0VoaN7X2ps2tn4Q6bMCdWdUiCj5dDRGrgzTDaGd/CZ26
         YPksleNAtk4n1gMCeCq0GIz/uCJg1yMa5EGW3HigMrm57Qt4OPBwFV9uZocs2tyK0ZPl
         soGJKgwFvn1R+laPkw3IaHCjXFMY/j4Dgb8AWwwjg8LBzstl/4sd2Hf9Skg+XfC9lSOF
         jlDoZlzh+a/A5bU0eSUFP6kgcS7C2CBmV/7/MtpFDAAQruiWGA3MoOegD2EGd3NlTNTv
         wgPm/33yv8l6zMSseI7D2Ja22QSI6FxUlWOqJhSQ8DyqJHvUI9vBNBUQabeCzN46eQHr
         osgQ==
X-Gm-Message-State: AFeK/H2oPM8jr00pJ5GJnpTPW9X5nQ6zaWTPZH3HOLCASKowUAHGIO53
        Y3jP8JNTckNdyelZAZMYL2gH6ppi5Q==
X-Received: by 10.36.76.16 with SMTP id a16mr10918674itb.91.1491302708268;
 Tue, 04 Apr 2017 03:45:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 4 Apr 2017 03:44:47 -0700 (PDT)
In-Reply-To: <20170404083341.uajswm3qdzyvzxsp@sigill.intra.peff.net>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com> <20170404083341.uajswm3qdzyvzxsp@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 4 Apr 2017 12:44:47 +0200
Message-ID: <CACBZZX5D2cYf0-ob_Da0EsxRtZHfegezPtCGA10-sjfi0A+AoQ@mail.gmail.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2017 at 10:33 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 04, 2017 at 10:17:51AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> On Tue, Apr 4, 2017 at 4:54 AM, Jeff King <peff@peff.net> wrote:
>> > My feeling is that this is old enough to stop caring about. Which mean=
s
>> > we can drop some of the #ifdefs that clutter the HTTP code (and there'=
s
>> > a patch at the end of this mail dropping support for everything older
>> > than 7.11.1). But that made wonder: how old is too old? I think it's
>> > nice that we don't force people to upgrade to the latest version of
>> > curl. But at some point, if you are running a 13-year-old version of
>> > libcurl, how likely are you to run a brand new version of Git? :)
>> >
>> > If we declared 7.16.0 as a cutoff, we could unconditionally define
>> > USE_CURL_MULTI, which gets rid of quite a few messy ifdefs.
>>
>> I don't object to this patch, but just as a general comment, in
>> enterprise-y environments using an old OS (e.g. CentOS 5/6) & then
>> compiling some selected packages like git based on OS libraries is
>> quite common.
>>
>> E.g. at work we're running git 2.12.0 compiled against CentOS 6
>> libraries, which has curl 7.20.1, released on
>> Apr 14 2010. Not so long ago we were still running CentOS 5 which
>> comes with 7.15.5 released in Aug 7 2006 which would break with your
>> patch.
>>
>> Whether we support that is another question, I think it's reasonable
>> to say that if you're compiling git on such an old system you also
>> need to compile a libcurl instead of using the OS version. I just
>> wanted to point out that this *does* happen, someone is going to be
>> compiling new git releases on CentOS 5 & will be hit by this.
>
> Thanks, that's a very useful bit of data. According to:
>
>   https://access.redhat.com/support/policy/updates/errata
>
> RHEL5 (which as I understand it basically the same as CentOS 5 in terms
> of packages).

Yeah CentOS is just s/RHEL/CentOS/g across the RHEL-provided source
packages. It's a way to use RHEL without paying for (or getting) RHEL
support.

> ended its 10-year support cycle just a few days ago. That
> would perhaps make 7.20.1 a reasonable cutoff.

FWIW these cut-offs don't have a lot to do with how long some
installations run things like RHEL5 or CO5 actually run. RHEL5's EOP3
phase ended days ago, but the End of Extended Life-cycle Support goes
until late 2020, and for anyone running the CentOS flavors these dates
matter very little, since they're about how long RedHat is supporting
it, and if you don't have RedHat support in the first place...

> I dunno. We could also just punt on the whole thing. It was nice to see
> a bunch of #ifdefs go away, but the code they're protecting is actually
> not that complicated. Most of them do not have an #else at all, and we
> just silently skip features on old versions.
>
> I think it might be nice to declare a "too old" version, though, just so
> we can stop adding _new_ ifdefs. Maybe 7.11.1 is that version now, and
> in another few years we can bump to 7.16.0. :)

I think it's completely fine to include your patch as-is. At some
point we need to pass the burden of dealing with these old software
versions, saying that you should use a <10 year old library isn't
unreasonable. Anyone packaging new git on RHEL5 or derivatives can
just package a newer libcurl as well.
