From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/2] rebase: support --no-autostash
Date: Thu, 10 Sep 2015 23:30:50 +0100
Message-ID: <cover.1441924193.git.john@keeping.me.uk>
References: <55F1EE67.3090401@thequod.de>
Cc: Daniel Hahler <genml+git-2014@thequod.de>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 00:30:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaAMm-0000DE-FF
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 00:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbbIJWas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 18:30:48 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48263 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbbIJWar (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 18:30:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id DF57686601C;
	Thu, 10 Sep 2015 23:30:46 +0100 (BST)
X-Quarantine-ID: <HWtvjoNLuuUa>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HWtvjoNLuuUa; Thu, 10 Sep 2015 23:30:46 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 9555FCDA5E5;
	Thu, 10 Sep 2015 23:30:38 +0100 (BST)
X-Mailer: git-send-email 2.6.0.rc0.162.gb2d3693
In-Reply-To: <55F1EE67.3090401@thequod.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277645>

The first patch is the fix so that git-rebase supports the
--no-autostash option that it's documentation claims it does.

The second is a slight tweak to the documentation to make it consistent
with the remainder of the file.

John Keeping (2):
  rebase: support --no-autostash
  Documentation/git-rebase: fix --no-autostash formatting

 Documentation/git-rebase.txt |  3 ++-
 git-rebase.sh                |  5 ++++-
 t/t3420-rebase-autostash.sh  | 10 ++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.6.0.rc0.162.gb2d3693
