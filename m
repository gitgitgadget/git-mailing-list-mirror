From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: [PATCH] ls-remote documentation: <refs> argument is optional
Date: Wed, 09 Mar 2011 21:03:48 +0100
Message-ID: <4D77DD24.6040806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 21:04:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxPcB-00053I-L3
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 21:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab1CIUEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 15:04:07 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61691 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab1CIUEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 15:04:05 -0500
Received: by bwz15 with SMTP id 15so1013575bwz.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 12:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:content-type:content-transfer-encoding;
        bh=Dzut+TL3luV/L/dltGnkxaW/icDGKF5G3Aa0SBtJyOM=;
        b=em3nNNWB+/4HDMvsHLXpDsWgW2e/qsLqBb76tdsyPbqzSZCrARQKQ3lPTOJqbP1DY1
         pcNfq/NUqGC1egYMRLh7daiMu1Ea/Zgha9cGkVQbkqttuODPxoYPW3SXog8PZTscDioH
         u4mcelGr7skbc0E4CDfP1RmFDS6GbXrEY2rcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=XSrv15lUaP/fO8slNMa1A2yIpgyO3zDfVJLFdTudO3gLlSu8bOp73h+aayKXFDWlZL
         ivDbjmr8u6TspP7HRQD+fauMsRjg5LMcy+e/LmbH2EzrJbuaN+c2SEkBZO2JKzw6qCwb
         PGEiEULVVMdq1iychYX9/ykrCJV7Q53yWD9Xs=
Received: by 10.204.25.9 with SMTP id x9mr120270bkb.82.1299701042932;
        Wed, 09 Mar 2011 12:04:02 -0800 (PST)
Received: from [192.168.1.101] (ackx216.neoplus.adsl.tpnet.pl [83.10.99.216])
        by mx.google.com with ESMTPS id x6sm1593826bkv.0.2011.03.09.12.04.00
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 12:04:02 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168751>

Correct SYNOPSIS section.

Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 Documentation/git-ls-remote.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index abe7bf9..3422765 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]
-	      <repository> <refs>...
+	      <repository> [<refs>...]
 
 DESCRIPTION
 -----------
-- 
1.7.4.1.208.gf7c6c.dirty


-- 
Piotr Krukowiecki
