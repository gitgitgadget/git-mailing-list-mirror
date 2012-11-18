From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/6] completion: test consolidations
Date: Sun, 18 Nov 2012 11:51:51 +0100
Message-ID: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:52:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2UG-0004mE-ND
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365Ab2KRKwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:52:15 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38183 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2KRKwO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:52:14 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599489bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=SIYk4Xuzsl2n/z5/lv4o6b76AglPuoBRp6G1ezVMOYg=;
        b=Fn0wCgI0dNb35A03No3gM02s42uTBuUXhvth2wUgFVwGioDSxSBUyvf5EsRBHFWfQ3
         I/bghap7Z8VWfExmaijBJMQVQI6L5hWkAQ+qwHmyaBTE7YJ/VKNcxHJDt7aHD7MaExSn
         qKaANrOVzN5qXmgDFs3rSIUBkPsDymzjzDlhKMH3KmtJ0rpy+URyIAPpxOS5i93uR+5j
         zFT204YjFiUm6FvjxpWguT1bjTUcOQYP81NuiIV4v7kIvxKT4S+iCv673T/n5ju9FyAc
         GdDiOqvUXSN3KVpWLsHF/v8+6A34HPfF3INRYa9RTYpPGl4CRWBm4WzUKXxUi+PRns2M
         mvNA==
Received: by 10.204.11.79 with SMTP id s15mr3835622bks.136.1353235932863;
        Sun, 18 Nov 2012 02:52:12 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id n27sm2892317bkw.0.2012.11.18.02.52.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:52:12 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210005>

These started from a discussion with SZEDER, but then I realized there were
many improvements possible.

Changes since v2:

 * Updated comments and commit messages

Changes since v1:

 * A lot more cleanups

Felipe Contreras (6):
  completion: add comment for test_completion()
  completion: standardize final space marker in tests
  completion: simplify tests using test_completion_long()
  completion: consolidate test_completion*() tests
  completion: refactor __gitcomp related tests
  completion: simplify __gitcomp() test helper

 t/t9902-completion.sh | 133 +++++++++++++++++++-------------------------------
 1 file changed, 51 insertions(+), 82 deletions(-)

-- 
1.8.0
