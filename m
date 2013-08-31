From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 00/11] Check replacement object type and minor updates
Date: Sat, 31 Aug 2013 21:12:03 +0200
Message-ID: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:13:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqc9-00015H-CS
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569Ab3HaTNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:13:15 -0400
Received: from [194.158.98.15] ([194.158.98.15]:48080 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752137Ab3HaTNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:13:13 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 6434C63;
	Sat, 31 Aug 2013 21:12:51 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233533>

In this new version of the series, the only change in the 5 first
patches, is a small change in the commit message of patch 1.

Patches from 6/11 to 11/11 are all new:
	- 6/11, 7/11 and 8/11 are about bypassing the type check
	if -f is used
	- 9/11, 10/11 and 11/11 are about adding long option names

Christian Couder (11):
  replace: forbid replacing an object with one of a different type
  Documentation/replace: state that objects must be of the same type
  t6050-replace: test that objects are of the same type
  t6050-replace: add test to clean up all the replace refs
  Documentation/replace: add Creating Replacement Objects section
  replace: bypass the type check if -f option is used
  Documentation/replace: tell that -f option bypasses the type check
  t6050-replace: check that -f option bypasses the type check
  replace: allow long option names
  Documentation/replace: list long option names
  t6050-replace: use some long option names

 Documentation/git-replace.txt | 28 +++++++++++++++++++++++++---
 builtin/replace.c             | 16 +++++++++++++---
 t/t6050-replace.sh            | 31 ++++++++++++++++++++++++++++---
 3 files changed, 66 insertions(+), 9 deletions(-)

-- 
1.8.4.rc1.31.g530f5ce.dirty
