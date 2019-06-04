Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08401F462
	for <e@80x24.org>; Tue,  4 Jun 2019 13:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfFDNpy (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 09:45:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:51067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfFDNpx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 09:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559655951;
        bh=X+EH9BIL8+mzCXDJdJaIsA13NHfpdNkyRVvLJgprVC8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FvIj6ZdRmmpifYUyvY07U+cD/QmOryrp9dyxcBgg9IwwgIqPI9SHcdfuF0iFci/Vj
         HSiSDTD2A8MmctTXOLh/EdEJP6FOynfyjEXl0X8XGc/CMmpIjcMIXhjQv3VLuqS5Vy
         h2GHiY0ToglCnoxgws9wPk/65VQT/LODliaE0W1c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1gg36O33WJ-00sy7S; Tue, 04
 Jun 2019 15:45:51 +0200
Date:   Tue, 4 Jun 2019 15:45:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Wen Bei Li <wenbei123@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] mergetools: add support for VS Code
In-Reply-To: <20190603150315.16032-1-wenbei123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906041542050.1775@tvgsbejvaqbjf.bet>
References: <20190603150315.16032-1-wenbei123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/pEWz84XcJRDiEH7nNO8sxegepQftjHpGG4ZTguo4uzj6EYVLDn
 W1wWNBXg3FMKtNgvpoKWJtgBlK+VvS2j4GiIjSeW2C4sRSqAX0zhiYhWKGkmkTMBmXNWpLu
 N1kQzCjtkNJTUvhijOnOyNwXRPuaVaK3/gupI3rJAkArzM7Q7vxGKRPd0lySUVPYDjrvG3m
 xaCebYClbm0EkwE/GBEnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9rmNupJREJY=:cU9CzMpPHthEawGdyuGvVi
 JRWJ6qrxFgROuabMM+KZJ24nUcEJym1fbfi/p4N3SYQqCvQ1qqRCBJs+2h2C/tK5IRFF5F24F
 3TiZp4zxdhd/4w9akCnJzkpx+48AJf2MrDYK/fSjeM204l/xTKUNTCM1NDWj04CBlYfbwdQOK
 HBDqn7Jl7XSdGfBvc5bcOSFFkn8FgSdqxcJacQ6DJMU5JCp3yEF723IselSh1IBANbx22+GJM
 CMZEn39uXtXmla/VIYN0zbzJA6RNjSHHPvOiKXfKND2qPbL0jG/gtS6X/EXl6Hr6MCqryIWZx
 NdRvKcDTwj8QRGtkzDfoHEk7zXq9MrOp/SpSEtxp9E30+dbaSV0GLqsp4x6hvRvQJhv303y+5
 IUoW6GeVrtv2uglxMyk76LLLXYROfbFT88Emv3DyFEG2lCVNBDbvkzbkMwl/eQoo4ow4T1Gx2
 u2lnGZ/ljujIaaizysuZ16DrQRDDO2KgrAHb/dxjskLzKm1aDyz+O/iesHkHPn7qzdai/zKer
 9A698tZabR/q5F4JXtGHdPU7/30XcJrQaYPZRy0p9q2j8i3ZoOeGkoLdSgd7NRVl0vLVVBtp4
 zP/10fmIIOCT3T84Ri/Y1Z19hRSUYwtDRPMb8p7vJepQIHtzdnGsw2z8nlPbyVI7miqfapWM3
 vs187DuuiqB0QP1z6g3p/3RzE0gW5ENJXkVwQHRWhmYHQwPyBWNEJjKbrQqFqvushP7UOW2zs
 5OiKTpY0SghHb+Hh7yU1nPtJzqap6vfdVHlwnszFXxEUT5XR6CGk5nkTC+aOGd8lQJU9RhArx
 gIcDZQrkocvWv32wde03mvJy/kjM1tCb7qT2YVK9dBJXL7SqYaBE+3+gJhv3Lv414DaOiQqHw
 ei+lz6UdVJ3saGyifAq+p6xEVAerfD62fjizVZaUqWZS0TYZBGfSe0O2cUhIDRzGVzbHYvLqR
 3iaqbZEWXxV31DjDU4npAGgxJN4/mKpqXqGvVEFFy9/3xY7e2xaIq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wen Bei Li,

On Mon, 3 Jun 2019, Wen Bei Li wrote:

> Teach difftool and mergetool about VS Code.
> ---

Even if it is a very short commit message (see e.g.
https://github.com/git-for-windows/git/commit/581d2fd9f2d6 for a typical
commit message in Git's repository), I think it is okay.

Personally, I would have "lost" a few words about Visual Studio Code and
how popular it is, but probably only because I like it so much (and maybe
nobody wants to hear about that anymore).

However, in the Git project we do ask for your Sign-off:
https://git-scm.com/docs/SubmittingPatches#dco

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 204a5acd66..59512ae673 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -283,7 +283,7 @@ list_merge_tool_candidates () {
>  		fi
>  		tools="$tools gvimdiff diffuse diffmerge ecmerge"
>  		tools="$tools p4merge araxis bc codecompare"
> -		tools="$tools smerge"
> +		tools="$tools smerge code"

Do you also want to add support for `code-insiders`? (That's what I run a
lot of the time because it allows me to develop code in my Windows
Subsystem for Linux while the GUI runs on Windows.)

>  	fi
>  	case "${VISUAL:-$EDITOR}" in
>  	*vim*)
> diff --git a/mergetools/code b/mergetools/code
> new file mode 100644
> index 0000000000..566a0d9d63
> --- /dev/null
> +++ b/mergetools/code
> @@ -0,0 +1,7 @@
> +diff_cmd () {
> +	"$merge_tool_path" --wait --diff "$LOCAL" "$REMOTE"
> +}
> +
> +merge_cmd () {
> +	"$merge_tool_path" --wait "$MERGED"
> +}

This looks good to me!

Thanks,
Johannes
