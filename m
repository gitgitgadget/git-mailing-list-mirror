From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/2] remote-bzr: couple of fixes
Date: Fri,  3 May 2013 19:31:05 -0500
Message-ID: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 02:32:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYQP5-0008BC-OT
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 02:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763260Ab3EDAcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 20:32:31 -0400
Received: from mail-gg0-f175.google.com ([209.85.161.175]:57339 "EHLO
	mail-gg0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762885Ab3EDAc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 20:32:26 -0400
Received: by mail-gg0-f175.google.com with SMTP id k6so333651ggd.20
        for <git@vger.kernel.org>; Fri, 03 May 2013 17:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=vcKjcE2D99eKIC7zpKgp5lRhz/U4IapOkIsQlQ+vC5M=;
        b=JwHVqKFWgcdxPtBQypX8QqfnU+MJ7XAwSw54RYNP6xbuuO+BKM5Em4xtcYI3oE/ZVT
         DAp98gJPU5ICdj4PmauSS7pRm2EPszTazQ0hQrupwzJhEIWTF59aHm8wgDl6q0smqh3g
         YpbD0RyT/pGoEgLuMnUdc0TMe/4EkdRJ5q0y3zuV3bRsOY0+/VfvnKlxdI7jSLKoY9d5
         LkTO899FTPJc4h0Y3jMwcbazrbWfXwQYboEuoGrJ7L4I9EXDM+evOkYPPyfFhz/ipFfC
         wbeWoYYCITGYKHC45yI7Anpi2NHrObF+MbdrEQ3cpRD3ZiQPZ1A8evQnfU4XbGpHS3kq
         7Jag==
X-Received: by 10.236.118.113 with SMTP id k77mr10795780yhh.147.1367627545326;
        Fri, 03 May 2013 17:32:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c67sm24923582yhh.16.2013.05.03.17.32.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 May 2013 17:32:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223346>

Hi,

The previous version had an indentation bug (did I mention I hate python?).

A few fixes to be applied on top of the massive changes already queued. Nothing
major.

Felipe Contreras (2):
  remote-bzr: convert all unicode keys to str
  remote-bzr: avoid bad refs

 contrib/remote-helpers/git-remote-bzr | 42 +++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 17 deletions(-)

-- 
1.8.3.rc0.401.g45bba44
