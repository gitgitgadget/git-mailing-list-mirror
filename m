From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/2] difftool --dir-diff: symlink all files matching the working tree
Date: Wed, 13 Mar 2013 20:33:07 +0000
Message-ID: <cover.1363206651.git.john@keeping.me.uk>
References: <7vy5dr14mc.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 21:34:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFsNL-0005Et-VV
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 21:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab3CMUdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 16:33:49 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:59469 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab3CMUdt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 16:33:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 9E53922FC6;
	Wed, 13 Mar 2013 20:33:48 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tT4f1Ax9QOkt; Wed, 13 Mar 2013 20:33:48 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 3010322FBA;
	Wed, 13 Mar 2013 20:33:38 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.rc2.4.g7799588
In-Reply-To: <7vy5dr14mc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218089>

Here's the proper patch.  It grew into a series because I noticed a
minor formatting error in the difftool documentation, which the first
commit fixes.

The content of the second patch is the same as was previously posted.

John Keeping (2):
  git-difftool(1): fix formatting of --symlink description
  difftool --dir-diff: symlink all files matching the working tree

 Documentation/git-difftool.txt |  8 +++++---
 git-difftool.perl              | 21 ++++++++++++++++++---
 t/t7800-difftool.sh            | 14 ++++++++++++++
 3 files changed, 37 insertions(+), 6 deletions(-)

-- 
1.8.2.rc2.4.g7799588
