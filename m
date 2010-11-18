From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 1/3] mergetool--lib: Sort tools alphabetically for easier
 lookup
Date: Thu, 18 Nov 2010 11:43:21 +0100
Message-ID: <4CE50349.50803@gmail.com>
References: <4CE50290.90600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Nov 18 11:43:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ1xt-0005mi-Qc
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 11:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab0KRKn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 05:43:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49118 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571Ab0KRKnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 05:43:25 -0500
Received: by eye27 with SMTP id 27so1823424eye.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 02:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=nhvFDRji/CNfB54IUv1o27HaCdxHH7SW+074wensFiE=;
        b=t6G86iyofq7JQkSadWga3hGJc4WHybtGcXuhaHLhldSnVxzAAUZHq1hL1mObUXZPvW
         oozi7XZwpV+FUa53yuK65X/6qt5zyoJjI3US9ttIkA+r48hqn4iAur+cF08Bds3EvDa8
         QL7NQHyjHGP5hZzFu3X0rFBng82yATnDSLXYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=f5xC+P6iFNHK+57r1kvQzyPEPGx5WAdoMBiIMBlyZv2K+MNnN7ilUXL4gJA4Ws15XB
         dzIuHnk+vG/T6+7/QfSAASouaIlWqcb3JpKpte4OVgsYta8gRJ/ZuYJVdF3R+4I8hxIR
         z9ZGA+rceyJZowCcdxBjQp/hcNbBp1VEKv8mc=
Received: by 10.213.8.77 with SMTP id g13mr3469318ebg.70.1290077003536;
        Thu, 18 Nov 2010 02:43:23 -0800 (PST)
Received: from [130.73.68.143] (berry.zib.de [130.73.68.143])
        by mx.google.com with ESMTPS id w20sm274182eeh.6.2010.11.18.02.43.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 02:43:22 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4CE50290.90600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161660>



Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-difftool.txt  |    4 +-
 Documentation/git-mergetool.txt |    4 +-
 Documentation/merge-config.txt  |    8 +-
 git-gui/lib/mergetool.tcl       |   94 ++++++++--------
 git-mergetool--lib.sh           |  234 +++++++++++++++++++-------------------
 5 files changed, 172 insertions(+), 172 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 8250bad..a54fbf1 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -30,8 +30,8 @@ OPTIONS
 --tool=<tool>::
 	Use the diff tool specified by <tool>.
 	Valid merge tools are:
-	kdiff3, kompare, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
-	ecmerge, diffuse, opendiff, p4merge and araxis.
+	araxis, diffuse, emerge, ecmerge, gvimdiff, kdiff3,
+	kompare, meld, opendiff, p4merge, tkdiff, vimdiff and xxdiff.
 +
 If a diff tool is not specified, 'git difftool'
 will use the configuration variable `diff.tool`.  If the
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 1f75a84..4987245 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -26,8 +26,8 @@ OPTIONS
 --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge,
-	diffuse, tortoisemerge, opendiff, p4merge and araxis.
+	araxis, diffuse, ecmerge, emerge, gvimdiff, kdiff3,
+	meld, opendiff, p4merge, tkdiff, tortoisemerge, vimdiff and xxdiff.
 +
 If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index b72f533..2c4ca09 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -31,10 +31,10 @@ merge.stat::
 
 merge.tool::
 	Controls which merge resolution program is used by
-	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
-	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
-	"diffuse", "ecmerge", "tortoisemerge", "p4merge", "araxis" and
-	"opendiff".  Any other value is treated is custom merge tool
+	linkgit:git-mergetool[1].  Valid built-in values are: "araxis",
+	"diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
+	"opendiff", "p4merge", "tkdiff", "tortoisemerge", "vimdiff"
+	and "xxdiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
 
 merge.verbosity::
diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index 3fe90e6..249e0cf 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -175,43 +175,49 @@ proc merge_resolve_tool2 {} {
 
 	# Build the command line
 	switch -- $tool {
-	kdiff3 {
+	araxis {
 		if {$base_stage ne {}} {
-			set cmdline [list "$merge_tool_path" --auto --L1 "$MERGED (Base)" \
-				--L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" -o "$MERGED" "$BASE" "$LOCAL" "$REMOTE"]
+			set cmdline [list "$merge_tool_path" -wait -merge -3 -a1 \
+				-title1:"'$MERGED (Base)'" -title2:"'$MERGED (Local)'" \
+				-title3:"'$MERGED (Remote)'" \
+				"$BASE" "$LOCAL" "$REMOTE" "$MERGED"]
 		} else {
-			set cmdline [list "$merge_tool_path" --auto --L1 "$MERGED (Local)" \
-				--L2 "$MERGED (Remote)" -o "$MERGED" "$LOCAL" "$REMOTE"]
+			set cmdline [list "$merge_tool_path" -wait -2 \
+				 -title1:"'$MERGED (Local)'" -title2:"'$MERGED (Remote)'" \
+				 "$LOCAL" "$REMOTE" "$MERGED"]
 		}
 	}
-	tkdiff {
+	ecmerge {
 		if {$base_stage ne {}} {
-			set cmdline [list "$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"]
+			set cmdline [list "$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --default --mode=merge3 --to="$MERGED"]
 		} else {
-			set cmdline [list "$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"]
+			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" --default --mode=merge2 --to="$MERGED"]
 		}
 	}
-	meld {
-		set cmdline [list "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"]
+	emerge {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" -f emerge-files-with-ancestor-command \
+					"$LOCAL" "$REMOTE" "$BASE" "$basename"]
+		} else {
+			set cmdline [list "$merge_tool_path" -f emerge-files-command \
+					"$LOCAL" "$REMOTE" "$basename"]
+		}
 	}
 	gvimdiff {
 		set cmdline [list "$merge_tool_path" -f "$LOCAL" "$MERGED" "$REMOTE"]
 	}
-	xxdiff {
+	kdiff3 {
 		if {$base_stage ne {}} {
-			set cmdline [list "$merge_tool_path" -X --show-merged-pane \
-					    -R {Accel.SaveAsMerged: "Ctrl-S"} \
-					    -R {Accel.Search: "Ctrl+F"} \
-					    -R {Accel.SearchForward: "Ctrl-G"} \
-					    --merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"]
+			set cmdline [list "$merge_tool_path" --auto --L1 "$MERGED (Base)" \
+				--L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" -o "$MERGED" "$BASE" "$LOCAL" "$REMOTE"]
 		} else {
-			set cmdline [list "$merge_tool_path" -X --show-merged-pane \
-					    -R {Accel.SaveAsMerged: "Ctrl-S"} \
-					    -R {Accel.Search: "Ctrl+F"} \
-					    -R {Accel.SearchForward: "Ctrl-G"} \
-					    --merged-file "$MERGED" "$LOCAL" "$REMOTE"]
+			set cmdline [list "$merge_tool_path" --auto --L1 "$MERGED (Local)" \
+				--L2 "$MERGED (Remote)" -o "$MERGED" "$LOCAL" "$REMOTE"]
 		}
 	}
+	meld {
+		set cmdline [list "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"]
+	}
 	opendiff {
 		if {$base_stage ne {}} {
 			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$MERGED"]
@@ -219,22 +225,20 @@ proc merge_resolve_tool2 {} {
 			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$MERGED"]
 		}
 	}
-	ecmerge {
-		if {$base_stage ne {}} {
-			set cmdline [list "$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --default --mode=merge3 --to="$MERGED"]
-		} else {
-			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" --default --mode=merge2 --to="$MERGED"]
-		}
+	p4merge {
+		set cmdline [list "$merge_tool_path" "$BASE" "$REMOTE" "$LOCAL" "$MERGED"]
 	}
-	emerge {
+	tkdiff {
 		if {$base_stage ne {}} {
-			set cmdline [list "$merge_tool_path" -f emerge-files-with-ancestor-command \
-					"$LOCAL" "$REMOTE" "$BASE" "$basename"]
+			set cmdline [list "$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"]
 		} else {
-			set cmdline [list "$merge_tool_path" -f emerge-files-command \
-					"$LOCAL" "$REMOTE" "$basename"]
+			set cmdline [list "$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"]
 		}
 	}
+	vimdiff {
+		error_popup [mc "Not a GUI merge tool: '%s'" $tool]
+		return
+	}
 	winmerge {
 		if {$base_stage ne {}} {
 			# This tool does not support 3-way merges.
@@ -245,25 +249,21 @@ proc merge_resolve_tool2 {} {
 				-dl "Theirs File" -dr "Mine File" "$REMOTE" "$LOCAL" "$MERGED"]
 		}
 	}
-	araxis {
+	xxdiff {
 		if {$base_stage ne {}} {
-			set cmdline [list "$merge_tool_path" -wait -merge -3 -a1 \
-				-title1:"'$MERGED (Base)'" -title2:"'$MERGED (Local)'" \
-				-title3:"'$MERGED (Remote)'" \
-				"$BASE" "$LOCAL" "$REMOTE" "$MERGED"]
+			set cmdline [list "$merge_tool_path" -X --show-merged-pane \
+					    -R {Accel.SaveAsMerged: "Ctrl-S"} \
+					    -R {Accel.Search: "Ctrl+F"} \
+					    -R {Accel.SearchForward: "Ctrl-G"} \
+					    --merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"]
 		} else {
-			set cmdline [list "$merge_tool_path" -wait -2 \
-				 -title1:"'$MERGED (Local)'" -title2:"'$MERGED (Remote)'" \
-				 "$LOCAL" "$REMOTE" "$MERGED"]
+			set cmdline [list "$merge_tool_path" -X --show-merged-pane \
+					    -R {Accel.SaveAsMerged: "Ctrl-S"} \
+					    -R {Accel.Search: "Ctrl+F"} \
+					    -R {Accel.SearchForward: "Ctrl-G"} \
+					    --merged-file "$MERGED" "$LOCAL" "$REMOTE"]
 		}
 	}
-	p4merge {
-		set cmdline [list "$merge_tool_path" "$BASE" "$REMOTE" "$LOCAL" "$MERGED"]
-	}
-	vimdiff {
-		error_popup [mc "Not a GUI merge tool: '%s'" $tool]
-		return
-	}
 	default {
 		error_popup [mc "Unsupported merge tool '%s'" $tool]
 		return
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index b5e1943..aebb070 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -10,17 +10,17 @@ merge_mode() {
 
 translate_merge_tool_path () {
 	case "$1" in
-	vimdiff)
-		echo vim
-		;;
-	gvimdiff)
-		echo gvim
+	araxis)
+		echo compare
 		;;
 	emerge)
 		echo emacs
 		;;
-	araxis)
-		echo compare
+	gvimdiff)
+		echo gvim
+		;;
+	vimdiff)
+		echo vim
 		;;
 	*)
 		echo "$1"
@@ -46,16 +46,16 @@ check_unchanged () {
 
 valid_tool () {
 	case "$1" in
-	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
-	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis | p4merge)
+	araxis | diffuse | ecmerge | emerge | gvimdiff | \
+	kdiff3 | meld | opendiff | p4merge | tkdiff | vimdiff | xxdiff)
 		;; # happy
-	tortoisemerge)
-		if ! merge_mode; then
+	kompare)
+		if ! diff_mode; then
 			return 1
 		fi
 		;;
-	kompare)
-		if ! diff_mode; then
+	tortoisemerge)
+		if ! merge_mode; then
 			return 1
 		fi
 		;;
@@ -88,95 +88,72 @@ run_merge_tool () {
 	status=0
 
 	case "$1" in
-	kdiff3)
+	araxis)
 		if merge_mode; then
+			touch "$BACKUP"
 			if $base_present; then
-				("$merge_tool_path" --auto \
-					--L1 "$MERGED (Base)" \
-					--L2 "$MERGED (Local)" \
-					--L3 "$MERGED (Remote)" \
-					-o "$MERGED" \
-					"$BASE" "$LOCAL" "$REMOTE" \
-				> /dev/null 2>&1)
+				"$merge_tool_path" -wait -merge -3 -a1 \
+					"$BASE" "$LOCAL" "$REMOTE" "$MERGED" \
+					>/dev/null 2>&1
 			else
-				("$merge_tool_path" --auto \
-					--L1 "$MERGED (Local)" \
-					--L2 "$MERGED (Remote)" \
-					-o "$MERGED" \
-					"$LOCAL" "$REMOTE" \
-				> /dev/null 2>&1)
+				"$merge_tool_path" -wait -2 \
+					"$LOCAL" "$REMOTE" "$MERGED" \
+					>/dev/null 2>&1
 			fi
-			status=$?
+			check_unchanged
 		else
-			("$merge_tool_path" --auto \
-				--L1 "$MERGED (A)" \
-				--L2 "$MERGED (B)" "$LOCAL" "$REMOTE" \
-			> /dev/null 2>&1)
+			"$merge_tool_path" -wait -2 "$LOCAL" "$REMOTE" \
+				>/dev/null 2>&1
 		fi
 		;;
-	kompare)
-		"$merge_tool_path" "$LOCAL" "$REMOTE"
-		;;
-	tkdiff)
+	diffuse)
 		if merge_mode; then
+			touch "$BACKUP"
 			if $base_present; then
-				"$merge_tool_path" -a "$BASE" \
-					-o "$MERGED" "$LOCAL" "$REMOTE"
+				"$merge_tool_path" \
+					"$LOCAL" "$MERGED" "$REMOTE" \
+					"$BASE" | cat
 			else
 				"$merge_tool_path" \
-					-o "$MERGED" "$LOCAL" "$REMOTE"
+					"$LOCAL" "$MERGED" "$REMOTE" | cat
 			fi
-			status=$?
+			check_unchanged
 		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE"
+			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
 		fi
 		;;
-	p4merge)
+	ecmerge)
 		if merge_mode; then
