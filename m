From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/2] send-email: couple of improvements
Date: Sat,  6 Apr 2013 03:03:30 -0600
Message-ID: <1365239012-15079-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:44:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWTF-0001b9-CT
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932836Ab3DFJEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 05:04:34 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35901 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932834Ab3DFJEd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 05:04:33 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so4316524obb.23
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 02:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=X9TglekbXvhmi87kezUWwiJkfaraMH4jiXCewi+orm0=;
        b=h7NvyZ/M1Q8kpl1fWeg7OEbOr61+MiUF9vZ2MpvlX2P6eAHKHd0OUDdQeJlypyBa2m
         RvtPe1kklDtEVb+guDpgFZE5cHbOodWY7xQQsnkLe9wZ/XU1D6NvdQBoyGzoJKfF//bt
         pYHll7c6+oGykT4tOQwlPdz7gaBDGSaaqqlJdtWDV24BOW1hiriEGQn5PWgi3DDaCA+r
         qsWxH7DtZy15JkXGE3pG/uUsD92jqUTWBSuJc/Y25G08YoDJaH6i6JzjhV3VJLBN2F15
         cJ8lxHmY8Xol5Tj0Su6H3FEW9ltfxyrMkJcFeIjwF0rlyrB9dWD83+zb9S9rJ6/YN8Be
         ms0Q==
X-Received: by 10.182.204.5 with SMTP id ku5mr10469106obc.22.1365239072788;
        Sat, 06 Apr 2013 02:04:32 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id a10sm15938539oez.1.2013.04.06.02.04.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Apr 2013 02:04:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220229>

Hi,

First patch was already sent, I just added the --no-annotate option. Second one
is new, it adds a configuration for --cover-letter, so it can automatically
determine when to generated: 1 patch, no cover, otherwise there is.

Felipe Contreras (2):
  send-email: make annotate configurable
  format-patch: add format.cover-letter configuration

 Documentation/config.txt           |  7 +++++
 Documentation/git-format-patch.txt |  5 ++--
 Documentation/git-send-email.txt   |  5 ++--
 builtin/log.c                      | 55 +++++++++++++++++++++++---------------
 git-send-email.perl                | 12 ++++++---
 5 files changed, 55 insertions(+), 29 deletions(-)

-- 
1.8.2
