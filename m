Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2FC1F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 21:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfJJVNE (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 17:13:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:37241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJJVNE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 17:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570741977;
        bh=9bphFtKGumK237y/ntHNULABgUa6s4L5bvF65oOPu+M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J9sJJHX0NL5YeDyj0XhCUMU33l2fDWYJ1QPIKQEfAQjl76hi3M4sm6T041T7cNfiF
         /GictoM94gZEx+MMAhGrvTvNNU6FljD6yjQwBF4xGuFicac25vij57z8CK3lyDV9+0
         2gsjAxhpcT/ZUjDNLU1pK8mfC494kBEl6i0KG2MQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRR0-1ifrQz05UK-00TmjJ; Thu, 10
 Oct 2019 23:12:57 +0200
Date:   Thu, 10 Oct 2019 23:12:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Maxim Belsky via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Max Belsky <public.belsky@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Maxim Belsky <public.belsky@gmail.com>
Subject: Re: [PATCH 1/1] doc: Change zsh git completion file name
In-Reply-To: <ae00e1e3932b3364da68fa66e2ec5fbcce124bdc.1570726611.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910102310260.46@tvgsbejvaqbjf.bet>
References: <pull.367.git.gitgitgadget@gmail.com> <ae00e1e3932b3364da68fa66e2ec5fbcce124bdc.1570726611.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ew+OvYe1WXn3CcA5Vqhx+O5Ktql8FZpEJsYpyhZMWtbeqL395V6
 Y6B8+vHDupwRi1pwc2KwGv5tvzdqDPz7B89Cy1afTMzmvN4WhvKagVGLjse8wBv1qPniikD
 sAq6NukOr1s6hLMgTq1PnFy6T78kDgkcQzv6Cw1u/2YM1NmGWHrzQo0RyfOWkBI9AtE3SRK
 R76RW9sxoF+xw7IV8+uRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uCR02kTpBdw=:M3b54Jmn+5+6o2HkcdNg4M
 ehYF/uJyHizBqnS1XlYHrGQTdaMg5Xcm8wYdiM4rOMekF+UdQ4Emfkdv1fqjVMbnmdOjpXVB1
 cW5gT4NHcN88bUjkFFLOE/6XSw/yG/MlGXbofQxystI9QTVBigNgD+qX6+qqIZsFF5denOvwE
 i2wLl/qnm4mtMEubB82Hej80Qlc4EuVfLEU+hzMXlE7lpgNb8MLzIxALdRY0TtpsrIqlwm5sQ
 yLqvNEYWg0d0E27WsPfyDj6BV3fKbSD/aGNygxBQHyavmhGR1Y8AnLreBiujkKVhdEKoSPyKl
 8/ccmRKX7PXjGB4325elkTTWdPZo+dLl+VzJMCbXzSJfnMuFvyLDSw/1nmzRFOGaYZqxvP4Bw
 4RWu1OwWR6HQQNeaGPb2f51nNmzUnE13Bv4CqoUcAEZG5A1iolfRe2rLl3BRrk+30tG4XQkxn
 lqPu3VPs+28SMPOLMPdja9FnTtGeG5QMSDamEWA1Ab+miIuQ0l9VuJHMConchP8dfad2ITPM0
 R+fumPKhStdtgQj8gAUaCx8AUzF/UZ4OGsh581ItWeb19UW3jIYyHCP+JeaRV66KgW++AsHqZ
 Qk+i0W4jeEya7kUFBCzmfBooSvc88p3IeiFaGxQp0k3OGFvRGXP0eQp+EMT0I57jizMca9lMb
 eePm9Qb7895vxYDNgPT8FsPKIEUylc/gpTr/A/BMU+beLHl78JnajaGKKV9mZJTR3wkCJ4X9J
 CTFXJsk/6RW+gjlELEm+kdcq42yuBUGkjKwTcRLdNXE6+jlv5nwyKRMnYefWO6ej3X4HXlHK8
 prSxYBUdZc0EOZEZAHME9Lt7OvwPtIYmGCPEBhDP66Ikil2q/KgBWqFM8QtDl/TX4opWb4Td5
 w7LrHImNj6ynkOgv0txwLBfsC0BESlAkbTKkhwyRJjTMjPTG9wJH9/UMeFwIsAjuDaKNY22ln
 gLF2ICuPJuO0WewaR6FaOOXFdFyIv9jfS/7k9Tpw6vislHea2yLIqOqbdIixj7fy0mPgG4cGo
 LZtYA6UiK/GsRB1bOvFUyOqrWAg5Ii437LUHnk9YQnbnXcfA307OsD27fRrFGa2eP0RDWrL7B
 yBdHESY6XZTwSTrnNGv8dNkiUSLcUIbwvbLywd6yT11D575PNk+g1pTWSFToPLQjTdSH0HeYQ
 xiTwwAEmSZiJFtUSHaIy+/M1BihRYbuQYMtyHJNF/020awVyqlH/NGbKhIhGqWGz9IYyJciBv
 Hdq+X0e02Wr6Npc4ipT0FPXLKKbrmdPHkvTcZgOP8KZI7pPY7jpF1diC27GI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Maxim,


On Thu, 10 Oct 2019, Maxim Belsky via GitGitGadget wrote:

> From: Maxim Belsky <public.belsky@gmail.com>
>
> Signed-off-by: Maxim Belsky <public.belsky@gmail.com>

I totally agree with the patch, but only because I read a couple of
reports that users were struggling with this. Maybe add a couple of
reference points to the commit message, to describe how easy it is to
miss the fact that it needs to be a _file_, not a directory, and also
describe how `zsh` tells you that there is a problem (even if it does
not report a problem, that's a valuable piece of information for the
commit message).

Thanks,
Johannes
> ---
>  contrib/completion/git-completion.zsh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/=
git-completion.zsh
> index 886bf95d1f..c0eca3ff25 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -11,8 +11,9 @@
>  #
>  #  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
>  #
> -# The recommended way to install this script is to copy to '~/.zsh/_git=
', and
> -# then add the following to your ~/.zshrc file:
> +# The recommended way to install this script is to copy to
> +# '~/.zsh/.git-completion.zsh', and then add the following to your ~/.z=
shrc
> +# file:
>  #
>  #  fpath=3D(~/.zsh $fpath)
>
> --
> gitgitgadget
>
