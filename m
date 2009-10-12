From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-stash documentation: mention default options for 'list'
Date: Mon, 12 Oct 2009 21:37:39 +0200
Message-ID: <20091012193739.GR23777@genesis.frugalware.org>
References: <havj2n$d85$1@ger.gmane.org>
 <20091012175201.GA10263@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jef Driesen <jefdriesen@hotmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:39:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxQjn-0007U8-AA
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 21:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933197AbZJLTiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 15:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933187AbZJLTiU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 15:38:20 -0400
Received: from virgo.iok.hu ([212.40.97.103]:41303 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933180AbZJLTiT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 15:38:19 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8A7C7580B5;
	Mon, 12 Oct 2009 21:37:39 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 28F1044906;
	Mon, 12 Oct 2009 21:37:39 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3C66A11F0028; Mon, 12 Oct 2009 21:37:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20091012175201.GA10263@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130056>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I just noticed this was not mentioned in the manpage.

 Documentation/git-stash.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 3f14b72..fafe728 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -78,7 +78,8 @@ stash@{1}: On master: 9cc0589... Add git-stash
 ----------------------------------------------------------------
 +
 The command takes options applicable to the 'git-log'
-command to control what is shown and how. See linkgit:git-log[1].
+command to control what is shown and how. If no options are set, the
+default is `-n 10`. See linkgit:git-log[1].
 
 show [<stash>]::
 
-- 
1.6.4