-		    touch "$BACKUP"
+			touch "$BACKUP"
 			if $base_present; then
-				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
+				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
+					--default --mode=merge3 --to="$MERGED"
 			else
-				"$merge_tool_path" "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
+				"$merge_tool_path" "$LOCAL" "$REMOTE" \
+					--default --mode=merge2 --to="$MERGED"
 			fi
 			check_unchanged
 		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE"
-		fi
-		;;
-	meld)
-		if merge_mode; then
-			touch "$BACKUP"
-			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
-			check_unchanged
-		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE"
+			"$merge_tool_path" --default --mode=diff2 \
+				"$LOCAL" "$REMOTE"
 		fi
 		;;
-	diffuse)
+	emerge)
 		if merge_mode; then
-			touch "$BACKUP"
 			if $base_present; then
 				"$merge_tool_path" \
-					"$LOCAL" "$MERGED" "$REMOTE" \
-					"$BASE" | cat
+					-f emerge-files-with-ancestor-command \
+					"$LOCAL" "$REMOTE" "$BASE" \
+					"$(basename "$MERGED")"
 			else
 				"$merge_tool_path" \
-					"$LOCAL" "$MERGED" "$REMOTE" | cat
+					-f emerge-files-command \
+					"$LOCAL" "$REMOTE" \
+					"$(basename "$MERGED")"
 			fi
