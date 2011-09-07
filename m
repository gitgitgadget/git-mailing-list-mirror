From: Wang Hui <Hui.Wang@windriver.com>
Subject: [PATCH v3 0/1] sha1_file: normalize alt_odb path before comparing and storing
Date: Wed, 7 Sep 2011 18:37:46 +0800
Message-ID: <1315391867-31277-1-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>, <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:29:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Lvt-0001be-EM
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab1IGR27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:28:59 -0400
Received: from mail.windriver.com ([147.11.1.11]:63192 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab1IGR25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:28:57 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p87AbUsH005434
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 7 Sep 2011 03:37:30 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Wed, 7 Sep 2011 03:37:30 -0700
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180878>

Hi Junio & Martin,

In the V3, i prepared a patch basing on Junio's suggestion. If this patch can
pass review and be merged to upstream. What about the last two patches in the
V2 (remove relative alternates only possible at current repos limitation), do
you think it is safe to pick up these two patches?

Hui Wang (1):
      sha1_file: normalize alt_odb path before comparing and storing

 sha1_file.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)
