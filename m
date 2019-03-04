Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECDB620248
	for <e@80x24.org>; Mon,  4 Mar 2019 15:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfCDPPT (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 10:15:19 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:44472 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCDPPT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 10:15:19 -0500
Received: by mail-qk1-f171.google.com with SMTP id r21so2946107qkl.11
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 07:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CwP+FMCUtkTRRti/CPrvLYWNcgQN+RpXwtmionYPk/4=;
        b=k0Fw0nrZvIOMTEXsxS7KGB2iTw+hINCrAFq+HIFKsXNYuv/aAqCi1S+XYp86sye9gL
         UdAdp/1aVWqRTfTNuWAqDZF1rcn9+wG/fBfdOHBADEeB1MiI8L90bxXQgNVDtU9rEeYz
         H6oB6CqTPgzF83bntLCc8YZSpedA0TLYatLvd0RDAJVjPDcu8ghfj1w3+n1uUwOTqFlj
         IbxuesdRXjZ6I3ddjQt+x7MD3gYEMUck9kvUa4dGI+36Ere+GpiRHRCJkvSX+WngZLXA
         M1UwZTJgbM2iFvwSMHNmurbAAIESRql0sUJUFaXVhKYMf5vlqRsp6BwATR6jvmgplhth
         6rdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CwP+FMCUtkTRRti/CPrvLYWNcgQN+RpXwtmionYPk/4=;
        b=hvMRYx6dVoC+Uj1CfzlAaEn7296nAnr1z956NgWXY48YpwYzKMgvre/58cUBhZU4WW
         QFw4I87lo15Y6h9Z20Rc3uKwXCDpk5+xPPkv8Hwmt0cherGlGT3XBUkoCcnnc2/P10Jm
         x0ML5Sh/r4/0jBD01Fb6bf/gqqlS/p0OVNOTpHoMuoN56CWjez7is6O0aN2pDWqHeCci
         zDR509dqkTKgge1O6V2+8FdhA6WALvO28el2U2kLcCmpok38twW6s+VfivlPDwRji0kA
         iwKnCyWxbxqscfraGOVJCkzK4OOdgkxmUdyVIabxahKskdVGpI41mYoXL1qjcz8hyw3G
         9hUA==
X-Gm-Message-State: APjAAAW6SQYsyFV8xUPWyph/Us7BAi7C8ZOsSqV7oRRFlFPOdBYNfGgK
        nIA/WVZ9qA00QSGTjien4Ko=
X-Google-Smtp-Source: APXvYqwv4jFHKhiSPY0potxO7hq1fHUBcpVdrlMrl/2HEKQ9yu+RrlV8I8d4wxagbcxeskb7/5+hgA==
X-Received: by 2002:a37:a556:: with SMTP id o83mr14466230qke.78.1551712518341;
        Mon, 04 Mar 2019 07:15:18 -0800 (PST)
Received: from [10.124.100.9] ([66.210.32.226])
        by smtp.gmail.com with ESMTPSA id z41sm4340237qtz.5.2019.03.04.07.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:15:17 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: small fix for git-diff man page
From:   Kenneth Cochran <kenneth.cochran101@gmail.com>
In-Reply-To: <51ADB663-BF46-454B-A281-03B54F9C3424@ya.ru>
Date:   Mon, 4 Mar 2019 09:13:44 -0600
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <83F77C14-B5F3-40C5-9CAA-DE9C169292A0@gmail.com>
References: <51ADB663-BF46-454B-A281-03B54F9C3424@ya.ru>
To:     =?utf-8?B?0J7Qu9C10LMg0KHQsNC80L7QudC70L7Qsg==?= <splarv@ya.ru>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Mar 4, 2019, at 8:09 AM, =D0=9E=D0=BB=D0=B5=D0=B3 =D0=A1=D0=B0=D0=BC=D0=
=BE=D0=B9=D0=BB=D0=BE=D0=B2 <splarv@ya.ru> wrote:
>=20
> A small pull request.
>=20
> https://github.com/git/git/pull/580
>=20
> Git diff can work with a tree in the form git diff tree..tree too, =
only
> the form git diff commit...commit can't accept a tree instead of a =
commit.
>=20
> Also added useful example about using a tree with git diff.
>=20
> But what is strange. I changed only one asciidoc file. But my pull =
request can not pass an integration checks. =C2=ABGit.git =
(Documentation)=C2=BB is successfully passed, but =C2=ABgit.git =
(linux-gcc)=C2=BB, =C2=ABgit.git=C2=BB, =
=C2=ABcontinuous-integration/travis-ci/pr=C2=BB  and I don=E2=80=99t see =
reason for it.

I=E2=80=99ve noticed that error in my fork also, about fetch not =
noticing a corrupt pack; I don=E2=80=99t believe it=E2=80=99s related to =
your changes.

It is intermittent though - if you re-run the target it likely will pass=
