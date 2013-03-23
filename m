From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 0/3] difftool --dir-diff test improvements
Date: Sat, 23 Mar 2013 13:31:38 +0000
Message-ID: <cover.1364045138.git.john@keeping.me.uk>
References: <cover.1363980749.git.john@keeping.me.uk>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 23 14:32:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJOYn-0003XJ-84
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 14:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973Ab3CWNb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 09:31:58 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:55596 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab3CWNb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 09:31:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 7C143161E036;
	Sat, 23 Mar 2013 13:31:57 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F4xjP5omeS8w; Sat, 23 Mar 2013 13:31:57 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 18914161E2F4;
	Sat, 23 Mar 2013 13:31:46 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.324.ga64ebd9
In-Reply-To: <cover.1363980749.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218917>

This version fixes the actual cause of the test failure (not being
specific enough when adding files).  This is done with a new version of
patch 2.

Patch 1 is unchanged and patch 3 only contains a minor change.

This is built on da/difftool-fixes.  There may be a small textual
conflict with jk/difftool-dir-diff-edit-fix in the context lines but I
don't believe there is any logical conflict.

John Keeping (3):
  t7800: don't hide grep output
  t7800: fix tests when difftool uses --no-symlinks
  t7800: run --dir-diff tests with and without symlinks

 t/t7800-difftool.sh | 73 +++++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

-- 
1.8.2.324.ga64ebd9
