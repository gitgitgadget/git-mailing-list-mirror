From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] Trivial cleanups
Date: Tue, 29 Apr 2014 16:49:35 -0500
Message-ID: <1398808178-3703-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:00:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfG4c-0006ya-MG
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbaD2WAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:00:17 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:42626 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964783AbaD2WAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:00:16 -0400
Received: by mail-yk0-f178.google.com with SMTP id 200so764260ykr.37
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2WJnrg6FrisDmLdXMzt1RMVAe55Z/hO1zv6o6UwJo3s=;
        b=pMDMjFcqSSveBAXasUVXgTgrD2V25LjRLk0SllNUhXXLIvdMEgH0Pf8PqB2D8MwVPE
         s9F+rM5cRr4qse7x9phFIg9lvUy4752fTxuOF/8fdzwkoyXL/2SoQOvrg1N6ZYAovi/X
         FnU9qnqR2zVPJJD4V+PMMy7kdJFYXz4g1o6IucK19LS/JvHKf/SUCcg4BnaEdutLt8LV
         JHV0dWSqXw8iqsZ+DScROVZ24j3LRrHaoHyQ16tqRLKUJmOnb88qak54v8RsR0v9Zcn2
         GiNOvaOGzUkGX745fXGQILXPl6pOWw+zRsX+E3Fqdydf6gEbZMKrVQWD9YWvoDWSOjM6
         q9rQ==
X-Received: by 10.236.89.3 with SMTP id b3mr752147yhf.54.1398808815361;
        Tue, 29 Apr 2014 15:00:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d44sm13554155yhf.21.2014.04.29.15.00.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 15:00:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247618>

Felipe Contreras (3):
  config: avoid yoda conditions
  add: avoid yoda condition
  add: remove dead code

 builtin/add.c | 6 +-----
 config.c      | 4 ++--
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
1.9.2+fc1.3.gade8541
