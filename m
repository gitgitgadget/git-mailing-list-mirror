From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/2] reset: handle submodule with trailing slash
Date: Tue, 10 Sep 2013 20:13:16 +0100
Message-ID: <cover.1378840318.git.john@keeping.me.uk>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 10 21:13:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJTNe-0000Gz-3L
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 21:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab3IJTNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 15:13:36 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:46561 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3IJTNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 15:13:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id D3C3E6064EC;
	Tue, 10 Sep 2013 20:13:33 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0hbbSL8ulC+B; Tue, 10 Sep 2013 20:13:33 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id AF0C36064FA;
	Tue, 10 Sep 2013 20:13:27 +0100 (BST)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234470>

The first patch is the important one here, the second one I noticed
while checking if any other commands fail to handle submodule paths with
a trailing slash and is just a simplification.

John Keeping (2):
  reset: handle submodule with trailing slash
  rm: re-use parse_pathspec's trailing-slash removal

 builtin/reset.c            |  5 +++++
 builtin/rm.c               | 20 ++++----------------
 t/t7400-submodule-basic.sh |  6 ++++--
 3 files changed, 13 insertions(+), 18 deletions(-)

-- 
1.8.2
