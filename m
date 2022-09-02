Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ECFC54EE9
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 14:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiIBOeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiIBOdg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 10:33:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C649FE3C11
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662126915;
        bh=owXENwJwKrVNlM0VozFOeSaX3oUYUMhJKdmwt+1nJaw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HF+lpMReiferkof5cp4bg56P1je11xUjSrDijfq/INpQRGDL2ufpH4rCqD0oEsWLK
         ZnwO9fWbwwFaL/SUWvg9l6lMyFHiwzOB/KGBD4BWSqzkDikqUfEc4mSjyIUYr2U9T/
         FVOSe2QWHbEiArPPmwy2EJbXBVn5sgWxTk2ZNSRA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKKX-1oaMFo2dZp-00FmFu; Fri, 02
 Sep 2022 14:38:13 +0200
Date:   Fri, 2 Sep 2022 14:38:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/5] Makefile: split up $(test_bindir_programs)
In-Reply-To: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
Message-ID: <62q164ro-pp89-6248-3s1q-66nq2s4s1491@tzk.qr>
References: <sso99so6-n28s-rq86-8q20-4456r3pn869r@tzk.qr> <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-20147947-1662122294=:189"
X-Provags-ID: V03:K1:ap6nJ+2hWEQgIn/yJrtSgA0L+1vQjJh928k5euKiDT7UCbMOnx0
 PpFCOXKBWBSAHq0w5+/l2rJTOTUC5bTH2NO23dBSZw8yLBpe7AphZrupdBJXyjg2FMpsIy0
 dj6YlS4g9nNpwY0X6c4Z75PLZilghWBB8rV5LygOPrs2OdW4nucuWikCiyRzbdHzvvzC00T
 j3FvXGVy+sMhF0P5ujNzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ytSzoAc+xcU=:ZD6muDrEzOcbxq8+GQX0RY
 ZoSsFyGHAam60DyLb1cDX4/x7IA775MkojeMc/o7wW/c4pN51vqdtbBY8cb4xgpsSf2zqiiKv
 IrHD69kqi+wsnyc10CrasLQhuFPR2zVOkNiORTAiUq2Git2/hkbaj/6UtUGbA2Hl2olWqecFJ
 FezmhDEjvYYsE0WqRVkULObY+rbGKvSLOp/tCkUJAeWuLn4HLGswNnrtlNYxBlTxO1NfQoYre
 a+aUtBBf1umy2+O0S+11+DegROW9dQWYE5yROhv8/OhkpHQQY6rSmT/oH24b6Y8u2o04xF6N2
 QOpv1AGq5ba8KUFYEJMhtEbcno6ItJwkwiNTiqWTpDQN50HI5jsSS+jOkF4TK2TAlDYoytn6/
 xIHSH4RFJz+enWdiEILoHnL3YTKr+CEuKre+qWBWK83HeBBIWG+bUaJERBV7ruHOY57lzaa+N
 ln4adcph2RUhkQtYmizV9Vjafq9DUEaJGZYIWyn5G8hBU7nrAx6W2Xt8tBD8qgsfw5MNhgaBx
 OgUlYVRNvdhS7nrSXCRLbCzmc9eBGjdvuTLKmUaY2y3wifL2ofrl/agZ2xN+/GrGu5NIBYI2I
 es+CtB5bIhkDFtM1Bu0wPnwzm5U2hp7VTtx+pS4kGbaOrjpuU1H9uxh9aYN3BbhW67BRDQQ+n
 nZP1wdHAS6cJe6bQ0PNfUspC1Sg9WgFsrbKiby271NlWZT3PE+LtZRTrHsn5VXZE/S0AuZf2k
 PmiJLC9aUfxvgnt4M8POY2c9Ap/79WM2SkU/8kYn6U6ndrSpP57pDs8qRwlffnQlD56BEu2EA
 9JVlrp9NeO2SQ9bUVmz4YkJVsI3Gv3SfxlRna0KGUI2Wcy2YJyUXqF8DOnp2texLBWmcFEgyG
 PG55hxe0uhCFF7aIj1rkuK+Iv5xJMk58bWkAk0ms9vXIEWN2Svb1M8h2rDppicW0HscAcywg0
 b5bB+DDQvnuGeZ1uaPSvzxDI/lGqcjiTnSlTlAqy8vojDay54H1qDVqOqM0/uPeAeAYKsEsJ2
 rR+yP7Z8HRqrtG7Qn317LVXipbAfjr+3CtxuWUzOpW9mypWa/GH+jZnJVcb7ML6yHp24qrLnX
 LK7/DGC64vCeI1KzuatxO+vICYjvYGSGMdMJescKeB3DRuMTsxKvekN9UHekOFiObA4/QgZJJ
 ApwMiXYxSO57k5YlCvkft+5bv7
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-20147947-1662122294=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 1 Sep 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Sep 01 2022, Johannes Schindelin wrote:
>
> > [...]
> > On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:
> > [...]
> >> @@ -3062,7 +3067,7 @@ bin-wrappers/%: wrap-for-bin.sh
> >>  	$(call mkdir_p_parent_template)
> >>  	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> >>  	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
> >> -	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(p=
atsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ &=
& \
> >> +	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(=
filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
> >
> > It took me a good while to wrap my head around this (and let me be cle=
ar:
> > I consider none of this your fault, it's the fault of the design of th=
e
> > Makefile syntax).
> >
> > Let me untangle this, for posterity's benefit. We substitute the
> > placeholder `@@PROG@@` with a concatenation of two strings that are bo=
th
> > derived from `@F`, i.e. the basename of the to-be-wrapped command.
>
> We could do this later, [... something about touching the same code ...]

Yes, and we should.

It would be better if we kept the focus on Scalar in this mail thread, to
get it done first.

It is the stated preference in this project anyway to avoid working on the
code that is already being worked on in other in-flight patch series, to
reduce unnecessary friction.

Ciao,
Johannes

--8323328-20147947-1662122294=:189--
