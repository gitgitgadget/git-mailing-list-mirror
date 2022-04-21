Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F36C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 12:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiDUNAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiDUNAP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 09:00:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC802E9E0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650545826;
        bh=xO9yl4yPk6Agx8vOiDimfdnJTaU5EC0BzJA01Xjf3to=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GFM/Q3BBXrwiQCfYSdAzsHl4O52XiuLkH/+ZWBC2wNTiflqG8Ib67UByNNTFRTje+
         8e+mZnPAduB5X5wZNLq5v4aG4Ftqn5rRLHJlYLgrc9xcJHzCsqntuwdVCdyyY7bNKQ
         rPZxHc1A9Cz4YMfz3X3AtR/lNwToziC3+w/x6PjA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.146.35] ([93.245.32.65]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1nbF6H1sHz-00Bre0; Thu, 21
 Apr 2022 14:57:06 +0200
Date:   Thu, 21 Apr 2022 14:57:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: js/ci-github-workflow-markup, was Re: [PATCH v4 30/31] CI: have
 osx-gcc use gcc, not clang
In-Reply-To: <xmqqr15rpp9b.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2204211454500.355@tvgsbejvaqbjf.bet>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <patch-v4-30.31-94abb826627-20220418T132809Z-avarab@gmail.com> <55271bbe-7b6e-7c92-7337-2439a2f5be26@talktalk.net>
 <xmqqh76orx3v.fsf@gitster.g> <52382f7c-5b6a-63b6-2eb2-26c12f31f529@gmail.com> <xmqqr15rpp9b.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-281452686-1650545826=:355"
X-Provags-ID: V03:K1:V8nGQxW9VWORjwfm8OaVPPaKdc4B3ySwBSTXTWNHDVKe8I+s5U+
 P0K8ZRBrlq0FS0kA8LE53fjGSrrw3S/8F5oUNG/2ypGfbKiZW/9aNUdhgTkDRKCUWJOx9Qm
 i71q1ad59Rlf74N1shk+MFAa9xUmiS6enNK/owtinYAymAAHFSlAx0nBPQT+ZXBqrpz1YNI
 pHfIVl/MnkQp8H54USOPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fOav17RrCJA=:wlL/i99TTH42v3s5xrrp6V
 Y6Mc7dzWRDh+MI8p9DdJR2G0IFH3WrS0LcqplwyoAsIoCAwjy4g4KCTKVBSvWlqQf7s77mHW9
 Bnq8yF73MwiKtE4TLUoycWX1XG/GC86Q9RnS9B2KijGhqcLX0Lc8h7M+JT9JgInUCwliPSoX1
 sNhMxcA82yy765Pk+x3kAjAoUQF5aS9coOBwdjH/G8Xfx627h+H6q2D1Kimi3e5cm00vYq2A2
 mVU7pCf2xS1PprRwfvJSjVHFzBqx1OT1dsB+u4XBk2kgT7HMtwhkljDcoKiNTCMOTWAofNBcX
 NeeA4OPq7Q4JJS0KDJXZw4+Qek3Zxw9N1qc5EOC7m7menGYpiA0iGEuX5Otwi9elXo9N6uDW6
 7U/3d7ZsmZRibbIdvQ1r1Nw4J+Ib4PKQWC02qDSZo1JdC1i54PDCtQEbpFub34V+LonHM1QwQ
 ap6MUY9OrYP/8ZaedyUcd+pnkCnfFAFR9ayDFf4DX6/rbzoJpfgZbxzuls+JVuONE3Sq6nNMi
 5QfrBNKFMDGZhcVW1Sc8+VCEZs7PbP8bB/RG8P+F65zzUK6/bSq7qZvD4M8vW2oFw2Ei0x1ky
 pDBe9frbnEupXRHOA0736saoliY9Ohedw2LX8Kc4WE47llQmw22JgV5V2t2s+l7EzWo94F7IX
 gc33ksovfVQvxT9wFGb36mPhY6hOq2KArf9MnxI6DVrh0gDyOtqWCRDFSZZ0u2hZFMWJFYegu
 2BfaPbqIL9WJNKFNZZ7j31CGWFPXT+QIL6E5s2v7UeiMJ1AfRJUiRIf34Mn3gNkmU/VvsubQm
 TUoGACI6aCIvgZttXKxeSYgdH2Uaig8sCb6/7cjhqFQ5D4XXBgx9dJjmKj/0P+emPVJ3HaNGV
 2s561aobhD9iT5taYJa/f9No2CWV2bgAxN37tT+FygcNLktX1l0tCA3o6VnQ4MJArEeVHlYpB
 rfoXnMNFUCN9EnJGUhSjqK+Bbf499DEnvUxfTQcWFajquDPlQwWoihS7Jji2qa2Oa907YZRAJ
 1dQTzk5J/Jm3jC83Yd59CfjfqSOFZMP8qkucJ5eX6kh0ApNGENmtg2u3y50DGzNmeLusl77ex
 VkpRaz/0uqPk3o=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-281452686-1650545826=:355
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 20 Apr 2022, Junio C Hamano wrote:

> OK, Dscho, =C3=86var, does that sound like a workable plan?  See a rerol=
l
> of Dscho's series (which Phillip considers "should be easy enough")
> first, get it solid enough and merge down to 'next', and then see
> the refactoring by =C3=86var on top, hopefully with a minumum churn that
> makes it impossible for people to review?

That works for me. Give me a few more days to catch up and then I will
send a new iteration of my patch series.

Thanks,
Dscho

--8323328-281452686-1650545826=:355--
