From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/3] tests: --valgrind=tool
Date: Sun, 31 Mar 2013 10:00:14 +0200
Message-ID: <cover.1364716452.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 31 10:01:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMDCD-0005O3-Le
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 10:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549Ab3CaIA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 04:00:29 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:57352 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754205Ab3CaIA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 04:00:28 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 10:00:24 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.251) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 10:00:23 +0200
X-Mailer: git-send-email 1.8.2.467.gedf93a5
X-Originating-IP: [213.55.184.251]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219604>

From: Thomas Rast <trast@inf.ethz.ch>

I had a quick-and-dirty edit to t/valgrind/valgrind.sh in my trees
while we did the index-pack investigation.  This small series is the
"proper" way of achieving the same.

Thomas Rast (3):
  t/README: --valgrind already implies -v
  tests: parameterize --valgrind option
  tests --valgrind: provide a mode without --track-origins

 t/README               | 21 +++++++++++++++------
 t/test-lib.sh          | 10 +++++++++-
 t/valgrind/valgrind.sh | 27 +++++++++++++++++----------
 3 files changed, 41 insertions(+), 17 deletions(-)

-- 
1.8.2.467.gedf93a5
