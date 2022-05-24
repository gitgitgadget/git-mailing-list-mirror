Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0648C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241680AbiEXUrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbiEXUrE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:47:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC297340F7
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653425220;
        bh=jlq6QlWqo9PIFb+4gnKBqE4li73mresq/NZDxwQHw+A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JnWGE737pm6yg12ec6frTTqMa5Gu2HhX1Y7DlAa+QmVu1+GW3PNji2zm8hoV67Hul
         sI2KrGUCim7FEAayLgclZp1uE7DtCrBzH+f8rS4ErhCnxxCJ0bGcNQGkjRjcIYPHqF
         /CghxAjtqdzX3L9rpggVHwRt1oEvQQ8LDvdRi08s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1nVKRh1xSD-00p5PD; Tue, 24
 May 2022 22:47:00 +0200
Date:   Tue, 24 May 2022 22:46:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/4] nedmalloc: avoid new compile error
In-Reply-To: <972c3c82-0c10-ee95-9a7f-082de02a49c0@web.de>
Message-ID: <nycvar.QRO.7.76.6.2205242239150.352@tvgsbejvaqbjf.bet>
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com> <8963c6fa625bbaf5153990939ea06742304ddcd2.1653351786.git.gitgitgadget@gmail.com> <220524.86bkvnxsm5.gmgdl@evledraar.gmail.com> <972c3c82-0c10-ee95-9a7f-082de02a49c0@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-99894040-1653425220=:352"
X-Provags-ID: V03:K1:W1m+0+VIr5FR9b31NujbdLciSEMGI7C27P5YOW5sg5yk/iSR5QZ
 4T9gMuaVtyToH/ziu3wkrWwkjlGdC3ogm4ffTmfRs8+t3ST4qk0WkarlP0vY7LHbcZ/k6Ec
 s2SwhHNS3EccwzLNgOkGZy1cOXlOV13AW7LIOHIEsifQ0ZfcGh4dJd30SaQkGUlM5briiNi
 980ONUjaY85UVxxG3ZPpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GGcP/anjI18=:nU9FXwMABK9jJV2vvTvlM2
 qQQ6Zj1I+FX/DZ9SSdcj6A7lvb+LmPMAQ5csN8mKAHLgphQJSF0wWSSXsdzhMVwtazTUKcFNo
 UnS8DdY/fDIR/Sv/qvjQj101JOz2v+D/CWcJDY8WelM2o7QB5YyCkvsFV/U51vG+jDvQMdKgR
 xVsjiroCMns8skP94b5GJ7HCsGIIfThXx5BoPb0nYAmtEAVX3ZVPt8R/yX4/fpFXx89//oeEg
 6TbYCJoitPLxEjf25QgBzZf6f1SdByUMYzShpKN/38pC8MPY+BT3YnCG5vyk4LZ6HPfjREWnn
 B1TBjI3Dof6thD/cHxl2vDidg4VxbU3ioyUVmIpx9dsNIdl3+DJg0fZKROQzkDdZ4WuhpNZOx
 FsENbHkpESETjDGh4C7RjnHQx0trUIy6oyQ5d0yh8YonsRdMYvlNu6m95j8xg8DWhJqUR3/kA
 gSFi3Mo8Zcaf/SZQcu0kM0k9gR0VRU+KqlVKSsqW5Ixf5UQ5kVnGeA34X2hiGXKRy3MTjUB8j
 TyVYKLFQ7ES8z3jzEbILXgFJ3zh4o79wjAcI7OfN3R2HkAcrRLDG26pJDE5FdfA7ZTBF5806g
 ghmqN2btN8Bqt/kpqKXdZ3IMTMHYeLlJfyG1yS8dotkpmwF6wX2iAjWN9XpXPMGchwZXyQR1B
 2+jJ/sRqVMbuNOnDRsnvhrQ7jW9fLIwGkNNO4XDUQ+aPfyICPRlK+RdTVYmJO26QDo9vOvnUb
 0loZ6SmfKGvxZe7snGk+1gkCJNd4j0AQlV6XpZrNWQsw0kR5oPY6XoOw9dGGwDJt4pxSHB+wW
 UY9tKtFvO063EwiUwbi5s8T9j8/y/iarNAofJr0itdpV5zEYBNUinEsrTQjZ7jezjwwgzKph1
 aZqLqOZOsXA/Is9exyiQ9daMoXooEEfjNh5gSe2PQ/IwB58sqYGxUj4vGr0j+cFwicwC6ljo1
 6CYtiHsSYOLvMLGx2RrTf9lku2R1s4ip2CESGoMb6+WjRhKQ5jEmYOzk8vPzx/3mjBU9tKJHM
 4eWT0tQVbKBiu5+GHeWSslDeMFhxEG+VrQZK8FArmg9ubdneoczcXzcyyKeD216uSVbRu413Y
 fGufKDXt9DGJdV6VJfeA+RRNX+Is25YqLct3RpYr1nsfZDG/qP1B8xKIw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-99894040-1653425220=:352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Tue, 24 May 2022, Ren=C3=A9 Scharfe wrote:

> Am 24.05.22 um 10:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> >
> > This seems sensible, I thought "why not submit it to upstream",
> > i.e. see:
> > https://github.com/ned14/nedmalloc/blob/master/nedmalloc.c#L1298
> >
> > But that repository was last updated in 2014, I wonder if it's just
> > because nobody's submitted a patch since then, or if it's inactive. Ha=
ve
> > you tried making Njall Douglas (the nedmalloc author) aware of this
> > issue?
> >
>
> https://github.com/ned14/nedmalloc says at the top: "This repository has
> been archived by the owner. It is now read-only.".

Indeed, maintenance of nedmalloc has stopped a few years ago (see e.g.
https://github.com/ned14/nedmalloc/issues/20#issuecomment-343432314).

About five years ago I tried to upgrade us to the latest nedmalloc version
but ran into a performance regression that I was unable to justify the
time to investigate further.

Ciao,
Dscho

--8323328-99894040-1653425220=:352--
