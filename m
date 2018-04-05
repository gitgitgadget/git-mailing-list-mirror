Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3EC1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 21:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeDEVqM (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 17:46:12 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:41439 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeDEVqL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 17:46:11 -0400
Received: by mail-qk0-f180.google.com with SMTP id s78so27983794qkl.8
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 14:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EYCAl4lq3qyCjIf2X9IdFJVt763goC77u6lLB2VRNw0=;
        b=mbmsKUeqKokbNz6k7PdR2EzMfDLEptvtsYSL3efkvAaZ8GAqfXFOv+XUA8WBnw+tBd
         CNrZBat1IftuPYHBsioEInBVwPwBv9oF2T7WeHibhzJnbQoN2v0wkY2ygrePnH3Ass2Y
         +ohloAgEwAEnum6B6gm8/dvbLitze39tX0ungGb8DKDWsEG/7Y4K/za1/Qo9baPNPn+6
         Aadb4DBxgwB0NRhX4ptcqsPsCWzsGQVFDC0+OG6Hcd0Dn9rPu1BZ8qALyh7T6mI1+PdO
         pg2GWu1PwUsOYV11DJtHYcdXOQgbk1j38PyegHAH3ezSHwJhd1pjVNbc0l/5rYJHlQfg
         A69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EYCAl4lq3qyCjIf2X9IdFJVt763goC77u6lLB2VRNw0=;
        b=TLSbS05pHBXp9tr4oEISTaBdD7ILEGltXw5shzafOUKj9EUtsQNgCRBXLUj4eu2Cwh
         rXdW3n2oemP5Q68SplsbBTBdvrytb0LsskoV/750qZ036h50fkJiq3VQrLZaWyFvZT/q
         RHo4TsV/DdXlejsTj6Sq75BN5ekWGTLWXBGlCVverfwaLyz2DqMQ/4oiHVlq3hM/z2U6
         OwO9uS/hIuIfe22TE1EmHXruWCa7p9Ozu6nATTFLekURv1/2pf8hP27RrLE/qQN+SiHP
         hCuvG8nOZ+oEKwCtlgkW43XDuCDZuY9h00gSaIYwzA2LaJoMyRgDoCCGXyJCnNeVLqvM
         jQTg==
X-Gm-Message-State: ALQs6tCbnF8NBClfhyS5G0TZION/wGhD3yISd/ZhDjwjr9mCBDXD0CNl
        mwlpJBpYJTK7GOB0ON9kKhS/IzUy/ANRERF15tc=
X-Google-Smtp-Source: AIpwx48mFCvMDvpoq0fO7Sq/4T9VtmrxSLXRU0V0oMmzexaFc48iqZAbdZUIGnsi3tMh1Um6WYrGLugaNcT+FrCtbi4=
X-Received: by 10.55.3.140 with SMTP id 134mr32986835qkd.26.1522964771097;
 Thu, 05 Apr 2018 14:46:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Thu, 5 Apr 2018 14:46:10 -0700 (PDT)
In-Reply-To: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 5 Apr 2018 17:46:10 -0400
X-Google-Sender-Auth: ppFJaqxVS01Iv8rNWWZxjLL7XQw
Message-ID: <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Igor Korot <ikorot01@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 3:48 PM, Igor Korot <ikorot01@gmail.com> wrote:
> Is support for 10.8 dropped?

Until about a year ago, I was still periodically building Git from
source on MacOS 10.5, and there hasn't been any outright effort to
drop support for older MacOS, so I expect that 10.8 is still supported
by the Git project itself.

However, whether various packagers of (pre-built) Git support 10.8 is
a different matter.

> dyld: lazy symbol binding failed: Symbol not found: ___strlcpy_chk
>   Referenced from: /usr/local/git/libexec/git-core/git
>   Expected in: /usr/lib/libSystem.B.dylib
> dyld: Symbol not found: ___strlcpy_chk
>   Referenced from: /usr/local/git/libexec/git-core/git
>   Expected in: /usr/lib/libSystem.B.dylib
>
> Now my question is - how I can upgrade the git console client for my
> OSX version?
> It looks like all installers are written for 10.9+ and the only way to
> work it is to update the OS?
>
> Is there a version of the git console app for OSX 10.8?

It's not clear what installer you used? Was it the package from
git-scm? Was it from Homebrew?

I would guess that, even if the git-scm installer no longer supports
10.8, it is likely that Homebrew does. Have you tried it?

If both those options fail, you can always build from source.
