From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 0/7] Check replacement object type and minor updates
Date: Fri, 06 Sep 2013 07:10:52 +0200
Message-ID: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 07:12:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHoKt-00059G-Rl
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 07:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770Ab3IFFLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 01:11:55 -0400
Received: from [194.158.98.14] ([194.158.98.14]:38037 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750733Ab3IFFLy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 01:11:54 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id ADA143C;
	Fri,  6 Sep 2013 07:11:32 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234019>

Many patchs have been squashed together as Junio suggested.
And in patch 3/7 now no grep is done on the error message.

Christian Couder (7):
  replace: forbid replacing an object with one of a different type
  Documentation/replace: state that objects must be of the same type
  t6050-replace: test that objects are of the same type
  t6050-replace: add test to clean up all the replace refs
  Documentation/replace: add Creating Replacement Objects section
  replace: allow long option names
  t6050-replace: use some long option names

 Documentation/git-replace.txt | 28 +++++++++++++++++++++++++---
 builtin/replace.c             | 16 +++++++++++++---
 t/t6050-replace.sh            | 25 ++++++++++++++++++++++---
 3 files changed, 60 insertions(+), 9 deletions(-)

-- 
1.8.4.rc1.28.ge2684af
