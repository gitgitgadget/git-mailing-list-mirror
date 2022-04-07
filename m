Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A28FC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 13:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbiDGNfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 09:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiDGNfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 09:35:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FB22467FF
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 06:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649338410;
        bh=fExQRY69Imc1ra2WFVQ1GtIfYTkKVu7E/WnvEPQMpJQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WS8XB+uUMeMDyxpQ/rjaNxBwKeRV5qUXMAe4h0h51wx7lpzG1fUZ+ipWRvZ0tmcAd
         UD0+4qxUjfqIh1RW9pKXsKnztd/FMNURDSKqZ24BU+/zwwEZhoJzVjU49lRSJncmP/
         UMq6/MAhWtl+nT5+r7gYExs5bw5zK56Ac5bAcyTE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.255.204] ([89.1.214.127]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KTy-1o247M2Auw-010Oxm; Thu, 07
 Apr 2022 15:33:30 +0200
Date:   Thu, 7 Apr 2022 15:33:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Todd Zullinger <tmz@pobox.com>
cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] doc: replace "--" with {litdd} in
 credential-cache/fsmonitor
In-Reply-To: <20220406184122.4126898-1-tmz@pobox.com>
Message-ID: <nycvar.QRO.7.76.6.2204071528590.347@tvgsbejvaqbjf.bet>
References: <20220406184122.4126898-1-tmz@pobox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TEI5Oq807X1T8IQNAQRGrqWtYqMsfuEisa38Xh5jtFAG6PheBGH
 fPxBUupW4zmbJf7UYJ/7IFfiUdtDcXYaXFxG4Y2q2ljZtnJaYbAuCsfum3Mm+ukJ41Jan8Y
 IIuTgzqoECTXIG2xQAyCBq41rNFOvNw+FcwGlMiqs375lev/YP647FLNgT0BIh5Thi8fFH3
 KGMPZ1gfgRJqZwndAgbIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TESfZTb2KM0=:kGDAGuwTfOiPjohpYLks4b
 4hdSDWa9nU0V4Sk/5zDY3Qv5FRF02HzGU341dUia85OTlt9EXTT3ifkHreU+VlBCE350lHE0T
 SqaTMIZx6BdO8JOT5DIY15S/pwCe4hHgXXvOa7S/0AjM5ulf5X4NSxcRdcjGTU/I7+RHYoR0r
 Bp+bdxwItBrr7hn9S7eHirZpTADjRJIN9M0kCwItseiGvx1lE34VLgkS+iZGzem4qcB7dGSwi
 d+4DTUCJZEFx9OTr4lLQdKKrrld7Z/i+IaT2LXe5VRPbdYqAxVB+xsSbT5rXvThK17+oP2I4G
 5A08hA1e6B7OTTJsmzBa0Jx/u3U6gIBjCx4hczQTdCe7jK4/7jeHXPPXkdghrHS2Eq6VKAYw9
 mOwiqDJy3lL/vXcG4Rf0g6nGnql5idHDXbkASPpMLKPRGsK0RbR0GQGwXFwwXtNN+uVnsTkPH
 Leb71J/EIPEIAKdTlKyoRnbnHvXZjIrMK4dRZhcklO/w7OLiT3JBxkODugdylU7j63yfbFQhg
 qtl1RQz02d7TNF9Zwwj0MkZopUXwN8KVV+1xhx25yiyrnQaYZEzMJFv/WVzFrgh0JJy9vQ0uD
 aWM8Z3AC5KtAsx2HxuKdTC6quvyhG+3QPU3Gop9bTp0+bSUCCvwV4u+5NE8MzT7QHFWKvq/K1
 sZgRsgVrrN+ghr/ZmL5XQqxkvbJFXYkq96iu7/+5GOO3l/wvhbrO0IR40SLp7zAQWoPtBn3Rz
 JXg9MwTZ2mTpwE6flic6W+THA/1ET9p6lzCwXpKqEC0PqWlVCKWDquUwhvyirrCmrsvavLd5Z
 fvPvFE7YuSIaeLEazmXKFnDF2gzT9eKS7Q7APoEem1lIa4sc97gAo8lXsXc/KEdgeiMfKBZQq
 lBT1rzrNDTuaM5fdzC2D9GigtrVhDMskNLioxSvYPpseq9tvmvPV5iF4UvITjCCxwiaY1NQrt
 OVPYNvyGvofrVLADVWQeLzUm/fwmayJ+ld01eYY0N5w8asF3vlysKU7HQ2YgdbegrYC+q/2xZ
 A6ngpfuVLPAQHLjAPjNzr47V/HVE8XeeTGd3Y1Us9TtqEkaRQxvqo3+HwVVouHhiwxy66SIPt
 EZgi5y9HPMOXBs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd,

