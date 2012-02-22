From: =?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
Subject: [PATCH 3/4] completion: remove stale "to submit patches" documentation
Date: Wed, 22 Feb 2012 09:58:12 +0100
Message-ID: <1329901093-24106-4-git-send-email-philip@foolip.org>
References: <20120222001737.GB2228@goldbirke>
 <1329901093-24106-1-git-send-email-philip@foolip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	=?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 09:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S082O-0006Gb-W1
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 09:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab2BVI6v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 03:58:51 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54339 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754443Ab2BVI6u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 03:58:50 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so8716873lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 00:58:49 -0800 (PST)
Received-SPF: pass (google.com: domain of philip@foolip.org designates 10.112.98.37 as permitted sender) client-ip=10.112.98.37;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of philip@foolip.org designates 10.112.98.37 as permitted sender) smtp.mail=philip@foolip.org
Received: from mr.google.com ([10.112.98.37])
        by 10.112.98.37 with SMTP id ef5mr10626257lbb.73.1329901129614 (num_hops = 1);
        Wed, 22 Feb 2012 00:58:49 -0800 (PST)
Received: by 10.112.98.37 with SMTP id ef5mr8896567lbb.73.1329901129523;
        Wed, 22 Feb 2012 00:58:49 -0800 (PST)
Received: from localhost.localdomain (h128n3-g-hn-a11.ias.bredband.telia.com. [217.209.32.128])
        by mx.google.com with ESMTPS id ot2sm24473095lab.3.2012.02.22.00.58.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 00:58:48 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1329901093-24106-1-git-send-email-philip@foolip.org>
X-Gm-Message-State: ALoCoQlp+U/0RaYccPWMm0NlsNarZHyPCrRqRJzE9qK70RUkKm7dFrhZBrdQX+04PWQ0URSBJ/35
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191237>

It was out-of-sync with the reality of who works on this
script. Defer (silently) to Documentation/SubmittingPatches
like all other code.

Signed-off-by: Philip J=C3=A4genstedt <philip@foolip.org>
---
 contrib/completion/git-completion.bash |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 1903bc9..48237c8 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -60,18 +60,6 @@
 #       per-repository basis by setting the bash.showUpstream config
 #       variable.
 #
-#
-# To submit patches:
-#
-#    *) Read Documentation/SubmittingPatches
-#    *) Send all patches to the current maintainer:
-#
-#       "Shawn O. Pearce" <spearce@spearce.org>
-#
-#    *) Always CC the Git mailing list:
-#
-#       git@vger.kernel.org
-#
=20
 if [[ -n ${ZSH_VERSION-} ]]; then
 	autoload -U +X bashcompinit && bashcompinit
--=20
1.7.5.4
