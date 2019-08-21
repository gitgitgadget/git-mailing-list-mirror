Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919B41F461
	for <e@80x24.org>; Wed, 21 Aug 2019 14:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfHUOKn (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 10:10:43 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:42467 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUOKn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 10:10:43 -0400
Received: by mail-yb1-f175.google.com with SMTP id h8so1071786ybq.9
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 07:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tAsz2wYXzQrb01zFeLXYEaKXU/bSUXc/u+g0vs3IkTY=;
        b=ZRfgeTvczNggEKwbuoE/rVySt8qED49tqksNRuz9zfU2uCF2MYOEjWwKPzCCjyRJy1
         HwC1x0GdV/eGewcNxFVorwzDKntu694ZPvqlT1GlHYRIjrBowcVs2IMrY6Dzpl8HtIwJ
         8FrUjIWAIHiLPG42/4BkJ+z8/Ivis/AaLjLuWqukm392IPsRVdn27IGDVd/Zxgag30YH
         /iZf8dlLZ5ds4WQkAw+B51ymYUkmkgtueQraH4ZRHcx14a9hNSf7gALft6NxYYDX53Ai
         LFla4p0bK50HgiVdf8AwzI+y92fwtHW+MKbcJAXks6jlml78Vnqem6VOhVdROMiZUpZ5
         JBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tAsz2wYXzQrb01zFeLXYEaKXU/bSUXc/u+g0vs3IkTY=;
        b=Gl2E0+fC+Qem7bsc+UFAdvxltudnGjl5z7uNHr0YPMaUWRYHBYhCxoA8lKWMubkGa3
         NQ+rbyE69lV2H+EeGjhadb07KQ+T90us7CPNYdK1Zz8M5eDcC3qpB1m84HwHnJh8PrOl
         zKiRKt/hMCLg+O4rHdPky8j8l5ylYx/KukA+aq5pb/MhC7kR3461jbuouSj7XZlSyEXT
         z9nvBzpK0Q+JHJkW1CpW/5LnlwnLpRq/NCMTEmP6aW5dVhLOrxhuyQs1yVL5GiLafXmk
         dhuANdSBkXeUeZOefzDUOEFVxCG6HCueQjN8ZUaDH7nFxLCvWt8/z4ZkPlgeV8GTq/QA
         ySOA==
X-Gm-Message-State: APjAAAUiRmRTJtI+xB1cw4jmTEH/6k2REk0UpQWVHGRRB0/03joCOzyG
        mdKixKCNhDHRPz0V3UATRV1beYdA0lMsI2t+2EmaRw==
X-Google-Smtp-Source: APXvYqz9h1wR0z5vQVqX7jIoKqkF6mh31n5dben0NoQi70lo5FzpL5qQWcUVBIDwCRf4YDIzBbEWPtqnZop1kbsVM4I=
X-Received: by 2002:a25:6305:: with SMTP id x5mr23184499ybb.444.1566396642234;
 Wed, 21 Aug 2019 07:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAAZEOjv+y8y6z_stqqZFAVe6SqCH1upvhYPeqAY=w49EGdzK4g@mail.gmail.com>
In-Reply-To: <CAAZEOjv+y8y6z_stqqZFAVe6SqCH1upvhYPeqAY=w49EGdzK4g@mail.gmail.com>
From:   Rick Tillery <rtillerywork@gmail.com>
Date:   Wed, 21 Aug 2019 09:10:31 -0500
Message-ID: <CAAZEOjuaMarjG=RUj2UDYL19u0tnYgXf-Kx3Z2dYJzmDDK8esw@mail.gmail.com>
Subject: Re: QGit 2.8 for Windows?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, does QGit have a test build for Windows, perhaps run as a
regression test to verify the build each time a change is made to the
source?

Rick

On Thu, Aug 15, 2019 at 4:06 PM Rick Tillery <rtillerywork@gmail.com> wrote:
>
> QGit's README (
> https://github.com/tibirna/qgit/blob/master/README.adoc ) directs me
> to this mailing list, so forgive me if this is the wrong place.
>
> Is there a fully built version of QGit 2.8 for Windows?
>
> The latest QGit for Windows I can find is 2.3, from 2008 (
> https://sourceforge.net/projects/qgit/ ). That version encounters an
> error every time I load a repo (deprecated command "git
> repo-config..."), and I see this has been updated between then and
> now.
>
> I did attempt to clone and build, using the instructions in the repo,
> but after several hours of trying, the binary I produced will not
> load, with several error dialogs, which appear in differing order each
> time I try to run qgit.exe (and the procedure entry point doesn't
> always appear):
>
> "The code execution cannot proceed because libGLESv2.dll was not
> found. Reinstalling..."
> libGLEv2.dll is present on the system in \Windows\SysWOW64
>
> "...VCRUNTIME140_APP.dll..."
> I do not find this on the system, in the Visual Studio files, or
> available online (I do find VCRUNTIME140.dll).
>
> "...MSVCP140_APP.dll..."
> Same as VCRUNTIME140_APP.dll
>
> "The procedure entry point
> ?qt_metacall@QProcess@@UEAAHW4Call@QMetaObject@@HPEAPEAX@Z could not
> be located int the dynamic link library
> C:\Projects\qgit-qgit-2.8\bin\qgit.exe."
>
> Is there a pre-built 2.8 for Windows?
>
> Thanks,
> Rick
