From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 0/3] extract proper comments for l10n translators
Date: Thu, 17 Apr 2014 13:37:16 +0800
Message-ID: <cover.1397712142.git.worldhello.net@gmail.com>
References: <CAN7MxmV5tzvGTTG+aOL73fLhbXc7YeOWvYwLkMyad0=mvffMHQ@mail.gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 07:37:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Waf1K-0000Ve-1E
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 07:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbaDQFhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 01:37:45 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:53005 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060AbaDQFho (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 01:37:44 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so11834966pbb.11
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 22:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HsWUKzX3B14CMYVqdi5+LdqRDD3a+593cWGxBzEUroA=;
        b=hPvX+5MZxpl43A39Jz64vk0JojwQ5GjV2MdYL10VSMbuWbpZpk5QmUG+Vi6sPmCUU8
         wVwyvElr5HFTcZvTjXnhuWMaA8zQV1jxEb2D7YuJzB2SfYW6BA5HlYrBXLIRTdEEO7bK
         g26kRozFfcXVdyCbdLgFpUBSpq7t4hRQx1NaRm1yRDrKAUQQwSdtYCOQA1EmaPq8Nh1L
         mKeFrirVZcsgDMuJF3klRGRYKaO5pRQD5WhZP/bNa2rWiETNI6xjeQMqg7OTxHCQM4mh
         qKjxiKSwezqxcdqxhz5dmm8Ob0sPIhxPxxQJGHlWtdMX7HCcLwWSjmu9q/nDKB40Tfv8
         Qs/A==
X-Received: by 10.68.189.33 with SMTP id gf1mr13082269pbc.111.1397713063899;
        Wed, 16 Apr 2014 22:37:43 -0700 (PDT)
Received: from localhost.localdomain ([124.207.10.6])
        by mx.google.com with ESMTPSA id n6sm50901640pbj.22.2014.04.16.22.37.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Apr 2014 22:37:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.461.g942803f
In-Reply-To: <CAN7MxmV5tzvGTTG+aOL73fLhbXc7YeOWvYwLkMyad0=mvffMHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246402>

When generate git.pot, many irrelevant comments are extracted as references
for translators, but one useful comment is lost.  This series patches will
fix this issue.

Jiang Xin (3):
  i18n: Fixes uncatchable comments for translators
  i18n: Only extract comments marked by special tag
  i18n: Remove obsolete comments for translators

 Makefile          | 2 +-
 builtin/init-db.c | 8 +++-----
 date.c            | 2 +-
 diff.c            | 8 --------
 4 files changed, 5 insertions(+), 15 deletions(-)

-- 
1.9.2.461.g942803f
