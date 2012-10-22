From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] completion: test simplifications
Date: Mon, 22 Oct 2012 03:38:59 +0200
Message-ID: <1350869941-22485-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 03:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ6zE-0007wV-2M
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 03:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757Ab2JVBjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 21:39:12 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49887 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab2JVBjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 21:39:11 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1941168wib.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 18:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=AULOGBQ/uognBNr10XVk4j3Ko0H2jfX27H1X1CvYaAo=;
        b=dq9kTwn0zUIGQ2kChzswLeDvHYm10gUbQcTLqiJGEqA1lHvVAI59Ah5WI+zkYirIA3
         dhYRDN+ACzqnwduGxJB245tDzbdfDIxRpWRApdzXrSS4aVBWykFSbl3yvixTSpP/Mq6t
         XXblYCH9i2VPUcff5mDkMOuTJlYCc2V9Zdwu8u+ucj6fypyDONUYZ0B5dy9G9aS3AJEP
         chDH9CSJORRj2SQwty76c+/6/18EXVnRXA9qsbfOwRfHjvg2qfAZ6egk8L0uweRuf/P/
         wojA0NFbLZq3xUgXHxCwNaTXsqob7un/KW/hHYYn9zhjibh8pnGEBTC0p0dy8DrU+YsX
         P5qQ==
Received: by 10.216.142.160 with SMTP id i32mr3885611wej.71.1350869950568;
        Sun, 21 Oct 2012 18:39:10 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id bn7sm19111799wib.8.2012.10.21.18.39.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 18:39:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208167>

As the subject says. These came up in a discussion with SZEDER.

Felipe Contreras (2):
  completion: refactor __gitcomp related tests
  completion: simplify __gitcomp test helper

 t/t9902-completion.sh | 71 +++++++++++++++------------------------------------
 1 file changed, 21 insertions(+), 50 deletions(-)

-- 
1.8.0
