From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/3] Version fixes and cleanups
Date: Sat, 14 Sep 2013 01:28:45 -0500
Message-ID: <1379140128-12397-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 14 08:34:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKjQt-0008M6-Rl
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 08:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab3INGeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 02:34:04 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34704 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab3INGeD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 02:34:03 -0400
Received: by mail-ob0-f172.google.com with SMTP id gq1so1915583obb.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 23:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UvFV7ev1OCUelPCfZ8MODBciXUESh2mf1v6Fsn4MuRg=;
        b=M/r+eUfG05mbEF6YovZbIzEbV5SlMw4MD2TNsQ+I84EbSk1bUrruLJ11vqwGYyaY1y
         Yz11up/VuVpFvHDM0DHCYnNpUUlNGlCtvVd0Dv0Dbsw6IHbPDNjusYQm/67HRpyAyVo2
         KZyVRQfMxkBi/dA3SC6zDXfTQRnC1NvZctgFjSvkDT595xjImzYK7gWzpr1SlqPw7oqT
         2tcj11L10i+PDcII6/pM9v0jmflNgeEqe40hZ5gSXE1e9VcJ/ro4wXcgHOmadsUzrJYS
         52Fe8cbFPeB+vKoxkUry0MpBoyEcurPXMPeMs7tHNLodez0WT6Mfd9ZszIQBgDHipdb0
         vD5A==
X-Received: by 10.182.28.134 with SMTP id b6mr15972825obh.27.1379140441103;
        Fri, 13 Sep 2013 23:34:01 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id b5sm20298805obj.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 23:34:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234793>

Felipe Contreras (3):
  version-gen: cleanup
  version-gen: avoid messing the version
  build: fix rpm versioning

 GIT-VERSION-GEN | 36 +++++++++++++++++++-----------------
 Makefile        |  2 +-
 2 files changed, 20 insertions(+), 18 deletions(-)

-- 
1.8.4-fc