On Wed, 6 Apr 2022, Todd Zullinger wrote:

> Asciidoc renders `--` as em-dash.  This is not appropriate for command
> names.  It also breaks linkgit links to these commands.
>
> Fix git-credential-cache--daemon and git-fsmonitor--daemon.  The latter
> was added 3248486920 (fsmonitor: document builtin fsmonitor, 2022-03-25)
> and included several links.  A check for broken links in the HTML docs
> turned this up.
>
> Manually inspecting the other Documentation/git-*--*.txt files turned up
> the issue in git-credential-cache--daemon.
>
> While here, quote `git credential-cache--daemon` in the synopsis to
> match the vast majority of our other documentation.

Looks very sensible.

While the credential--cache fix is technically not due to a regression in
the 2.36.0 cycle, the fsmonitor--daemon one is, and it does not make sense
to do only one during the -rc phase.

FWIW I just looked at
https://git-scm.com/docs/git-credential-cache--daemon to verify that it
indeed renders the double-dash as a long dash.

> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Documentation/config/core.txt                  |  2 +-
>  Documentation/git-credential-cache--daemon.txt |  6 +++---
>  Documentation/git-fsmonitor--daemon.txt        | 12 ++++++------
>  Documentation/git-update-index.txt             |  2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.t=
xt
> index 889522956e..e67392cc83 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -63,7 +63,7 @@ core.protectNTFS::
>
>  core.fsmonitor::
>  	If set to true, enable the built-in file system monitor
> -	daemon for this working directory (linkgit:git-fsmonitor--daemon[1]).
> +	daemon for this working directory (linkgit:git-fsmonitor{litdd}daemon[=
1]).

I am not quite certain that using `{litdd}` in a `linkgit` construct works
both in AsciiDoc and AsciiDoctor, but I trust that you have verified that
this works.

Thank you for doing this,
Johannes

>  +
>  Like hook-based file system monitors, the built-in file system monitor
>  can speed up Git commands that need to refresh the Git index
> diff --git a/Documentation/git-credential-cache--daemon.txt b/Documentat=
ion/git-credential-cache--daemon.txt
> index 7051c6bdf8..01e1c214dd 100644
> --- a/Documentation/git-credential-cache--daemon.txt
> +++ b/Documentation/git-credential-cache--daemon.txt
> @@ -1,5 +1,5 @@
> -git-credential-cache--daemon(1)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +git-credential-cache{litdd}daemon(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  NAME
>  ----
> @@ -8,7 +8,7 @@ git-credential-cache--daemon - Temporarily store user cr=
edentials in memory
>  SYNOPSIS
>  --------
>  [verse]
> -git credential-cache--daemon [--debug] <socket>
> +'git credential-cache{litdd}daemon' [--debug] <socket>
>
>  DESCRIPTION
>  -----------
> diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git=
-fsmonitor--daemon.txt
> index 0fedf5a456..cc142fb861 100644
> --- a/Documentation/git-fsmonitor--daemon.txt
> +++ b/Documentation/git-fsmonitor--daemon.txt
> @@ -1,5 +1,5 @@
> -git-fsmonitor--daemon(1)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +git-fsmonitor{litdd}daemon(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
>  NAME
>  ----
> @@ -8,10 +8,10 @@ git-fsmonitor--daemon - A Built-in File System Monitor
>  SYNOPSIS
>  --------
>  [verse]
> -'git fsmonitor--daemon' start
> -'git fsmonitor--daemon' run
> -'git fsmonitor--daemon' stop
> -'git fsmonitor--daemon' status
> +'git fsmonitor{litdd}daemon' start
> +'git fsmonitor{litdd}daemon' run
> +'git fsmonitor{litdd}daemon' stop
> +'git fsmonitor{litdd}daemon' status
>
>  DESCRIPTION
>  -----------
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-upda=
te-index.txt
> index 64315e2e8c..5ea2f2c60e 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -528,7 +528,7 @@ This feature is intended to speed up git operations =
for repos that have
>  large working directories.
>
>  It enables git to work together with a file system monitor (see
> -linkgit:git-fsmonitor--daemon[1]
> +linkgit:git-fsmonitor{litdd}daemon[1]
>  and the
>  "fsmonitor-watchman" section of linkgit:githooks[5]) that can
>  inform it as to what files have been modified. This enables git to avoi=
d
>
