From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 00/11] Check replacement object type and minor updates
Date: Tue, 03 Sep 2013 09:10:14 +0200
Message-ID: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:11:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGklu-0004eS-OO
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749Ab3ICHLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:11:15 -0400
Received: from [194.158.98.15] ([194.158.98.15]:42763 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752076Ab3ICHLO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:11:14 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 951476F;
	Tue,  3 Sep 2013 09:10:50 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233687>

The only changes in this new version are:

	- removed useless redirections in 8/11
	- improved commit message in 11/11 (s/litlle/little/)

I may add examples and more in a new patch series later.

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
