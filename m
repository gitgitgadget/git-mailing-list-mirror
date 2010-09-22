From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] Testing installed gitweb
Date: Wed, 22 Sep 2010 16:21:23 +0200
Message-ID: <1285165286-12452-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 16:21:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyQCl-0005b0-2l
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 16:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab0IVOVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 10:21:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40730 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab0IVOVn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 10:21:43 -0400
Received: by bwz11 with SMTP id 11so464599bwz.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=JK/efu43iqWRWouDtSv+Mxg+YVkNV2maODpE52hNxoY=;
        b=DA0Rr3EPhYP8tBQuWdAGs5kGC4YD7+2EjHUKZHgoGgNc77B/IEK/BsVWWKIxMRlsx0
         lb/QA89L/VOLDH8JVVI9SUV4jXInkqJLHtRLa3GkO96cVYQuMk0JJyNMbe7hNbJDpetr
         ciCpn5he6ZgOi5SD8lbtBqXUeZGlm3hPvUJZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VNfUEP/HRsa9WN+K4gKPWueYxMFkarWOZPeHB2PvFUWXTHrffBwoJddWiAYAxwUCec
         +iEEMXmmE5jN3E1/Bi4KtY4zxxQAZXf5hGQ03UgEDljkIOCmQAdZ6DGTQAZeUGsmNxz3
         jkq8s/VFJXe/4VRRpj7t88bEZI0aeWAfoopt0=
Received: by 10.204.65.145 with SMTP id j17mr76544bki.209.1285165302319;
        Wed, 22 Sep 2010 07:21:42 -0700 (PDT)
Received: from localhost.localdomain (abva250.neoplus.adsl.tpnet.pl [83.8.198.250])
        by mx.google.com with ESMTPS id x13sm8626411bki.12.2010.09.22.07.21.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 07:21:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156803>

This series add a mechanism to easy test installed gitweb, via

  $ make -C gitweb test-installed

This way we can check if the install procedure work correctly, when
gitweb gets split into smaller modules.

This series applies on top of 'jn/gitweb-test-lib' branch, merged as
4621733 into next, i.e. on top of commit 89d1b5b (t/gitweb-lib.sh: Use
tabs for indent consistently, 2010-09-12).

Jakub Narebski (3):
  gitweb/Makefile: Include gitweb/config.mak
  t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
  gitweb/Makefile: Add test-installed target

 gitweb/Makefile |    5 +++++
 t/Makefile      |    4 ++++
 t/gitweb-lib.sh |   21 +++++++++++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

-- 
1.7.2.1
