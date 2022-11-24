Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3769CC433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 08:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiKXIlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 03:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKXIlO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 03:41:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502CBDF15
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 00:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669279264; bh=r9H/r7vlRhVJYQDxTr2/ko9hbGtCLszoZtqto3TnT8o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dq2OrW2QVBlv+TnR0HCwZCcGJI+qsffuB3NvXjMXsQ6atDx6QDA46tyy9MvMeuBwZ
         KRqDfH8QAqfJlERFCPJZWuW81fP9WiOGPpmh2dcJZJxWGkWwshf/n37cjr2ie78VKA
         miSKmDPjW+i1VisXYrVIeqBpMpNumGp9PT2YxbRUBdQRHOc7/W/o5bb9bBcEixrXI4
         a+mwT1ejsHRL9gJnJWFeIQWh8JWt3aCU8Vrx3yrClW++L4YPQl4/5FlsdkLFZsCMDb
         O/XqK77T7+SZIrBsRLdpZYyKI9mVeJwvgtyT5PkR01XdELs9RCNV8AWE9sAqyVakF3
         YFDmZz74sPSiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.58.20] ([89.1.212.70]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRRZ-1oQLO72Ro3-00Xu7G; Thu, 24
 Nov 2022 09:41:04 +0100
Date:   Thu, 24 Nov 2022 09:41:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] ci: upgrade version of p4
In-Reply-To: <n79194n5-8q94-29n4-s447-64r0p2po4r76@tzk.qr>
Message-ID: <9q4525s6-qrq8-1841-n257-711328352n85@tzk.qr>
References: <20221123150233.13039-1-worldhello.net@gmail.com> <20221123150233.13039-3-worldhello.net@gmail.com> <n79194n5-8q94-29n4-s447-64r0p2po4r76@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PUUpkuRjtWqmb4vwGZ4qY0t2Zo8kAmilsblbd6BSlO8T5OUQeGO
 PNz7m/CB00EJIarvLMGeepijvIVI8Dmr9RWccuPFzKRL+Lrq5rtIiv8ZR8YIwX69AqpDyqW
 dI5I6R/sk2YJ7e1iP+604IQdfatcO4wLDMqMLzyThfe50Ma0e6/rVggCmptgOOSjItazOjz
 Kk/YuRklZHSN+jrLm9TVw==
UI-OutboundReport: notjunk:1;M01:P0:ho16F4SCBqg=;3WT2vQE2OGLMCsSulJDmsbbKPJ0
 wRyOw3scRIS34d/WIuEPaH3N1m9cwKlCTaERvV19zyFnN8ZsMEoNP7ux1JGOolnYqqds/1GCk
 cIXmmkAlHuhCGn0eYq8JNmRqyab3Ltnc+sWMlXNsMqzNRZnM14jubu9HuU6Q8+KrxXFivlhK/
 iKQ99TzsOWmn11lWcAZXjywZbelDZhHf85f5y1oHFB1wthNVO8xv3xrKH83vE4K99k+vcBK0o
 6KAvcsUrq1OmioE2vvdWvPMHYmV01vqTFIesi2KyAeQ+X0D7q5bLXCSSXICb8NjmHviSkhN3k
 +5olft8y/1nOfOYend8UA/RaUpUDnxahT5qQ4ZhTwGObGdfQ7Pw9YYiPhPMTgxcXP48Q+vbEP
 duvHk8jI9SLlOGVpPx765nZsIlnfFXaTjPNA1gNEy3J3fGQeHD2nDsEg5Sd6AJlu+RTi5eRig
 99RGImXS0L5uQy2yd8QrqgSHD/lJPePubYNqBLHOf/dYMHeMDqzGIj1XfBnXFNzRa9VX0mo+G
 VTqv6IQTopjnSPOaRbvO5QIXBYtlrKYZGCH89cgj2PnE37I0eSRqgzCdgKmXriv4I5MuMNoSA
 rxrE7+9np8KNrTi5pmlcHSq7FxFW0PvbxG5VDb88gNixR+ltc5/eNf+czTHaXDzvFcTKwPF8r
 3EXA17nRpwc3Y5akIjDEGjf4lZqz280EbMefOB1v+4d7Kw1o0uOz5PF4FqsrTq1CSWMQ5J/5/
 VYOWpWJotqgW6h6VEzWFZ7N/S7IgOqKAmCWjo0sqe7pVrl3I+c88cQ1DlPNwvSlvj3fo8PxDf
 ESRlDoTAOGiohu6KS6VCj/BSFRnGj1+uQnJ+pqwH/id6LEtLvUToOr8hhccvA1sYY+G23KyOs
 mpfAlGTaovyq9aUaB8i31ny4VmXiLlCh5y79giCOiHy3w3bc46S4yBEbJLaTRZs2ZnlfOzgkT
 ETUdJQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 24 Nov 2022, Johannes Schindelin wrote:

> On Wed, 23 Nov 2022, Jiang Xin wrote:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > There would be a segmentation fault when running p4 v16.2 on ubuntu
> > 22.04 which is the latest version of ubuntu runner image for github
> > actions. Upgrade p4 from version 16.2 to 19.2 will fix this issue.
>
> I was about to embark on a debugging session when I had the splendid ide=
a
> to look at the Git mailing list archives to see whether anybody else had
> encountered that particular problem.
>
> However, when I pushed a branch with this fix, it still segfaulted even
> when downloading version 19.2 (link:
> https://github.com/dscho/git/actions/runs/3538788474/jobs/5939977231#ste=
p:3:387):
>
>  + wget --quiet https://cdist2.perforce.com/perforce/r19.2/bin.linux26x8=
6_64/p4d
>  + wget --quiet https://cdist2.perforce.com/perforce/r19.2/bin.linux26x8=
6_64/p4
>  + [...]
>  + echo 'Perforce Server Version'
>  Perforce Server Version
>  + p4d -V
>  + grep Rev.
>  + echo 'p4d: bad version'
>  p4d: bad version
>  + p4d -V
>  ci/install-dependencies.sh: line 91:  3051 Segmentation fault      (cor=
e
>  dumped) p4d -V
>
> I guess I'll embark on that debugging session after all ;-)

And I did. It turns out that r22.2 works both on ubuntu-20.04 and
ubuntu-22.04 (I locally verified for the former, proof for the latter:
https://github.com/dscho/git/actions/runs/3538941550/jobs/5940295721#step:=
3:384).
So I propose this fixup:

=2D- snip --
=46rom 81e2d9a4f6ad2d2d9df27edfb666fe2112bdef57 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 24 Nov 2022 09:31:41 +0100
Subject: [PATCH] amend! ci: upgrade version of p4

ci: upgrade version of p4

There would be a segmentation fault when running p4 v16.2 on ubuntu
22.04 which is the latest version of ubuntu runner image for github
actions. Upgrade p4 from version 16.2 to 22.2 will fix this issue.

Also add some instructions to show errors of command "p4 -V", so we can
see why the output doesn't match.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
=2D--
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 6c658fa21227..eaa75ab3c07d 100755
=2D-- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -252,7 +252,7 @@ ubuntu)
 	# were recorded in the Homebrew database upon creating the OS X
 	# image.
 	# Keep that in mind when you encounter a broken OS X build!
-	export LINUX_P4_VERSION=3D"19.2"
+	export LINUX_P4_VERSION=3D"22.2"
 	export LINUX_GIT_LFS_VERSION=3D"1.5.2"

 	P4_PATH=3D"$HOME/custom/p4"
=2D- snap --

If you squash this in, please feel free to also use the updated commit
message.

Thank you,
Dscho
