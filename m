Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B912023D
	for <e@80x24.org>; Thu, 18 May 2017 10:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753819AbdERKDL (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 06:03:11 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:19718 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbdERKDK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 06:03:10 -0400
Received: from lindisfarne.localdomain ([92.22.40.87])
        by smtp.talktalk.net with SMTP
        id BIGsdcxC6xR4bBIGydCNJ2; Thu, 18 May 2017 11:03:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1495101789; bh=D4jP0p0fgt/6psHGS13sEgYVhd83OfDSf0ztgCYPV+I=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=Q/O535QV0qjgvw+CM9laUgmxsD1bnPJ0L9R5wix+3bNLUH4nu48DCwGgds9kYkgK4
         8LneyRdTcIBZLTl0wnpCNyex4MVp/u5OWG1ZXWBt+lCXZr4ke+nzgpUKH0II1I+CL3
         mFTgCukyGlhiCSqYNJ8xS6X1siVkVXAqd4ZUbpb4=
X-Originating-IP: [92.22.40.87]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=Uk7VDCfhaeB8IHNEy8al/Q==:117
 a=Uk7VDCfhaeB8IHNEy8al/Q==:17 a=evINK-nbAAAA:8 a=hm08_smbYGlZgFOPTvUA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/2] Fix a couple of minor rebase -i regressions
Date:   Thu, 18 May 2017 11:02:31 +0100
Message-Id: <20170518100233.30559-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfO4FG1PnBUcT6yAiz/DQfaxtrE+VDblTrl/0ROSfMp1IR08BjuIbhdmTneBnwBJCLORkv5I3udGbloMQNwJFnFjlwKef4Zgso4Wnf573IdPET1vzFjtx
 j114A0UnQRAVTL+HBW1wgFxF9CRgI2nvR+Ru49e/3VQF4l5T5NQznlKDXJYSawzTylPJ8iYiqcWqDBADc5GvJuN57LPK1pSjV0lFkariqhli2YYFGCXApHvJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

These patches fix a regression in the reflog message written when
rebase -i finishes and supresses the status output from applying any
autostashed changes to match the shell version of rebase -i.

Phillip Wood (2):
  rebase -i: fix reflog message
  rebase -i: silence stash apply

 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.13.0

