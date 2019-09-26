Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D9D1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 12:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfIZM5n (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 08:57:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:48003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfIZM5n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 08:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569502661;
        bh=2NoQRIIKhldfFsgO3/C55h99f/MZJAnvVbTIsfS+Mjo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JYpenCpEaqBp79M4LgSWOKkA+9IVqz8AcAkLPtbAKVmkdl9AcH6nq9Tp9REShc5HZ
         GPFwO6AlNBKVjE3FkD/17G4VYqo+FGNs/UL7ubLLan0ZBDo/3OVVDPXdYK8QaueQtL
         rxnUJ1kSvkPFqmAgwoA0iCE0Zswvyvl5rL1I5PSo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC30Z-1iJDRY1stB-00COIk; Thu, 26
 Sep 2019 14:57:41 +0200
Date:   Thu, 26 Sep 2019 14:57:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] fixes related to `make hdr-check`
In-Reply-To: <cover.1569263631.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909261452340.15067@tvgsbejvaqbjf.bet>
References: <cover.1569263631.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UkRNpbJYWma2EVlwtEYPBgLE7q/28mmog1btUSPFZmU0NFytIHM
 MOS/l2fnuAIJDcNx0GQhX7yjT5sFuh6SDtSMPYQ2W1oLGMLJ7+H2nlWgdRtmIJYXi+wMTTJ
 YfeYmxkgFb4/s+COkCgdgtCCSgId5uhChBkgLouzb277iY/p10Jd2fKfkxX7yb3CY5u5dPJ
 MywwBnDTNXk8FMv/Fz1Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nZyYoSh2fBs=:gLplEtEBgy1IXGE+AmvNBk
 nEdksDmTpijKjxpWJdgSVcHqpOzjj6D5hWh9x2LxahB/rufslsTLW/Kt2VRzvflWniSqSRhVD
 YDp2bqk7VxSz8mahx6IoYh7GIwibPDxsYIgu7pMENR5jx7lXnp0APcQYQVaDbrDaWnSy1p8IK
 Xe0mq0KE/TRHSYR+kV9E8ASTVURdzDG2QCh3GJwPVaC6pZ0Vcq1Zmurjz2M4Kr9tKM6Hop7UQ
 Q8MircfV3VN193RXJBo+ZTgV0sitGic3xFT9EEWOK9QNEvHmXmuzojbQsbXQll1QFJgClLjP3
 0W56ZzPNOVp5vu9TNPOziMP0lBLX0xJzpI1PnSqfQscZWmnO8pcVhtWYitg6p6fiIp9WSHivf
 xQdNoQ7SWNmZbXD60UEA85fkb8EU6TZWW9s5mh6xeh3QkY1bMjBzM6ZUUbarEgguUXFl/5PSG
 N868MVHV0E2RPCGLBG6gRD+RD9gNqJHckEZsrj4k78/7bH6jBYw78Iy5wi+I8iA/eoTmN2GlE
 vf2QiVMqo4UM14u1XFqfTJ3P/gOJzANzj0s/NZSooA01WtpVlMiq/7B1v3f3Q/AKCJtK1gXe7
 l6WlfGLKLFxaSLalbJ5pnf50M0Mjh5Q1mfB7FOlNNneXrB4Aa1tIF0bwtsjOdbObDU/PhzGpu
 xX0sX5ih2gVI1+bRs8GRIKVqhFVsxCrUDPD0rm6TlDEgz2vVPfva6e9ikIzEvevoTCsQKPzMX
 sH5Oj+oCUkBMePRCnONam4DANWazeylrxV1O3IUffLtUcXYihHGpJ9zgnPhj9SlCQtM5lp6zh
 w46CRpojV5jxhzEquikaLC9x4SO9Is6Ic7gfHcDFunr+qeHA4/0tRG3u7DqUx+dVf8Ecp4qFV
 b516XiwWwTTj0tHKgK2lyboS47xv5Imnk42RYxy750cq9pAAa5MbzqFsi5X+amwLhOl48fohE
 eZXeStsWv0qHrKiY01pMUhCN0SCq8RGfNyDTyBeYIzXPIZFq7kC+jnVfpcMHLfXoLQFANNDuN
 rkKx2umObKWcYex3R227dWKciDoVOgrTClLzfAh+o9pqlaZmnpck5VrePI2b6OYB24GB8X9Au
 9fH4nSM8XIidjO/sjT+7BF4pNl+GZqqpLeZesmlsE9HnolMO+P5YeV1tL5/Vhh5Jd2pBme7rR
 mPu/ioLuK0sqQS5SKtZKdUi4xxlONqwjGM/g8DatKIbs2keT+kKk3Ii+6CEMYw6ct8HIM5PWt
 1k5gjf9oQvH9Gwtol3NCBh7Qb/El+G1UVKCQbNikqCT6E+HpK+1X90XpCk3Y=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Mon, 23 Sep 2019, Denton Liu wrote:

> This patchset relates to `make hdr-check`. The first patch addresses
> getting it to run on platforms which require custom CFLAGS.
>
> The other two patches address errors/warnings caught by actually running
> `make hdr-check`.
>
>
> Denton Liu (3):
>   Makefile: use $(ALL_CFLAGS) in $(HCO) target
>   apply.h: include missing header
>   promisor-remote.h: include missing header

These all make sense to me (including 4/3). I wonder whether we would
want a 5/3 that essentially does this:

=2D- snipsnap --
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index a19aa7ebbc0..65bcebda41a 100755
=2D-- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -26,4 +26,7 @@ then
 	exit 1
 fi

+make hdr-check ||
+exit 1
+
 save_good_tree
