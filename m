Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257301F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 10:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeKOUtn (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 15:49:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44566 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeKOUtn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 15:49:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id p82-v6so16325878oih.11
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 02:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RaySFVjHzHBNYYe2f+AIdSlCdYTDpMuyhVAVl/mk++w=;
        b=l2QJmg+1bnvoGb0Z2A5rmErlJ0nDCUcLYoKOtVGkbjvNxD1rO+rAfZYCHCdrymOxJh
         lqhV0+Jdj5ahpKLYC3MpIGbSd+/KK+i2dJYoQ2Eqv/qfzJicxAUbmyCOmr1diqDHmhOP
         ZnfqztJxLtCegiDLGi7cGJc01KcfRUjfcaEuRaztoFk3BX3/SDowW1z0vY2tBF+NZ24N
         cUpmIPRGlLgM472/ZVN+rH4Yivf1hJEakrUyaIQSGA0tfLvHsVRHJIzPbrIfefMD03K2
         Hi0rQQKNAJH0f5p31bSQ5YJyFa1y2ykxURdYGbcGuoycOF0UMpBqu1WdJlUmKURBoc5N
         r0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RaySFVjHzHBNYYe2f+AIdSlCdYTDpMuyhVAVl/mk++w=;
        b=Hx4S0Dg6nDmjn+w06uJdTdCTnlodbmu/H6tuLyubfDEVbArNjtBaaSsBxtZaNvwKst
         rsKTp9m9X7dXQfUXDqdoZmbKHgccB3pUP5cM0D6tg80udfAfzRCH5ib8HxzUR8k2icSp
         OHD6h80Z7gAAzS+LtKAGlJPG5N3RWbsviwLAruueb8oEbNkFClYzeJEqtkHAkpHQ27vd
         m/xEBVtUr3ZYX4gjfoqqMd/zcbr6CzJ+K99MzsQ6K0XzVhS27P4M3PcWkN3gAi5sLeei
         DQvBrhZjM1qpiNhbn142Ij+WFDJSsIWjGviw3DuRwMAcGo3Rg+NspIQqPq9opJsswXRv
         OIVA==
X-Gm-Message-State: AGRZ1gKra5U+jWXF+okMfVyKH0EQjJLhPHOjOgNUiga7Mds21pYTV4x5
        VoqXGIfV7SZtw6ILODSbqN0EzNi1ojUigcK6Y34=
X-Google-Smtp-Source: AJdET5cZcAzlSmFvpDdVU9Er0MOc2ihiItdo32NtL8+R1JR8rC58E53DXePnlmGoBxLLAUiUMcl52SqH9LxzdPDfx7c=
X-Received: by 2002:aca:48d1:: with SMTP id v200mr3399744oia.69.1542278545243;
 Thu, 15 Nov 2018 02:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20181115013233.24685-1-yanke131415@gmail.com> <20181115030503.GC92137@google.com>
In-Reply-To: <20181115030503.GC92137@google.com>
From:   yan ke <yanke131415@gmail.com>
Date:   Thu, 15 Nov 2018 18:42:13 +0800
Message-ID: <CAJosSJ757tVMy3XL_CEwhs0w-meZR7bv8b66V_+_BcnXRcALiA@mail.gmail.com>
Subject: Re: [PATCH] INSTALL: add macOS gettext and sdk header explanation to INSTALL
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for review, I will summit a new patch soon to improve this.

Jonathan Nieder <jrnieder@gmail.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8815=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8811:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi!
>
> yanke131415@gmail.com wrote:
>
> > From: out0fmemory <jiu4majia2@163.com>
> >
> > ---
> >  INSTALL | 7 +++++++
> >  1 file changed, 7 insertions(+)
>
> Thanks for writing.  A few bits of administrivia, from
> https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html:
>
> Can we forge your sign-off?  See the section "certify your work" in
> SubmittingPatches for what this means.
>
> What name should we attribute this change to?  Documentation/SubmittingPa=
tches
> explains:
>
>  Also notice that a real name is used in the Signed-off-by: line.
>  Please don=E2=80=99t hide your real name.
>
> [...]
> > --- a/INSTALL
> > +++ b/INSTALL
> > @@ -165,6 +165,9 @@ Issues of note:
> >         use English. Under autoconf the configure script will do this
> >         automatically if it can't find libintl on the system.
> >
> > +    In macOS, can install and link gettext with brew as "brew install =
gettext"
> > +    and "brew link --force gettext", the link operation is necessary.
> > +
>
> As context (e.g. to go in the commit message), can you tell us more
> about this?  E.g. what happens if you don't perform the link
> operation?
>
> [...]
> > @@ -178,6 +181,10 @@ Issues of note:
> >     will include them.  Note that config.mak is not distributed;
> >     the name is reserved for local settings.
> >
> > +  - In macOs 10.14, the Command Line Tool not contains the headers as =
before, so it
> > +    need install Command Line Tool 10.14 and install the headers which=
 command
> > +    "sudo installer -pkg /Library/Developer/CommandLineTools/Packages/=
macOS_SDK_headers_for_macOS_10.14.pkg -target".
> > +
>
> Likewise: what is the symptom if this isn't done?
>
> Is there more general advice we can put here that will survive past
> macOS 10.14?
>
> Thanks and hope that helps,
> Jonathan
