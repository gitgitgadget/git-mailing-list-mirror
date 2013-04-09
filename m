From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 0/2] submodule: drop the top-level requirement
Date: Tue,  9 Apr 2013 21:29:20 +0100
Message-ID: <cover.1365539059.git.john@keeping.me.uk>
References: <cover.1365364193.git.john@keeping.me.uk>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 22:29:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPfAo-0005Yt-3r
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 22:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935949Ab3DIU3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 16:29:42 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:42878 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933489Ab3DIU3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 16:29:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id DC726161E7A9;
	Tue,  9 Apr 2013 21:29:37 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2r7wntWczDBb; Tue,  9 Apr 2013 21:29:37 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 7D3F4161E7A2;
	Tue,  9 Apr 2013 21:29:28 +0100 (BST)
X-Mailer: git-send-email 1.8.2.694.ga76e9c3.dirty
In-Reply-To: <cover.1365364193.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220628>

Since version 1, patch 1 has been completely re-written using the
approach proposed by Jonathan and Junio.

Also, there's now a documentation update and some tests.

John Keeping (2):
  rev-parse: add --filename-prefix option
  submodule: drop the top-level requirement

 Documentation/git-rev-parse.txt | 16 ++++++++
 builtin/rev-parse.c             | 24 ++++++++---
 git-submodule.sh                |  7 ++++
 t/t1513-rev-parse-prefix.sh     | 90 +++++++++++++++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh      | 26 ++++++++++++
 t/t7401-submodule-summary.sh    |  9 +++++
 6 files changed, 167 insertions(+), 5 deletions(-)
 create mode 100755 t/t1513-rev-parse-prefix.sh

-- 
1.8.2.694.ga76e9c3.dirty