-			check_unchanged
-		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
-		fi
-		;;
-	vimdiff)
-		if merge_mode; then
-			touch "$BACKUP"
-			"$merge_tool_path" -d -c "wincmd l" \
-				"$LOCAL" "$MERGED" "$REMOTE"
-			check_unchanged
+			status=$?
 		else
-			"$merge_tool_path" -d -c "wincmd l" \
+			"$merge_tool_path" -f emerge-files-command \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
@@ -191,30 +168,42 @@ run_merge_tool () {
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
-	xxdiff)
+	kdiff3)
 		if merge_mode; then
-			touch "$BACKUP"
 			if $base_present; then
-				"$merge_tool_path" -X --show-merged-pane \
-					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
-					-R 'Accel.Search: "Ctrl+F"' \
-					-R 'Accel.SearchForward: "Ctrl-G"' \
-					--merged-file "$MERGED" \
-					"$LOCAL" "$BASE" "$REMOTE"
+				("$merge_tool_path" --auto \
+					--L1 "$MERGED (Base)" \
+					--L2 "$MERGED (Local)" \
+					--L3 "$MERGED (Remote)" \
+					-o "$MERGED" \
+					"$BASE" "$LOCAL" "$REMOTE" \
+				> /dev/null 2>&1)
 			else
-				"$merge_tool_path" -X $extra \
-					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
-					-R 'Accel.Search: "Ctrl+F"' \
-					-R 'Accel.SearchForward: "Ctrl-G"' \
-					--merged-file "$MERGED" \
-					"$LOCAL" "$REMOTE"
+				("$merge_tool_path" --auto \
+					--L1 "$MERGED (Local)" \
+					--L2 "$MERGED (Remote)" \
+					-o "$MERGED" \
+					"$LOCAL" "$REMOTE" \
+				> /dev/null 2>&1)
 			fi
