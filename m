From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Make t3411 executable
Date: Thu, 15 Jan 2009 01:33:19 +0100
Message-ID: <1231979599-24534-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 01:34:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGC2-0004rI-VF
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761105AbZAOAdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761052AbZAOAdS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:33:18 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:33016 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760997AbZAOAdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:33:18 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id B060E446CE6;
	Thu, 15 Jan 2009 01:33:15 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id E682119DFC4; Thu, 15 Jan 2009 01:33:19 +0100 (CET)
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105741>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I just wanted had an old script, which did:

for i in *merge*
do
        ./$i
        if [ $? != 0 ]; then
		...
        fi
done

which pointed out this permission problem.

 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/t3411-rebase-preserve-around-merges.sh

diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
old mode 100644
new mode 100755
-- 
1.6.1
