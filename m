Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECD0C001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 21:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHGVJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHGVJE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 17:09:04 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD3AB6
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 14:09:03 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52D651A717D;
        Mon,  7 Aug 2023 17:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Fpi+aRRHKcyo
        2k+0qDkzjugvaIAT02xva8ryCaWZrg0=; b=GDff0vruoEmJeedQNm17LWF4x3le
        Bt+hL5hLpzwJXhguTVdDk6kuveFud6u7dY+I3G1ykxtlfkdKYm+zmqXy1vG5ESQU
        +qqPZRhYvypl6iIxZB7A90OZ5lO3Tj7R9QX383tJNsV3B0hwToW+mWDlGkFkR9P1
        Xe+E9Xh63VnL4cw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ADBD1A717C;
        Mon,  7 Aug 2023 17:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF3ED1A717B;
        Mon,  7 Aug 2023 17:09:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] mailmap: change primary address for Glen Choo
References: <pull.1561.git.git.1691433710768.gitgitgadget@gmail.com>
Date:   Mon, 07 Aug 2023 14:09:00 -0700
In-Reply-To: <pull.1561.git.git.1691433710768.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Mon, 07 Aug 2023 18:41:50 +0000")
Message-ID: <xmqq350ud0gj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A215B4BC-3566-11EE-ABDC-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     As mentioned elsewhere, I will be leaving Google. I've enjoyed work=
ing
>     with so many folks here, so I'm sad that I won't have nearly as muc=
h
>     time to spend on Git. Nevertheless, I'll still pop in from time to =
time,
>     at least to fix the bugs bothering me the most :)

Will queue.  Don't be a stranger.

Thanks.

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1=
561%2Fchooglen%2Fpush-usmowlsllvks-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1561=
/chooglen/push-usmowlsllvks-v1
> Pull-Request: https://github.com/git/git/pull/1561
>
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 733e047aa82..dc31d70b8c1 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -80,6 +80,7 @@ Frank Lichtenheld <frank@lichtenheld.de> <flichtenhel=
d@astaro.com>
>  Fredrik Kuivinen <frekui@gmail.com> <freku045@student.liu.se>
>  Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.com>
>  Garry Dolley <gdolley@ucla.edu> <gdolley@arpnetworks.com>
> +Glen Choo <glencbz@gmail.com> <chooglen@google.com>
>  Greg Price <price@mit.edu> <price@MIT.EDU>
>  Greg Price <price@mit.edu> <price@ksplice.com>
>  Heiko Voigt <hvoigt@hvoigt.net> <git-list@hvoigt.net>
>
> base-commit: cba07a324d2cda06dd7a7b35b4579f800de024aa
