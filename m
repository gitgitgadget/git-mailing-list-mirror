Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF16020A40
	for <e@80x24.org>; Sun, 26 Nov 2017 20:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdKZU5R (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 15:57:17 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:36128 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdKZU5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 15:57:16 -0500
Received: by mail-io0-f179.google.com with SMTP id 79so26655657ioi.3
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 12:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZmxCef6jn/x8rApcofLYbBNXVKqg+ij9Tb0ejlUWKK4=;
        b=XCZBOLKc4UtdqlZk2i1mk1gY7zvvSUeww5VErKoKAlCTDvevxwuQj1PaUi5w/cb1N6
         lAo7C1T4OLCUxpeG9ah1i6jia3YJCi5Aq8UU7Wh7S+RNYrNPBV3BY53G9Ar8rl/oVEZU
         +oAqOtOi7USMHMBXKWgo7Jr4ojplhhlG6vynxY2kQvDrC1eKKEtKOxZI30nB3I3cQu0k
         6bdq2lGLkU2Hopwtt7fpPz6a9/NQik252lMmED0NLxh8h0Vmycf0PqCoYZql0VCOwaiP
         5HhiS/DgBOEMFuGWLreLl2jLN1g+SwxGLjdnRLEnL26t6cPabdIQU5ZOpZ9V5CMDYiCG
         qPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZmxCef6jn/x8rApcofLYbBNXVKqg+ij9Tb0ejlUWKK4=;
        b=qTdqH5UAkWboOIZ9u0yxAvCeCTHANpgcfL71l1GZdgq/cYYNtTvHmRSJGGbM93Cwgp
         QdHroLAIoDcne4hgoXI4BAIRwuP5yuCLQz5dQoPsBCOfyqz1Mf3ivIddPncv2KkVGH8Z
         z6vDRgLCU/4/OQpDHUyZuhwWHraR3oXexy5gsIVZd9W2+lHsBCVGSKHBJAwc5rLDhZQu
         iZt9qdOllYOl209/bmZMXKfIbB6DrhQeWPzhV2NyBqYWqyIX0R3SydCqV3f9fhHHWb5Z
         n7cAvpbc26wz0uiSljtGX4j9xQA8Vpax+g+M0/b8tAm8x6QG3lzlkbQLJSOwxKgANxkN
         jrQA==
X-Gm-Message-State: AJaThX7NNB0CCc4vs/GV25VSDEmF+xrtkKvOr9X7MpoujfbmpXRwGri1
        NjLjOyKADNjD+ZVzSpjeJPojmZKp10yVjxwzTzo=
X-Google-Smtp-Source: AGs4zMYlgIBRHbY65o4gDm/G3YHMrnI1qhiNxEMa3DO+Lr1wj2cWcZYD/UOQEEvjV5hINZ/Fp5XVGUFFLgsHDcdH+6Q=
X-Received: by 10.107.20.21 with SMTP id 21mr41205963iou.116.1511729835209;
 Sun, 26 Nov 2017 12:57:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sun, 26 Nov 2017 12:57:14 -0800 (PST)
In-Reply-To: <20171126191510.GA1501@sigill>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
 <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
 <CAP8UFD0d9zM9F3tLrTMiLdfoJQsOPELtmudVB6e83DiLPN5DEA@mail.gmail.com> <20171126191510.GA1501@sigill>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 26 Nov 2017 21:57:14 +0100
Message-ID: <CAP8UFD1hRWa1YtgRPZxXvkqcHfUoKKxgVUuN_d9C36jbrGBBXA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 8:15 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 21, 2017 at 12:58:17AM +0100, Christian Couder wrote:
>
>> > Can you say more about where this comes up?
>>
>> The original discussion is:
>>
>> https://public-inbox.org/git/b6b12040-100f-5965-6dfd-344c84dddf96@teddy.ch/
>>
>> and here are discussions related to version 1 of this patch:
>>
>> https://public-inbox.org/git/20171115125200.17006-1-chriscool@tuxfamily.org/
>>
>> As Peff mentions in the original discussion, at the Bloomberg Git
>> sprint, we saw someone struggling to compile Git, because of these
>> msgfmt and Tcl/Tk issues.
>
> Actually, I think we had the _opposite_ problem there.
>
> The main problem your patch fixes is that we may silently build a
> version of gitk/git-gui that do not work. The "make" process completes,
> but they refer to a non-existent "wish" tool, and running them will
> fail.
>
> That's potentially annoying if you wanted those tools. But if you didn't
> care about them in the first place, it's fine.

I think it's a bit better to not install the tools if you don't care about them.
So overall whether you care or not about them, there is still a bit of
improvement.

> The opposite problem is when you don't care about those tools, and they
> _do_ break the build. And then just to get the rest of Git built, you
> have to know about and set NO_TCLTK.
>
> AFAIK that only happens if you don't have msgfmt installed. Because then
> the gitk and git-gui Makefiles try to auto-fallback to implementing
> msgfmt in tcl _during the build_, and there a lack of "tclsh" will break
> the build.
>
> I think your patch does say "consider setting NO_TCLTK" in that case,
> which is an improvement.

Yeah, so my patch actually improve things in all the cases.

> But it might be nicer still if it Just Worked
> (either because we don't do tcl/tk by default, or because we respect
> NO_GETTEXT in the gitk/git-gui Makefiles, or because our msgfmt can
> fallback further to not even using tclsh).

Yeah, it might be nicer if it just worked, but as I already answered
in another thread, it could break some environments if we just stopped
installing gitk and git-gui by default.

About improving the way msgfmt is handled, I am not against it. In
fact I might even give it a try, but I think it is a separate issue,
and I don't want to mix those issues right now.

> So I'm not really against this patch, but IMHO it doesn't make the
> interesting case (you don't care about tcl and are just trying to build
> git for the first time) all that much better.

I agree that it doesn't solve all the issues, if you are trying to
build git for the first time, but I do think that it makes it easier.
If you don't have msgfmt, you get an error that is not so difficult to
debug.

> I do also wonder if we
> want to start putting these kind of run-time checks into the Makefile
> itself. That's kind of what autoconf is for.

I don't quite agree that autoconf is for that, and there are already
some checks in the Makefile.

> As much as I hate autoconf,
> is it the right advice for somebody who doesn't want to look at the
> Makefile knobs to do:
>
>   autoconf
>   ./configure
>   make
>
> ?

I don't think so. I think it is just easier to advice to do as most of
us do, and to just add a few checks in the Makefile to make it clear
which dependencies should be installed or which knob should be
tweaked.

> If there are deficiencies in configure.in (and I can well believe that
> there are), should we be fixing it there?

If most of us don't use autoconf, even if we fix the current
deficiencies, there could still be some a few years from now. While if
we add checks to the Makefile, there is a good chance that those who
change the Makefile will see the existing tests and add more if
necessary.
