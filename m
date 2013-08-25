From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/5] Check replacement object type and minor updates
Date: Sun, 25 Aug 2013 15:06:03 +0200
Message-ID: <20130825125940.4681.70226.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.orcg>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 15:06:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDa1o-0003bG-RE
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 15:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958Ab3HYNGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 09:06:36 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:37313 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946Ab3HYNGg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 09:06:36 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 0381336;
	Sun, 25 Aug 2013 15:06:33 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232953>

Here is a reroll of the patch forbiding replacing an bject with one
of a different type (1/5).
It is followed by a documentation update (2/5) and a test (3/5).
I also added for good mesure another test (4/5) I came up with while
developing the previous test, and another doc update related to what
we discussed about creating replacement objects (5/5).

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
1.8.4.rc1.24.g13dc82a
