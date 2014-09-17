From: Pramod Gurav <pramod.gurav.etc@gmail.com>
Subject: Query: Failed to suppress CC while sending patchset
Date: Wed, 17 Sep 2014 12:20:13 +0530
Message-ID: <CAMf-jSkjYFEsN01DZc=Xc6qb037zeVeo4cUKDJJN-Q0Z4f6B9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 08:50:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU94H-0002eG-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 08:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbaIQGuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 02:50:16 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:33094 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbaIQGuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 02:50:14 -0400
Received: by mail-la0-f48.google.com with SMTP id ty20so1241817lab.35
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4zv0IdGXCzpH0TKpTnN/L+ThZDIuJT+iz5M8oo80pzM=;
        b=Vy1KixyHSpQbsYLzM3ms2TADm4ZlaXszZe4VZEnShn8qTBYgbnzKAGvNg6q9R7GhAx
         6IgI3VPdF1P7cioy4/aMYO8JofOEm35p89Ukjc8q/lNsvJhgk3Zaz4UgwdwazFTq8rBK
         qvwbKYO7HHWfIO+OmIJQQ73npMaEWJ54QEe4Vq8WPFf0MwIXUOJv8JhSnpwDFdCx0X7N
         I6cM7kMqed5+aJCEBimIjqR85AivBL3pkQ5bWRur/ZU1uj67gWYQiIl2zwpi3Tm+/nIq
         STLAMfvd2RMQQMyVKSIeYl1nitLyLMBShhRfxvaZpj6585dEZrRjhIABeLxV3UO9e+Pg
         CPhw==
X-Received: by 10.153.6.5 with SMTP id cq5mr2398259lad.46.1410936613149; Tue,
 16 Sep 2014 23:50:13 -0700 (PDT)
Received: by 10.152.3.73 with HTTP; Tue, 16 Sep 2014 23:50:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257213>

Hi,

I was trying to send a patchset to self just to test by suppressing
everyone in CC list of patch header. But it failed and the patch was
send to people in CC.

Is there anything wrong that I have done? My git verions is:

gpramod:git$ git --version
git version 1.7.9.5

Below is the command I used to send the patch and it follows the
messages until I pressed a Ctrl+c.

gpramod:linux-next$ git send-email --to=pramod.gurav.etc@gmail.com
--suppress-cc=cc --suppress-cc=self --suppress-cc=author 000*
0000-mmc-msm_sdcc-Cleanups.patch
0001-mmc-msm_sdcc-Switch-to-using-managed-resources.patch
0002-mmc-msm_sdcc-Add-support-for-platform_driver-remove-.patch
0003-mmc-msm_sdcc-Replace-pr_-with-dev_.patch
0004-mmc-msm_sdcc-Remove-duplicate-check-around-dmares.patch
0005-mmc-msm_sdcc-Remove-unwanted-initializations-in-prob.patch
OK. Log says:
Server: secure.emailsrvr.com
MAIL FROM:<pramod.gurav@smartplayin.com>
RCPT TO:<pramod.gurav.etc@gmail.com>
From: Pramod Gurav <pramod.gurav@smartplayin.com>
To: pramod.gurav.etc@gmail.com
Subject: [PATCH 0/5] mmc: msm_sdcc: Cleanups
Date: Tue, 16 Sep 2014 16:45:41 +0530
Message-Id: <1410866146-15144-1-git-send-email-pramod.gurav@smartplayin.com>
X-Mailer: git-send-email 1.7.9.5

Result: 250 2.0.0 Ok: queued as 1CD0F1802A2

In git 1.7.0, the default has changed to --no-chain-reply-to
Set sendemail.chainreplyto configuration variable to true if
you want to keep --chain-reply-to as your default.
(body) Adding cc: David Brown <davidb@codeaurora.org> from line 'Cc:
David Brown <davidb@codeaurora.org>'
(body) Adding cc: Daniel Walker <dwalker@fifo99.com> from line 'Cc:
Daniel Walker <dwalker@fifo99.com>'
(body) Adding cc: Bryan Huntsman <bryanh@codeaurora.org> from line
'Cc: Bryan Huntsman <bryanh@codeaurora.org>'
(body) Adding cc: Ulf Hansson <ulf.hansson@linaro.org> from line 'CC:
Ulf Hansson <ulf.hansson@linaro.org>'
(body) Adding cc: linux-mmc@vger.kernel.org from line 'CC:
linux-mmc@vger.kernel.org'
(body) Adding cc: linux-arm-msm@vger.kernel.org from line 'CC:
linux-arm-msm@vger.kernel.org'
OK. Log says:
Server: secure.emailsrvr.com
MAIL FROM:<pramod.gurav@smartplayin.com>
RCPT TO:<pramod.gurav.etc@gmail.com>
RCPT TO:<davidb@codeaurora.org>
RCPT TO:<dwalker@fifo99.com>
RCPT TO:<bryanh@codeaurora.org>
RCPT TO:<ulf.hansson@linaro.org>
RCPT TO:<linux-mmc@vger.kernel.org>
RCPT TO:<linux-arm-msm@vger.kernel.org>
From: Pramod Gurav <pramod.gurav@smartplayin.com>
To: pramod.gurav.etc@gmail.com
Cc: David Brown <davidb@codeaurora.org>,
Daniel Walker <dwalker@fifo99.com>,
Bryan Huntsman <bryanh@codeaurora.org>,
Ulf Hansson <ulf.hansson@linaro.org>,
linux-mmc@vger.kernel.org,
linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/5] mmc: msm_sdcc: Switch to using managed resources
Date: Tue, 16 Sep 2014 16:45:42 +0530
Message-Id: <1410866146-15144-2-git-send-email-pramod.gurav@smartplayin.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1410866146-15144-1-git-send-email-pramod.gurav@smartplayin.com>
References: <1410866146-15144-1-git-send-email-pramod.gurav@smartplayin.com>

Result: 250 2.0.0 Ok: queued as B9A481803A0

(body) Adding cc: David Brown <davidb@codeaurora.org> from line 'Cc:
David Brown <davidb@codeaurora.org>'
(body) Adding cc: Daniel Walker <dwalker@fifo99.com> from line 'Cc:
Daniel Walker <dwalker@fifo99.com>'
(body) Adding cc: Bryan Huntsman <bryanh@codeaurora.org> from line
'Cc: Bryan Huntsman <bryanh@codeaurora.org>'
(body) Adding cc: Ulf Hansson <ulf.hansson@linaro.org> from line 'CC:
Ulf Hansson <ulf.hansson@linaro.org>'
(body) Adding cc: linux-mmc@vger.kernel.org from line 'CC:
linux-mmc@vger.kernel.org'
(body) Adding cc: linux-arm-msm@vger.kernel.org from line 'CC:
linux-arm-msm@vger.kernel.org'
^C

gpramod:linux-next$ stty: standard input: Input/output error

This is the header of my first patch:

>From f7ced72a85866e550ea2d76d8d7f9d1df88f5994 Mon Sep 17 00:00:00 2001
From: Pramod Gurav <pramod.gurav@smartplayin.com>
Date: Tue, 16 Sep 2014 15:41:37 +0530
Subject: [PATCH 1/5] mmc: msm_sdcc: Switch to using managed resources

This change makes changes to use managed version of ioremap, clk_get,
request_irq etc for clean unloading of modules. This does away with
lables to release these resources.

Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc@vger.kernel.org
CC: linux-arm-msm@vger.kernel.org
Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 drivers/mmc/host/msm_sdcc.c |   43 +++++++++++++++++--------------------------

-- 
Thanks and Regards
Pramod
