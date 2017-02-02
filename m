Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C301F9AF
	for <e@80x24.org>; Thu,  2 Feb 2017 22:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbdBBWvy (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 17:51:54 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:11612 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbdBBWvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 17:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1486075911;
        l=481; s=domk; d=benjaminfuchs.de;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Subject:Cc:
        To:From;
        bh=Sc0hJMPeLon4cS2Oy/ocZLY0blhVFi2avTC7cJkF0Nw=;
        b=HO5menFKA0q+lLdCBSdSFB1JbuTc3mtTDODHotf3QNNZOHLXV3gBZRu7mA/bHZAl1b
        Glb4F+7byKEGZ/h3nt4Lc/m0T6oNBYLGE8gKlv3dZYtHoMvBkllPtNX5h9n9L9NZ27ew
        UQSu/pEfTPv9QYXSIA3yd2Oh5xz2pe4ShoM/I=
X-RZG-AUTH: :KWEFfEyIefqISxrQo86CUgBQlWGSsNRH+R9D//SwlcQsxFnnwAcCdlhhPcjKRjsJ10UFW8MI
X-RZG-CLASS-ID: mo00
Received: from fuchs-ThinkPad-T431s.poststrasse57.local (p5499AA8C.dip0.t-ipconnect.de [84.153.170.140])
        by smtp.strato.de (RZmta 39.12 DYNA|AUTH)
        with ESMTPSA id e066aft12Mpkau7
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 2 Feb 2017 23:51:46 +0100 (CET)
From:   Benjamin Fuchs <email@benjaminfuchs.de>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, sbeller@google.com, gitster@pobox.com,
        Benjamin Fuchs <email@benjaminfuchs.de>
Subject: [PATCH v2] git-prompt.sh: add submodule indicator 
Date:   Thu,  2 Feb 2017 23:51:31 +0100
Message-Id: <1486075892-20676-1-git-send-email-email@benjaminfuchs.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone again,
I guess this time I'm rerolling my patch the right way.
Thanks again Gábor for your feedback.
And thanks to Junio for being patient and explaining the reroll workflow 
Greeting,
Benjamin

Benjamin Fuchs (1):
  git-prompt.sh: add submodule indicator

 contrib/completion/git-prompt.sh | 40 ++++++++++++++++++++++++++-
 t/t9903-bash-prompt.sh           | 59 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 1 deletion(-)

-- 
2.7.4

