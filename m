Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_DNOT,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E29571F453
	for <e@80x24.org>; Mon, 18 Feb 2019 10:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfBRKqU (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 05:46:20 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:43284 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbfBRKqT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 05:46:19 -0500
Received: by mail-ua1-f49.google.com with SMTP id z11so5641498uaa.10
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 02:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/kE97JObMm01ShjDw232fwfJ7WDmujnKeTbkkfLNkR0=;
        b=Kh0brTddpnlyl69gSt1YkMNGJgJTDxYiAlk9UqtriN6fttHRqNR8oBrbxg431Wiivh
         Afkipow9PLnrd8Uc1cTvC44PNqQU5VbMnT6Dvn58PtOgY75fqf0Tnmwh7uszZoEDIaBy
         1DrDeoaLZEar+js75F+1zXDaMdXcsObDLvQ2xgyDPxBB94atR+UKKCliUtVMt60FGVam
         aCjBatgg3IfZWPDtsrjrpvaCcAoJXxPM5vmNI9cqovts/ubzbxsh9y4DguLrwz+k2XLQ
         T238Y3Gikxtz2bwaxR3SvXoIl6nsbKaWxQb7MEMl0D2j+cmxtDdl5nnR41QVwyADzlG7
         wcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=/kE97JObMm01ShjDw232fwfJ7WDmujnKeTbkkfLNkR0=;
        b=ck8kO6ukZCFFHtdkEf9GUCS+0Q/5tUuhFcq33TIkG15vmhrJZXhk+8u5e7lCCrUOB3
         KOgHBHXN/uCGjPDVNMRqOUz9Z4Jb5juLM0RM+7OR3ivXPdqcrLLhKr5uzBnptQw9EuaW
         lVND9D0PdYIGMF8H/l2uR1w8GcLcsBbkQvfvHgtuIyXuH147yeXOqqJ6QD9Oxn26JbBP
         o0el+qFj6k5cAPcBIbmkDtasrP27os/GUDETLvdnDPE85w8R4KnX+E1d/uhmcXWYVyFY
         W2caebR5+sCXFkLua2weCeF4ycfzRRxyuhi4v3vjcmLniis6z6sS4WUkrfbpCHtSReB3
         eZhA==
X-Gm-Message-State: AHQUAuZKeFov+wu9ccVwIZP+/i5ZFSmrMNE0huX607z3YY9zqrx3jZpx
        IvAfHYEMHQYUFWLH9evKAs+fHDaWmTvtGjDn8samDw==
X-Google-Smtp-Source: AHgI3IZxDdjsLTrJoJIZkIgCDGXZmnWQhmXIOwYsty4sV1QbKK8x1sfxeWMoScGJQqHfDszIYWCD/tcPGfl+3nK272g=
X-Received: by 2002:ab0:4707:: with SMTP id h7mr11444673uac.46.1550486778296;
 Mon, 18 Feb 2019 02:46:18 -0800 (PST)
MIME-Version: 1.0
References: <5c62b41d.1c69fb81.fe791.877b@mx.google.com> <CAFacdQ-soWD176VHgd+raHaV=VPpzKXrDrLFavPcNEoewZwBYA@mail.gmail.com>
 CAFacdQ-soWD176VHgd+raHaV=VPpzKXrDrLFavPcNEoewZwBYA@mail.gmail.com <5c657002.1c69fb81.d433c.32ce.GMR@mx.google.com>
In-Reply-To: <5c657002.1c69fb81.d433c.32ce.GMR@mx.google.com>
From:   Senol Yazici <sypsilon@googlemail.com>
Date:   Mon, 18 Feb 2019 11:46:42 +0100
Message-ID: <CAFacdQ8NDKfd0p8=9Rh3s4FPeS9mbqpQt8mw3AZoJn9jHjriPg@mail.gmail.com>
Subject: Re: Delivery Status Notification (Failure)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I just stumbled over following page

https://git-scm.com/about/distributed

and was wondering if it is possible to

- demilitarise that =E2=80=9Cdictator/lieutenant=E2=80=9D thing and
- de-religionise that =E2=80=9Cblessed=E2=80=9D thing

I did not had the feeling that git is =E2=80=9Cpro military=E2=80=9D, or is=
 against
=E2=80=9Cnon religious=E2=80=9D developers/users.

Thank you very much,

Senol Yazici
