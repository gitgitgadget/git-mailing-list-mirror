From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/3] Colored prompt for ZSH
Date: Mon, 13 May 2013 19:19:15 +0530
Message-ID: <1368452958-31090-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 15:47:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubt6P-00009d-Ua
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 15:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041Ab3EMNrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 09:47:41 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:55036 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab3EMNrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 09:47:41 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so4649606pad.11
        for <git@vger.kernel.org>; Mon, 13 May 2013 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=1qYQenVDn7LfmZA1NhDWbvgXYrlpzRp8sUiieP88Mzk=;
        b=B5tcjNaaEWcGAQIDkTTZ1mKymkU/AnT75sOuP8u8v3kQ4Pl/dI9eONMnMako5VnXHS
         Oul3QzGRc9Z8WPtKS/7pQxw7wf4gxQHkJk0sSV4rEh6yuJ2m147S0IUTyb073aN3iLD/
         u2jHd+apn05ZkNV5YU6m2p4h6NuJ5dYhm8uab26VG3aS7/DGnx5jBs4evI/qyzPDTJWu
         kJRvzHUHng3kQKQ2B9t5Ohfikav2ggmTKWZYNvEUjBtdXb/1XJ+7PDzWWpqn7XCSfheh
         afE0HJwPSEwOOz9hMNKNt0dDmpuz96ormfABPlweSrRVJgv7h8qMk+qqcfFch9lpZNGr
         ZFZg==
X-Received: by 10.66.163.200 with SMTP id yk8mr29847593pab.170.1368452860714;
        Mon, 13 May 2013 06:47:40 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id sq9sm15114287pab.5.2013.05.13.06.47.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 06:47:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.57.g4ac1522
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224136>

Thanks to Felipe, SZEDER, and Junio for a review of v1.  This is a v2
in response to those reviews.

Ramkumar Ramachandra (3):
  prompt: introduce GIT_PS1_STATESEPARATOR
  prompt: factor out gitstring coloring logic
  prompt: colorize ZSH prompt

 contrib/completion/git-prompt.sh | 128 +++++++++++++++++++++++++++------------
 1 file changed, 89 insertions(+), 39 deletions(-)

-- 
1.8.3.rc1.57.g4ac1522
