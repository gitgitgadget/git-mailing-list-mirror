From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 0/5]
Date: Tue, 24 Apr 2007 15:01:10 -0300
Message-ID: <1177437675887-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Apr 24 20:03:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgPMV-0008IZ-MO
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 20:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422931AbXDXSDV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 14:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422955AbXDXSDV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 14:03:21 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:49844 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422931AbXDXSDU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 14:03:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 6346C17708;
	Tue, 24 Apr 2007 15:03:18 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id Q188cE9v1lb7; Tue, 24 Apr 2007 15:03:18 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 0A20D1770D;
	Tue, 24 Apr 2007 15:01:16 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id D46D868B586; Tue, 24 Apr 2007 15:01:15 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.303.g946d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45482>

 Hi,

 Some random things I've fixed while reading the code, they're
unrelated changes, but I think it's better to send in one shot.

Diff stat:

 Documentation/core-tutorial.txt |    9 ++++-----
 builtin-commit-tree.c           |    3 +--
 cache.h                         |    2 +-
 entry.c                         |   14 +++++++-------
 read-cache.c                    |   16 ++++++++--------
 5 files changed, 21 insertions(+), 23 deletions(-)
