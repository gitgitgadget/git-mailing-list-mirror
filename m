From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] diff options documentation: refer to --diff-filter in
	--name-status
Date: Tue, 22 Apr 2008 14:23:48 +0200
Message-ID: <20080422122348.GD22086@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 14:24:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoHY7-0000MH-Ts
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 14:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbYDVMXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 08:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbYDVMXv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 08:23:51 -0400
Received: from virgo.iok.hu ([193.202.89.103]:56446 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbYDVMXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 08:23:51 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F40791B2538;
	Tue, 22 Apr 2008 14:23:48 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id DE94344659;
	Tue, 22 Apr 2008 14:20:15 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 80B231190AC5; Tue, 22 Apr 2008 14:23:48 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80106>

git diff --name-status outputs letters, but the meaning of those letters
is documented elsewhere. Add a note to make the manpage more intuitive.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/diff-options.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 01e7a57..13234fa 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -83,7 +83,8 @@ endif::git-format-patch[]
 	Show only names of changed files.
 
 --name-status::
-	Show only names and status of changed files.
+	Show only names and status of changed files. See the description
+	of the `--diff-filter` option on what the status letters mean.
 
 --color::
 	Show colored diff.
-- 
1.5.5
