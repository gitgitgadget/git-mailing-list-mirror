Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12AE520899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbdHWMKy (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:10:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:65209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbdHWMKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:10:53 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue003
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0M9LBa-1dqWNY45Pi-00ChkY; Wed, 23
 Aug 2017 14:10:51 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     hIpPy <hippy2981@gmail.com>
Subject: [PATCH v3 0/4]  Keep merge during kills
Date:   Wed, 23 Aug 2017 14:10:41 +0200
Message-Id: <cover.1503489842.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.426.g4352aa77a5
In-Reply-To: <xmqq1so34m6d.fsf@gitster.mtv.corp.google.com>
References: <xmqq1so34m6d.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:Ko1mW+a/Q0y12IRKsP9Mjv3k0zFQIcPNQir6PfBzDXzdWSoTn2X
 Xlq6gON9Br1i3PxSm4BK00a2ueVsLfSsm47Iqle/25OL1AfLQL6xo7MtW+KmU3b9rbOKTqx
 3TkdS0hP9xsjmWgk4Rt8WGHYJLLFxdFyAyswthh7YXAbmSDNe3sJk0h9zcsV60tCF/eLUr5
 wNChmRr1a5TZN5d0xHuSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6JIfkBHIojs=:oz+eMluosCetyXV461d9+L
 Tb9v0X7nw/qIDDqAf0NqSHS747ry+/o1tXdvjEuBVG6q6r0zd6sT+Vp8oXawdsAA2rRkz9AmF
 6I2t/2DLtJxrVgb9yGfY9H4bQcgZByw4xWvIxXE89zy5yTwtjE1b/yjzfPaD0Fy1cLJggl+vz
 i3GJhCiN+mVNo4nE5ktY0/qxw6h2oJ/SlKq0hbT1YWK6ylhebs19aCLv7OEwDXDkhMTw5tb0H
 UtfCBa08cYhW2NHo70T43Y+OoIrfzUkXZThdJymiqmNDPRaw6CrmDoMxeOlBZK5o9zWesBS25
 T5w7htqJ9pUVTEW8Jl/PjYCwb2ajn4QShDKZd5jWjuOg6ETUBrXFLbLJfEZVctp3ia7HBTKwh
 e+Bh5fxuJPXVgEU5C/GWT3hyjtZ66qzxqWa67+jDVQW2yOwf509KdyuT9j3Xd/PceBfHdBbOd
 pO4ALR/S6BWGIt0BYwYeW9OF9bnJ4OIZkFd4Gh1lvv5aXXBxzDMegRcbd+fpZhj8qU30kvB1A
 x/fgrP2x1ViV576pXUOB5cja8mdlX5vrZ64XGD+abohjKPlr827ntVuP9Kl3vxK/jqmId/tjg
 JfDynC9sDoEQvo/kxEgpNyY7EH/UkEQvonQTut1L0GVJyHXRE8Z1EauyBFQH6pZpzbTnUvbfA
 sq5PVODmNA+twxxtqDBpXaAnIzqrtzrJ029AqejokgyLSKHG4sNsX1UFJHjLYTFgP3oE1SMzS
 wN0PF8GxSyE1ID04kU5yoN2maZkZCqzim2Nvhg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to the 3-item v2:

1/4 == 1/3

2/4 is new as per Junio's suggestion: clarify the call-chain leading up
to prepare_to_commit()

3/4 == 2/3 with amended subject

4/4 is 3/3 rebased, squash-if removed

Michael J Gruber (4):
  Documentation/git-merge: explain --continue
  merge: clarify call chain
  merge: split write_merge_state in two
  merge: save merge state earlier

 Documentation/git-merge.txt |  5 ++++-
 builtin/merge.c             | 15 ++++++++++++---
 t/t7600-merge.sh            | 15 +++++++++++++++
 3 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.14.1.426.g4352aa77a5

