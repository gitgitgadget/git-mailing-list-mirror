From: newren@gmail.com
Subject: A few fast-export fixups
Date: Fri, 19 Jun 2009 22:36:56 -0600
Message-ID: <1245472623-28103-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusambite@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 06:39:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHsMM-0004B4-CS
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 06:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbZFTEjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 00:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbZFTEjK
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 00:39:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:7578 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbZFTEjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 00:39:09 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1018242wfd.4
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 21:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=lDNfqD5BXf5m+hHeC74pKMO9yp9YOmQmchlycvYM1Pg=;
        b=MVwAowKjfLub3EpvnhAZt7XFvBx3tfFlm/JzR0yFeSYedBCa0OZyYQ1P7ytMg9MTk6
         5CcqIoVCh0osnp3t87S7n3hKleCQwspOpGgL1YjI/TBN5tpfSvz9vMwOctCpd2pLv5Nq
         LXhbajZ7jWG8T3APzAMYFEaMDcp/nbBG5k4+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ScyuLV7jW7Uf91L+4f7/Ih/MMvpRf1ZXKiKAK+sFBFkHCNsZ+Ng7ZeJFQvZ5nSgZ2h
         0Ulsgh4my/tj9JYJtqcBnfazZtxJjLRtTmR4G4Aw8RmZVAtpKKuSQkP/F3reTUHJloFZ
         wxlf5uDodUnTpBtu8bVan7j9xgMqQligsFN/U=
Received: by 10.143.10.7 with SMTP id n7mr1636486wfi.236.1245472751213;
        Fri, 19 Jun 2009 21:39:11 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 22sm39467wfi.32.2009.06.19.21.39.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 21:39:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121924>

This patch series fixes a few fast-export bugs I have come across,
plus some new testcases to verify the fixes, and finally a small
addition to the documentation.
