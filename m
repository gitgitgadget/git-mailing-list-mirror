Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB5820D11
	for <e@80x24.org>; Mon, 30 Jan 2017 20:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbdA3UpU (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 15:45:20 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:30836 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbdA3UpP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 15:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1485809113;
        l=862; s=domk; d=benjaminfuchs.de;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Subject:Cc:
        To:From;
        bh=GsSB0sIUXzZM0n8MOrG2C6EslpUWPddj1zPc8U+cKh4=;
        b=sdtKR2dlAPnmAymZn+2GR/q+/UAfsp0v+3d+bH0PpvKkLop82/I1izEOtVrD3Qy2KF
        1oWPzS3rxfjt7v3vfLVKql0ljikf/8pG/BB0NpuaX6A5IG2J4vFnVSozdLdkbHpyMPGY
        Y/HgZAhI3nPxAE0sk0jIn4nHphGC6vRXYGyYw=
X-RZG-AUTH: :KWEFfEyIefqISxrQo86CUgBQlWGSsNRH+R9D//SwlcQsxFnnwAcCdlhhPcjKRjsJ00UGWq4=
X-RZG-CLASS-ID: mo00
Received: from fuchs-ThinkPad-T431s.poststrasse57.local (p5499AE19.dip0.t-ipconnect.de [84.153.174.25])
        by smtp.strato.de (RZmta 39.11 DYNA|AUTH)
        with ESMTPSA id x0accft0UKiVLRQ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 30 Jan 2017 21:44:31 +0100 (CET)
From:   Benjamin Fuchs <email@benjaminfuchs.de>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, sbeller@google.com,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi,
        Benjamin Fuchs <email@benjaminfuchs.de>
Subject: [PATCH 0/4] git-prompt.sh: Full patch for submodule indicator
Date:   Mon, 30 Jan 2017 21:44:21 +0100
Message-Id: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,
since I didn't get a response I decided to sent my patch again. Maybe it was because
I to sent my consecutive commits the wrong way, so a new try.
First thanks again Steffen and Gábor for your feedback.
Based on the first feedback I rework the indicator and it is now way cheaper then the
first version and has a 'dirty' indicator now.
Tests exist also now.
Looking forward to more feedback!
Greetings,
Benjamin

Benjamin Fuchs (4):
  git-prompt.sh: add submodule indicator
  git-prompt.sh: rework of submodule indicator
  git-prompt.sh: fix for submodule 'dirty' indicator
  git-prompt.sh: add tests for submodule indicator

 contrib/completion/git-prompt.sh | 36 ++++++++++++++++++++++++++++++++-
 t/t9903-bash-prompt.sh           | 43 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)

-- 
2.7.4

