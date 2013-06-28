From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/4] Batch completion improvements
Date: Fri, 28 Jun 2013 19:48:04 +0530
Message-ID: <1372429088-385-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 28 16:21:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsZYI-0001Ym-UL
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 16:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab3F1OV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 10:21:27 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:41285 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab3F1OV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 10:21:26 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so2309678pbc.38
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=wdYxwy/7tFNUbq2APy/XQWO33W9sBV9C9zvQrFvbE94=;
        b=qT6DTT8mPm4KVp6jkvo2lI25kZy645RQ9uGZrRRavs4Wtu9BQzANhXPdAr+coYhrhX
         T+8BjD2ISnHHz63Z6mTgZ39ITqlAdR3nC0/UZ9AStEpAlmamfCx5/Vglrk3Y4gIulHVD
         rgt23/RNoNylg5u8eTzRgt2QwvrGK5e4KL1jmow7x6ra9PDPmWjRhXVixyoLvLF6Nw7S
         jkL7YuDccJIAIMgkcyKJnD0nyQl6jXCYG5dtfMPPgyfXjyjYZmldE7qpwQ2tImniUwkV
         cRbS1KokiPqpmYyyp3c4It1XDVUlKcPJKanaCnxFC/M3mGJqBAmjnmTGw0zKkiy7E3wg
         nCsA==
X-Received: by 10.68.104.196 with SMTP id gg4mr11824362pbb.25.1372429285953;
        Fri, 28 Jun 2013 07:21:25 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id iq6sm8397665pbc.1.2013.06.28.07.21.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 07:21:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.585.g9832cb9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229202>

Hi,

An older iteration of [2/4] was just reviewed by SZEDER on the list.
[1/4] and [3/4] have been sent out in the past, but haven't been
picked up.  [4/4] is new.

Thanks.

Ramkumar Ramachandra (4):
  completion: complete rebase --edit-todo
  completion: add completer for status
  completion: add completer for rev-parse
  completion: prefer to use local git-completion.bash

 contrib/completion/git-completion.bash | 45 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.zsh  |  2 +-
 2 files changed, 46 insertions(+), 1 deletion(-)

-- 
1.8.3.1.585.g9832cb9
