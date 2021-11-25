Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BE8C433FE
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 11:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbhKYLvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:51:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:44489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235336AbhKYLtA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 06:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637840746;
        bh=8SYIrxA+ruFOlN2ITbgz69WFVz8xShiIZMShD8qDzto=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=f+XqhU3pDXVnb7f3jMvF9nrO/Ohol1vBzF63G+Npz1PFJS8d6KvCqc0xZhIT0xqqP
         ojbsPVtKyYQkptXYgjeBFV/M3QaKyVQLuqrcZETqxDVN/oBMF1f2DqjHt1wD3msg++
         I0CaNLT8dpSiEVXjGNUOoEpLi0b3a9ENVUQ3mJTc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1mim932nxT-007WeG; Thu, 25
 Nov 2021 12:45:46 +0100
Date:   Thu, 25 Nov 2021 12:45:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
        Yoichi Nakayama <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH] completion: add human and auto: date format
In-Reply-To: <pull.1083.git.1637666875171.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111251245200.63@tvgsbejvaqbjf.bet>
References: <pull.1083.git.1637666875171.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TdPq0J48QKRk5waBYL7Oyg5dN1CCmtK0nC6mBfNkevXipVwaVTv
 oSB9F1yzdxvXYJRmvXl94XbZKfwXa9Fow+LmShH+ese37cH/1vP3q5LDg6hIlkBQ/SFKoq0
 ZtQJKbvkNnLzejIYn03gQDke22XR7MeI/UtwMbtTF1y2fKPAimv14i1mYuc1aFG2WhBrk3P
 hsRnE+ELvfeyk4kWGqkUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CEWjNS0xbY4=:lbt12p9R+7fJCFRKs6uBFs
 RQPY4k1UZuFV1cdg25PaqeRn6rVktZmaefqEdwOZmJJ7gLd/ZlU181U9WkY+TzgwFfkJ8d3f9
 hTxXMXmdHC8/0iymKcgYpKUei7P3YVOuPUFeeKcmhp5WqI7Dsg83SBKdR6JKi40pqLe78kusC
 JbGq03Zk88iQKW2fK3yRXL6NbXJVUfyWbWv6hRijYl9m9I7prXsSaLQE8UxBrYzSuhSR/NXTR
 8ZASXbIIlk9vtjG5ZvDdlklIhdbumuTTZFciPrRlG4xeWcC+ePhUR/n7e8qk/OhHetpSXW1mx
 w8ungSKLSaff5kNQfL5j2NJiXC920WJacmRK78Y1danNl2QlZt17SbQtTQgngJPqB2H0BydvS
 ij1ZNTy2VKR2tmriTgYdNDhE8JIOzqbuc8+axGc8y995e43AVOwELuRwilcBWU2rL5sTgW1Qk
 z03YkqhoSECBPvLSY0Rtnt3mAx2bDDvx+jXcBZjQcycKgKitGpLdQMyJDiQ9x9aGOEgC5MlL9
 BsUCiS+NMak8JbwyIa2Lf8f4JV9flRZtV0KUe/sxBJ9Ju5MGYrtIxFmVuHU5w2ybu1uZDAEdo
 +scXKZuELghDWb/Qtx8qoZSy/i8kXq3oqgFG06NXVF14hGT/XJ82x4useJqEd7qzy8ezOhosH
 jVZjZebeo3i7tjWHxUoKoMPn6KLEI3a25kPjkCy4V2zRYqsOVnNWwYbBVkYYEVOlF/7m2ciNh
 NC5z1jY2bKpEbn/F3H2QPFDsrIGtsYYtnaERFYOTR9CQE+sF90ritUVZnhavUrIkDptjBMf6x
 HlGFuU1sa2zTriEbgvn00MtHQMzV6bEaTFnCiZUThNHiM9ApBb7MQdUEA8cjlyUS0ny1APunE
 e8d6nAVqystKQgw4AtdJfRmWDzEX1MX38tObqPVmt1+plsVjJyOlmNgx/nLvMuOJxB3COWMIH
 2+bIx+q1TeLZT2ibkTQEmyuaCEZjePDSl2Oex/M1wcX1wsNQUtFdpGp/Np3XkRAOgU00/Huz1
 FaWtyyLBQzquIb0AKGq+IdLhbTFZotUEZw8AoKBXOWf+jZC+fBBmSda0O3TfG+ZLcOymh5+Mc
 XAHzae6UKxuuTk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yoichi,

On Tue, 23 Nov 2021, Yoichi NAKAYAMA via GitGitGadget wrote:

> From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
>
> human was introduced in acdd37769de8b0fe37a74bfc0475b63bdc55e9dc
> auto:* was introduced in 2fd7c22992d37469db957e9a4d3884a6c0a4d182
>
> Those formats were missing when other values were added to completion
> at 5a59a2301f6ec9bcf1b101edb9ca33beb465842f
>
> Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>

The commit message and the patch look good to me.

Thanks!
Dscho

> ---
>     completion: add human and auto: date format
>
>     In bash/zsh completion for git log --date=3D, following values are
>     missing:
>
>      * human (introduced in acdd37769de8b0fe37a74bfc0475b63bdc55e9dc)
>      * auto:* (introduced in 2fd7c22992d37469db957e9a4d3884a6c0a4d182)
>
>     They did exist when other values were added to completion at
>     5a59a2301f6ec9bcf1b101edb9ca33beb465842f
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1083%2=
Fyoichi%2Flog-date-completion-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1083/yoic=
hi/log-date-completion-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1083
>
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion=
/git-completion.bash
> index 7c3a75373a4..37fd5c4c885 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2001,7 +2001,7 @@ __git_log_shortlog_options=3D"
>  "
>
>  __git_log_pretty_formats=3D"oneline short medium full fuller reference =
email raw format: tformat: mboxrd"
> -__git_log_date_formats=3D"relative iso8601 iso8601-strict rfc2822 short=
 local default raw unix format:"
> +__git_log_date_formats=3D"relative iso8601 iso8601-strict rfc2822 short=
 local default human raw unix auto: format:"
>
>  _git_log ()
>  {
>
> base-commit: 0ea906d20517145895193a99666d5f2860a04360
> --
> gitgitgadget
>
