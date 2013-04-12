From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/10] git-gui: fix spelling in comments
Date: Fri, 12 Apr 2013 00:10:18 -0700
Message-ID: <20130412071017.GJ5710@elie.Belkin>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
 <7v4nfch90r.fsf@alter.siamese.dyndns.org>
 <20130412064837.GA5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	sunshine@sunshineco.com, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 09:10:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQY7w-00019m-17
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 09:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab3DLHKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 03:10:24 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:52199 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab3DLHKX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 03:10:23 -0400
Received: by mail-pd0-f172.google.com with SMTP id 5so1264950pdd.31
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 00:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6IHDYZoMRmhbQW3V6w8oFcDwPs0Ig//sD2R33fFJwSE=;
        b=HHPNjA/9iFXFcvoDN3PBNZpDujipc3QOpuvW90bUp+9bNMBRhJ/DwGFSyWbi28rBRP
         IAJdAQiFZKSa6NoMTez8sdnQRoaMenaOlC5dNIi2OpF72d/ITAn/YiTy/wSt+TphOso4
         m0QpVt8OQtUbWyl7GQMWCbPJcbFWAWgZjvBeaLogrXKKgTtVfb2VkfawULBcHR4Mp4CN
         1jtPmAVng3gn1nfUuJ6SqPpW0XzZOa/JU0ZgLNLBzZ6EhlZ3tbrCw6uAS8acX3/G3o1J
         6vPkPQmXlbKnpcsJzTN+8cHlaNeVp3pesHGRf+FNNnbK4+F9VMYIuM0fFLs5PRtPllDx
         DL+g==
X-Received: by 10.66.122.8 with SMTP id lo8mr13744086pab.163.1365750622656;
        Fri, 12 Apr 2013 00:10:22 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id wi6sm7395637pbc.22.2013.04.12.00.10.20
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 00:10:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412064837.GA5710@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220967>

From: Stefano Lattarini <stefano.lattarini@gmail.com>
Date: Fri, 12 Apr 2013 00:36:10 +0200

Correct common spelling mistakes noticed by Lucas De Marchi's
codespell tool.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Split from a larger patch.  Could be applied with "patch -p2"
if it seems like a good change for git-gui.

 git-gui/lib/blame.tcl      | 2 +-
 git-gui/lib/index.tcl      | 2 +-
 git-gui/lib/spellcheck.tcl | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
index 324f7744..b1d15f46 100644
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
index 8efbbdde..74a81a7b 100644
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
index e6120303..538d61c7 100644
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
1.8.2.1
