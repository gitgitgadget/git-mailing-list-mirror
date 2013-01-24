From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v4 0/4] Reroll patches against v1.8.1.1
Date: Thu, 24 Jan 2013 13:10:24 +0400
Message-ID: <cover.1359018188.git.Alex.Crezoff@gmail.com>
References: <20110921004602.3d59bed4@zappedws>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 10:11:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyIq7-0002jt-Jr
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 10:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab3AXJK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 04:10:58 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62305 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab3AXJK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 04:10:56 -0500
Received: by mail-lb0-f174.google.com with SMTP id l12so2382217lbo.33
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 01:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=lkYq5cO9PPT3No1AElrBPvYmFcTsKlcCzJY4424vLnk=;
        b=qGoZdeqR6i2VrvfsmNtYjnvp7pwDx4QsG0j+3LG+yFgKsKMLCATYogDzNLu/fbsGiL
         KHA1DspC/Tx+KCcpRRd8M2TxsNvd8zNn/AiW+lOLS6xaN4uSh8ZtWwYrSAa3F0IgtBws
         ZAbc7obPwUM2sIWcTt9Hj7C6Xi6ZWO/6D6kUKq6vTPS/SoFrq4X9HvOjqQ4wfffWpjvE
         cwHcX7G6LtT1Olu/CEEAU1KMABikwnsUmnoDkCxV6bzBCymO7JII0Qwlu05aDUNMQohY
         sqyqFc157WPTMomoBl0dzurXRvlI5jh+dEG1mubfZGHT1wYcaYYZiFNwAEqIy47aPtPt
         mtng==
X-Received: by 10.112.38.164 with SMTP id h4mr460747lbk.123.1359018654405;
        Thu, 24 Jan 2013 01:10:54 -0800 (PST)
Received: from ds212plus (ppp91-77-44-105.pppoe.mtu-net.ru. [91.77.44.105])
        by mx.google.com with ESMTPS id ml1sm9294345lab.15.2013.01.24.01.10.48
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 01:10:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by ds212plus (Postfix) with ESMTP id 9B90B60017;
	Thu, 24 Jan 2013 13:11:34 +0400 (MSK)
X-Mailer: git-send-email 1.8.1.1.10.g9255f3f
In-Reply-To: <20110921004602.3d59bed4@zappedws>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214419>

Woooof! 
Reroll my patches again after 1.5 years ;)
They must be applied against v1.8.1.1
Sorry for my laziness ;)

Alexey Shumkin (4):
  t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
  t7102 (reset): refactoring: don't hardcode SHA-1 in expected outputs
  pretty: Add failing tests: user format ignores i18n.logOutputEncoding
    setting
  pretty: user format ignores i18n.logOutputEncoding setting

 builtin/reset.c                  |   8 +-
 builtin/rev-list.c               |   1 +
 builtin/shortlog.c               |   1 +
 log-tree.c                       |   1 +
 submodule.c                      |   3 +
 t/t4041-diff-submodule-option.sh |  23 +++--
 t/t4205-log-pretty-formats.sh    |  37 ++++++--
 t/t6006-rev-list-format.sh       | 200 +++++++++++++++++++++++----------------
 t/t7102-reset.sh                 |  71 +++++++++-----
 9 files changed, 224 insertions(+), 121 deletions(-)

-- 
1.8.1.1.10.g9255f3f
