From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 1/2 v2] mergetool--lib: Sort tools alphabetically for easier
 lookup
Date: Sun, 27 Feb 2011 12:31:37 +0100
Message-ID: <4D6A3619.7040006@gmail.com>
References: <4D6A355C.3000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Packham <judge.packham@gmail.com>, charles@hashpling.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Feb 27 12:31:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pteqw-0007nX-HF
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 12:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094Ab1B0Lbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 06:31:50 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36289 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab1B0Lbs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 06:31:48 -0500
Received: by fxm17 with SMTP id 17so2956650fxm.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 03:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=FlTeblSOEc9Fa3V9k/ZW/FpSmL4ZkALQtpOFz/2bNEQ=;
        b=tKwgxc5v2WUdCuyyiRILlG8hZcBXja8Vmv7H06aRQvkIC11MFTrCHy28xB4QV5Qi9I
         RV2mbQJnlrW559CsnYATmRms8yeqEwpF5noKtOmSYkLviOCpDNskh/oEoMwWPBIw1N+H
         vLGyZJmg0mT+WRFTDTVBxq5hQKFvMngqH+zlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=A9OpheS9wY/wmGtocp4zPwVyZ2PHFjzZr0XhlstkH+qAXPKJIQjV8BjovJ3O1TLgi8
         RmVaQmQmkLFVoLHZ/dTkH+d2yJm1fV5YcO2CqU9q6y8pTi1fqFIWp39py8te+SaiLjnw
         kor134Clohoo4wdTGw0GrDjv6NW1n0a4wtcJE=
Received: by 10.223.16.75 with SMTP id n11mr398167faa.8.1298806307213;
        Sun, 27 Feb 2011 03:31:47 -0800 (PST)
Received: from [192.168.178.23] (p5DDB0164.dip0.t-ipconnect.de [93.219.1.100])
        by mx.google.com with ESMTPS id n1sm1053842fam.40.2011.02.27.03.31.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 03:31:46 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4D6A355C.3000805@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168027>

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-difftool.txt  |    4 +-
 Documentation/git-mergetool.txt |    4 +-
 Documentation/merge-config.txt  |    8 +-
 git-gui/lib/mergetool.tcl       |   94 ++++++++--------
 git-mergetool--lib.sh           |  245 +++++++++++++++++++--------------------
 5 files changed, 177 insertions(+), 178 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index db87f1d..4c8825d 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -31,8 +31,8 @@ OPTIONS
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
index 1e5c22c..90587db 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -33,10 +33,10 @@ merge.stat::
 
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
index 77d4aee..9fb82e5 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -10,17 +10,17 @@ merge_mode() {
 
 translate_merge_tool_path () {
 	case "$1" in
-	vimdiff|vimdiff2)
-		echo vim
-		;;
-	gvimdiff|gvimdiff2)
-		echo gvim
+	araxis)
+		echo compare
 		;;
 	emerge)
 		echo emacs
 		;;
-	araxis)
-		echo compare
+	gvimdiff|gvimdiff2)
+		echo gvim
+		;;
+	vimdiff|vimdiff2)
+		echo vim
 		;;
 	*)
 		echo "$1"
@@ -46,17 +46,16 @@ check_unchanged () {
 
 valid_tool () {
 	case "$1" in
-	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
-	vimdiff | gvimdiff | vimdiff2 | gvimdiff2 | \
-	emerge | ecmerge | diffuse | araxis | p4merge)
+	araxis | diffuse | ecmerge | emerge | gvimdiff | gvimdiff2 | \
+	kdiff3 | meld | opendiff | p4merge | tkdiff | vimdiff | vimdiff2 | xxdiff)
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
@@ -89,69 +88,22 @@ run_merge_tool () {
 	status=0
 
 	case "$1" in
-	kdiff3)
-		if merge_mode; then
-			if $base_present; then
-				("$merge_tool_path" --auto \
-					--L1 "$MERGED (Base)" \
-					--L2 "$MERGED (Local)" \
-					--L3 "$MERGED (Remote)" \
-					-o "$MERGED" \
-					"$BASE" "$LOCAL" "$REMOTE" \
-				> /dev/null 2>&1)
-			else
-				("$merge_tool_path" --auto \
-					--L1 "$MERGED (Local)" \
-					--L2 "$MERGED (Remote)" \
-					-o "$MERGED" \
-					"$LOCAL" "$REMOTE" \
-				> /dev/null 2>&1)
-			fi
-			status=$?
-		else
-			("$merge_tool_path" --auto \
-				--L1 "$MERGED (A)" \
-				--L2 "$MERGED (B)" "$LOCAL" "$REMOTE" \
-			> /dev/null 2>&1)
-		fi
-		;;
-	kompare)
-		"$merge_tool_path" "$LOCAL" "$REMOTE"
-		;;
-	tkdiff)
-		if merge_mode; then
-			if $base_present; then
-				"$merge_tool_path" -a "$BASE" \
-					-o "$MERGED" "$LOCAL" "$REMOTE"
-			else
-				"$merge_tool_path" \
-					-o "$MERGED" "$LOCAL" "$REMOTE"
-			fi
-			status=$?
-		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE"
-		fi
-		;;
-	p4merge)
+	araxis)
 		if merge_mode; then
