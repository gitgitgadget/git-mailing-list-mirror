Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DCA41F454
	for <e@80x24.org>; Wed,  6 Nov 2019 22:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfKFWTc (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 17:19:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:32865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfKFWTc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 17:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573078770;
        bh=5HETZdoLRgvsQRNVPtMn7UFmySgYPaMWOFg73T1Cip8=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=GNr4440KPjNke8RbJZ0/O8kIrAHnoupkg4820iGSi+jvojQlJSLHLsxm6lmtG5Xog
         lxlmceZGmnq16aqAHhOT76daAXPlPXJujPIno+qjXSQBfaRr+zON/RLa+D3xOryBYd
         RLyGgCWyTOFvw5ZtPl25RmQkp/0bNqhwDqXppULM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My32F-1hidxN23Bv-00zVtJ; Wed, 06
 Nov 2019 23:19:30 +0100
Date:   Wed, 6 Nov 2019 23:19:15 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.24.0(2)
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1MeCpb-1htgaz38AJ-00bNIH@mail.gmx.com>
X-Provags-ID: V03:K1:orJvDIPK/MIHlB5BIPPl1ViwhFpOKbWVoM5+Dypa9NK8V64Gldh
 SwX1GkM6y4REjO2MErGVUxhF6/nMGhRcxZ61eWD6xCkXCqKjfNV8AjFdwM1zco3i9iwpI7A
 8Uh2Ipv5h7sOC2chKEDWfkVorN0/HlUjjk5LvkwZqRborbQdbwPZZ8uVUPJtqrq52fPZJG+
 qo73OmiHBhe3SYg9oAXAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wkkrtVPA3Wk=:vrDZ6um55+1D7EVs2n95T9
 JgoF4YpN8S/GFJ7yckJxxK3fCSKq5XTqQN8UnC/Iyq4bb84WGSacdw+Sa2MYU5E97qN0ToH6M
 WbVOJJyfNBx8mtT2FOEn+SRxozow1Z/IF0kD1B7YlOJ1geIW3EMjTwf1rXxDkMfcQuo7xMeYe
 Dc/szJtCAiCuQUaIz7AJuV3X0R7EK89LSU1GaLTniaNM0ogRIou1nWyMJ185PHgHQYyLbyXfn
 /6EiEPOCNPCoaBHFqRLaBF7xfgKYyRM6foBO8Uf4EKC4exK9VdjzH5t2GSp0ltDWdS2GHTEDh
 EBf3ObEZK6jRmU5QdykrZlpsyzLZ3TPckY0jHhe6vVG85wvrclPp5ONN1eQRBUjr5YM0xt8E1
 Ri0mRAh4GWGpPlGWubAwiK2CUGoFRO0D1Oe+03PRi07V0NjPoIxmOZFeg2u7cBy1lCYeLxlWO
 P55S0FVXqBYpOl+kJtrv6lYOIFdOs3O6lj9GKgLFAYF/zFGquQekzZnun3Xfc21ZEjWuHjJDz
 7B6SaqmhYkvqaWBDgHW7/gciqQJze4XdxbqPCvavDuSh88qCE2/0XkDEKt4dyhX9QBxI1MHJ4
 ZQCgAxhL1gMg/LLaazbKbf2JlUURlXJsi2kEiGoXt+Ls8wX3uc8QHrl1lGVaRdUrHS3ptSKLh
 ADbedcfSX938tu4unW8XEVNTzRVBOJFae9hppTMXWvSgPMQBsxfoYIV+rsiThfZ4qVikjUn4f
 8mA0fvmB2PcccsNxV2XP5yyn1wHwcjCGRqKm812UfrJwMgVT2zG7P/od+iwxCO2HSWeDx0GVo
 1b6TDYXxp78CuEiJgoYfZAK/U3rouK6ZIqapg2Fyu/hmNGyoQ2bOXsr71qIDo6FQyBOvHv2/z
 RHzTKBIn2B5b099F12qN9VtQe+biRgL/w2U8PerRbWiU+plWGMxEAeA6lLgfvZnaLOKrayL7R
 pBN+Nt0iwD3oLp36cTMsqJUMAHU7j++5uxeNIBzWyXM0iQdEH46+WmdfTzrm9o13iwS78v9Uh
 8c/sAXMcnPzhkQXlEbHDYlNcUok8Vy/NzqoLysfdR3h3S7HcZ7mU56bdsUUTT2DueYSEhzYEM
 y4QDe5xgKb0T3kJbnLiUh55PS9fG72/WAiQA/u3sjyxn7shthydOCsU8zTJx/D7/lED7NSRFb
 ickj9VZ+ZWF2tsw7uYw2Fa79004ujl9LeBeGR65J2tz0ZubOVAvY7rOuWmfx6+l3UxaocSyPO
 JcLEtV8tJTNCztOutUuZnUolcPXKF4bieGcwLwrbfB/8jB8LdJfPxIWA2S3s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.24.0(2) is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.24.0 (November 4th 2019)

New Features

  * Comes with cURL v7.67.0.

Bug Fixes

  * Using http.extraHeader no longer results in spurious crashes.
  * The /proc/{stdin,stdout,stderr} pseudo-symlinks are now installed
    properly even with non-US locales.
  * A bug was fixed that prevented gitk from refreshing after new
    changes were committed.

Filename | SHA-256
-------- | -------
Git-2.24.0.2-64-bit.exe | af679d8b3dbeb84c95c6c7f3be2f200a58d85201552ca0594fb7a3f4ee99cb38
Git-2.24.0.2-32-bit.exe | 45d094e1ad96d40de0900b09b57213316fb986476413c3f7049761dd3ac82392
PortableGit-2.24.0.2-64-bit.7z.exe | 353d0e1566d8897cb7afe2f6f9088bac17182ca43416feadec1c16f5c3bb9e0f
PortableGit-2.24.0.2-32-bit.7z.exe | 6ac4761e2711cb584f2df1fbc27b677a03c745cfef0bae55604bc27a5c26d68b
MinGit-2.24.0.2-64-bit.zip | c33aec6ae68989103653ca9fb64f12cabccf6c61d0dde30c50da47fc15cf66e2
MinGit-2.24.0.2-32-bit.zip | b7b26e87d3df9b44fee0606a9df3ca839bc444faf76c4c27bc0824a6c10e7831
MinGit-2.24.0.2-busybox-64-bit.zip | 8c021b7c2be5d4b3196943a50ab66babc41e56824546cbafa79fa9ddf0df5fe8
MinGit-2.24.0.2-busybox-32-bit.zip | fe2f2186f79d69fede2e51ba2f7d89a9403a6acf10061851c9517b1b32e06c08
Git-2.24.0.2-64-bit.tar.bz2 | 6609945e5ab69bcccb5a20d83c250bf50ba98f67f8727dcfa2bfc40059d3de0a
Git-2.24.0.2-32-bit.tar.bz2 | 8e83c9a1c029d6d73ff03f75ffd5aced34241e3b2a47e7842ac2cd1e4080fc24
pdbs-for-git-64-bit-2.24.0.2.02af2cc5bf-1.zip | 09743e573d30af9331b974761270581e064a8053e8269d103690da69e70282e4
pdbs-for-git-32-bit-2.24.0.2.02af2cc5bf-1.zip | 62da7f3bc32a60ec356549b0c4ba972d8a37116cacd7358c112ccc34049ac1f4

Ciao,
Johannes
