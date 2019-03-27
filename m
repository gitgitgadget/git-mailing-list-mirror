Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MIME_QP_LONG_LINE,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BB4420248
	for <e@80x24.org>; Wed, 27 Mar 2019 12:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfC0MZ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 08:25:59 -0400
Received: from n1nlsmtp03.shr.prod.ams1.secureserver.net ([188.121.43.193]:55790
        "EHLO n1nlsmtp03.shr.prod.ams1.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728696AbfC0MZ6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Mar 2019 08:25:58 -0400
Received: from n3plvcpnl110358.prod.ams3.secureserver.net ([160.153.140.31])
        by : HOSTING RELAY : with ESMTP
        id 97c0h7UPpVoev97c0hGfBH; Wed, 27 Mar 2019 05:24:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m-mooga.com
        ; s=default; h=Content-transfer-encoding:Content-type:Mime-version:Message-ID
        :To:From:Subject:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Yg4nOLkPDRwg5S0glCmeboMU9iOClsrrmP3aDDr8lL0=; b=22n+oPmH0Yeta5XjsiDQur+MIM
        RQ3KJWsN0WIxh6Az0xwOxNvfidHxD7cpqhUJQKbJrHofCFRHSnCA45//0bHedaIgtA4SmhNAC4Pw3
        v3KaaOszdTqKMRT0Q6kHsxmUWOiHPiDv6WNZmazskJR0+DzicQyCiz+d5RnvD5TkZUI3c5sXalSrw
        dT65TWgR6Nst92en3nb7ybqaxhr5plXNJQCnbugTVtXtHp8/+bMIXmIeP47CmVDSjz1TzbPsthJ1j
        Y3DoAUB6NIWUN9t28Xx/svpENL/52UHTVfPXtDdKcvUGJT374Sl4IShLfSNMx2CaZoPoV6EjGQvez
        tEq+3JkQ==;
Received: from [141.22.241.209] (port=53696)
        by n3plvcpnl110358.prod.ams3.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <contact@m-mooga.com>)
        id 1h97bu-005Ncf-IK
        for git@vger.kernel.org; Wed, 27 Mar 2019 05:24:55 -0700
User-Agent: Microsoft-MacOutlook/10.17.0.190309
Date:   Wed, 27 Mar 2019 13:24:25 +0100
Subject:  [GSoC][PATCH] microporject test_path_is_*
From:   Mooga <contact@m-mooga.com>
To:     <git@vger.kernel.org>
Message-ID: <1A5DE2FC-7D94-4785-A915-EA2A71C6C377@m-mooga.com>
Thread-Topic:  [GSoC][PATCH] microporject test_path_is_*
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - n3plvcpnl110358.prod.ams3.secureserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m-mooga.com
X-Get-Message-Sender-Via: n3plvcpnl110358.prod.ams3.secureserver.net: authenticated_id: contact@m-mooga.com
X-Authenticated-Sender: n3plvcpnl110358.prod.ams3.secureserver.net: contact@m-mooga.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4wfFzO7Bw6pEm6syPyomj6hr71F/shf3h3Tec4aekuIftuoXqOT5AiHuotOiqUB2PDnJ5SdSVM75PAg3Js1HehHytoNawwyhztyvydoRg2gBruBiZaMrNo
 Xv0jTUJH4+r/onkDqYY25Ag9lQj0n/birNYoOEgl7hGlBuXLHExDuWJCoFkqOJLPUlCCKUne316QQ3ptgA0ICJiyHVV2qz4/1WY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


So for example=C2=A0=C2=A0that is git diff

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 286bba35d8..fc82965a0f 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -66,7 +66,7 @@ test_expect_success '"add" worktree' '
test_expect_success '"add" worktree with lock' '
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git rev-parse HEAD >expect &&
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git worktree add --detach --lock here-with-lock master &&
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test -f .git/worktrees/here-with-lock/locked
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_path_is_file .git/worktrees/here-with-lock/locked



I would like to hear feedback if I should commit=20




