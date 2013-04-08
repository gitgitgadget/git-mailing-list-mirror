From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] remote-bzr: fixes
Date: Mon,  8 Apr 2013 13:36:37 -0500
Message-ID: <1365446199-11382-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 20:37:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGwu-0007Fn-Cz
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935182Ab3DHShl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:37:41 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:56930 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934738Ab3DHShk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:37:40 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so6526483oag.21
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=rV0ln8V8MCCBpP5toMohOJ6WTPoBcP7cBgQxlxB36ck=;
        b=iM8poDoGEdONwjdPBHaf63iHNqwbSoh/UAELdfAgABBvvGh8iN+0gVb8Xazu7eGgBS
         tHVAJ6BMQbca77OiV3MlVHoEDQr0DH2uOpg4k2uuvV0DwIYEOFwTQzUo80WtZgYC1MLG
         Cd11qyWbpsZs2SeAqVrDX/3nUlE87sQ7cpUTnCXeZO61u8o3vWwiTEDOHnCLbJjxdDYQ
         1z+cJhN3eywiJ14hOBxzfASb09HPDhczhzWtxMagcUEP+Kex8guuOAuuaSd9rKrGQ2N/
         dapVg5nKFZUpvC/w0CMFhyJPGT8PesIOxHYtxgwpDaki08HKhEKBAQA+QPyPGpUkeUV8
         WMUA==
X-Received: by 10.60.29.37 with SMTP id g5mr16174088oeh.140.1365446260138;
        Mon, 08 Apr 2013 11:37:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id qk4sm25318105obc.5.2013.04.08.11.37.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 11:37:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220486>

Hi,

Resending because the previous commits were already merged. The second one is
probably important.

Christophe Simonis (1):
  remote-bzr: fix utf-8 support for fetching

Felipe Contreras (1):
  remote-bzr: improve tag handling

 contrib/remote-helpers/git-remote-bzr | 44 +++++++++++++++++++++--------------
 contrib/remote-helpers/test-bzr.sh    |  9 ++++++-
 2 files changed, 35 insertions(+), 18 deletions(-)

-- 
1.8.2
