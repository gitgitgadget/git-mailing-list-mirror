From: Brad King <brad.king@kitware.com>
Subject: [PATCH v5 0/8] Multiple simultaneously locked ref updates
Date: Mon,  9 Sep 2013 09:22:31 -0400
Message-ID: <cover.1378732710.git.brad.king@kitware.com>
References: <cover.1378307529.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 15:24:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1SN-0003iv-ME
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898Ab3IINYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 09:24:39 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:40306 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752195Ab3IINYi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:24:38 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 7F44F9FB8C; Mon,  9 Sep 2013 09:22:33 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <cover.1378307529.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234324>

Hi Folks,

Here is the fifth revision of a series to support locking multiple
refs at the same time to update all of them consistently.  The
previous revisions of the series can be found at $gmane/233260,
$gmane/233458, $gmane/233647, and $gmane/233840.

Updates since the previous revision of the series:

* Patches 1-6 are identical to v4 so are not re-sent here.

* Patch 7 and 8 now implement and test the input format proposed and
  discussed at $gmane/233990.

-Brad

Brad King (2):
  update-ref: support multiple simultaneous updates
  update-ref: add test cases covering --stdin signature

 Documentation/git-update-ref.txt |  54 +++-
 builtin/update-ref.c             | 252 ++++++++++++++-
 t/t1400-update-ref.sh            | 639 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 943 insertions(+), 2 deletions(-)

-- 
1.8.4.rc3
