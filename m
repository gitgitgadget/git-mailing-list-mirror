Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3844CC76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 10:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjC0KiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 06:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjC0KiD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 06:38:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDC14C2F
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679913455; i=johannes.schindelin@gmx.de;
        bh=/bwYO8bvUDHc8lXp5Hk7XcqI4CZ6eQJqjE+rvhm0VjU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=I4ea5oZDfLsMOMFOozMVYyJ02F87Q3CxcdRxxCqALk23/aQv2bw12KkNBi7Y7R8kT
         4fleaezoCrzfT+Utsz+q4U+51Rg5Ak/YtPeen3OS/onFiZOk2L/MMahklhn2RQECL8
         EQtgBS8J47wk3xtRsaQlPfMGO6CnlsQJHTSvu/kZJFAoumVksS5rJF1qqmJW+lTXFe
         1++rm/N0P2PfoHx388o+dPEP82rOq4RFGmS0Ts9IQoOaMAxEMsZhVU/vWM82g809ZP
         yEVsBoUOmRlHSL+nhYHXnKgF74CNH6Eozb+Tqt/gO3vSXEu/zj5DjARgnOpZ6lwovo
         sdv/W17LwpxeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1qNm5L1taG-00h8US; Mon, 27
 Mar 2023 12:37:35 +0200
Date:   Mon, 27 Mar 2023 12:37:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: win-test: unknown terminal "xterm-256color", was Re: [RFC PATCH 6/6]
 ls-tree: introduce '--pattern' option
In-Reply-To: <xmqqtu20qinx.fsf@gitster.g>
Message-ID: <d566eb68-6476-a193-2acb-10106a154d3d@gmx.de>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>        <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>        <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr> <xmqqtu20qinx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CWlb3S957ILeniA5gBnEswsomyBvJiTbPXrr9YvD/2G1C22L5PB
 gRnsLdaDeLUPvFrfHFAqwx2QDg5O1Sm7SxG8Gtgp7o7WGswjzL45W3KAWZkRoLvsOsA4RN5
 fHSN+1SvD0dOEehxQ7TMKp+fEiQi9ypg76ZzBiPGfwUT6da9gSv38x94OBuWz+GZzbNEmxK
 GrNzFLdAAeqvIy4qMutYA==
UI-OutboundReport: notjunk:1;M01:P0:IacNTCX1pcY=;egVhF3uHCTRi77lp8RJwb7aP+Lb
 PllAQysyrKC0EN2IFQPSMgRZg4HYrmKtjwlMdMGZBir2eJlnndbdAsTAK0YC/MPJ60zwZI1nc
 nQG+tWxhh6v5sGloeLbRrtWNK+EeWWWuBsJuQxUHwNNrGmKAHEzT/Nu7uUhx1/bCDmVepzRCb
 q+qB89ZjW+9tpJ9M4oLGjBi1Jf6qy3x6sKpv1EVys7kQ+fZSELarTz17DADBWb2oo1HU4EAkF
 vocHB0mcoWU1vlg9Uxmmpi01Htyc2ixzkpLnPQNRCsMq6nwCekaf7Y9eEmNlA52WkZfykzupv
 9yol43nnhfnUL0vniaA0XzKYSb9SpkuHLESrr4ZL/fxQaZ2fekWsed4vTBrlAh4Rj+mIKR9T2
 eJkqMa7VHA3gihSRwKhH3z7HUSIZwkvKsvPiXxOjXc5GCCuFhq56h4r8iaLhYpWi+0znV8I40
 /x2xsvJ3rSgfX+sdC9QcmXcs2JyA8mzvL65lBnIELZJSo6lCRJlBZFIz2tLZOIZ/3ir+9Y8ZH
 cum2AsEs3YEGjiYcYWi7xgiHzlV9C9dHnDthkPMmihhzwB3CygYKFAJFJ4Z9c5CGXy/R7UmEl
 aFAfjO4BPbjXU/96NEYuLj5IxzWZJLdxQb1Jr/Kb82HeVpmFxEANgzFq1UpJDs3GwaWw+pIwo
 AN2d6doLwDjjesNJm1qlCo0ab/asGtBwngMUroJSQQOPd9ohbcqesk7XjEZkQBqVW4XS4qiOk
 72H8bvy5Ta/Lgm9F0CSrfDbzHIdDavbwsrcA14JR5eaDYyCYoNuWJ7CXzLDFvxr8ci6A7QPqD
 KerIh7yl1h0kOnEAZZ6FkX3Awy5nIzwG2DvGYg8eeAPU4wgeHXwmEM5x5VhIZIe4fjUnaGGML
 0DKcrF2Tnfl+xM9nu5aGJX+gpIVggxrfCZRxQjq+YFZvADIMhw7vsNsreE4i52Tffp8ka3kTq
 ybixzemZyd4aeLkwyuwdpGA51II=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Tue, 13 Dec 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > The hard-coded object IDs break the `linux-sha256` job, as pointed out=
 in
> > https://github.com/git/git/blob/6ab7651d8669/whats-cooking.txt#L522-L5=
37.
> >
> > Please squash this in to address this (Junio, please feel free to
> > cherry-pick this on top of `tl/ls-tree--pattern` to reduce the number =
of
> > CI failures):
>
> These days, I gather topics with known CI breakages near the tip of
> 'seen', and push out only the good bottom half of 'seen' until such
> a topic gets rerolled, at which time it gets added back to the set
> of topics pushed out on 'seen' again (and then ejected if it CI
> breaks).  I excluded the part with the topic from last night's
> pushout.
>
> By the way do you know anything about xterm-256color error in win
> test(6)?
>
> https://github.com/git/git/actions/runs/3676139624/jobs/6216575838#step:=
5:196

Unfortunately by the time I got back to this mail, the log had expired.
Here is a link to the same symptom in a newer build:

https://github.com/git/git/actions/runs/4523517641/jobs/7966768829#step:6:=
63

> I do not think we hard-code any specific terminal name (other than
> dumb and possibly vt100) in our tests or binaries, so it may be
> coming from the CI runner environment---some parts incorrectly think
> xterm-256color is available there while there is no support for the
> particular terminal?

The TERM is hard-coded in the MSYS2 runtime:
https://github.com/git-for-windows/msys2-runtime/commit/bd627864ab4189984c=
db0892c00f91e39c4e8243

Note: The MSYS2 runtime merely wants to ensure that `TERM` is set; If it
already has a value, that value remains unchanged.

And to save on bandwidth/time (in a desperate attempt to counter the
ever-growing runtimes of Git's CI builds), I liberally exclude files from
the "minimal subset of Git for Windows' SDK", e.g. `/usr/lib/terminfo/`
and `/usr/share/terminfo/`. That's why `tput` cannot figure out what to do
with this `TERM` value.

If these `tput` errors become too much of a sore in your eye, I see two
ways forward:

- Set `TERM=3Ddumb` for the Windows jobs

- Use a simple shim like this one in `ci/` (and maybe even in
  `t/test-lib.sh`):

  tput() {
  	printf '\e[%sm%s'"$(test sgr0 !=3D $1 || echo '\x0f')" "$( \
		case $1 in
		bold) echo 1;;
		dim) echo 2;;
		rev) echo 7;;
		setaf) echo 3$2;;
		setab) echo 4$2;;
		esac \
	)"
  }

Personally, I do not really want to work on this, not before much bigger
fish are fed first. For example, the friction regarding the CI build times
is becoming quite crushing.

Ciao,
Johannes
