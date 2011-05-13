From: Luke Diamand <luke@diamand.org>
Subject: [PATCH/RFC v6] git-p4: warn if git authorship won't be retained
Date: Fri, 13 May 2011 20:45:59 +0100
Message-ID: <1305315960-17818-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 21:46:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKyJU-0002ax-Kv
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 21:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317Ab1EMTqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 15:46:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40194 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab1EMTqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 15:46:09 -0400
Received: by wwa36 with SMTP id 36so3214070wwa.1
        for <git@vger.kernel.org>; Fri, 13 May 2011 12:46:08 -0700 (PDT)
Received: by 10.216.254.90 with SMTP id g68mr1808286wes.16.1305315968167;
        Fri, 13 May 2011 12:46:08 -0700 (PDT)
Received: from localhost.localdomain (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id t58sm1312229weq.16.2011.05.13.12.46.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2011 12:46:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173565>

Updated version of authorship warning change, with modifications to
test harness as compared to v5 suggested by Junio.

Junio - do you need the same fixes to the test cases I put in earlier
(in 3ea2cfd488ed70e03d8d6f10e601784926db8008)? The redirects have
extra whitespace. If so, how should I best do that?

Thanks!
Luke


Luke Diamand (1):
  git-p4: warn if git authorship won't be retained

 contrib/fast-import/git-p4     |   33 ++++++++++++++++++++++++++++++-
 contrib/fast-import/git-p4.txt |    7 ++++++
 t/t9800-git-p4.sh              |   41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 2 deletions(-)
