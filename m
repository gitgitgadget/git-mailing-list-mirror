From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] t: branch: fixes and cleanups
Date: Fri, 30 Aug 2013 23:31:47 -0500
Message-ID: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 06:36:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFcvM-0005zG-86
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 06:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307Ab3HaEgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 00:36:32 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:38523 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176Ab3HaEgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 00:36:31 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so2665143obc.13
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 21:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9JtPA7nrMsdwfFqTxgjE1noGSuSOTxmq9TlVhkaNoyQ=;
        b=zTZ356bDeeL+j7J4UAm/BYVLSVf8A3zcRgxHVAtl2EPPZ/82ce0n9Gsc1JUJg58Vat
         yos/2h+6AcF+4LqC1DcRTClMqL+13ivt7cCqhc0riCiEgdZAw+xyL6aboGb1+4YABGDW
         8k76LPPvDyvUjIQHFPX/7NJoQCUZjCVXdAUc4BlmeqBUlk/2Ddv1ErYDUqdv0hqqafyr
         hM/Zx+SL/eHlGlJ/LJI1mkXGThlGHxOOlu5nXObABgfvg6EbrvTKIdIqnYr0FqxL4R89
         SwYan+HCuxeXQ3xTITjvDqXoXxpm/OC9QZ0kKCvPs2Cq1Leh0Gb8CMuG8jEgXLi3L3nJ
         wqxg==
X-Received: by 10.182.51.132 with SMTP id k4mr9346468obo.101.1377923790988;
        Fri, 30 Aug 2013 21:36:30 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm1813336oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 21:36:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233499>

Felipe Contreras (4):
  t: branch: trivial style fix
  t: branch: fix typo
  t: branch: fix broken && chains
  t: branch: improve test rollback

 t/t3200-branch.sh | 82 +++++++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

-- 
1.8.4-fc
