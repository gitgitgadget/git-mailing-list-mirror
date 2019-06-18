Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4F81F462
	for <e@80x24.org>; Tue, 18 Jun 2019 10:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfFRK0A (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 06:26:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:54515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfFRK0A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 06:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560853553;
        bh=BRhXEAAmtUVKzeOszfoSj+hHpA1YpJsJoFQamxSH3Kg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KMKGZhsX1njLM15WuWan6F7UIoeaNbDvCugx05GMhHXPTCG+HcfVFzkaKBmps7VLw
         0clahQB8+yK30gpeWo89ajuVqRUKUC0ahrQWxa5HqEdmwYYL8+lIFshouVRfqg50ff
         Y4UZwK8zSGPxiVuhuqzlTscVMsZmGYqSp8u4Q9Js=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWkZL-1i6cHa1WKh-00XuAN; Tue, 18
 Jun 2019 12:25:53 +0200
Date:   Tue, 18 Jun 2019 12:26:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: js/gcc-8-and-9, was Re: What's cooking in git.git (Jun 2019,
 #04; Fri, 14)
In-Reply-To: <xmqqpnncrnr0.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906181221360.44@tvgsbejvaqbjf.bet>
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1906171940201.44@tvgsbejvaqbjf.bet> <xmqqpnncrnr0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1508008231-1560853567=:44"
X-Provags-ID: V03:K1:Fut3pFFtpXiiu8I6y2IAwKDxMZ+AaMI6sAI9Tq1MugjCOIOVTST
 7caYsNc8QVEMcjfm+WVda6llsSMXjVc3vd1MD9/vNqbUsWG25pBYcEtI1ftJEeamJixWxTp
 GMjN7PS4AhFvTdGri/rsqlXe4BGW570whcm3I3g33W4ZrwwwDsB3pQMu7t6W2aIGsS74gI6
 l/I+MpZXwHMxI85nJD9iA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l33HwGVyfg0=:0JZjk9t5iboVXqJK835B1l
 9VbM+m9RV9i63LIy7yf4sRm5ejmxT7E6p4ZlhSQbWOnnOSr4aGo6pQev2+G5G80Riw2AaiB2R
 Dr7B+r64x3wj3HZr9k/Nl85mFdFw2M6d9ykOhW1KtVvZ9DEHoQ/M9Geo299lh3NeXF6FLWqr4
 ahY/V4ccuaCJEyzNEpbUmm5ItvKbuEEp+dD6XTOotf89PBvfbD8sUFArB8wsL1sTc56cDJu0q
 g5mJOL8itbupsaTXBeEk7XnPHMsUQCM6bnWam4nm6Bj6/Z6a7vxFWDTIJu7+DgOcNO4BFvAhn
 P2mTBKLTDuUKGJ5EyT4hCIkuHI//vDZMw5eM01ECYGng/tJRxAoi/w2TRaiiybOViQjV5/6/k
 kxy1MS9pxiHgPAFP45JkBkc15lAIo/IxfqBI6WllSQCsL1Ye2fnD9nBFS3Hz4XxShpqF082mq
 H5rx5B1NT7UOZ5sbWV7AJJicOVTAOQnzRDecuvGnMZqO7/b6DrLoand/v/f479pXiEGXoJPHU
 WGnj8xYO7j1bxli/QLhWTt3rIsDnvq3D3hHJfUkIDYtldVgKAT6y2/FObq6z5YENbPhPSlniN
 KXwHazGO0BiWIQpkJgYfyI7rMRAFCyO1uZR82Et+FGmkvcOfClV9vBeg5IFwS8LpAtC0aEmQi
 9X2Y+K04b2XtwbJp7A+tDS48urYEBZhhwTtKoA01odmM34MvU088ovffREnjjlS7a6Ay5pQhd
 MbOysDGpMaxjnDJtBDtkPT1n3V6WDXN2LCP5tRC7IgBKdPwYpyRUZLdjcAD+NMcFDr9RO95Ey
 1D8ZO9fgNN34wBiX43cc2ZyJ+8V0aSj2Yok/InrUojHtiF7pcvNrLDC1Cc+U4XCjpMVRoS6NJ
 Bp33kssVJkIngh6yfRqDgmIomBkLyWPSEaPmY5rNgmHtwEZG6lZJmBxrjJQeCnH6U+A6CQmpi
 NDMd9vxv+xpnKa326HlQKQPctmd+cTz8lUo2AzGrxwDx/Z86IKri2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1508008231-1560853567=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 17 Jun 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Fri, 14 Jun 2019, Junio C Hamano wrote:
> >
> >> * js/gcc-8-and-9 (2019-06-13) 4 commits
> >>  - config: avoid calling `labs()` on too-large data type
> >>  - winansi: simplify loading the GetCurrentConsoleFontEx() function
> >>  - kwset: allow building with GCC 8
> >>  - poll (mingw): allow compiling with GCC 8 and DEVELOPER=3D1
> >>
> >>  Code clean-up for new compilers.
> >>
> >>  The 'kwset' one may want to be discussed a bit longer.  Perhaps
> >>  merge the other three earlier to 'next' and then to 'master'
> >>  separately?
> >
> > Or just take the kwset one with an adjusted commit message because it =
may
> > turn out that the kwset update will be blocked for a while because of
> > licensing issues?
>
> Sorry, but I do not understand why you'd want to "take" one that you
> suspect may be blocked for a while.  I'd rather see us unblock the
> other ones that are unproblematic, without taking them hostage,
> which was what I meant.

My apologies for causing confusion.

What I *tried* to suggest is to take my minimal `kwset: allow building
with GCC 8` together with the other three, as it fixes the build. Without
it, the build is not fixed under `DEVELOPER=3D1`, it is still broken.

This would prevent me from upgrading GCC in Git for Windows' SDK to GCC v8
or v9, as that SDK is used to run all the CI builds.

Sure, having this small wrapper around `xmalloc()` would be a less elegant
solution than the alternative (i.e. synchronize our `kwset` with
upstream). But that alternative will take substantially longer to
stabilize, and that would block the GCC upgrade substantially longer.

And I am quite confident that G=C3=A1bor (or is it Szeder?) will be very a=
ble
to rebase their changes on top of that small compile fix.

That's all I meant to say.

Ciao,
Dscho

--8323328-1508008231-1560853567=:44--
