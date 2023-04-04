Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F0EC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 20:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjDDUUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjDDUUX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 16:20:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D108730DC
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680639617; i=johannes.schindelin@gmx.de;
        bh=JdR6wsghP+Gcju9hdjh81xZ9Q3Z3QDIjCX6jVv6xx7A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=sOPktliQDyZ08sHafcimMk8f6DdYX7y79C+6YLhbzGqcp069cFpUqnZJ2c/Zfnk/2
         FdvO/MioSsMk1RpsbD83K/ZUhLGm+gp1lI9CzsGrkSSgPa7G6zzdR1tiNIFa8GLSiu
         dy4Q3eH16Dxx4OTKQh5mgLyOdJ+P6FV0kFs/lq3Ac876CiOoj8rugNQW0hOmYYT8SS
         mmpYGbrSGZ2vDhQJCZjUUCRePr7Gi7K8vohwoYko3YuHEbb01DX2lyd0OpNUjm1D3A
         QNLvCg4cLAbZRg25oA6BWlXDkYbGRT7x1hXflOmQNgfBgvlxexFzya8oFDq2lfM1NS
         WujlOIXUOWiVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOREc-1q382x0vxm-00PwK8; Tue, 04
 Apr 2023 22:20:17 +0200
Date:   Tue, 4 Apr 2023 22:20:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
cc:     git@vger.kernel.org
Subject: Re: range-diff: slight usability problem with mistyped ref
In-Reply-To: <de43cd37-bfa5-4dbc-84d5-9362e9af6a9a@app.fastmail.com>
Message-ID: <b8e9b054-4cd5-9c65-a397-088143d2fdc4@gmx.de>
References: <b93934a2-91e7-4645-9a24-4f2354172f31@app.fastmail.com> <818b3ad0-df43-3484-8c19-d95026f6b2b1@gmx.de> <de43cd37-bfa5-4dbc-84d5-9362e9af6a9a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1941335813-1680639617=:26978"
X-Provags-ID: V03:K1:+KxNSY2Ku3w3hdSZl8dzq5pBYgDZwA1n3LLcB5f4LiJlqJ6Qy17
 JFEFvKx1c/OfwQ9ICa7jaqfc93cBT1PTPSo5tfyFqaQLCIIfz7hMJBpT6ofKZgpkW5xACPF
 6Ho2ElcverRHT7L6bPwRJlmpfXQ77EFwb2VwkQ+neAtKZ33tHUZ7Wjd8+GYHb+TVLMKpwvQ
 VzeMBOs6txWvg+/QZsJNw==
UI-OutboundReport: notjunk:1;M01:P0:W7ypiWUeK4E=;3ZjVOKbEYswVN2CdddF7wkhwv1k
 gtGjDqMMqy7mFMq1Lcj4zLEidQom2TTS/CRpGKf53IqOBM6FHyT5Ex9EPhchzI6Dxha3p/BJY
 J7t7YMaC1DiSzPNdWIhrJ5eA8olC8MxnkjmsDQB4RZZoN8MvfgnGzJxgTRVdkOP1TtP5tsGUH
 nBSg9RvlT1gZkD4ttP0m/nKL93/so/sQN+vaIkc0Z2FdSxJF6lVtmJkgeS1hq+77s/VdUu8Rz
 269qBr/nxfTLASrFe0UgaIdMtWn2hVWOOcBuUONeU/l19VS5qvMyNFKYcsUMzfD28PEo+lMtF
 pPAFUBpFxhjtK8/T2N21szF/xD1KyaBzygCCWaIw4tK5p58aOPNmiCgDfBRsIj0eihxyY9nMw
 JtfQssfHIWtKcCO30HzMe9wpNSh3oqBmzxLWc1XTunfQGj9pUTWYim7A4bp4ykJ2/b3u7Q4/S
 swp3vy0YiZzS18+wHKsPAKSYD0x8fr14qbeUzAl8w0gxutsbmw93q9aDmJ1gGZwIMV5hRODIV
 JHNALudy5S78RuBc2FoRBt8QEj2NsSyMxIbLqnC/uDI1YVAdGuO6SjbBAkpaWAwfoZodaEVqf
 ShEUxEgb9y+vEKe0P43Sx/+z0C+FZvxDP+/pImRleVAjvCzXefJeeHEStozFfls8unzvX4AOW
 y9IYTCVxTSuGG3TpBarJot33oR3+fuKF/dH1vworweL9GxPG7dF+lYV35h2igoXM9tuwvvIXi
 EFb8Vvl9KTqKZnGQ+WoRvOVE21FK2fKsdOi+jZgMDTWBquNG0eYLORObTW+DREkIuILw8MfnH
 Ghot9qnB2lzsLw3xcdCcdR5nWTnGZ50gyV41dryl5XnwOu/We7ZqFFYcxkwF4fa4wf4AirrjY
 NvAfSm9YuI40KvWd0KVC+xZLhi6xzZiOllZxfAhOOVK2Qz9n/iaCVrHM29wJ059wpuppyIXTn
 oTt29w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1941335813-1680639617=:26978
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

On Mon, 3 Apr 2023, Kristoffer Haugsbakk wrote:

> On Tue, Mar 28, 2023, at 13:37, Johannes Schindelin wrote:
> > So even making the exact error message depend on the number of
> > arguments could result in misleading error message.
>
> Yeah, I see. It seems that the variadic nature of the command makes it
> difficult to guess what the user might have meant in all cases.
>
> > Do you have any splendid idea how to phrase the error message (or
> > adapt it to the concrete invocation)?
>
> No. I was going to look more closely at that if-else chain, but given
> the fact that I don=E2=80=99t know C and all the cases that would need t=
o be
> covered (=E2=80=9Cwhat if the third argument happens to match both a ref=
 and a
> file?=E2=80=9D) I wouldn=E2=80=99t get anywhere.

Knowledge of C is not required to come up with an error message ;-)

The forms in which `git range-diff` can be called are:

	git range-diff A...B [[--] <path>...]
	git range-diff A..B C..D [[--] <path>...]
	git range-diff A B C [[--] <path>...]

In general, I find it hard to guess which form was meant when a typo
causes an error message. For example, `git range-diff A..B C` might have
been intended to be the three-rev form `A B C`, but it could also have
been intended to pass two commit ranges `A..B HEAD..C`.

As such, I wonder whether we can just cleverly _avoid_ saying _which_ form
we suspect the user to have intended.

In other words, instead of

	need two commit ranges

we could say:

	`range-diff` needs three revs, two ranges or a symmetric range

Since this does not require any C expertise, it would probably be a good
idea to let C experts work on other patches, patches that do require their
expertise: The patch to improve the error message does not require any
knowledge of the C language at all.

Ciao,
Johannes

--8323328-1941335813-1680639617=:26978--
