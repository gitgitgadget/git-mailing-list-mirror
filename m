From: larsxschneider@gmail.com
Subject: [PATCH v2] git-p4: fix faulty paths for case insensitive systems
Date: Wed, 19 Aug 2015 22:04:45 +0200
Message-ID: <1440014686-63290-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, pw@padd.com, torarvid@gmail.com,
	ksaitoh560@gmail.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 22:05:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS9bo-0003hl-Ax
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 22:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbbHSUFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 16:05:04 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33170 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbbHSUFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 16:05:01 -0400
Received: by wijp15 with SMTP id p15so135795787wij.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7no/Qz+Ia0m3lVU7GuanUWA850WtZEdGh2/do0oXDLA=;
        b=m/fk5ux+bcwPi1fOQKRLiaVkP6mUQETOFBNe7tItzc+asTIIjlTjAKsfxTs5YB+//F
         j6KAqc1lJ20S2IT60pAOT0FKByLDnFRm6ZitYsD/8IaORwelFgymwdimRhSD4XphLr+N
         H/dYO0KoJjUMjhVYLhaQGNRIi5X/nm+GoDvUMCACTo0OUZoie4PQjwJMORtfoFEzAqve
         h6ziPKsGwH0R3QpDLMPf1UoHo48okjKPDeLZ8RZS7N3G3LBV8EFVeitHUQpELEU+qPV3
         OwqRMa4AeTtK4Tcq3FNyzwzAPIrA1IsakasqMIbTayhJbVqXwT2bPZ+kMYIv5JmprejQ
         iXbg==
X-Received: by 10.180.80.70 with SMTP id p6mr6362415wix.43.1440014700599;
        Wed, 19 Aug 2015 13:05:00 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-092-078-131-195.092.078.pools.vodafone-ip.de. [92.78.131.195])
        by smtp.gmail.com with ESMTPSA id kb1sm2426440wjc.24.2015.08.19.13.04.58
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Aug 2015 13:04:59 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276223>

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

as discussed with Luke in "[PATCH] git-p4: fix faulty paths for case insensitive
systems" I added a test case for my path fix. I also changed the trigger for the
fix to the command line parameter "--fix-paths".

Cheers,
Lars

Lars Schneider (1):
  git-p4: fix faulty paths for case insensitive systems

 git-p4.py                         | 83 +++++++++++++++++++++++++++++++++--
 t/t9821-git-p4-path-variations.sh | 91 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+), 4 deletions(-)
 create mode 100755 t/t9821-git-p4-path-variations.sh

--
1.9.5 (Apple Git-50.3)
