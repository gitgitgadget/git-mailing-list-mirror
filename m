From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/6] remote-hg: fixes and cleanups
Date: Fri, 10 May 2013 15:59:20 -0500
Message-ID: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 23:01:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UauR2-0000dT-Cj
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 23:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab3EJVAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 17:00:55 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52612 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab3EJVAx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 17:00:53 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so5482756oag.19
        for <git@vger.kernel.org>; Fri, 10 May 2013 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=GmpEljkGmvS/Uak2zfevGc+n10LjcbSEwkHsS3QO6a8=;
        b=LFGqhEFlphw/PMw8flRV9iq1ZU4EbdUBAFGqjn4/KclCWsYDjGdxeGOYQ4D5Gu44Tj
         r20tKJFxz9qsGzJdAfz9YW7GadXRIpD55y+JZgBohIH5zJ5jPPqLl1R2GAQFvdKqK8vo
         sr3PFTiHf4HN4vMhVd3WE2YoXOzsS6P5rm+j4S1R0VlgwyUW2multe9hyca6l1dgss6R
         +5xzb1WdcjfILqmtQDqxfcsD3xlnpWGg//Onf6KaN8LUkrx8TECXXEP/yFX6wqh9daVZ
         8ACNHbyLqSueqvrDvV/IPvCcv9abCn9uZO3FyigVzowAs4kmQnOyTCmmYm1YUPqFvp3L
         PDtw==
X-Received: by 10.182.44.129 with SMTP id e1mr7984493obm.57.1368219653149;
        Fri, 10 May 2013 14:00:53 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm4524543obb.14.2013.05.10.14.00.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 14:00:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223908>

Hi,

A few fixes since last series, plus a few more patches. Simple no-brainers.

Felipe Contreras (6):
  remote-hg: disable forced push by default
  remote-hg: don't push fake 'master' bookmark
  remote-hg: update bookmarks when pulling
  remote-hg: test: be a little more quiet
  remote-hg: fix new branch creation
  remote-hg: trivial reorganization

 contrib/remote-helpers/git-remote-hg | 18 +++++++++++-------
 contrib/remote-helpers/test-hg.sh    |  4 ++--
 2 files changed, 13 insertions(+), 9 deletions(-)

-- 
1.8.3.rc1.579.g184e698
