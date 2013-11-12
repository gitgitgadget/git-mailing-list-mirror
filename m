From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] [trivial] Fix typo in git-gui
Date: Tue, 12 Nov 2013 09:36:27 -0800
Message-ID: <xmqqa9h9iktg.fsf@gitster.dls.corp.google.com>
References: <1384269465-23352-1-git-send-email-standby24x7@gmail.com>
	<1384269465-23352-3-git-send-email-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Masanari Iida <standby24x7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 18:36:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgHtE-0005Gk-IT
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 18:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab3KLRgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 12:36:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34936 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754288Ab3KLRgb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 12:36:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EE4450C71;
	Tue, 12 Nov 2013 12:36:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=b8z56Oqw1ASBze9UsVvONzfrQyY=; b=novOmx16fP2KWVe9VzC4
	HJIEA3ro/wgCfvqDKi1DTZCNPfj8XThZIg4iE2yKgQ/stQSVl+uiVBUBmYuehPCx
	Hz9zMnnyUqHta+EF/LzyrrCH5IZHu2YB8d35uK9hIseWPRiThtxPicZE4bv1R4jV
	x2aVTalUEJSqd280cuZzFR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Yy3yFX04FrN7KWcRvVh96i4Dyl7+SkPdW/BoIqaSV+CGLM
	8ZG100TldYA6kn+Xe15YlJQ6S2AWyZrFEYsWfyZ5LrBFbKvU6dVR18ahcpcFX95Y
	Mh103eMe3ztNW+LYP0+lODZXh+WBKOOYMKUun2rCmLJqGHlpXZNfp7Y4naiYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E5A550C70;
	Tue, 12 Nov 2013 12:36:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A468B50C6F;
	Tue, 12 Nov 2013 12:36:29 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F6C00188-4BC0-11E3-81EA-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237721>

Masanari Iida <standby24x7@gmail.com> writes:

> Correct spelling typo in git-gui

The text after the change looks OK, but I shouldn't be taking
patches to git-gui part of the tree bypassing Pat, so...

-- >8 --
From: Masanari Iida <standby24x7@gmail.com>
Date: Wed, 13 Nov 2013 00:17:44 +0900
Subject: [PATCH 3/4] git-gui: typofixes

Correct spelling typo in git-gui.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Makefile           | 2 +-
 lib/blame.tcl      | 2 +-
 lib/index.tcl      | 2 +-
 lib/spellcheck.tcl | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index e9c2bc3..cde8b2e 100644
--- a/Makefile
+++ b/Makefile
@@ -4,7 +4,7 @@ all::
 #
 # Define NO_MSGFMT if you do not have msgfmt from the GNU gettext
 # package and want to use our rough pure Tcl po->msg translator.
-# TCL_PATH must be vaild for this to work.
+# TCL_PATH must be valid for this to work.
 #
 
 GIT-VERSION-FILE: FORCE
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 324f774..b1d15f4 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -5,7 +5,7 @@ class blame {
 
 image create photo ::blame::img_back_arrow -data {R0lGODlhGAAYAIUAAPwCBEzKXFTSZIz+nGzmhGzqfGTidIT+nEzGXHTqhGzmfGzifFzadETCVES+VARWDFzWbHzyjAReDGTadFTOZDSyRDyyTCymPARaFGTedFzSbDy2TCyqRCyqPARaDAyCHES6VDy6VCyiPAR6HCSeNByWLARyFARiDARqFGTifARiFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAYABgAAAajQIBwSCwaj8ikcsk0BppJwRPqHEypQwHBis0WDAdEFyBIKBaMAKLBdjQeSkFBYTBAIvgEoS6JmhUTEwIUDQ4VFhcMGEhyCgoZExoUaxsWHB0THkgfAXUGAhoBDSAVFR0XBnCbDRmgog0hpSIiDJpJIyEQhBUcJCIlwA22SSYVogknEg8eD82qSigdDSknY0IqJQXPYxIl1dZCGNvWw+Dm510GQQAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7}
 
-# Persistant data (survives loads)
+# Persistent data (survives loads)
 #
 field history {}; # viewer history: {commit path}
 field header    ; # array commit,key -> header field
diff --git a/lib/index.tcl b/lib/index.tcl
index 8efbbdd..74a81a7 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -414,7 +414,7 @@ proc revert_helper {txt paths} {
 	# such distinction is needed in some languages. Previously, the
 	# code used "Revert changes in" for both, but that can't work
 	# in languages where 'in' must be combined with word from
-	# rest of string (in diffrent way for both cases of course).
+	# rest of string (in different way for both cases of course).
 	#
 	# FIXME: Unfortunately, even that isn't enough in some languages
 	# as they have quite complex plural-form rules. Unfortunately,
diff --git a/lib/spellcheck.tcl b/lib/spellcheck.tcl
index e612030..538d61c 100644
--- a/lib/spellcheck.tcl
+++ b/lib/spellcheck.tcl
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
