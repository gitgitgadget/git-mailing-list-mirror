Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A2DC433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 17:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF75961A7D
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 17:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhJBRYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 13:24:39 -0400
Received: from mout.web.de ([212.227.15.4]:42195 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233993AbhJBRY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 13:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633195356;
        bh=m11L1yhHZ0rd99p+qACnqaIjs89W8+u3NoHMYr1croc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=OQRl1jSVE8rmWt3Ny0QIY87gWI8GzXcIntPoEybvxi3FwyZAspDxyipL1aVQvrxXd
         A65AXkJXinQ2XT+APONqidupp5TqoBv8gXhnYI4x2gmYosdrYqOdCnjmUjYRe83xvb
         0+zpeNs8C6Lw/FaUYFxTkeCNPuEmW9rJBDNkO0og=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M91LW-1mTx1h4AKs-006Wqy; Sat, 02 Oct 2021 19:22:36 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] p5326: create tag needed for shared tests
Message-ID: <ad6777d3-73d0-54d9-200b-88aad2d265b4@web.de>
Date:   Sat, 2 Oct 2021 19:22:35 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eUfyWeZBfPLss5uAz/0oWyIl7aeNZT1sLNQ+AeX3Q0x4kLpPyxj
 qVshqAnHxgsvKxfnfVQkNyAiHxWf52AGlQbTMw1NCWwdqjyIDM3fmBd7cnjvvBIwsO0PfGz
 BctnIVvlew+V1b7ETTHLKHW82FcB5cl+9OUAF335AOaQv8G3f+odwO9zSVLDwKtr3dLQRyH
 XmDWNAYdNdEBDclr0eNCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p1ltZkSn0u0=:Zz1FmpXE3ZdrS6dsrVcvAN
 psM0goWl51nVuYtBjYJaU7VCgPLrW1ztoTD/zwubaC/sh0bnPM+m1wnQ9XFpxsmOnAMPY27A7
 ouEvJFLdX9rWHTLuzqGxU/959LmDoL0f1SraoUcySQ9kmMvcp82nxj2cyG1miQkM+3v4CLS0F
 iv9szDz4b5bFGIZm8HOcvsMQHapF2paGIEJIJY2kS4aWHNgNe31eTDltYNeRl/Jqlxoz3Spb1
 +curdCLyoo0t1lZSTo3KSy/ITZ2xMq7focX25DtF8wYKXwFEHVwlR472eI1A3XkkR4D8QISq9
 YFXeUjxN7j23w6TDD5DsOmiaEcIk4JtFQYeSGsXogtIgWyZqbizgn28nefYumFpNpuSY62DhD
 tkX2vqKim2L5p2HNmYaBQ9kzm6sVIL64PQYsU3IJXNCtW/rbPXqLvDSDwHYkQRgxTb4ZFiUkG
 zdA/fU+jDKttduS1XG1oJI+Lx0tM56SOiFjkNWISIp3Kbck1fRLAfH4fZwlaNzGEmOaQidF6F
 +0JhndJ+Tb9sthorEtMBJ6dJSkaQHTZE6JWE24642xri4xoPwt8fjMQbDunlObLvcfKWkWhI6
 jZWzW/jh2+s8h9k5K1j6OiwuX8GX4gxh2CcfcWlCFwSw9YyvzP1JHyfkFqRIwa9+EYELaU04x
 K3VxSsSrHWBPkB/BTNEe8co1FVL/X+6KjTDamM8ssNJe8G/i4wqedPX5QRAdVo7hRajx/138r
 xMvI3lRWANyy0iVdCIJU1VvWod7teIef9FmnkB1HfJQBkog24/YZvziSmW3abK7RuFzt1jJmV
 WOjukwTVMi7ILdmp6UxtnvEaaF3RKGvWSZSprJ4tbiKWEYD0dc6HE89U1zjCmEYSiDx1RL1/m
 KuK88+knHrAyVQ8YbX/Nte8e9EaVblElv7JUJMaO7az54SVi9JSOHJYX9XT9fMcoxBujmBXkz
 +gVeYatEcPTqQIZ4kLgxOQQZPA8rRwSx76uAZ8VUolTJQcAp4xTxO2mQRlP0XpH9jU/50i8Ib
 sHVnIerBnizykJnwyQ83OPWymPNCGCWPrkKnhVgh2cYm3ZAnr3DuKSPR911/j14PzJvQgRF3z
 9/UOz1sGVbrcws=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

p5326 fails with the following error:

   perf 8 - rev-list with tag negated via --not --all (objects):
   running:
   		git rev-list perf-tag --not --all --use-bitmap-index --objects >/dev/=
null

   fatal: ambiguous argument 'perf-tag': unknown revision or path not in t=
he working tree.
   Use '--' to separate paths from revisions, like this:
   'git <command> [<revision>...] -- [<file>...]'

Reason: 540cdc11ad (pack-bitmap: avoid traversal of objects referenced
by uninteresting tag, 2021-03-22) added two tests and created a tag as a
prerequisite for them.  9387fbd646 (p5310: extract full and partial
bitmap tests, 2021-08-31) moved the two tests (and others) to
t/perf/lib-bitmap.sh, but not the code for creating the tag.  2d59597333
(p5326: perf tests for MIDX bitmaps, 2021-08-31) used this library, but
didn't create the tag.

Create the neccesary tag in p5326 using the code from p5310.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/perf/p5326-multi-pack-bitmaps.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-=
bitmaps.sh
index 5845109ac7..51b5636259 100755
=2D-- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -10,6 +10,12 @@ test_expect_success 'enable multi-pack index' '
 	git config core.multiPackIndex true
 '

+# we need to create the tag up front such that it is covered by the repac=
k and
+# thus by generated bitmaps.
+test_expect_success 'create tags' '
+	git tag --message=3D"tag pointing to HEAD" perf-tag HEAD
+'
+
 test_perf 'setup multi-pack index' '
 	git repack -ad &&
 	git multi-pack-index write --bitmap
=2D-
2.33.0
