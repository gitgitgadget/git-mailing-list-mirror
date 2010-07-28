From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] SubmittingPatches: Cite the 50 char subject limit
Date: Wed, 28 Jul 2010 14:11:25 +0000
Message-ID: <1280326285-10203-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 16:11:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe7MR-0006Zz-Fe
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 16:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab0G1OLe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 10:11:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34729 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab0G1OLd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 10:11:33 -0400
Received: by bwz1 with SMTP id 1so3972450bwz.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=OyJKquxQm4Yhvawtpz5PeWQSpkjYwFWwq/8a3mhkdYM=;
        b=ITPAWd3S8v5R0UGSRO6xm3Gy9dQWCLsu63z+Ax8F4SqxKuJT9O/PPkz1oigASyI1o1
         zUe3yM3MG/8xWRfFekeq4AlB/2WLJCz2/LuyvD6dHjUHaqqj3XgyYkoDzoZjm4JPwQIv
         255IcHAEqLB4D86Fl5XASwoTgFcolAuYb/Txs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Z4VLtNakXch5THWR0N2A2GKR1I37GwHRrJqszRd9Cyrx4rKGoKaFIAKia7nIa3LUjv
         gtp876kkoU2ULRG2aUiifiQeiDw/UmOAGSED2HINEb2jJ3tH/wAp1zaDbo8wpyHJtJMe
         +SgUgWpBURAZ6GsdNg5bRe3TFHsJVKcUpyyyc=
Received: by 10.204.82.136 with SMTP id b8mr8183672bkl.38.1280326291696;
        Wed, 28 Jul 2010 07:11:31 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id y2sm4814676bkx.8.2010.07.28.07.11.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 07:11:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152088>

Change the SubmittingPatches recommendations to mention the 50
character soft limit on patch subject lines. 50 characters is the soft
limit mentioned in git-commit(1) and gittutorial(7), it's also the
point at which Gitweb, GitHub and various other Git front ends start
abbreviating the commit message.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/SubmittingPatches |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/Submitting=
Patches
index eb53e06..099b238 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -7,7 +7,8 @@ Checklist (and a short version for the impatient):
 	  before committing
 	- do not check in commented out code or unneeded files
 	- the first line of the commit message should be a short
-	  description and should skip the full stop
+	  description (50 characters is the soft limit, see DISCUSSION
+	  in git-commit(1)), and should skip the full stop
 	- the body should provide a meaningful commit message, which:
 		- uses the imperative, present tense: "change",
 		  not "changed" or "changes".
--=20
1.7.0.4
