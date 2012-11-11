From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/6] completion: test consolidations
Date: Sun, 11 Nov 2012 15:35:52 +0100
Message-ID: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:36:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYeM-0005xu-13
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab2KKOgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:36:15 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41620 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2KKOgO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:36:14 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2066470bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=tleSBgWRwv12sSzJlL7CTYsj4xAvYMQWVEAgKKlGxiw=;
        b=G8Kiy0AHvbaLhZXSjLIpkq5HHdFaY33ItIzWoOvovW0/+dCebEetgifVUTU/eo8kaA
         4mYviXFS2tIn3MrKbttYtBldOM+UK4d0TXM2oKi7mvX31qGv72wYBHkROguUKixpJeVk
         R/C/1uKYGYeWbgM+I6YG+344YVtZ2CP2M6uOXIx6XbLFb5kmngo5iCEXL3sZ3kXCxS2g
         +3nIVQJG0ivw9+LLOkPmOZEMM6xH/WCxaSItGnml5RbGkmVmTm0YI3a5L4Cb+stJXE/3
         2yneyKWs9ZXU8KcTquekRWpuYa4FG1RiKe5N5RC0fxJciv2u9ElEylRCxNrwp1YHUOcr
         7Tgg==
Received: by 10.204.4.149 with SMTP id 21mr5884349bkr.122.1352644573260;
        Sun, 11 Nov 2012 06:36:13 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id ht18sm1514129bkc.14.2012.11.11.06.36.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:36:12 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209382>

These started from a discussion with SZEDER, but then I realized there were
many improvements possible.

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