-		    touch "$BACKUP"
+			touch "$BACKUP"
 			if $base_present; then
-				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
+				"$merge_tool_path" -wait -merge -3 -a1 \
+					"$BASE" "$LOCAL" "$REMOTE" "$MERGED" \
+					>/dev/null 2>&1
 			else
-				"$merge_tool_path" "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
+				"$merge_tool_path" -wait -2 \
+					"$LOCAL" "$REMOTE" "$MERGED" \
+					>/dev/null 2>&1
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
+			"$merge_tool_path" -wait -2 "$LOCAL" "$REMOTE" \
+				>/dev/null 2>&1
 		fi
 		;;
 	diffuse)
@@ -170,23 +122,58 @@ run_merge_tool () {
 			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
 		fi
 		;;
-	vimdiff|gvimdiff)
+	ecmerge)
 		if merge_mode; then
 			touch "$BACKUP"
 			if $base_present; then
-				"$merge_tool_path" -f -d -c "wincmd J" \
-					"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
+				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
+					--default --mode=merge3 --to="$MERGED"
 			else
-				"$merge_tool_path" -f -d -c "wincmd l" \
-					"$LOCAL" "$MERGED" "$REMOTE"
+				"$merge_tool_path" "$LOCAL" "$REMOTE" \
+					--default --mode=merge2 --to="$MERGED"
 			fi
 			check_unchanged
 		else
-			"$merge_tool_path" -f -d -c "wincmd l" \
+			"$merge_tool_path" --default --mode=diff2 \
 				"$LOCAL" "$REMOTE"
 		fi
 		;;
-	vimdiff2|gvimdiff2)
+	emerge)
+		if merge_mode; then
+			if $base_present; then
+				"$merge_tool_path" \
+					-f emerge-files-with-ancestor-command \
+					"$LOCAL" "$REMOTE" "$BASE" \
+					"$(basename "$MERGED")"
+			else
+				"$merge_tool_path" \
+					-f emerge-files-command \
+					"$LOCAL" "$REMOTE" \
+					"$(basename "$MERGED")"
+			fi
+			status=$?
+		else
+			"$merge_tool_path" -f emerge-files-command \
+				"$LOCAL" "$REMOTE"
+		fi
+		;;
+	gvimdiff|vimdiff)
+		if merge_mode; then
+			touch "$BACKUP"
+			if $base_present; then
+				"$merge_tool_path" -f -d -c "wincmd J" \
+					"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
+			else
+				"$merge_tool_path" -f -d -c "wincmd l" \
+					"$LOCAL" "$MERGED" "$REMOTE"
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" -f -d -c "wincmd l" \
+				"$LOCAL" "$REMOTE"
+		fi
+		;;
+	gvimdiff2|vimdiff2)
 		if merge_mode; then
 			touch "$BACKUP"
 			"$merge_tool_path" -f -d -c "wincmd l" \
@@ -197,30 +184,42 @@ run_merge_tool () {
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
@@ -239,39 +238,31 @@ run_merge_tool () {
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
@@ -286,22 +277,30 @@ run_merge_tool () {
 			status=1
 		fi
 		;;
-	araxis)
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
1.7.3.2.msysgit.6.dirty
