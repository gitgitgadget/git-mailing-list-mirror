From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/5] Check replacement object type and minor updates
Date: Tue, 27 Aug 2013 21:48:22 +0200
Message-ID: <20130827194022.11172.56453.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:49:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEPGO-0006k6-OC
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754Ab3H0TtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:49:04 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:53246 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753481Ab3H0TtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:49:01 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id CF89954;
	Tue, 27 Aug 2013 21:48:57 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233150>

The only changes compared to the previous version are those
suggested by Johannes:

- the error message is now:

	"Objects must be of the same type.\n"
	"'%s' points to a replaced object of type '%s'\n"
	"while '%s' points to a replacement object of type '%s'."

- the test uses "." instead of "'\''"

Only patchs 1/5 and 3/5 were changed.

Christian Couder (5):
  replace: forbid replacing an object with one of a different type
  Documentation/replace: state that objects must be of the same type
  t6050-replace: test that objects are of the same type
  t6050-replace: add test to clean up all the replace refs
  Documentation/replace: add Creating Replacement Objects section

 Documentation/git-replace.txt | 23 ++++++++++++++++++++---
 builtin/replace.c             | 10 ++++++++++
 t/t6050-replace.sh            | 19 +++++++++++++++++++
 3 files changed, 49 insertions(+), 3 deletions(-)

-- 
1.8.4.rc1.26.gdd51ee9
