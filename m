Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B118D20248
	for <e@80x24.org>; Sat, 13 Apr 2019 15:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDMPYN (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 11:24:13 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:36463 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfDMPYN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 11:24:13 -0400
Received: by mail-ed1-f47.google.com with SMTP id u57so10259769edm.3
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nYFDnyPyjwocUbnWcuBf0PnW0l0w69CLXKkYpvkXpEU=;
        b=M9k6XhX/2HBJt4NPHicKiOTOvxIUhOrnwRySA3+dPGaVJ80bfXWI0teN0m0FDW81RG
         fIY7r2sj65JnyUMWEuTAAI3tV/DnTx3i5irvUz7F2m2pxZ1S83LPlBKTqJkYvnzkgmj3
         MRUmJzbo/xN3z2PEq6t6lD36Kq22Pt+9mqMTwvz6HjUIBo/ClKvB71kujWXNS0y/RV0h
         76+RXTLwnQMD2J/HGzyixTpSxipKE5OefLig8uoLmQmIH9eCirRJ90RonmrRTz5pAbtl
         JecDJZ6Zfnl0EkyFTZaf7B1qQtyg7rNa3qF2J1NFfMiWK/QYKmJSnNU/Xkj89t8yvlAJ
         HeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=nYFDnyPyjwocUbnWcuBf0PnW0l0w69CLXKkYpvkXpEU=;
        b=bqKCbgjPJz/C7E5Dcw3w6Rabscs0SBMS89qtqNOPQUPpCM/eDALVEG8baGsk5absa0
         ii/3jYILNQEAFd2yufUJzfLJQl41O7PdzRxlo+QmVY4186nOVSC6mSlqAcQEt4eSHzj3
         jR3jpibT6KTvzP4njLCv1jatOhdfTRLSUyO3ZWFiBTvPNHQqZVcCEBY++zoUjrk06pfu
         gdIKlgPSX0Nrycmpm7HkFkULog3WCo5P3WzO8hKy8WYKUEgydySMD/eY8fN3kUJeWvNH
         wVGeSNqgB+hdpc7FRWItQcrb/z/vrQe2aiuMfiR3H0YrozmjJnLa0kpJGmZh21G7u1LK
         KNkQ==
X-Gm-Message-State: APjAAAV006aOVokTryFo2W2JYbidEyi5JzCEllKEsTXWMsk8gVGUpfxR
        g+POFkMtN5tYnW/SYIE6YpJA/P00nW9FpPrxAZ/LZuKFDGj+Tw==
X-Google-Smtp-Source: APXvYqwLkmfyowguf8rBkScFzJIoskadEhOwiwfRxtp5KOv2Kvr/zf2L5DIzyKQzm4YdGN/M0szNNT/cxHaEHUoZsOM=
X-Received: by 2002:a50:acc6:: with SMTP id x64mr11877360edc.141.1555169051294;
 Sat, 13 Apr 2019 08:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <5cl.5Cyq.1JuGDapDk}8.1SiN42@seznam.cz>
In-Reply-To: <5cl.5Cyq.1JuGDapDk}8.1SiN42@seznam.cz>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Sat, 13 Apr 2019 17:23:45 +0200
Message-ID: <CABUeae9g-J3zXpkc1Y_6vQM5VQ0do3c9PT-300Vcvoxi5kQY1g@mail.gmail.com>
Subject: Re: Repositories stucture
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 13 Apr 2019 at 07:32, Mgr Georg Black <georg.black@seznam.cz> wrote=
:
> People from big company(BC) wanna to have only one big repository with al=
l code in it. BC wanna have to folders structure for language and projects.=
 But for us is that idea bit uncomfortable because we rather have more repo=
sitories by language, maybe by project (in BC folders). It's useless for us=
 that every developer on specific project and language have all other sourc=
es in their local repository. Is it the solvable?

Show the BC how Boost libraries structure the repositories with submodules
There is single superproject https://github.com/boostorg/boost/
and large number of libraries (each with dedicated team of developers).
Periodically, everything is synchronised into the superproject repo
and prepared for release in single bundle.

Then, you may want to learn about submodule and subtree features of Git,
and choose the one that suits best your workflow(s) to implement your
repositories structure.

Best regards,
--=20
Mateusz Loskot, http://mateusz.loskot.net
