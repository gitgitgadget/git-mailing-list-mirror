From: Luke Diamand <luke@diamand.org>
Subject: [PATCH/RFC v3] git-p4: warn if git authorship won't be retained
Date: Tue, 10 May 2011 20:27:32 +0100
Message-ID: <1305055653-5133-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 21:27:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJsay-0008PC-UD
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 21:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381Ab1EJT1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 15:27:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54120 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab1EJT1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 15:27:43 -0400
Received: by wya21 with SMTP id 21so4934756wya.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 12:27:41 -0700 (PDT)
Received: by 10.216.61.135 with SMTP id w7mr4416229wec.19.1305055661813;
        Tue, 10 May 2011 12:27:41 -0700 (PDT)
Received: from localhost.localdomain (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id y35sm421296weq.15.2011.05.10.12.27.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 May 2011 12:27:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173349>

Updated version of git-p4 authorship warning suggested by Junio,
incorporating fixes for problems in v2 pointed out by Pete Wyckoff.

Luke Diamand (1):
  git-p4: warn if git authorship won't be retained

 contrib/fast-import/git-p4     |   33 +++++++++++++++++++++++++++-
 contrib/fast-import/git-p4.txt |    7 ++++++
 t/t9800-git-p4.sh              |   46 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 2 deletions(-)
