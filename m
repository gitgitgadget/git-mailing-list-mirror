From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/2] Squelch warning from send-email
Date: Fri,  5 Jul 2013 17:35:45 +0530
Message-ID: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 05 14:09:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv4pd-0002of-Sl
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208Ab3GEMJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:09:41 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36672 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab3GEMJk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:09:40 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so2207994pad.14
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=dULQWZh9r1n3jUMEYzhu5tqQ9wJVsdPnoGIUzmgGQ5s=;
        b=qKp2krPncmL290uDscvYpUGYSZLMPeEYPsyfBD3ExFCVHXregL38WsTZddjtehrLg/
         U5kPhtJKkAILyrK8c/DJpp7WLWHV68Jq3cjLdKmVZ+T1OCvXQtGoIjh8H6Y/2QYK3iq8
         bMKQJnEof3Ke+1bwWxh2fyA4wTPMlKcFwCYjkHvmZ9aPoxKLsHdVJMvHNFRvbq732qOL
         4OQeSOohCnbrdGKALNI/EyksXWIdkMolGlp4F5F7Ba1a89k2Z8HWTXipNgG7Grrc/AJo
         DGps4j/fsXKGdu1Z7w7hCnyC/ia7U8RxS2D63Zk3vT1DW3iQTG1iYCW7SRn0krBn3YUO
         OcYg==
X-Received: by 10.66.188.2 with SMTP id fw2mr11314582pac.91.1373026180403;
        Fri, 05 Jul 2013 05:09:40 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id b4sm7340980pbm.6.2013.07.05.05.09.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 05:09:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.723.gad7967b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229657>

Hi,

Since nobody stepped up to write it, I wrote [2/2] myself.  It will be
tested when I send out this series.

Thanks.

Ramkumar Ramachandra (2):
  send-email: squelch warning from Net::SMTP::SSL
  send-email: introduce sendemail.smtpsslcertpath

 Documentation/config.txt         |  3 +++
 Documentation/git-send-email.txt |  4 ++++
 git-send-email.perl              | 20 ++++++++++++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

-- 
1.8.3.2.722.g3244e19.dirty
