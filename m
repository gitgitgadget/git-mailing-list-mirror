Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 861C81F461
	for <e@80x24.org>; Tue, 23 Jul 2019 14:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfGWOxy (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 10:53:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:55209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbfGWOxy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 10:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563893623;
        bh=QhBmyuFxP9nuiidaCvd8MIn5p+VOHQge+BuWMoNy8U8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XjaP2Qn6699ym+4WN3UNhGulMWfadroSzRDgDWpLrrO6V2fxF2qj9V33cSjp3DWFw
         KlzuTUTDf63444Ca8s4S0i+HTGxKpKLJOsHIK3Hq9LZjKP2KbaUaclub74ZrRY8Ikl
         4r+6hRH5UtY9iUNU+acGZjz9TWuOgT2opfXHiGOA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIMUZ-1hqCDo1K3D-004G54; Tue, 23
 Jul 2019 16:53:43 +0200
Date:   Tue, 23 Jul 2019 16:53:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/5] repo-settings: add feature.manyCommits setting
In-Reply-To: <e00a1be75b410694374b0d9bd60ab16d67ef6d20.1563818059.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907231544200.21907@tvgsbejvaqbjf.bet>
References: <pull.292.git.gitgitgadget@gmail.com> <e00a1be75b410694374b0d9bd60ab16d67ef6d20.1563818059.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dZC7T+rPweTe06jTi6wcFFN/xvJ5yLuJb5Sd8UTZYz7qGJ7O243
 a0BqbvWIha1DZA1Bes6OZ7cVzXHBvuzAW94EhX/5A3zlw8mQHsbY7XzEzzteGmm0zzuQggD
 YjHDgyxgdh15b94M/Tgk6KUZOVtoIPEaY8jj0FKjjLH2WYzr+Gzc3dJ6R/Df5xU2cNY9oTC
 zm8Se9HU97aGWAtjTjHkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eK1TzRawzMo=:7sRsqhFdj0AVJAGju5Ny5O
 az/xFDs+EZ4ybmgMNkdBgEsPJRBPunF8ZCZ1E0zJrClAOAtP+Ga4N3Lo+e43ifoQyjb7YC7D9
 NhKln7WO4dbmtxi+/m+mIyj6N6kK79f37tnhWV+iXH2H2/AJeWX/F8tRkH9km6DfbVzz49/aw
 yI87Bxwf0NedPJ3dForMGEIjTW0ico8TcjB4OzAGjnVQACK6GisTc7Pwktxq7ibUJuQfcCcJ/
 giSIhaCVXrWKVygFN4ZxnEFv2cZGXI/BfpC7Acx67avXZsSeFJQ4LzPTIQ537aL1hJHcQD/Id
 jIgVMINysQExZmEd5Y85tdEunXwTby2QC/T4dXHuFipHSsEB/Y3rjQEJcb80oP0F7BPrHRxl1
 IFnfrQCSfNs9Q9+6ITCV2JASp1GdCv/2567SruupZlb6Gn4DSPKunPjkXltVX+ORpmzRLja5C
 wdFlwwiKNeDilHRX5QWG0WgQWZ36Co5qZWRTPpAWur0DlM7slCCSO3MGdc2POe1ddNS1XgFEJ
 jHGxCCp0PKdQcqjy2wyBgQqCvwNw/Tkx0vDuHZgDWdTPnIkvNblohCt5qSziF6TW4FGH6VSP8
 f02gST2uDSejMygbMcPPeqNBILfkzsnd+j2UvFqTiXC/MQG1XtcOZ9l4/Hm0OBm6fHK0NeEvu
 mOglrvOIMXvO9P/dKFTH3KwwxMMGiQIlNIhDJ+AtEDLNib0Vgv61xk2Ugebrcg7Cc0RLoLkbD
 kjfXGL87udBR8qTdzVbyrOq110n+rDloGSTcBJbRNObf7cVi0cjqYZ3FZd6iCBmaojDClxG/H
 LSHfhMvDB5pzwVKJIlrhmZKTtbz4e6NQBuRamkS/56GzeHFn5jjThcD4x9W6uzjL7aOCyFsV7
 SB7Jhi3/c/hsHR9uK2sCMBEyBeZcxVWd/BVkbEmSGHd0IN3OuWW7ldZrtViuUbaUAP0pClQLX
 mFjJ8+B8btvRZHuORKGJIWtNNMQ4p1yAmDW1IZhdsRDk3MQtN4Pt5/08jX4nSYJY5BVeEecVb
 NVYtUaC90gFyfBb+KwlGQcjgqlHdD9c0i46As4i6oOwvfYb7FeisVa6ysiB4qixbw6m2miQh2
 P2zPY+OcbMPAUaXtVSYuMnnYW5L+Jje+T2/
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, 22 Jul 2019, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When a repo has many commits, it is helpful to write and read the
> commit-graph file. Future changes to Git may include new config
> settings that are benefitial in this scenario.

s/benefitial/beneficial/

>
> Create the 'feature.manyCommits' config setting that changes the
> default values of 'core.commitGraph' and 'gc.writeCommitGraph' to
> true.

Great!

> diff --git a/repo-settings.c b/repo-settings.c
> index 13a9128f62..f328602fd7 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -3,10 +3,17 @@
>  #include "config.h"
>  #include "repo-settings.h"
>
> +#define UPDATE_DEFAULT(s,v) do { if (s =3D=3D -1) { s =3D v; } } while(=
0)
> +
>  static int git_repo_config(const char *key, const char *value, void *cb=
)
>  {
>  	struct repo_settings *rs =3D (struct repo_settings *)cb;
>
> +	if (!strcmp(key, "feature.manycommits")) {
> +		UPDATE_DEFAULT(rs->core_commit_graph, 1);
> +		UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
> +		return 0;
> +	}
>  	if (!strcmp(key, "core.commitgraph")) {
>  		rs->core_commit_graph =3D git_config_bool(key, value);
>  		return 0;

Okay, this one is tricky. The behavior I would want is for
`feature.manycommits` to override the _default_. And if I set
`feature.manycommits =3D false` (e.g. via `git -c
feature.manycommits=3Dfalse ...`), I would want the default to "go back".

So I'd really rather see this as

	if (!repo_config_get_bool(r, "feature.manycommits", &b) && b) {
		rs->core_commit_graph =3D 1;
		rs->gc_write_commit_graph =3D 1;
	}

	[...]

	repo_config_get_bool(r, "core.commitgraph", &rs->core_commit_graph);

I.e. override the default only if `feature.manyCommits` was true *in the
end*.

In any case, we really need to make sure to handle the `=3D false` case
correctly here. We might want to override the setting from the
command-line, or it might be set in `~/.gitconfig` and need to be
overridden in a local repository. We need to handle it.

Otherwise this looks good!
Dscho
