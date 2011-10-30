From: =?UTF-8?q?Dejan=20Ribi=C4=8D?= <dejan.ribic@gmail.com>
Subject: [PATCH] Fix a typo in line 117 of git-gui/lib/sshkeys.tcl.
Date: Sun, 30 Oct 2011 18:18:44 +0100
Message-ID: <1319995124-7509-1-git-send-email-dejan.ribic@gmail.com>
References: <n>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Dejan=20Ribi=C4=8D?= <dejan.ribic@gmail.com>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 30 18:19:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKZ2W-00011D-Bj
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 18:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934271Ab1J3RTP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Oct 2011 13:19:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60432 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934231Ab1J3RTO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 13:19:14 -0400
Received: by faan17 with SMTP id n17so4921814faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4XpFTvmuY6fXyW8kqEeZy3C4mh9mP+PyRSJHlVDmfZw=;
        b=JZvYYUyAkGzP6QFZPgD34zoSiI/CxstrqQ52a5wwnTAAwNpmAnlbxKMeT+QFOSlk71
         9bcrlc4gctABqcmiAUsm9ymnnwmgivOEXcSr7oLqn/rg6HaDS37mZoMezdGhlwsBNW6M
         zO1zBMHNGrIgGaRx/DZCN/KYWOZbMQC+3olqE=
Received: by 10.223.76.27 with SMTP id a27mr22333665fak.12.1319995153064;
        Sun, 30 Oct 2011 10:19:13 -0700 (PDT)
Received: from localhost.localdomain (cpe-46-164-0-113.dynamic.amis.net. [46.164.0.113])
        by mx.google.com with ESMTPS id d21sm29627258fac.4.2011.10.30.10.19.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 30 Oct 2011 10:19:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <n>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184474>

"succeded" changed to "succeeded".

Reference Launchpad bug #879427.

modified:   git-gui/lib/sshkey.tcl

Signed-off-by: Dejan Ribi=C4=8D <dejan.ribic@gmail.com>
---
 git-gui/lib/sshkey.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/sshkey.tcl b/git-gui/lib/sshkey.tcl
index 5f75bc9..aa6457b 100644
--- a/git-gui/lib/sshkey.tcl
+++ b/git-gui/lib/sshkey.tcl
@@ -117,7 +117,7 @@ proc read_sshkey_output {fd w} {
 	} else {
 		set finfo [find_ssh_key]
 		if {$finfo eq {}} {
-			set sshkey_title [mc "Generation succeded, but no keys found."]
+			set sshkey_title [mc "Generation succeeded, but no keys found."]
 			$w.contents insert end $sshkey_output
 		} else {
 			set sshkey_title [mc "Your key is in: %s" [lindex $finfo 0]]
--=20
1.7.5.4
