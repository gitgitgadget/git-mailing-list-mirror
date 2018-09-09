Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93CDA1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 18:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeIIXPd (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 19:15:33 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35202 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeIIXPc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 19:15:32 -0400
Received: by mail-it0-f66.google.com with SMTP id 139-v6so25930162itf.0
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=91zDo6jFeT3kqlZN5D58GqgmhTyLRng3AtASQp2/M/c=;
        b=RtQVi+dTDAuWcgAGSLAEq3/SpTEwEWqj8OvSyT4MkKcG03FQJK8EUHR3ka2ZgMGqhs
         OkdG2Z29pf+GGiT3pGVnMaaGYbgZ6VxMyN+kGO4/TW1LFxJRIlA9f1Q1mH/Bq5ktlLoW
         F3v8i086vo3qGjGGrZa3jVYKam28XJ+C3eycCXbuyu71KIb9ApjH+oETsOXhYbEZHBn2
         5Or28LnKHw03ku6Tdx+Jib6QJirvejxdBLuaLp4HD6CNSzFQDKHJCxSUK12djMUuqRHS
         jGIbC+I742+L6TdnrAJ86DZ9wc9ACExibqbZq4YKe/lIJ0GcsmkurVeS97lVwK6zvVcR
         SF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=91zDo6jFeT3kqlZN5D58GqgmhTyLRng3AtASQp2/M/c=;
        b=uTkpKO2EOPDgUTHPfmFI3VyTZyDE8wU1RxST3P9eJvi2M648UERPsZYp34i7PZPTj+
         ZiIlraXWbACgpQlh45DezzmSqVU5tMlrf+aL/J+FdTMewdUsbz6xtFMfHUlxBaxOlIPW
         KbeunhBCOjF6NlBn0oIyrEzWVlmVgCFcSu2fkfPpqeYJAmCC4m0zAEfht7zIP/egt5wV
         T5kOL+F5wEPFfdfAe26/hih7IJEM2U4VVO2hEpaUzcPh3QPNJoXh8Vd990wltjOwT1yd
         J3IgdwqSAdTsSnbvGYsQ1oemtIctMeWASJ0wDdHn7XFqucv9jvo47xHHUW3CCsoj5h8q
         JW0Q==
X-Gm-Message-State: APzg51AG+QK69ZDWj+HstRRUpVPbAedc1KZKDpbgMtoC+v8uM9A/oDp7
        1I6sCQ+Z6+W4Op6ubqeG++PUkIxwWmQoA5JeFaY=
X-Google-Smtp-Source: ANB0VdZXnQIDf8zwNzht8kCh3PePFsVgbfmq1fkqVJoDt4yx4Ykkb+0ZeyTQQFaike4RPlhmls7wxC7ZJV5AlW9NrKw=
X-Received: by 2002:a24:d583:: with SMTP id a125-v6mr15445652itg.91.1536517502396;
 Sun, 09 Sep 2018 11:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180909173631.1446-1-pclouds@gmail.com> <87o9d6lezg.fsf@evledraar.gmail.com>
In-Reply-To: <87o9d6lezg.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 9 Sep 2018 20:24:36 +0200
Message-ID: <CACsJy8BJYKBcPZeTwP4_0bUsDM4uRxafS77T6RnG9U6h_t2y5g@mail.gmail.com>
Subject: Re: [PATCH 0/6] Merge remaining t/helper binaries to test-tool
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 9, 2018 at 8:09 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Sun, Sep 09 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > Last time when I added test-tool in 27f25845cf (Merge branch
> > 'nd/combined-test-helper' - 2018-04-11) I left out a few test programs
> > because there were a couple in-flight new tests that used them. All
> > those topics are merged now. So we can merge these to test-tool and
> > call it done.
>
> This is great. Just a small side-note: Am I the only one who misses the
> 2.8.0 days when you could do "git clean -dxff" in the t/ directory to
> clean up various test crap without breaking subsequent tests?

Isn't "make clean" (in t/) enough?

> That went away in e6e7530d10 ("test helpers: move test-* to t/helper/
> subdirectory", 2016-04-13) when we started building stuff in t/helper/.
>
> So now that this is one binary perhaps we can build it in the root
> directory and get that functionality back?

It's still a few binaries. Most of them are now merged to test-tool,
but ones that need separate program name, or have extra deps, stay
separate. Having said that, producing the binaries at root directory
is possible. I'm just not sure if it's worth doing.
--=20
Duy
