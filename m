Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E4CC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF4E610F9
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbhIBOJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 10:09:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:36907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345447AbhIBOJL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 10:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630591688;
        bh=sjVwAktkIfOasz9R3TZUoJYH1rxI6IXrEvytMhdK9O0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Lj1tpuIV8gGeJRHjeKpYHGubRf5meuixf9uXHXzgC+2MY/sq5NWWea5geOvp5r5I6
         2jnTyMbGk3UaC1jTyc3Hy/1kgtK2sVSycLVy4Ag+FoWdOChkzfSt+nuMzaprFKSALC
         4nIwR9vg0Gq8dhtbNh6PTe2RzxMmAwOq0vvxQINA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1mEgO61pl0-00AYid; Thu, 02
 Sep 2021 16:08:08 +0200
Date:   Thu, 2 Sep 2021 16:08:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 6/7] git-svn: drop support for `--preserve-merges`
In-Reply-To: <87zgswv34e.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109021607110.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <a987e9439af6335e15a3d41b82832e9a8824317b.1630497435.git.gitgitgadget@gmail.com> <87zgswv34e.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1240559053-1630591698=:55"
X-Provags-ID: V03:K1:9yTapXQfBPzSj8i0zWNXkwejBTYAgDF6fH5UvxhKt/MVgpUMRhm
 gOWBbN4/XNKfMKksmdBGCrRFFm4yUeyLeQLFI4z1BTpMxN2Se/H+2UNES3mbHmFO3iWjHCJ
 5E9ERa3/YN8ReOTVDXa8zuFaNaYl0vBpqc6Q65eME1E985gS6kNPdle3clKMOK7x67hVrzu
 La4XW0Kk+QwMLvL0VB58w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F48M3h7kahU=:gHMAM1S0St6QcWUGicHoO1
 zqgLAC/7ZKcjtjWi+6X/YzZVeWkZEYGhqcanj29E80ywBBEDJ5Egq7CIAT88TL0uF3K+VIktd
 Brk8QNC0xWMMCiqovWIEH0ob2CrBktW07MVDNvQbBuW/VZv3xB57BeuVf1Cw/MnrUtIFtUqEt
 ZoIr6bz1QamMQSrNFo2YHi0iSjJjLOmbK5z0Fh8SfUfGChCnLimUERgvbACeFz/3svyO9hT8r
 5u7tzpzDLnCxxu3+EsLMHD7Uft8yuJwUJp1muhBmPmlYfh6kuPEBcNXPqFji1Nhwgc5ZFJHAj
 +aK3B9mPuC7tGavnZ35osDn/JiCtAL3YbeVPZHe/8jfiZZay4Dmn6XOhRXQIFfrxovMEcsGuN
 jVwcU7hYGJEdfv9+0YuWhx4z/xDrGAnF8tHJ58PBnPvwgBtRXuiRb6SGIhiGj9bOIxc+SUjhT
 4pTiPXNmlEehH5wRn4xlqJOK7Sv3FS9n9564NKIErlKTHVH0N4Q66mResEwOoVPfYjSw5GYrc
 d/wz014sNV2nwq+5cPv0+N4/I4NfRo1mpUTCPcBDi+2EYBjFmED588LfjaIvWihYsIkY9/Bsg
 72HIHbkL9zT4bxGGs1n83+Y0zjxUW77RHJrbJx14Pu4sQza+IW9URApOMdkWDfJ55aRFZ8t4x
 qqvNfv4nTK02qa9bZcN4fmBBXCWQ1EiroU2jzXDMcvNwiD8r/M3fyzjhmGgrkBH3fd09YRDfk
 nBnL3clD+5dnHV6ko+dY+C2H8UyShszEfUyIh/b4smthK801SuZyjW4rkzC11oJw5UKWvMQ+c
 iP5goYjA5vlfgu0J9RfNrk5V5DVZVYb4bYY5Gdi9EROAcw4cXL4baAgJ4qIiaJMAQbLQ+bBWR
 tOtxLK5BVpRj0TdyTmKRdpy/N1Sr2GiBYjCPNNsKM+2eKNtxHmq2N+N2YXKQQnbsqlVfVcbL8
 XDyFkuMsYiUZ1WWmTuZk4NROZbcvsll9jS5jwnzbSidKAp+rNUTRsPi0D6FaE4yyYONKNjoEc
 oPXyXj1t79bJg9otpzRpUp06PxsjoCDF27DvvL6x1/zzFf79XnUhxUYK/SKb+RybfoTembP0U
 2AwuQ92OJ7zrTH0FXzoIwEXerzcJO6fcJmwLiRNcDPDZubT3f5FT6xhuQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1240559053-1630591698=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 1 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > We already passed the `--rebase-merges` option to `git rebase` instead=
,
> > now we make this move permanent.
>
> Unlike the cover letter's claim of deprecated since v2.22, this in
> particular has only been deprecated since v2.25, i.e. your follow-up
> ea8b7be1476 (git svn: stop using `rebase --preserve-merges`,
> 2019-11-22).
>
> I think it's fine to do this, but at least updating the commit message
> to note the difference would be good.

Thank you for being super rigorous.

Ciao,
Dscho

--8323328-1240559053-1630591698=:55--
