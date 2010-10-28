From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v8] Detection of directory renames
Date: Fri, 29 Oct 2010 00:08:27 +0200
Message-ID: <1288303712-14662-1-git-send-email-ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 00:08:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBaeV-00020R-F5
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 00:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943Ab0J1WIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 18:08:51 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:60517 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab0J1WIt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 18:08:49 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 697BDD480C3
	for <git@vger.kernel.org>; Fri, 29 Oct 2010 00:08:44 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PBaeJ-0003p4-8v
	for git@vger.kernel.org; Fri, 29 Oct 2010 00:08:43 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160233>

Changes since v7:

* turned debug traces off but allow them to be easily turned on
* corrected example in gitdiffcore.txt (Junio)
* unidiff output changes:
  * don't use "diff --git" to avoid confusing git-apply, use
    --git-detect-bulk-moves instead (Junio, 2008)
  * use "bulk move with similarity index NNN%"
  * don't use trailing asterisk, useless there
* added missing &&'s in testsuite
* improved short help messages
* documented the unidiff output format and --hide-bulk-move-details
* splitted raw output format, under discussion, into its own patch
* improved commit messages, including current rationale for using "/*"
* listed bulk-removal/copy/add as possible future related works
* renamed test script for consistency

I'll experiment next with bulk-removal detection, with bulk-move
rerolled on top of it.
