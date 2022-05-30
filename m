Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA88C433F5
	for <git@archiver.kernel.org>; Mon, 30 May 2022 10:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiE3KNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 06:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiE3KNC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 06:13:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50C33ED07
        for <git@vger.kernel.org>; Mon, 30 May 2022 03:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653905567;
        bh=wwlpHdDZNjCStor40Y9Z7Jruj052wChk5si6Oi+1SBg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PVDLC9RzkX+ypgsUr1R0kH089qUWDRuwq7LizrfOEIKOrYqKLZivRfDITJGh5266N
         f4Q9ZxTOh6q+YDIqoUi9J3Uj4ugPbt5PwIr0+7aVc+IVgXnZuLiq/lOhMBGO5bCmK3
         xnd9vPmIg557MX7Zrp3lfIN9CzmlUTYbogqWP8Pk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([89.1.212.145]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1nRWlo2X59-00nTcD; Mon, 30
 May 2022 12:12:47 +0200
Date:   Mon, 30 May 2022 12:12:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v6+ 0/7] js/scalar-diagnose rebased 
In-Reply-To: <20220528231118.3504387-1-gitster@pobox.com>
Message-ID: <nycvar.QRO.7.76.6.2205301205450.349@tvgsbejvaqbjf.bet>
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com> <20220528231118.3504387-1-gitster@pobox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-392597489-1653905570=:349"
X-Provags-ID: V03:K1:+hBJl9IeNc3t1gwbweTDysyy7OO6Ng6hwObv7qWLH2CwcwV9imC
 7eiB75cXazzmIGNjF9ONfZ7ucXfSJYPmGOb0tUiU1oJ6Jtf71pjDSrAadswt5b17jguIBK3
 V591pJXFNS1TyT4E+sXR7mteNOlr5w5H3M7H6DXvZ0BFdUcTeZmdywvCZnMJ97MO2LEuIEA
 p1VQM0yTtUSb4U0iJjkAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lMXGUvEM+cU=:T/B9T8MfyMoDLGudJB+0Yo
 MfGnFVNDhAXcQ8prGQeBf8DwZ5T4RqySupeRewXJGdO9nUyj2/2vMSgOHiIyNsjvlyKjQnCbx
 ZivuaRGlCWWzSm/asTRtVnd4mbs7FgDFTHVE8d29amlWnXDvCs+0RYQTXtIFyVeeFbNaQnPwL
 sYGXssOif85SzGkX1YJVw1JI+UFlDsyU3Do42T+UetbdsShbpEzih2CKmDEdG23vTfINVwDN/
 WkaFZ3wQUXUBlIP7yzUPdqVIKwRdky2A1gbFOI8NJgxrMKXpA2KF0YSOWJ/LSJQDB87iKA2h6
 HUd5agh3r87rXyK4M2rm0ltoxuEnE+STpCB8KFFu7D3tw5Ord6tuz6VvyG1u1Byg7h5miwfKq
 ndrlGtFk9z66zFVXZX10bWiBhyyDCMJrvEKB6VnXmR4IdLkMSJj9OAbKbgr3wjXcQblGAB8p+
 ULcnZqJSf41bQ+cNWFkOZA+xoNRUxReNNTdLcdwIp+NMDOgBQ8GQMU9pUE8XKvUEZG4p9aRI4
 rRfiQK5I0ffbCU06wlkaaj61IAk1phnz6G44bAbm1RvNV08FVewc4Bz1wJwe8ZvmP9Qx+gZV8
 YzDGm+xYrEnX/CloUS6d8JB7ExXBetZ3eJZkAM36vj2b4W14Jm50dOlmxprXiYrDOT9Ozq+Dh
 7TqgtduaUmYVyZ10lHHkgrvYhhsX8zL0A6xpGzHNFTKhgRm//hrsY9yzGjNT1F2yIq8Zufi8J
 Wm56795e0Je7Xs8ZuL0tVud5z2qC42oF85N5+0uXNtQGU+EP31GaucBqIleGIbpyKmx4i4LPr
 uv2wbqvSQxlX1ZTgnA+mWouJ7bkTTRDFQPcHsDgsjH2oHe334vn6wQQ4TFpV562O3q3k0wyC8
 DYago4N/N3mU0/hhsphxVqvOcONQakMdGVromlPPjA2dBKzGH5ydcLN7N7gsuXOzlKAAA+ave
 k92Nj86+7P3XK63zydu9rqSMv0oN03K/QwlNL6TluaY3yFRmqvfC0wGkRrEu7BYxvNtnnA8ku
 35YJHjPUCS4xqLM2chUgsqRff/InVesFtGixogCr8RuuK1KW1zUPNWBvXuyqD+B8hOyPEG3Xi
 HCVBj/UXq0f9kZPRBeHB7AUaASbD6dnpf3TZFi70lYPrvDqNSuH6NquGg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-392597489-1653905570=:349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sat, 28 May 2022, Junio C Hamano wrote:

> Recent document clarification on the "--prefix" option of the "git
> archive" command from Ren=C3=A9 serves as a good basis for the
> documentation of the "--add-virtual-file" option added by this
> series, so here is my attempt to rebase js/scalar-diagnose topic
> on it to hopefully help reduce Dscho's workload ;-)

I usually frown upon sending patches on other people's behalf without
obtaining their consent first [*1*], but in this case I have to admit that
I appreciate your help very much.

The range-diff looks good.

Thank you,
Dscho

Footnote *1*: In case it was unclear, I consider submitting PRs at
https://github.com/git-for-windows/git as an implicit request to shepherd
the patches onto the Git mailing list, i.e. as consent to have me send
those patches on the original contributors' behalf.

--8323328-392597489-1653905570=:349--
