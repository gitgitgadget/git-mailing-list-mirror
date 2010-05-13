From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] Documentation: mark another two rebase options as incompatible with --interactive
Date: Thu, 13 May 2010 14:47:53 +0200
Message-ID: <1273754873-7935-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 13 14:47:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCXof-0000J9-Lb
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 14:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab0EMMq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 08:46:59 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:36122 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab0EMMq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 08:46:58 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id CC05F1597F3F4;
	Thu, 13 May 2010 14:46:56 +0200 (CEST)
Received: from [91.19.22.231] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1OCXoW-0000qZ-00; Thu, 13 May 2010 14:46:56 +0200
X-Mailer: git-send-email 1.7.1.90.g36416
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+yZjXD1tu6ACyCn24poZOQgZPIgXrrpvDYGJO0
	3NRCDgbuV13/UzdnmZbuZuXcXId41IgL7oEJ725g290GqB32qo
	z4wFXnp0knUhD3qIbj9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146998>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/git-rebase.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0d07b1b..5863dec 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -295,6 +295,7 @@ link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for details).
 --ignore-date::
 	These flags are passed to 'git am' to easily change the dates
 	of the rebased commits (see linkgit:git-am[1]).
+	Incompatible with the --interactive option.
 
 -i::
 --interactive::
-- 
1.7.1.90.g36416
