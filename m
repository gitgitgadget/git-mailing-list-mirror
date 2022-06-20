Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACED5C43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 22:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiFTWxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345005AbiFTWxN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 18:53:13 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Jun 2022 15:52:56 PDT
Received: from omta013.uswest2.a.cloudfilter.net (omta013.uswest2.a.cloudfilter.net [35.164.127.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E242BCB5
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 15:52:55 -0700 (PDT)
Received: from cxr.smtp.a.cloudfilter.net ([10.0.16.209])
        by cmsmtp with ESMTP
        id 3PSyori1n4yys3QEvoOKb9; Mon, 20 Jun 2022 22:51:25 +0000
Received: from thunderbird.smith.home ([70.176.251.46])
        by cmsmtp with ESMTPSA
        id 3QEsomsBiJNPL3QEuolliY; Mon, 20 Jun 2022 22:51:25 +0000
Authentication-Results: cox.net; auth=pass (PLAIN) smtp.auth=ischis2@cox.net
X-Authority-Analysis: v=2.4 cv=KJBJsXJo c=1 sm=1 tr=0 ts=62b0f9ed
 a=OCGoW4wscCDr3YEa6K7Wzw==:117 a=OCGoW4wscCDr3YEa6K7Wzw==:17
 a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=lDTiKlOK4V0fPvXZ_vIA:9 a=CjuIK1q_8ugA:10
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 935CE1961EEB
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 15:51:22 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     git <git@vger.kernel.org>
Subject: SHA-256 transition
Date:   Mon, 20 Jun 2022 15:51:22 -0700
Message-ID: <12011256.O9o76ZdvQC@thunderbird>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CMAE-Envelope: MS4xfIZWMZec/nQRUG5D0MS91N41n4BcKfAX73BSFCm3kkFAkqov3FnVX6LLLUEiQCNwAEkX3e/BpWfCEsNFoTd4tJ3Mv/oglMVca/iyy0KFJA6K5ajSWQhn
 62xIxn3oPnv0VECVfwx73r43mpebqajnKSlqCRWQ0ERCwzwgOwgM6OiAJ2jhAUS9HM6QCFGIYvdv0w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What is the current status of the SHA-1 to SHA-256 transition?   Is the 
transition far enough along that users should start changing over to the new 
format?  