+			status=$?
+		else
+			("$merge_tool_path" --auto \
+				--L1 "$MERGED (A)" \
+				--L2 "$MERGED (B)" "$LOCAL" "$REMOTE" \
+			> /dev/null 2>&1)
+		fi
+		;;
+	kompare)
+		"$merge_tool_path" "$LOCAL" "$REMOTE"
+		;;
+	meld)
+		if merge_mode; then
+			touch "$BACKUP"
+			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
 			check_unchanged
 		else
-			"$merge_tool_path" \
-				-R 'Accel.Search: "Ctrl+F"' \
-				-R 'Accel.SearchForward: "Ctrl-G"' \
-				"$LOCAL" "$REMOTE"
+			"$merge_tool_path" "$LOCAL" "$REMOTE"
 		fi
 		;;
 	opendiff)
@@ -233,39 +222,31 @@ run_merge_tool () {
 			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
 		fi
 		;;
-	ecmerge)
+	p4merge)
 		if merge_mode; then
-			touch "$BACKUP"
+		    touch "$BACKUP"
 			if $base_present; then
-				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
-					--default --mode=merge3 --to="$MERGED"
+				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
 			else
-				"$merge_tool_path" "$LOCAL" "$REMOTE" \
-					--default --mode=merge2 --to="$MERGED"
+				"$merge_tool_path" "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
 			fi
 			check_unchanged
 		else
-			"$merge_tool_path" --default --mode=diff2 \
-				"$LOCAL" "$REMOTE"
+			"$merge_tool_path" "$LOCAL" "$REMOTE"
 		fi
 		;;
-	emerge)
+	tkdiff)
 		if merge_mode; then
 			if $base_present; then
-				"$merge_tool_path" \
-					-f emerge-files-with-ancestor-command \
-					"$LOCAL" "$REMOTE" "$BASE" \
-					"$(basename "$MERGED")"
+				"$merge_tool_path" -a "$BASE" \
+					-o "$MERGED" "$LOCAL" "$REMOTE"
 			else
 				"$merge_tool_path" \
-					-f emerge-files-command \
-					"$LOCAL" "$REMOTE" \
-					"$(basename "$MERGED")"
+					-o "$MERGED" "$LOCAL" "$REMOTE"
 			fi
 			status=$?
 		else
-			"$merge_tool_path" -f emerge-files-command \
-				"$LOCAL" "$REMOTE"
+			"$merge_tool_path" "$LOCAL" "$REMOTE"
 		fi
 		;;
 	tortoisemerge)
@@ -280,22 +261,41 @@ run_merge_tool () {
 			status=1
 		fi
 		;;
-	araxis)
+	vimdiff)
+		if merge_mode; then
+			touch "$BACKUP"
+			"$merge_tool_path" -d -c "wincmd l" \
+				"$LOCAL" "$MERGED" "$REMOTE"
+			check_unchanged
+		else
+			"$merge_tool_path" -d -c "wincmd l" \
+				"$LOCAL" "$REMOTE"
+		fi
+		;;
+	xxdiff)
 		if merge_mode; then
 			touch "$BACKUP"
 			if $base_present; then
-				"$merge_tool_path" -wait -merge -3 -a1 \
-					"$BASE" "$LOCAL" "$REMOTE" "$MERGED" \
-					>/dev/null 2>&1
+				"$merge_tool_path" -X --show-merged-pane \
+					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+					-R 'Accel.Search: "Ctrl+F"' \
+					-R 'Accel.SearchForward: "Ctrl-G"' \
+					--merged-file "$MERGED" \
+					"$LOCAL" "$BASE" "$REMOTE"
 			else
-				"$merge_tool_path" -wait -2 \
-					"$LOCAL" "$REMOTE" "$MERGED" \
-					>/dev/null 2>&1
+				"$merge_tool_path" -X $extra \
+					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+					-R 'Accel.Search: "Ctrl+F"' \
+					-R 'Accel.SearchForward: "Ctrl-G"' \
+					--merged-file "$MERGED" \
+					"$LOCAL" "$REMOTE"
 			fi
 			check_unchanged
 		else
-			"$merge_tool_path" -wait -2 "$LOCAL" "$REMOTE" \
-				>/dev/null 2>&1
+			"$merge_tool_path" \
+				-R 'Accel.Search: "Ctrl+F"' \
+				-R 'Accel.SearchForward: "Ctrl-G"' \
+				"$LOCAL" "$REMOTE"
 		fi
 		;;
 	*)
-- 
1.7.3.2.msysgit.11
