From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 08/12] merge,
	pull: mark the config variable 'merge.diffstat' as deprecated
Date: Wed, 16 Apr 2008 02:39:07 +0200
Message-ID: <1208306351-20922-9-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
	<1208306351-20922-1-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-2-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-3-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-4-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-5-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-6-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-7-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-8-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 07:38:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvhq-0007aE-Vp
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbYDPAj1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 20:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755339AbYDPAjZ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:54471 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbYDPAjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:20 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu0) with ESMTP (Nemesis)
	id 0MKwh2-1JlvgE3oEV-0007kX; Wed, 16 Apr 2008 02:39:19 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <1208306351-20922-8-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1/hpK/BzdKmYzDH6f27rbHpKKHabWSWWh1+u8Z
 baXHRhnKZpWG07loxrbosD5tEB3SU/VLZn8Y7LtCdi0PEYE6DB
 ep3OP5hKLh2e6FLY4BZ3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79664>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/merge-config.txt  |    4 +++-
 Documentation/merge-options.txt |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
index a0f71e6..5000162 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -1,8 +1,10 @@
 merge.stat::
-merge.diffstat::
 	Whether to print the diffstat berween ORIG_HEAD and merge result
 	at the end of the merge.  True by default.
=20
+merge.diffstat::
+	Deprecated equivalent of merge.stat.
+
 merge.log::
 merge.summary::
 	Whether to include summaries of merged commits in newly created
diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index d0a2ac9..f282556 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,7 +1,7 @@
 --stat::
 	Show a diffstat at the end of the merge. The diffstat is also
 	controlled by the configuration option merge.stat (and the
-	equivalent merge.diffstat).
+	deprecated merge.diffstat).
=20
 -n, \--no-stat::
 	Do not show diffstat at the end of the merge.
--=20
1.5.5.76.g546c
