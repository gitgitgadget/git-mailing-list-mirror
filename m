From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH 3/4] [trivial] Fix typo in git-gui
Date: Wed, 13 Nov 2013 00:17:44 +0900
Message-ID: <1384269465-23352-3-git-send-email-standby24x7@gmail.com>
References: <1384269465-23352-1-git-send-email-standby24x7@gmail.com>
Cc: Masanari Iida <standby24x7@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 16:19:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgFke-0003pO-VV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 16:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab3KLPS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 10:18:59 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:61700 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab3KLPSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 10:18:16 -0500
Received: by mail-pa0-f54.google.com with SMTP id lj1so3671126pab.41
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 07:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RMF7ACFUVV0lVXTvHgSONO7WocwxGl+YBH1IAfqrVSk=;
        b=rMWFEd9Iy+UIMlfKxciHAbsLqskYIYghJBbrCxPzWpkWEWlinhevm5QMX3KgKgvU4m
         veYLs0t/dl7ljOeGLGed/8NHfxP6u2XyERrF+cjHe1TzkpbYXydfm5deNUS7jl0DekTs
         OHipevngoCt4vpXxGQr1jxpXwyN/Y6DKRq1uFrRizPCW+OiWzo+Vvfq6j3y6/ZlHnoZT
         eTg6oAJTCwLiV92TrfZmJq39TjXsmBY2Ds0038NBuAEja7j5Y/xSDgV1CnFTprE12uRr
         avhd0qXEtPO1cKUPNCCC9oxPoDjNTCaVIEJ0teB9KfCfXTFrExJUOiJ3Oyax5EVHm3DV
         Hdng==
X-Received: by 10.68.244.168 with SMTP id xh8mr35723347pbc.3.1384269495531;
        Tue, 12 Nov 2013 07:18:15 -0800 (PST)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by mx.google.com with ESMTPSA id yg3sm44600459pab.16.2013.11.12.07.18.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 07:18:13 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
	id DF63B64946; Wed, 13 Nov 2013 00:18:09 +0900 (JST)
X-Mailer: git-send-email 1.8.5.rc1.17.g0ecd94d
In-Reply-To: <1384269465-23352-1-git-send-email-standby24x7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237716>

Correct spelling typo in git-gui

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 git-gui/Makefile           | 2 +-
 git-gui/lib/blame.tcl      | 2 +-
 git-gui/lib/index.tcl      | 2 +-
 git-gui/lib/spellcheck.tcl | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index e9c2bc3..cde8b2e 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -4,7 +4,7 @@ all::
 #
 # Define NO_MSGFMT if you do not have msgfmt from the GNU gettext
 # package and want to use our rough pure Tcl po->msg translator.
-# TCL_PATH must be vaild for this to work.
+# TCL_PATH must be valid for this to work.
 #
 
 GIT-VERSION-FILE: FORCE
diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
index 324f774..b1d15f4 100644
--- a/git-gui/lib/blame.tcl
+++ b/git-gui/lib/blame.tcl
@@ -5,7 +5,7 @@ class blame {
 
 image create photo ::blame::img_back_arrow -data {R0lGODlhGAAYAIUAAPwCBEzKXFTSZIz+nGzmhGzqfGTidIT+nEzGXHTqhGzmfGzifFzadETCVES+VARWDFzWbHzyjAReDGTadFTOZDSyRDyyTCymPARaFGTedFzSbDy2TCyqRCyqPARaDAyCHES6VDy6VCyiPAR6HCSeNByWLARyFARiDARqFGTifARiFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAYABgAAAajQIBwSCwaj8ikcsk0BppJwRPqHEypQwHBis0WDAdEFyBIKBaMAKLBdjQeSkFBYTBAIvgEoS6JmhUTEwIUDQ4VFhcMGEhyCgoZExoUaxsWHB0THkgfAXUGAhoBDSAVFR0XBnCbDRmgog0hpSIiDJpJIyEQhBUcJCIlwA22SSYVogknEg8eD82qSigdDSknY0IqJQXPYxIl1dZCGNvWw+Dm510GQQAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7}
 
-# Persistant data (survives loads)
+# Persistent data (survives loads)
 #
 field history {}; # viewer history: {commit path}
 field header    ; # array commit,key -> header field
diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
index 8efbbdd..74a81a7 100644
--- a/git-gui/lib/index.tcl
+++ b/git-gui/lib/index.tcl
@@ -414,7 +414,7 @@ proc revert_helper {txt paths} {
 	# such distinction is needed in some languages. Previously, the
 	# code used "Revert changes in" for both, but that can't work
 	# in languages where 'in' must be combined with word from
-	# rest of string (in diffrent way for both cases of course).
+	# rest of string (in different way for both cases of course).
 	#
 	# FIXME: Unfortunately, even that isn't enough in some languages
 	# as they have quite complex plural-form rules. Unfortunately,
diff --git a/git-gui/lib/spellcheck.tcl b/git-gui/lib/spellcheck.tcl
index e612030..538d61c 100644
--- a/git-gui/lib/spellcheck.tcl
+++ b/git-gui/lib/spellcheck.tcl
@@ -14,7 +14,7 @@ field w_menu      ; # context menu for the widget
 field s_menuidx 0 ; # last index of insertion into $w_menu
 
 field s_i           {} ; # timer registration for _run callbacks
-field s_clear        0 ; # did we erase mispelled tags yet?
+field s_clear        0 ; # did we erase misspelled tags yet?
 field s_seen    [list] ; # lines last seen from $w_text in _run
 field s_checked [list] ; # lines already checked
 field s_pending [list] ; # [$line $data] sent to ispell/aspell
@@ -259,7 +259,7 @@ method _run {} {
 		if {$n == $cur_line
 		 && ![regexp {^\W$} [$w_text get $cur_pos insert]]} {
 
-			# If the current word is mispelled remove the tag
+			# If the current word is misspelled remove the tag
 			# but force a spellcheck later.
 			#
 			set tags [$w_text tag names $cur_pos]
-- 
1.8.5.rc1.17.g0ecd94d
