Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB6AC3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 21:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8F620838
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 21:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DarWU4j5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgCDVj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:39:58 -0500
Received: from mout.gmx.net ([212.227.17.20]:40249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbgCDVj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 16:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583357994;
        bh=J7m/Co4H8PMwWY+6zAK8xboGABP7r1u66TD3i4YElNc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DarWU4j5JSdt3NNKzzLqIJ3pkyXeTbvNsepnvOSsN5d9XpwTUnjF59YL1/JexOVCB
         nDR0Inzf/RHCFSUoxOYVktvzmQ+XwMNtUHOcgq3dQd0ATRVFPm76hhtiMmyr7W7FZj
         sznPU/5MQqY9g9aQG7I1h3RK0vVWatQYz7rXKmBY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.189]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MS3mt-1imHSL2rZj-00TSfN; Wed, 04 Mar 2020 22:39:54 +0100
Date:   Wed, 4 Mar 2020 22:39:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 5/5] bugreport: add compiler info
In-Reply-To: <20200302230400.107428-6-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2003042236060.46@tvgsbejvaqbjf.bet>
References: <20200302230400.107428-1-emilyshaffer@google.com> <20200302230400.107428-6-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RqYq3f3gIzAVIcJo2aVXqyuk1JUnGJPnfPHhuVaN1+sqgGx8O7U
 Im6hTmQ65rr7OsmOXQuR+WNVd7gGJolKH/PS7JNj9fY7mTgsCCkmac/Vc9gYIg1zF0f8kDF
 DjGwjA8xibWqCt+JUbaMjrIHLLQUU/hjXwk05kjxMobhpk1vqxjGpcIfaGO8OSl0y5YzzfS
 fx1Qww2IgStjf/ZeyRwQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h9lEdu39XDI=:9a3rMBv3QTEiSQop7Bl6wi
 1JYDcav0hjjoe2k+1SFScjT848mQNS4F69/nopEQAUvtlyIca2MX9IdGTYvw/fXzIvrZqItJD
 MTgq7ts6tiLwL+yNi/lE3mRIgD5ckRRhiAwawAgL7oFheQQS46Y0Q3+8DR9e9Xi8hR61ZSoLi
 WX5u+a/vhfKxXcWQjaweay46CXavaILZDZm7+LWkdhMJJNie63NCYy2KidbxhZ6A7GR1zMY3h
 6fu7ttw8pi8AljOHdg3JUCquGe3cmJw8u9JEfMKw7nGbY+gMfXFJZhct8HUA075cd/1Z5rcM8
 nRUYt+ofDlmWmr749ul6iYqWFfMJ9a37KzK4xq6NExDb8PuPHb76ZYrLmlz2q2kHUL7oDgtM1
 BjiJebTewXI0ao7azQb0VlUBnLu2ai7Rfiu/N1xvoNIyLZfkpPtduxLMeKyDGaPyX1nDf+l6C
 nBrx0TdjRKo8HhRZ4WXYpLVmsTdq97ZIYOTeFt2UOg+BMVEoxtUDclVjwGKF9RsJ+Ju8/n8eR
 5LuHwEtPq1fM5xlzsJLJuRBsbmb5oH3WG1zwfwnXBV5eggjHAOvqN/q59c45+wUCoc9Bhvfbk
 7RMkZdSyBeF0ViCF2rjg8kofflN4bsJtnUHseRU9pEXL1UTTPzSxJMgs5mIpWeGk7UdQOli3L
 3S3htsKvgZ2WaP95g7eijQimOAB4QQTi+k3nz2daPY92ZvPNdBRrJ8T3UAYyMNKDZ/uqqS4K9
 JRAhHaXAz7bHc44h3uKX+UT9BaEd+KNXrjNu4BXC/dEG5H3I9PopUcIyNTyRHxWYVLfi1QJz5
 tCw4XuUY+6NMgYYjpho7a7RXffw+aGbQm4gr/n77nVwcC+yExgT6F3uN+01T2pe3kUJK/NfUa
 YJoiHVdbqeaLK4oi7zkcMmlVZlSeJL3bJET/36CUA22zWj5+RcpeTn2JhYZzYmrvPeTForKEB
 wznmdzF9dmkN7HpTGcvG9to03l++7F6rQM/pkSBDQnW5a+dA8IVka89thEu6aFGR1biy7aF5g
 IefFHje6u7FS12XmC+94zxhI/UA7ZAsmi5vj0nVeZ8BPuGhzNxyMlDPGQv/xgtFaOzsoTaEPx
 0c+I+4vTeCjRZGysvyRfCGtJvoRFF4gC45wIflbgcdyEwev17TA9piR636ed3mx99roB7ebgr
 yw+USqmTpNmitfUKirLS8FezQRgqqmyH6X6HPFBGgGt31aqDfjXO14J8MmiYxZIr33WVR85BC
 9NxrFpxzpf0z7xE+V
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Mon, 2 Mar 2020, Emily Shaffer wrote:

> diff --git a/compat/compiler.h b/compat/compiler.h
> new file mode 100644
> index 0000000000..21f098e6a4
> --- /dev/null
> +++ b/compat/compiler.h
> @@ -0,0 +1,38 @@
> +#ifndef COMPILER_H
> +#define COMPILER_H
> +
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +
> +#ifdef __GLIBC__
> +#include <gnu/libc-version.h>
> +#endif
> +
> +static inline void get_compiler_info(struct strbuf *info)
> +{
> +	int len =3D info->len;
> +#ifdef __GNUC__
> +	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
> +#endif
> +
> +#ifdef _MSC_VER
> +	strbuf_addf(info, "MSVC version: %s\n", _MSC_FULL_VER);

I need this to fix a crash in the Visual Studio build's test run:

=2D- snip --
Subject: [PATCH] fixup??? bugreport: add compiler info

As documented at
https://docs.microsoft.com/en-us/cpp/preprocessor/predefined-macros?view=
=3Dvs-2019,
`_MSC_FULL_VER` is an integer, not a string. Therefore this fix is
needed to prevent a segmentation fault in the test t0091.1.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 compat/compiler.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/compat/compiler.h b/compat/compiler.h
index ce6a7f6de9a..ac90fa051dd 100644
=2D-- a/compat/compiler.h
+++ b/compat/compiler.h
@@ -16,7 +16,8 @@ static inline void get_compiler_info(struct strbuf *info=
)
 #endif

 #ifdef _MSC_VER
-	strbuf_addf(info, "MSVC version: %s\n", _MSC_FULL_VER);
+	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n",
+		    _MSC_VER / 100, _MSC_VER % 100, _MSC_FULL_VER % 100000);
 #endif

 	if (len =3D=3D info->len)
=2D- snap --

Could you squash that in, please?

BTW the two issues I reported in the earlier round are still problems.
Could you squash my fixes, please? For your convenience, you can pluck all
four of them right off of
https://github.com/git-for-windows/git/commits/shears/pu

Just replace the `???` by `!` and you can even use `git rebase
=2D-autosquash`.

Ciao,
Dscho


> +#endif
> +
> +	if (len =3D=3D info->len)
> +		strbuf_addf(info, _("no compiler information available\n"));
> +}
> +
> +static inline void get_libc_info(struct strbuf *info)
> +{
> +	int len =3D info->len;
> +
> +#ifdef __GLIBC__
> +	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
> +#endif
> +
> +	if (len =3D=3D info->len)
> +		strbuf_addf(info, _("no libc information available\n"));
> +}
> +
> +#endif /* COMPILER_H */
> --
> 2.25.0.265.gbab2e86ba0-goog
>
>
