Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E0FC433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 12:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380137AbiEMMHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 08:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380126AbiEMMHO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 08:07:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0628694BD
        for <git@vger.kernel.org>; Fri, 13 May 2022 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652443618;
        bh=rrE40TKWqmZ+0tfDLWibSh2m6XeIMhiSlFCGhG0K07w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=howXqZvIv68dgmkneG/Zh1fShOohPLVxrtvZ3GnRVmUyjCA9JZte/xaMxp1FiqudN
         ZG3kEr+HbYGYEIoxTNiHdf9XwbVVQFxVsiFPVCi+d6QGRacw/NkWWIIFpHtj8yOX9U
         DwqKW1BM8PtVa7R5/IBTZNAwsRc+LE1aTlqevuIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.215.85]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQv8x-1nS42P0kuF-00NzB3; Fri, 13
 May 2022 14:06:58 +0200
Date:   Fri, 13 May 2022 14:06:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/scalar-diagnose, was Re: What's cooking in git.git (May 2022,
 #04; Thu, 12)
In-Reply-To: <xmqqilqacmmd.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205131404280.352@tvgsbejvaqbjf.bet>
References: <xmqqilqacmmd.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-660998962-1652443618=:352"
X-Provags-ID: V03:K1:n01/EHPNWZgUwIzLZpT3l7b3GzIbUbgyN4FdUPBR5qehzE4Ft/u
 nlWOaTijMfRmfXmvH1bP9Kb29NhQWupQdIDv+bQik2LDAXekNN1KMi0d/LyZDFkZNemkarg
 k0ptLHtC0xHJvOI5S70Duof3nkB1qCRmwVvS6UBQsZ8C2+PEuguf26G5Uvoq5q8tU/c1SIT
 k1lHiBjuAFRtZaASAnjAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9CmWnr1Pwb4=:/rrj97KYOz70Xzc8C8YRao
 1Jw6S1/vkTbsUt3TnYCpA13BvHnfF9iu/h/0/SQLkqZbCnNFcHJaxBrGd8n8sjr7nkXKPVUpx
 mHvmS/lcSJSS+c2YNIBdj2mLwawPUWlPMmXUkdSc4cMartkDkr2Zl01XQbz8uDkXVMi7b5n2H
 tEK6X3TlMtoTDFoS53fozN0tHubXWDu2wVujR5MNN/P2k1WNXh2CEQTb+hq3lpORjDeAWUK3k
 bZj+97EOhsIFx1eU7M4pawzoxxJMy2hjJLE+2Ri/vycjI0JYXtbp6drRh6URR1oKAsjnWMSD3
 vDNrO1loQNlevnIPk/0GzVrkOIN4ElsWxuZCnOWXHKGHfCZkdzImamPXKEZ0h28kTt5Xda3zY
 W2Fjb1eFjtG1uLSONRJS4egbDTpwM1Ifz+bxNpPscSx3bTuD75ArmAeycL36WQS3lTZj3QQH7
 1aAsNRrYz/gK/fZsV5zXD8cT1ZvjJaLuUa0ADUlZGuO/pmvGgWlY35Ks/dpn/cTCx98DggTRo
 1ql4+ALTHixVCVvHDvRXe8vv3Dmm1YQ0IeY5GV9UBY419jvfiJ3/0XCrvqtAlzRzs8OGOhDAU
 TlWWzMHdB7jCqiNQMjJAlLhe9p0HQNwZ0AMyhJtUbHeHRPMgfej5FkenSVYONA7Rqmtrq/evs
 BFnSI+hhiR8FKS6NiM4zvWQ9Rwg/MEGPZijHoC3B1vA198TrjY2oRe/ULxbX/KtYRbg3eYKj4
 v0/JrivnzNdxS7attxuBnjOk3PxuzAfBsJjjlVgVGmJ72VpLPjWVYPaYkWpB9wUPOSkYcpIRR
 51lFWvDkri0eMn4lLMFeyVdEMD/oeqGM5BtPkXZZdMNyhEkUeId52JRkAKbUBRsM5Zv501tnF
 uVFjeHUAn3HI1ovT21hSDnOXhB7GB0rEELecT6vaC+B3uF82PHbMDunPSyGzhhzF3VVLX2sj6
 fcH6k/wJQJwROGqjJpW3mPRMI/7YxBYv+suMhofot9Fl4TbDTKQbignRy9M27BFzxJXg67dWE
 qhfD5cmkPDbA3Q5jUa/YxqCt01IQNwmA6nXgjvv7zh/oLbCH3zMpGEghBDMYb/S4v9DX6GQQV
 zeJGxntRrYyyIE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-660998962-1652443618=:352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 12 May 2022, Junio C Hamano wrote:

> * js/scalar-diagnose (2022-05-12) 8 commits
>  - fixup: archive: optionally add "virtual" files
>  - scalar: teach `diagnose` to gather loose objects information
>  - scalar: teach `diagnose` to gather packfile info
>  - scalar diagnose: include disk space information
>  - scalar: implement `scalar diagnose`
>  - scalar: validate the optional enlistment argument
>  - archive --add-file-with-contents: allow paths containing colons
>  - archive: optionally add "virtual" files
>
>  Implementation of "scalar diagnose" subcommand.
>
>  Will merge to 'next' after squashing the fix in?
>  source: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>

Yes, please!

My first reaction was: but wait, what about the file mode? Then I
remembered that Ren=C3=A9 offered the opinion that we could easily introdu=
ce
`--add-executable-file-with-contents` _iff_ we need that at some stage,
and when I considered symbolic links, I noticed that the `--add-file`
option does not accept those in the first place, so it would be funny if
`--add-file-with-contents` supported symbolic links.

Thanks,
Dscho

--8323328-660998962-1652443618=:352--
