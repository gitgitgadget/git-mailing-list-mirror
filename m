Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891BE1FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 21:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbdALVc5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 16:32:57 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:27868 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbdALVc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 16:32:56 -0500
Received: from localhost.localdomain ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id RmzJcW0LO0KuvRmzJcL1ey; Thu, 12 Jan 2017 21:32:50 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=nHg1GVFOF_gFkD2-UdsA:9
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] updates to gitk & git-gui doc now gitview has gone
Date:   Thu, 12 Jan 2017 21:32:37 +0000
Message-Id: <20170112213240.7972-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1.323.g0305acf
X-CMAE-Envelope: MS4wfDMPUe0FO9eqpM9+rMs3WMsv1sAJvn8qYrr59YiEnTP7MwvMnNbrL185BBhMhWXjf1s/kJ5qxM+kSkwRj9dvGt+8aEVmo5Jv2ETbxOxtbA2syBmDyKiq
 0d6POQV3jRXO4fAaIVAvEW/w30KFmZuQIwl/Hz9Km7ny7RRZzJr9qA/z52Dw/gY8zVy1+5HM6+2dVRgEGDFEvFZZpmJGPMntLj8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitview was removed recently.

> Sent: Tuesday, January 10, 2017 11:48 PM
> Subject: What's cooking in git.git (Jan 2017, #01; Tue, 10)

> * sb/remove-gitview (2017-01-07) 1 commit
>   (merged to 'next' on 2017-01-10 at dcb3abd146)
>  + contrib: remove gitview

> Will merge to 'master'.


Lets remove the reference in the gitk man page, and do some other
fixups while in the area.

Philip Oakley (3):
  doc: gitk: remove gitview reference
  doc: gitk: add the upstream repo location
  doc: git-gui browser does not default to HEAD

 Documentation/git-gui.txt |  2 +-
 Documentation/gitk.txt    | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.9.0.windows.1.323.g0305acf

