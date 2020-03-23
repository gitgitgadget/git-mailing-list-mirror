Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286BCC4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3232072D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="V2Bgs3bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgCWN6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:58:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:42437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbgCWN6O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 09:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584971892;
        bh=yM7FRI+egCCkAlN+ykcTBYP6DKt6blwr0TaO1FnlPnk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V2Bgs3bcW/pTjq6MSrv42AmH6IizYbzdfQRkQhxqIsCJm7v+Pqc2CPpoixDJZy4Hp
         YyKLBKhG9pup5xT3okmhiKDJlLm8GQyFIhw2SMGAylscToVM4JSGPXRprFw8HxDAji
         Kzmdrt4LfUcvSV1FqmUdIWgjTaR/6nuoD5zZqPec=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.97]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MdefD-1jpiTd34AT-00Zk4z; Mon, 23 Mar 2020 14:58:12 +0100
Date:   Mon, 23 Mar 2020 14:58:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] t4124: fix test for non-compliant diff(1)
In-Reply-To: <10f39c3d30d13e9141f081f985a0620954cc7493.1584838148.git.congdanhqx@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2003231456200.46@tvgsbejvaqbjf.bet>
References: <cover.1584838148.git.congdanhqx@gmail.com> <10f39c3d30d13e9141f081f985a0620954cc7493.1584838148.git.congdanhqx@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-290645346-1584971893=:46"
X-Provags-ID: V03:K1:5PkHeT+s+MAqTgNBFE2APZS+WhfRSbVFwj3w5w1R5V0/9iau8h3
 jljoZEpjO+elmGqVDXJOkdK8QA22bbElDUJSX8gS/NKA4YGgQKBuGkRIyjD1HEpfILy5dFU
 Tnjg/HavQwvKQbigx2u6VG5pdNUPRfyXUxVVKf8aOkm0YquFHEOBsO5XijCszA4ay/2652P
 nyPLNKrcfPtvS0OXPIvWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fhmMatk+YYY=:QKdWejQV4ec/EBfB9R4/5x
 r/CSNzuhTEvkK6VVyAn5w8XrRQmjB4p+VqCSzcCI+KLilRK+9yYLI2w5u7SJv98ugIdwB3Kvb
 +UiM75SA5rPlAZMr1Xtuk4jkJ28qnXoynZ7vMtZ4rgvgUEc0o/nykmA3250krjm7Kge9ivDAL
 yKDY7ujxCFYFRqx77s3O1vUNA95EibvjcEX4Knrty5PV2GUOgz6BvKzGrqXUD7M2T6HJU2hVM
 24idcO7MMkwLRGfsNPCxjNG3rO9I6c8LPt9HvCLZXBCcl0Ee0WLwUd87V/AcaHm4eS04fC7W6
 xua/waboXeS1zfSWp2VVAl8pG9RmUolGyZZeDMJD6FOAY93UrK20VNr9GiW3uFP+cr5kkj3hk
 ZwkR4G26/q59a77opnJ9NLO3aYEbmT7IzppRhCbRnRa524nU4Z39jqt1MtCnvR9OL1c7n2qmI
 Qkv3oE9TkteICW9yIY/wXuiIIg/XEF5xEB5DWSeKNEBn6hRbaTWljFT/YyOvRFwZT8XCO8phF
 dD9bpoKr5Iyvnf1H7DukLpTnSp4S3/9EozxVBrJVrL3neZE+rePZe2qGLBt+AX3YjjdvNvGqs
 1wrJVxo1IOd+nBZO3Sgo07E9KXDmKfLBoilfJVPdUUoEnTa74D4O4KvE32gBJ7FtN7XuWuAJR
 s738m2CgL7qaHHf/zQCu4I3aJVEK2bt00vURZ+/5jEbVZZCS7f57wATtIXf/IfHRqOyCfidHr
 oKqGzX+l7f7nbY9BJArMD6nfyI9grwe9fWeKhzIKiS4JJWq2eB6EvaytCQevNC/IrlDivplra
 05YWGxYmosWvAGcY0CJciw7VZfykxr9urYsnIeuug1KdqCm9UAFgC/N2WXDp/OqmjbOK1PvWh
 xuyBCR6noKL8dpeB8BvGjorQxrV62//+9lzPcGgn+q+QaOOEOI2/VZQCmCoGG2aAySja+qreE
 953l6H6q9PF0HpnVSR20WEpUMrnBBSecR87ugM6pNVojl/5dQqfvRwbREJjzgn+0o38sVn1wo
 B5Vpp660tSQUIL8PlYQP8J5E2NgE2MffXfiDc3n7L8dEdraHcc1uKMGexZC+dSBvQV+FZJXcf
 7AsosBhZR71kPofBy/5zv8O7ArfBmGiWHnsL3UbQBPCeNeMcmXwFyYj3sor91lZaWbPDZqPes
 Fwc3w8IvfarfeNMiEqXFDVRwYrD7UfZU5dnwQzuU1/1iU1El5asO8RKTLoM5XePESoKkcAfe5
 NxEl3J9s0yLRVgGX/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-290645346-1584971893=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 22 Mar 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> POSIX's diff(1) requires output in normal diff format.
> However, busybox's diff's output is written in unified format.
>
> POSIX requires no option for normal-diff format.
>
> A hint in test-lib-functions::test_cmp said `diff -u` isn't available
> everywhere.
>
> Workaround this problem by assuming `diff(1)` output is unified
> if we couldn't make anything from normal-diff format.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gm=
ail.com>
> ---
>  t/t4124-apply-ws-rule.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
> index 971a5a7512..075b1912be 100755
> --- a/t/t4124-apply-ws-rule.sh
> +++ b/t/t4124-apply-ws-rule.sh
> @@ -52,6 +52,12 @@ test_fix () {
>
>  	# find touched lines
>  	$DIFF file target | sed -n -e "s/^> //p" >fixed
> +	# busybox's diff(1) output unified format
> +	if ! test -s fixed; then
> +		$DIFF file target |
> +		grep -v '^+++ target' |
> +		sed -e "/^+/s/+//" >fixed
> +	fi

In my patches (which are too unpolished to contribute, I have not found
time to clean them up in several years), I do this differently:

=2D- snip --
commit cb2f3a28dbf40b92d3d9ca0f3177cd5afb7c4196
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Wed Jul 5 22:21:57 2017 +0200

    t4124: avoid using "normal" diff mode

    Everybody and their dogs, cats and other pets settled on using unified
    diffs. It is a really quaint holdover from a long-gone era that GNU di=
ff
    outputs "normal" diff by default.

    Yet, t4124 relied on that mode.

    This mode is so out of fashion in the meantime, though, that e.g.
    BusyBox' diff decided not even to bother to support it. It only suppor=
ts
    unified diffs.

    So let's just switch away from "normal" diffs and use unified diffs, a=
s
    we really are only interested in the `+` lines.

    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 971a5a7512ac..133557b99333 100755
=2D-- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -51,7 +51,7 @@ test_fix () {
        apply_patch --whitespace=3Dfix || return 1

        # find touched lines
-       $DIFF file target | sed -n -e "s/^> //p" >fixed
+       $DIFF -u file target | sed -n -e "3,\$s/^+//p" >fixed

        # the changed lines are all expected to change
        fixed_cnt=3D$(wc -l <fixed)
=2D- snap --

Food for thought?

Ciao,
Dscho

>
>  	# the changed lines are all expected to change
>  	fixed_cnt=3D$(wc -l <fixed)
> --
> 2.26.0.rc2.310.g2932bb562d
>
>
>

--8323328-290645346-1584971893=:46--
