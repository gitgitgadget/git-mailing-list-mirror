From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: small improvements to user-preservation
Date: Sat,  7 May 2011 11:19:42 +0100
Message-ID: <1304763583-17425-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 12:20:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIecS-0007KR-Kd
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 12:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab1EGKUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 06:20:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58034 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097Ab1EGKUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 06:20:07 -0400
Received: by wya21 with SMTP id 21so2913426wya.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 03:20:05 -0700 (PDT)
Received: by 10.216.135.67 with SMTP id t45mr4618142wei.80.1304763605351;
        Sat, 07 May 2011 03:20:05 -0700 (PDT)
Received: from localhost.localdomain ([212.183.128.32])
        by mx.google.com with ESMTPS id m14sm620928wes.14.2011.05.07.03.20.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 May 2011 03:20:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173044>

. Slightly more paranoid checking of results from 'p4 change'
. Remove superfluous "-G"
. Don't modify the username if it is unchanged.
. Add a comment in the change template to show what is
  going to be done.


Luke Diamand (1):
  git-p4: small improvements to user-preservation

 contrib/fast-import/git-p4 |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)
