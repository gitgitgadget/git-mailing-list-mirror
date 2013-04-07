From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/4] send-email: couple of improvements
Date: Sun,  7 Apr 2013 01:10:26 -0600
Message-ID: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 09:11:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOjlG-0000Bx-Dg
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 09:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630Ab3DGHLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 03:11:30 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:64278 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119Ab3DGHL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 03:11:29 -0400
Received: by mail-oa0-f51.google.com with SMTP id g12so5192572oah.24
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 00:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=xzzNW+zRfzQhco9if6Oqcak6voBCG8Kk2tXHhai/5IM=;
        b=ZMcObZPN1zl5+HxM4bimmRxp1PZMiPu8TaZxj5NctC3DNs4rRQ33z18aqdyD9Q9lqk
         rAqwLuexhGHDsSFsh/+4Q1CEqVh4DxtwMkc6whz6ousPqdm1oozL44lqNRaEtuRsbow4
         Uilu9WS1xqN1DVtZMLYvh1WfwZ4dIKve8VXPNgqL1OROk0/YxPaz0O9Nj+BProky4ZmN
         uU8EDqnKi5deAFrAfnK641SlkkXcUOeO6W06/BcdId7A63FKClitAZ16ejjr7ep8Mnev
         knrPedjwtTTwwwf8X2kClEKUqDuR+T1/xqk06NNvpzWtktHYgq0pdkbEwc04EhbPyWxC
         HFiw==
X-Received: by 10.182.116.70 with SMTP id ju6mr11992540obb.48.1365318689061;
        Sun, 07 Apr 2013 00:11:29 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id be1sm19153389obb.11.2013.04.07.00.11.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 00:11:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220282>

Hi,

Integrated the latest feedback, and improve format-patch along the way. There
should be no disadvantages with applying the latest patch.

Felipe Contreras (4):
  send-email: make annotate configurable
  format-patch: improve head calculation for cover-letter
  format-patch: refactor branch name calculation
  format-patch: add format.cover-letter configuration

 Documentation/config.txt           |  7 ++++
 Documentation/git-format-patch.txt |  5 ++-
 Documentation/git-send-email.txt   |  5 ++-
 builtin/log.c                      | 75 +++++++++++++++++---------------------
 git-send-email.perl                |  7 ++--
 5 files changed, 51 insertions(+), 48 deletions(-)

-- 
1.8.2
