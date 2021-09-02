Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608C4C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4417A60249
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345444AbhIBORB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 10:17:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:58279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235635AbhIBORA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 10:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630592158;
        bh=htdrMSLVonfhtM6/lqxjDsaU3I/IbpUh2RzgZHfwEOc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JF3dn5i3A81G0V/fUIVpXq/LO+LfzrHlx4+kWJ/NIQ44u947dZu6AC2HQLqhWG83z
         OVlurjKTo9XolqhyB/8DhJjkETzNRcWvmkzFunfm4RNmq1dXWJbIkrC5aE1EjqLXif
         qiGNtOAFb9/ZZUDjeuPaRY9H/e5DPppXd6NCnAvo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1mS4O90I4t-00WmQH; Thu, 02
 Sep 2021 16:15:58 +0200
Date:   Thu, 2 Sep 2021 16:16:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
In-Reply-To: <87r1e8v26x.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109021609220.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <87r1e8v26x.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-810489069-1630592168=:55"
X-Provags-ID: V03:K1:5SNCgsm491Za3i1OasgFMzSM7o+S7fZXf0NCeJ5B68aofpn8WwE
 mnt69D1DPDOOnJvz21EEDRTDzZNfCycxqjnlY7S1/VeD3sxXGPAUu2hmKSdVnX2PRPXin8u
 oaaemY6qyFShJeK7IS9ibjF5P378ovEP1W1kqwo0ESoAdbjU6CotmrUFLHSG5SSwfDj8Y/O
 WM2rFj9e5lwgWUNU3LEzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dPEeaNM/2AU=:eNkUmVeqQHSy3qf5S8XyHu
 YaoAzKl9ktnmdPtcgHkz4aX5fgAea3aoExWD5cqih6d0P8m7CjtToW0QEsnYQKHfU9krb3Yth
 //kveOBERLiaOUt5cr17cTLr/VdEKoxViUjc6K50rohx+dOIoaIwrOwRbw9Tp8F6Li4pYy1+W
 az1p0YHHLZXLENAkL3tWza09zu0l37dB0H1HWsCX6CmvNFvOKbpcqHXElu82O0WIC9hOE0dsH
 dZoSfGMPCWXSzYouaHZKXn4odYm+eFKpjREcD1wZys2bx1m7EY4gLFp3AJfz+jDQB7HoKP9h1
 2raMKnjTpuOCqxlWUY/LgMugBGLNapRjg3Bo/Pm5XNUzO4NjwAz6B/TSllll9CdVHaSflTeMD
 OKqi/stAvvGK14xoVjlJgiOUwDkP4s+nDYQTxkvRrb8pmC3ceU9CVdFRFEuuNKnUZuY9obpU+
 n+HmS4dBhcAnZpExjupHK7mvN+dhqOdop6QjeSN+3Z0MSwCCHK0/82U/wu0cFTBC4R02UsKYs
 a03iBIyB1b8i3V5DnJKcc8NoTxgqxzqj1B76QUUn7yJA+XKNR2p5Xp/FLJPHlzy0MXcNHeeSr
 zVqNCniHjzCg1RvY/jUHf6bRqvRWary6yrIK6SWGKZKyzALBsY+WKUP1R/GdK4XaryX0PFajQ
 UawhodOcsrLuLK1XeFBZyc1KNhFhfW3PRDTiTzvOkhLusWmuFDao48Jw67Y7kjbWuQpyp6Db6
 EpJ32rhdG49Ss35iG9NHptdoCywq3viO8ecaEXs79AVMWpz7YuKQeOA7GYWbcC32IUXTy0kOT
 UrqOBRgA0Rayqh0pyA6XuFr/uNG/5MqXeJEsiGttI5q7sI/RbDIP0UitiezBpipR/2d4gEAPV
 j+qhgCHzEMbhTeT/00ZAEMzTCh2ArdsmxqHDNSn5QdD36ITq6Puq6QYmsHB+L0zCs52RTGAS0
 6Rj7uv9hoO8md71LW+RR/eg6zaYn7GVeBN7KXwZ5lBuhzonAOEJ51DLxy4V2vqIIVcJz4uhiU
 K1U0X5ITOyorC1FdJlSCOSr16ka7x9xEAPkxSTAt/NjpF5ZlBrJByJcxFSYpft0rpKxZhsf0r
 4eHrZMIp4blCVRh5taopkaR6YD3lT+qq15bMoziuhvoFA9IqEOoK1z3oQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-810489069-1630592168=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 1 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (whic=
h was
> > included in v2.22.0), we officially deprecated the --preserve-merges
> > backend. Over two years later, it is time to drop that backend, and he=
re is
> > a patch series that does just that.
> >
> > Changes since v1:
> >
> >  * Rebased onto v2.33.0
>
> I'm very much in favor if this series.
>
> I independently came up with pretty much the same at the beginning of
> last month before finding your v1 in the list archive. The comments I
> left inline are based on the diff between our two versions, i.e. I found
> some spots you missed (and your version has spots I missed).
>
> You're also leaving behind a comment in builtin/rebase.c referring to
> PRESERVE_MERGES. Perhaps we should just turn that into an "else if"
> while we're at it (the "ignore-space-change" argument won't need
> wrapping anymore then):
>
> builtin/rebase.c-       } else {
> builtin/rebase.c:               /* REBASE_MERGE and PRESERVE_MERGES */
> builtin/rebase.c-               if (ignore_whitespace) {
> builtin/rebase.c-                       string_list_append(&strategy_opt=
ions,
> builtin/rebase.c-                                          "ignore-space=
-change");
> builtin/rebase.c-               }
> builtin/rebase.c-       }

While it would be technically correct to turn this into an `else if`, by
all other standards it would be incorrect. As I commented on your earlier
comment: just because it uses less lines does not make the intention
clearer. In this instance, I am actually quite certain that it dilutes the
intention. The `if (options.type =3D=3D REBASE_APPLY)` clearly indicates a
top-level decision on the rebase backend, and an `else if
(ignore_whitespace)` would disrupt that idea to be about distinguishing
between completely unrelated concerns.

In other words: while I accept that your taste would prefer the suggested
change, my taste prefers the opposite, and since I am the owner of this
patch series contribution, I go with my taste.

> I do find the left-behind "enum rebase_type" rather unpleasant, i.e. we
> have a REBASE_UNSPECIFIED during the initial parse_options() phase, and
> after that just REBASE_{APPLY,MERGE}, but some of those codepaths use
> switch(), some just check on or the other, and it's not immediately
> obvious where we are in the control flow. Ideally we'd take care of
> parsing out the option(s) early, and could just have an "int
> rebase_apply" in the struct to clearly indicate the rarer cases where we
> take the REBASE_APPLY path.

Thank you for offering your opinion.

This encourages me to offer my (differing) opinion to keep the `enum
rebase_type` to clarify that we have multiple rebase backends, and even
leave Git's source code open to future contributions of other rebase
backends.

Ciao,
Dscho

--8323328-810489069-1630592168=:55--
