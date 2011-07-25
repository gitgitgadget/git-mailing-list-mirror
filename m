From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH] pretty: user format ignores i18n.logOutputEncoding setting
Date: Mon, 25 Jul 2011 14:31:14 +0400
Message-ID: <1311589875-12569-1-git-send-email-zapped@mail.ru>
References: <20110722110618.10a62631@zappedws> <loom.20110722T094944-284@post.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 12:31:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlIRb-0006rz-6A
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 12:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab1GYKbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 06:31:22 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:49964 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab1GYKbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 06:31:21 -0400
Received: by fxd18 with SMTP id 18so8869841fxd.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 03:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:references;
        bh=pAS1eBBC9KvgB5S7cA+112ugH0Pr7LNmThkX9zyRHSI=;
        b=IYAgmbCg/IzpWia804QiupVNhq9BhjMmDTADvGovq2mGOq4bjbmc+HdnhKfqmee/m/
         sM1CworOno5OsdzqvV2qbvJ5fNsu4oj8/E4e2svasnsg6spKTsOGaoqg6M3ft1MeI8UC
         xNVDopHUAek4/AMD9rOys9v0Qg67Bn6D9oB7s=
Received: by 10.204.135.146 with SMTP id n18mr1277085bkt.200.1311589880068;
        Mon, 25 Jul 2011 03:31:20 -0700 (PDT)
Received: from zappedws (ppp91-77-22-223.pppoe.mtu-net.ru [91.77.22.223])
        by mx.google.com with ESMTPS id a22sm1275025bke.20.2011.07.25.03.31.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 03:31:19 -0700 (PDT)
Received: from Alex by zappedws with local (Exim 4.76)
	(envelope-from <Alex@zappedws>)
	id 1QlIRS-0003Hi-3i
	for git@vger.kernel.org; Mon, 25 Jul 2011 14:31:18 +0400
X-Mailer: git-send-email 1.7.6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177791>


Started here http://thread.gmane.org/gmane.comp.version-control.git/177634
