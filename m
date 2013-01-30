From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/3] mergetool: add user configured commands to '--tool-help'
Date: Wed, 30 Jan 2013 19:55:43 +0000
Message-ID: <cover.1359575447.git.john@keeping.me.uk>
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 21:03:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0dsf-00014K-0h
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 21:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878Ab3A3UDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 15:03:15 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:56283 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3A3UDN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 15:03:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id EF6FA8660D8;
	Wed, 30 Jan 2013 19:56:11 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eJlN0V-kBkwn; Wed, 30 Jan 2013 19:56:11 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 146F78660D2;
	Wed, 30 Jan 2013 19:56:11 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 0891C161E559;
	Wed, 30 Jan 2013 19:56:11 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zK3-ktiKNxto; Wed, 30 Jan 2013 19:56:10 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 61DF0161E02E;
	Wed, 30 Jan 2013 19:56:04 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215066>

The first couple of these are fixups to da/mergetool-docs.  I think the
first one's obvious, but the second one should possible be changed into
an incremental patch on top.  I did it this way for now since that patch
is basically my comments in [1] in patch form.

The final patch adds tools from git-config to the '--tool-help' output.

[1] http://article.gmane.org/gmane.comp.version-control.git/214964

John Keeping (3):
  fixup! mergetool--lib: add functions for finding available tools
  fixup!  doc: generate a list of valid merge tools
  mergetool--lib: list user configured tools in '--tool-help'

 git-mergetool--lib.sh | 82 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 19 deletions(-)

-- 
1.8.1.1
