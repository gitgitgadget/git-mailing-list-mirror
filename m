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
	by dcvr.yhbt.net (Postfix) with ESMTP id AEF4C1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 20:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFUUR2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 16:17:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:47295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUUR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 16:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561148241;
        bh=LCMQ+gci7oz3jEVMvORBvGNL22r+0PlZ4M8uTG6F0Og=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L5dbpPVn95RuWRlQkVEw1kFMQN+1Xk17SAmAiVR1D0XcicC9/nFMRlyt/oiazVoca
         sWPuBxw4/BsKP0WDzLkY+Y3KaefQS8Zf/KhweGgINvtT0p3YLG+WBf5ZCTfFTZ+bRY
         JObMO951kuCHV5wxrCG8QVDqggH7iYu6NaNR+Jx0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1iN4CJ0h3y-00ijFy; Fri, 21
 Jun 2019 22:17:21 +0200
Date:   Fri, 21 Jun 2019 22:17:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 15/20] msvc: support building Git using MS Visual
 C++
In-Reply-To: <245f28ac3beda03c980220657ccc6e4d75269c00.1560978354.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906212216410.44@tvgsbejvaqbjf.bet>
References: <pull.149.git.gitgitgadget@gmail.com>        <pull.149.v2.git.gitgitgadget@gmail.com> <245f28ac3beda03c980220657ccc6e4d75269c00.1560978354.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WP81BWcW1ogAvDQ+UVXh8rUlt4K2NuPcZY9qHHcbyzftNdiZnH+
 7s8s1BOqyTih9FvQIHpgw4vu99RudRl2/9M5WYmfHS4sQENAyHmfvpYuCM2btKCMxcEIrQ7
 P5cS0OEjsI+U4doqJHSos36AMzvT2a/D7c6/VDgHrqtGogv6hei7JpD16YBo7WYW+iNmOLs
 rR9WeQor8q0v1wpqbAs7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l/gLNpyvVNo=:t5pyL6scg17e7+2geZhJG1
 wcaQAyhAW79WsVvAUZrTd2Fx0lQPc7QW38dPFHnk+WBHFVg6eei3BFdqkaNKip9/d3AH/6wPd
 olfoAaXx+6gAQ0gOEfz36hReqz1mSJKcOe6m6w02bK5HSW9sBnYrUNV45Yw0DfuBLKqQGVZAk
 WoATK+CnUjqKwCu76eTZNgDqyzVj30+sjA8gYJYUPA6CJ2BLTKnE97jtcWkT7bGFRqcsB0kRj
 DDxVaoWrTvmQpe1Jpaho0hhsePQLswolhqJfCrh8GZjz6XnXKrcOkhSyZYPw/PAYmWgXCq4Ze
 a5D1wnB+n6Dv67BYy3h5YWXArmPDqLXBh0gVxHpByqviGavH4va055cVZO7hKSuqYEO9fBYUF
 QXdVK8rU84W1bURN0Me/UlpxRSYwSR+RxQCJaXpMEKMZEj13UZ5zdSeK8dDFzHo1NQ2r4G4+r
 KxOzrluqZN4UaIlXOUr+rUPcOgQS6ntagEiyo4pWyWGHI8ENhWcjK08qGrHjx/eq3LizZCADu
 v8TK8oDyWOrPzPBX3q5AtsF8uVKVtsDL4LrsZApe4r32lmE13RzWEOGpbv4PWSirE7f7zHNOu
 fAeTAuj25Jdesa+zA56D0lhYYLOLjaSXPnqACVVBbW2QfN6LtXTpDQDRkBkKq620yJBDOtqkq
 5YcNLSeFn3Tp71sTLlMTDnyLOyGDwzQ10HXaH8VPx9irWC2S84HZqu248CiLqaExnZFGel8jF
 g+Q3eaOUclhlq3lik1kIEgkVReW+dVmhxg/ZLd2fZTwMFzlasGaG4/zrl4Pp01qq7FFf/Hxt5
 ReyKXoAlhWBoSnCzMn+f9g4Nz7vKpIE3eFTGYP8XXhZw1Q1wL38O0aIUiKshPvlUhR1hHGPJN
 +sp0ph5tLhfT7j9ZOkLUyR8VjwA4/EqkDnm7NJ6tEO+YwZtWS0duFaJZfljNP6bUsX/suQ/u8
 h8/q27hVUQQAXVtBND91IYy+pFVlpSBYVOwMsg6uAtokcAHhFUaKH
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 19 Jun 2019, Jeff Hostetler via GitGitGadget wrote:

> diff --git a/Makefile b/Makefile
> index 3cf8cc8ffd..2b66d5a3f3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1240,7 +1240,7 @@ endif
>
>  ifdef SANE_TOOL_PATH
>  SANE_TOOL_PATH_SQ =3D $(subst ','\'',$(SANE_TOOL_PATH))
> -BROKEN_PATH_FIX =3D 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$=
(SANE_TOOL_PATH_SQ)"|'
> +BROKEN_PATH_FIX =3D 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(=
SANE_TOOL_PATH_SQ)|'

Aaargh! I totally managed to mess this split up. This line should *not* be
touched by this patch.

Will fix locally, in preparation for the next iteration.

Sorry,
Dscho
