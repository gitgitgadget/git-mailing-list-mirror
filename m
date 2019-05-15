Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3641F461
	for <e@80x24.org>; Wed, 15 May 2019 08:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfEOIYj (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 04:24:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:58151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfEOIYi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 04:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557908674;
        bh=MWns0NBlFRO0Tzcns7IMpvmmCQa4/+2ZSv0YKOpn5jk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lj6rQqPc+HHqT1g8YD0TamsjaDEEgv5Ph01yOfmYZaeJZThR66MEnN4i6SZIvikhs
         BkLEeLC/EPRZsIIh1RcFQqTfYds0H879VGUuDufYhH33zBEd2/QE016OnyRPw+Zrkt
         Uj3mLwOd9HKUwiZcfxsSWwrRKwqI6MkVEuq2Oi3g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7pku-1gVRH00bse-00vKtB; Wed, 15
 May 2019 10:24:34 +0200
Date:   Wed, 15 May 2019 10:24:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: js/difftool-no-index, was Re: What's cooking in git.git (May
 2019, #02; Tue, 14)
In-Reply-To: <xmqqef508q0y.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905151015540.44@tvgsbejvaqbjf.bet>
References: <xmqqa7fqbahj.fsf@gitster-ct.c.googlers.com>        <nycvar.QRO.7.76.6.1905141153150.44@tvgsbejvaqbjf.bet> <xmqqef508q0y.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Tun7yNKqvD4YPeWNHD7MSxS8ZhDPazfZYm6WycdywV5kdV296bs
 +NqBmNpc1hLjop9bWyJ/aVGH+iR9qq/aevOytk3vU3LcBXD+3GCKuG+M7RiV5vAN4yIQHhS
 3tmagGjYNmEE6wjeCUhbkSl/bPqcylAg0RTkakHJQFvfLxscVMRBRHnwCuXOCaF79fXDCZy
 PiawpnY4lgU8JCHLIAkGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TZq5NlfdtLg=:QtKzPj+Vr/xz7Gx5Z6S7Hn
 JjuHbBZKIS56Vky7iANIaLybxNFCZN3aSeANa4IhvTVJSRQr1rlqxE7gnvCJZfTNcGu6ShwfF
 6vNtym32n16mikj6gasVrt1aKki/tTxFJB2Gq9gU1ImKxhY1UYVFK/R+A7vTMsTv2dDFeY9up
 exZ849yW0tdy1Et/pNrhaO5iSkGO+WWqZAwm/34WRzJCP4E3XLnwqPAA1pKMQlxgjMgnohsSf
 +9kALXivsq/gxwZC6fqT7W+zXJGeDY5evOKRXD01Z8zWTB7Yb0ELZ+4tQwBdd9ukcdziksGeQ
 ct4OZcAsgFpgfNm4CD+dOWTuwGwVot79MptjcRjiHMGowTPBR34ia8ADCONFX6SmDE7jJkkWR
 pdi7VlO7WWiPATNiBRyGqmFSUVTAMiTx6opaxJkANWYGOvlqJAYmMoVxTd3DxkjdMHQxneXMs
 69kouJCqvUi/6IqgRido1lgBjNtzdKY4bTzvyZxkRsFHGWwAfUl+H07JLLSaZiOs+uoqVsJK7
 IbiMY1eX/H0cKlAHajkQ7a1yomW0cJlFR5CWpbvLaGgHeProw5+RwBLl8TwWr2TeyEYL+BOJy
 hpWOf1HR23CHvAlw0Hkn7lQ2P4wVwEPV4UKfMKw0YXnfBAGC36bSshRbd7kHco2pmqW3Xoq/+
 rzv71ucEHA/3IfW8RGNzAqXkk8YP6TlMGoNJfxw3mvX9PA+JV4cxqfcv5PSVHCHyRBByUI+sr
 K5TTqjQ7bR4GAR/oMUtAWrpYJ722C5wnojsj+zYYJ9yZXqRK0Eje17pVBR6n+j3Z7XsqPQWge
 Ql4ylp/bje7vWNwZzg8ejdjWxvYETbUF14ThXyCKEpgah1RsvK3D993xGUiuL4G0fuEVLCktf
 a+uKV1k6h1YTXYESge0FnMaey7UilfOrOHZffb/9yEjtXACW8iFUJJyG+ZK7xGdEfkNQhQRNi
 jeQhwz5SmYA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 15 May 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 14 May 2019, Junio C Hamano wrote:
> >
> >> * js/difftool-no-index (2019-05-09) 1 commit
> >>  - difftool --no-index: error out on --dir-diff (and don't crash)
> >>
> >>  The "--dir-diff" mode of "git difftool" is not useful in "--no-index=
"
> >>  mode; they are now explicitly marked as mutually incompatible.
> >>
> >>  Will merge to 'next'.
> >
> > Seeing as the following is a part of v2.22.0-rc0's release notes:
> >
> > 	 * "git difftool" can now run outside a repository.
> >
> > maybe we could get this to `master` instead of `next`?
>
> There is no 'instead of'.  Topics advance one step at a time.

Well, some topics seem to enter `next` via `master`...

> I do not recall seeing you respond to my review comments on the
> "error out" patch <xmqqv9ykdr1w.fsf@gitster-ct.c.googlers.com>, but
> thinking about it further, assuming that my rephrasing of your
> justification in my review was correct, I wonder if it is even more
> correct if we do not error out but simply behave as if "--dir-diff"
> option were not given.

I misunderstood that to be a rhetoric question, like in the "thinking out
loud" you favor. Sorry.

> That is, if there were some way to distinguish tracked and untracked
> paths in --no-index mode, --dir-diff would copy only the tracked parts
> to temporary directories and run tree comparison.  Since there is no
> "untracked paths" by definition in --no-index mode, we do not even
> have to make copies but just compare the two directories given using
> the same tree comparison tool.

As far as `--no-index` is concerned, all files are untracked anyway. There
is no index, so there are no staged/committed/tracked files.

> Wouldn't that be more useful behaviour than telling the end users to
> run the backend tree comparison tool themselves?

I am lost. What behavior are you talking about? I *think* you mean to say
that the `--dir-diff` mode under `--no-index` should essentially do what
`--no-dir-diff` does? I think that's not the way I want to go. The
`--dir-diff` mode only makes sense when there is a mix of
tracked/untracked files, which simply is not the case for `--no-index`.
And we should not make it "fall back" to its opposite. The user asked for
`--dir-diff` and it just does not make sense.

In any case, the patch series I'd like to see advanced to `master` is not
about supporting or not supporting `--dir-diff` with `--no-index`, but
about preventing a segmentation fault when a user calls the (non-sense)
combination of `--no-index` and `--dir-diff`.

Ciao,
Dscho
