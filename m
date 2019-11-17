Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D45A1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 06:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfKQG4U (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 01:56:20 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38324 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfKQG4U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 01:56:20 -0500
Received: by mail-wr1-f48.google.com with SMTP id i12so15755448wro.5
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 22:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mBQFSdHKogX65G1eXA/tLAgiSNNej+r31jFj4khZl2I=;
        b=mtct8Xd833FP8itQ7+VTjSwwrvwi1z+EaduRsNaIRlUsl4r+pvxQy+bQ0LlDfvSpbP
         2sdnBb8rcwmdpdHyxbrY7DiOJfa5JYsCExr7lD9aaYhx6YAIcM/Zt/l+ziQOAmk1A926
         ws91QT6oTAyCw19PeMbQ16TucfT3ABKjv637Un3B5xaizq9a+vpE9//Y3hmmbiXkRtpK
         C+kMoZ/MNteCtpHotoZs54G4+YpqsXn769qq/PwspROaQGnz0j0K5id1lTdK42WMkinS
         8EnKtvUfmIA2LQsNhE4fIrnPKczcZ6UfyCokaqQmQ30CyHHZD/3QJWXdo/XwRrNoXjVQ
         G0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mBQFSdHKogX65G1eXA/tLAgiSNNej+r31jFj4khZl2I=;
        b=cKSBNOaV0ppmj5dAZWvPpyCZP3kbdORze1C0d63bWF/Xwk8wA+6JzYvgv5qsQGKKlR
         8t2ognlStDjJseLceYioorXuqng7wV45HobNm0PpdZwrOA/UBomDsrxNpR31wBAt9iS4
         jEGa514ca3HjcWVec30YEfuzNpWWwoqPMIp+2YVM5VGvAT/oXUqVn5CY9nziI/IQ8hLa
         0MVXzDG6CRSDkZATlYy2idrlZ4KlGcktVlq2RjDUERNjLdQLcyqGMEe9oXHiuySUJydF
         3cVEDUaMzaYLkAGKotLf+k8K3NNPWVrTE8JjLv/ameN8rYIZzqdEhgZ8TC/IegSZTHJ8
         20uw==
X-Gm-Message-State: APjAAAU8R111rrtHjD/h1JOoTM0vBuIO6O5ytqPb0w0Pgo/gEbYfTctw
        6tH4SZEmd2zwqvFuA8DPAzCST4O2
X-Google-Smtp-Source: APXvYqzm2NqRKeH2RkWy8raqeOI+XRG5pAEdaK25sRUYcmAVYJiw0kFeESAZffPyn+Ge6FaDivZ7hg==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr9741747wrm.4.1573973773895;
        Sat, 16 Nov 2019 22:56:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm18054286wrm.7.2019.11.16.22.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2019 22:56:13 -0800 (PST)
Message-Id: <23d4f5d829cb705441394186d274620b46bae8fb.1573973770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
References: <pull.436.v3.git.1573638988.gitgitgadget@gmail.com>
        <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 06:56:10 +0000
Subject: [PATCH v4 2/2] git-gui: revert untracked files by deleting them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Gilbert <JonathanG@iQmetrix.com>

Update the revert_helper proc to check for untracked files as well as
changes, and then handle changes to be reverted and untracked files with
independent blocks of code. Prompt the user independently for untracked
files, since the underlying action is fundamentally different (rm -f).
If after deleting untracked files, the directory containing them becomes
empty, then remove the directory as well. Migrate unlocking of the index
out of _close_updateindex to a responsibility of the caller, to permit
paths that don't directly unlock the index, and refactor the error
handling added in d4e890e5 so that callers can make flow control
decisions in the event of errors. Rework status_bar to explicitly handle
multiple overlapping operations, and update all call sites.

A new proc delete_files takes care of actually deleting the files in
batches, using the Tcler's Wiki recommended approach for keeping the UI
responsive.

Since the checkout_index and delete_files calls are both asynchronous
and could potentially complete in any order, a "chord" is used to
coordinate unlocking the index and returning the UI to a usable state
only after both operations are complete. The `SimpleChord` class,
based on TclOO (Tcl/Tk 8.6), is added in this commit.

Since the checkout_index and delete_files calls are both asynchronous
and overlap, they clash in wanting to update the status bar. This commit
reworks the status bar so that when an operation wants to display
ongoing updates/progress, it explicitly starts an "operation", which is
tracked by its own object, and the status bar handles multiple
concurrent operations by merging their progress and concatenating their
text.

Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
---
 git-gui.sh          |   7 +-
 lib/checkout_op.tcl |  15 +-
 lib/chord.tcl       | 160 ++++++++++++++++
 lib/index.tcl       | 443 +++++++++++++++++++++++++++++++++++---------
 lib/merge.tcl       |  14 +-
 lib/status_bar.tcl  | 221 +++++++++++++++++++---
 6 files changed, 734 insertions(+), 126 deletions(-)
 create mode 100644 lib/chord.tcl

diff --git a/git-gui.sh b/git-gui.sh
index 0d21f5688b..dc4ac577ac 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -30,8 +30,8 @@ along with this program; if not, see <http://www.gnu.org/licenses/>.}]
 ##
 ## Tcl/Tk sanity check
 
-if {[catch {package require Tcl 8.4} err]
- || [catch {package require Tk  8.4} err]
+if {[catch {package require Tcl 8.6} err]
+ || [catch {package require Tk  8.6} err]
 } {
 	catch {wm withdraw .}
 	tk_messageBox \
@@ -4159,6 +4159,9 @@ if {$picked && [is_config_true gui.autoexplore]} {
 	do_explore
 }
 
+# Clear "Initializing..." status
+after idle {after 500 {$main_status show ""}}
+
 # Local variables:
 # mode: tcl
 # indent-tabs-mode: t
diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
index a5228297db..21ea768d80 100644
--- a/lib/checkout_op.tcl
+++ b/lib/checkout_op.tcl
@@ -341,9 +341,9 @@ method _readtree {} {
 	global HEAD
 
 	set readtree_d {}
-	$::main_status start \
+	set status_bar_operation [$::main_status start \
 		[mc "Updating working directory to '%s'..." [_name $this]] \
-		[mc "files checked out"]
+		[mc "files checked out"]]
 
 	set fd [git_read --stderr read-tree \
 		-m \
@@ -354,26 +354,27 @@ method _readtree {} {
 		$new_hash \
 		]
 	fconfigure $fd -blocking 0 -translation binary
-	fileevent $fd readable [cb _readtree_wait $fd]
+	fileevent $fd readable [cb _readtree_wait $fd $status_bar_operation]
 }
 
-method _readtree_wait {fd} {
+method _readtree_wait {fd status_bar_operation} {
 	global current_branch
 
 	set buf [read $fd]
-	$::main_status update_meter $buf
+	$status_bar_operation update_meter $buf
 	append readtree_d $buf
 
 	fconfigure $fd -blocking 1
 	if {![eof $fd]} {
 		fconfigure $fd -blocking 0
+		$status_bar_operation stop
 		return
 	}
 
 	if {[catch {close $fd}]} {
 		set err $readtree_d
 		regsub {^fatal: } $err {} err
-		$::main_status stop [mc "Aborted checkout of '%s' (file level merging is required)." [_name $this]]
+		$status_bar_operation stop [mc "Aborted checkout of '%s' (file level merging is required)." [_name $this]]
 		warn_popup [strcat [mc "File level merge required."] "
 
 $err
@@ -384,7 +385,7 @@ $err
 		return
 	}
 
-	$::main_status stop
+	$status_bar_operation stop
 	_after_readtree $this
 }
 
diff --git a/lib/chord.tcl b/lib/chord.tcl
new file mode 100644
index 0000000000..275a6cd4a1
--- /dev/null
+++ b/lib/chord.tcl
@@ -0,0 +1,160 @@
+# Simple Chord for Tcl
+#
+# A "chord" is a method with more than one entrypoint and only one body, such
+# that the body runs only once all the entrypoints have been called by
+# different asynchronous tasks. In this implementation, the chord is defined
+# dynamically for each invocation. A SimpleChord object is created, supplying
+# body script to be run when the chord is completed, and then one or more notes
+# are added to the chord. Each note can be called like a proc, and returns
+# immediately if the chord isn't yet complete. When the last remaining note is
+# called, the body runs before the note returns.
+#
+# The SimpleChord class has a constructor that takes the body script, and a
+# method add_note that returns a note object. Since the body script does not
+# run in the context of the procedure that defined it, a mechanism is provided
+# for injecting variables into the chord for use by the body script. The
+# activation of a note is idempotent; multiple calls have the same effect as
+# a simple call.
+#
+# If you are invoking asynchronous operations with chord notes as completion
+# callbacks, and there is a possibility that earlier operations could complete
+# before later ones are started, it is a good practice to create a "common"
+# note on the chord that prevents it from being complete until you're certain
+# you've added all the notes you need.
+#
+# Example:
+#
+#   # Turn off the UI while running a couple of async operations.
+#   lock_ui
+#
+#   set chord [SimpleChord new {
+#     unlock_ui
+#     # Note: $notice here is not referenced in the calling scope
+#     if {$notice} { info_popup $notice }
+#   }
+#
+#   # Configure a note to keep the chord from completing until
+#   # all operations have been initiated.
+#   set common_note [$chord add_note]
+#
+#   # Pass notes as 'after' callbacks to other operations
+#   async_operation $args [$chord add_note]
+#   other_async_operation $args [$chord add_note]
+#
+#   # Communicate with the chord body
+#   if {$condition} {
+#     # This sets $notice in the same context that the chord body runs in.
+#     $chord eval { set notice "Something interesting" }
+#   }
+#
+#   # Activate the common note, making the chord eligible to complete
+#   $common_note
+#
+# At this point, the chord will complete at some unknown point in the future.
+# The common note might have been the first note activated, or the async
+# operations might have completed synchronously and the common note is the
+# last one, completing the chord before this code finishes, or anything in
+# between. The purpose of the chord is to not have to worry about the order.
+
+# SimpleChord class:
+#   Represents a procedure that conceptually has multiple entrypoints that must
+#   all be called before the procedure executes. Each entrypoint is called a
+#   "note". The chord is only "completed" when all the notes are "activated".
+oo::class create SimpleChord {
+	variable notes body is_completed
+
+	# Constructor:
+	#   set chord [SimpleChord new {body}]
+	#     Creates a new chord object with the specified body script. The
+	#     body script is evaluated at most once, when a note is activated
+	#     and the chord has no other non-activated notes.
+	constructor {body} {
+		set notes [list]
+		my eval [list set body $body]
+		set is_completed 0
+	}
+
+	# Method:
+	#   $chord eval {script}
+	#     Runs the specified script in the same context (namespace) in which
+	#     the chord body will be evaluated. This can be used to set variable
+	#     values for the chord body to use.
+	method eval {script} {
+		namespace eval [self] $script
+	}
+
+	# Method:
+	#   set note [$chord add_note]
+	#     Adds a new note to the chord, an instance of ChordNote. Raises an
+	#     error if the chord is already completed, otherwise the chord is
+	#     updated so that the new note must also be activated before the
+	#     body is evaluated.
+	method add_note {} {
+		if {$is_completed} { error "Cannot add a note to a completed chord" }
+
+		set note [ChordNote new [self]]
+
+		lappend notes $note
+
+		return $note
+	}
+
+	# This method is for internal use only and is intentionally undocumented.
+	method notify_note_activation {} {
+		if {!$is_completed} {
+			foreach note $notes {
+				if {![$note is_activated]} { return }
+			}
+
+			set is_completed 1
+
+			namespace eval [self] $body
+			namespace delete [self]
+		}
+	}
+}
+
+# ChordNote class:
+#   Represents a note within a chord, providing a way to activate it. When the
+#   final note of the chord is activated (this can be any note in the chord,
+#   with all other notes already previously activated in any order), the chord's
+#   body is evaluated.
+oo::class create ChordNote {
+	variable chord is_activated
+
+	# Constructor:
+	#   Instances of ChordNote are created internally by calling add_note on
+	#   SimpleChord objects.
+	constructor {chord} {
+		my eval set chord $chord
+		set is_activated 0
+	}
+
+	# Method:
+	#   [$note is_activated]
+	#     Returns true if this note has already been activated.
+	method is_activated {} {
+		return $is_activated
+	}
+
+	# Method:
+	#   $note
+	#     Activates the note, if it has not already been activated, and
+	#     completes the chord if there are no other notes awaiting
+	#     activation. Subsequent calls will have no further effect.
+	#
+	# NB: In TclOO, if an object is invoked like a method without supplying
+	#     any method name, then this internal method `unknown` is what
+	#     actually runs (with no parameters). It is used in the ChordNote
+	#     class for the purpose of allowing the note object to be called as
+	#     a function (see example above). (The `unknown` method can also be
+	#     used to support dynamic dispatch, but must take parameters to
+	#     identify the "unknown" method to be invoked. In this form, this
+	#     proc serves only to make instances behave directly like methods.)
+	method unknown {} {
+		if {!$is_activated} {
+			set is_activated 1
+			$chord notify_note_activation
+		}
+	}
+}
diff --git a/lib/index.tcl b/lib/index.tcl
index 28d4d2a54e..8d7590241e 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -7,53 +7,63 @@ proc _delete_indexlock {} {
 	}
 }
 
-proc _close_updateindex {fd after} {
-	global use_ttk NS
-	fconfigure $fd -blocking 1
-	if {[catch {close $fd} err]} {
-		set w .indexfried
-		Dialog $w
-		wm withdraw $w
-		wm title $w [strcat "[appname] ([reponame]): " [mc "Index Error"]]
-		wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
-		set s [mc "Updating the Git index failed.  A rescan will be automatically started to resynchronize git-gui."]
-		text $w.msg -yscrollcommand [list $w.vs set] \
-			-width [string length $s] -relief flat \
-			-borderwidth 0 -highlightthickness 0 \
-			-background [get_bg_color $w]
-		$w.msg tag configure bold -font font_uibold -justify center
-		${NS}::scrollbar $w.vs -command [list $w.msg yview]
-		$w.msg insert end $s bold \n\n$err {}
-		$w.msg configure -state disabled
-
-		${NS}::button $w.continue \
-			-text [mc "Continue"] \
-			-command [list destroy $w]
-		${NS}::button $w.unlock \
-			-text [mc "Unlock Index"] \
-			-command "destroy $w; _delete_indexlock"
-		grid $w.msg - $w.vs -sticky news
-		grid $w.unlock $w.continue - -sticky se -padx 2 -pady 2
-		grid columnconfigure $w 0 -weight 1
-		grid rowconfigure $w 0 -weight 1
-
-		wm protocol $w WM_DELETE_WINDOW update
-		bind $w.continue <Visibility> "
-			grab $w
-			focus %W
-		"
-		wm deiconify $w
-		tkwait window $w
-
-		$::main_status stop
+# Returns true if the operation succeeded, false if a rescan has been initiated.
+proc close_and_unlock_updateindex_rescan_on_error {fd after} {
+	if {![catch {_close_updateindex $fd} err]} {
 		unlock_index
-		rescan $after 0
-		return
+		uplevel #0 $after
+		return 1
+	} else {
+		rescan_on_error $err $after
+		return 0
 	}
+}
 
-	$::main_status stop
+proc _close_updateindex {fd} {
+	fconfigure $fd -blocking 1
+	close $fd
+}
+
+proc rescan_on_error {err {after {}}} {
+	global use_ttk NS
+
+	set w .indexfried
+	Dialog $w
+	wm withdraw $w
+	wm title $w [strcat "[appname] ([reponame]): " [mc "Index Error"]]
+	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
+	set s [mc "Updating the Git index failed.  A rescan will be automatically started to resynchronize git-gui."]
+	text $w.msg -yscrollcommand [list $w.vs set] \
+		-width [string length $s] -relief flat \
+		-borderwidth 0 -highlightthickness 0 \
+		-background [get_bg_color $w]
+	$w.msg tag configure bold -font font_uibold -justify center
+	${NS}::scrollbar $w.vs -command [list $w.msg yview]
+	$w.msg insert end $s bold \n\n$err {}
+	$w.msg configure -state disabled
+
+	${NS}::button $w.continue \
+		-text [mc "Continue"] \
+		-command [list destroy $w]
+	${NS}::button $w.unlock \
+		-text [mc "Unlock Index"] \
+		-command "destroy $w; _delete_indexlock"
+	grid $w.msg - $w.vs -sticky news
+	grid $w.unlock $w.continue - -sticky se -padx 2 -pady 2
+	grid columnconfigure $w 0 -weight 1
+	grid rowconfigure $w 0 -weight 1
+
+	wm protocol $w WM_DELETE_WINDOW update
+	bind $w.continue <Visibility> "
+		grab $w
+		focus %W
+	"
+	wm deiconify $w
+	tkwait window $w
+
+	$::main_status stop_all
 	unlock_index
-	uplevel #0 $after
+	rescan [concat $after [list ui_ready]] 0
 }
 
 proc update_indexinfo {msg path_list after} {
@@ -67,7 +77,7 @@ proc update_indexinfo {msg path_list after} {
 	set batch [expr {int($total_cnt * .01) + 1}]
 	if {$batch > 25} {set batch 25}
 
-	$::main_status start $msg [mc "files"]
+	set status_bar_operation [$::main_status start $msg [mc "files"]]
 	set fd [git_write update-index -z --index-info]
 	fconfigure $fd \
 		-blocking 0 \
@@ -81,16 +91,19 @@ proc update_indexinfo {msg path_list after} {
 		$path_list \
 		$total_cnt \
 		$batch \
+		$status_bar_operation \
 		$after \
 		]
 }
 
-proc write_update_indexinfo {fd path_list total_cnt batch after} {
+proc write_update_indexinfo {fd path_list total_cnt batch status_bar_operation \
+	after} {
 	global update_index_cp
 	global file_states current_diff_path
 
 	if {$update_index_cp >= $total_cnt} {
-		_close_updateindex $fd $after
+		$status_bar_operation stop
+		close_and_unlock_updateindex_rescan_on_error $fd $after
 		return
 	}
 
@@ -119,7 +132,7 @@ proc write_update_indexinfo {fd path_list total_cnt batch after} {
 		display_file $path $new
 	}
 
-	$::main_status update $update_index_cp $total_cnt
+	$status_bar_operation update $update_index_cp $total_cnt
 }
 
 proc update_index {msg path_list after} {
@@ -133,7 +146,7 @@ proc update_index {msg path_list after} {
 	set batch [expr {int($total_cnt * .01) + 1}]
 	if {$batch > 25} {set batch 25}
 
-	$::main_status start $msg [mc "files"]
+	set status_bar_operation [$::main_status start $msg [mc "files"]]
 	set fd [git_write update-index --add --remove -z --stdin]
 	fconfigure $fd \
 		-blocking 0 \
@@ -147,16 +160,19 @@ proc update_index {msg path_list after} {
 		$path_list \
 		$total_cnt \
 		$batch \
+		$status_bar_operation \
 		$after \
 		]
 }
 
-proc write_update_index {fd path_list total_cnt batch after} {
+proc write_update_index {fd path_list total_cnt batch status_bar_operation \
+	after} {
 	global update_index_cp
 	global file_states current_diff_path
 
 	if {$update_index_cp >= $total_cnt} {
-		_close_updateindex $fd $after
+		$status_bar_operation stop
+		close_and_unlock_updateindex_rescan_on_error $fd $after
 		return
 	}
 
@@ -190,10 +206,10 @@ proc write_update_index {fd path_list total_cnt batch after} {
 		display_file $path $new
 	}
 
-	$::main_status update $update_index_cp $total_cnt
+	$status_bar_operation update $update_index_cp $total_cnt
 }
 
-proc checkout_index {msg path_list after} {
+proc checkout_index {msg path_list after capture_error} {
 	global update_index_cp
 
 	if {![lock_index update]} return
@@ -204,7 +220,7 @@ proc checkout_index {msg path_list after} {
 	set batch [expr {int($total_cnt * .01) + 1}]
 	if {$batch > 25} {set batch 25}
 
-	$::main_status start $msg [mc "files"]
+	set status_bar_operation [$::main_status start $msg [mc "files"]]
 	set fd [git_write checkout-index \
 		--index \
 		--quiet \
@@ -224,16 +240,26 @@ proc checkout_index {msg path_list after} {
 		$path_list \
 		$total_cnt \
 		$batch \
+		$status_bar_operation \
 		$after \
+		$capture_error \
 		]
 }
 
-proc write_checkout_index {fd path_list total_cnt batch after} {
+proc write_checkout_index {fd path_list total_cnt batch status_bar_operation \
+	after capture_error} {
 	global update_index_cp
 	global file_states current_diff_path
 
 	if {$update_index_cp >= $total_cnt} {
-		_close_updateindex $fd $after
+		$status_bar_operation stop
+
+		if {[catch {_close_updateindex $fd} err]} {
+			uplevel #0 $capture_error [list $err]
+		}
+
+		uplevel #0 $after
+
 		return
 	}
 
@@ -253,7 +279,7 @@ proc write_checkout_index {fd path_list total_cnt batch after} {
 		}
 	}
 
-	$::main_status update $update_index_cp $total_cnt
+	$status_bar_operation update $update_index_cp $total_cnt
 }
 
 proc unstage_helper {txt paths} {
@@ -388,66 +414,301 @@ proc do_add_all {} {
 	add_helper [mc "Adding all changed files"] $paths
 }
 
+# Copied from TclLib package "lambda".
+proc lambda {arguments body args} {
+	return [list ::apply [list $arguments $body] {*}$args]
+}
+
 proc revert_helper {txt paths} {
 	global file_states current_diff_path
 
 	if {![lock_index begin-update]} return
 
+	# Common "after" functionality that waits until multiple asynchronous
+	# operations are complete (by waiting for them to activate their notes
+	# on the chord).
+	#
+	# The asynchronous operations are each indicated below by a comment
+	# before the code block that starts the async operation.
+	set after_chord [SimpleChord new {
+		if {[string trim $err] != ""} {
+			rescan_on_error $err
+		} else {
+			unlock_index
+			if {$should_reshow_diff} { reshow_diff }
+			ui_ready
+		}
+	}]
+
+	$after_chord eval { set should_reshow_diff 0 }
+
+	# This function captures an error for processing when after_chord is
+	# completed. (The chord is curried into the lambda function.)
+	set capture_error [lambda \
+		{chord error} \
+		{ $chord eval [list set err $error] } \
+		$after_chord]
+
+	# We don't know how many notes we're going to create (it's dynamic based
+	# on conditional paths below), so create a common note that will delay
+	# the chord's completion until we activate it, and then activate it
+	# after all the other notes have been created.
+	set after_common_note [$after_chord add_note]
+
 	set path_list [list]
-	set after {}
+	set untracked_list [list]
+
 	foreach path $paths {
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
+		?O {
+			lappend untracked_list $path
+		}
 		?M -
 		?T -
 		?D {
 			lappend path_list $path
 			if {$path eq $current_diff_path} {
-				set after {reshow_diff;}
+				$after_chord eval { set should_reshow_diff 1 }
 			}
 		}
 		}
 	}
 
+	set path_cnt [llength $path_list]
+	set untracked_cnt [llength $untracked_list]
+
+	# Asynchronous operation: revert changes by checking them out afresh
+	# from the index.
+	if {$path_cnt > 0} {
+		# Split question between singular and plural cases, because
+		# such distinction is needed in some languages. Previously, the
+		# code used "Revert changes in" for both, but that can't work
+		# in languages where 'in' must be combined with word from
+		# rest of string (in different way for both cases of course).
+		#
+		# FIXME: Unfortunately, even that isn't enough in some languages
+		# as they have quite complex plural-form rules. Unfortunately,
+		# msgcat doesn't seem to support that kind of string
+		# translation.
+		#
+		if {$path_cnt == 1} {
+			set query [mc \
+				"Revert changes in file %s?" \
+				[short_path [lindex $path_list]] \
+				]
+		} else {
+			set query [mc \
+				"Revert changes in these %i files?" \
+				$path_cnt]
+		}
 
-	# Split question between singular and plural cases, because
-	# such distinction is needed in some languages. Previously, the
-	# code used "Revert changes in" for both, but that can't work
-	# in languages where 'in' must be combined with word from
-	# rest of string (in different way for both cases of course).
-	#
-	# FIXME: Unfortunately, even that isn't enough in some languages
-	# as they have quite complex plural-form rules. Unfortunately,
-	# msgcat doesn't seem to support that kind of string translation.
-	#
-	set n [llength $path_list]
-	if {$n == 0} {
-		unlock_index
-		return
-	} elseif {$n == 1} {
-		set query [mc "Revert changes in file %s?" [short_path [lindex $path_list]]]
-	} else {
-		set query [mc "Revert changes in these %i files?" $n]
+		set reply [tk_dialog \
+			.confirm_revert \
+			"[appname] ([reponame])" \
+			"$query
+
+[mc "Any unstaged changes will be permanently lost by the revert."]" \
+			question \
+			1 \
+			[mc "Do Nothing"] \
+			[mc "Revert Changes"] \
+			]
+
+		if {$reply == 1} {
+			checkout_index \
+				$txt \
+				$path_list \
+				[$after_chord add_note] \
+				$capture_error
+		}
 	}
 
-	set reply [tk_dialog \
-		.confirm_revert \
-		"[appname] ([reponame])" \
-		"$query
+	# Asynchronous operation: Deletion of untracked files.
+	if {$untracked_cnt > 0} {
+		# Split question between singular and plural cases, because
+		# such distinction is needed in some languages.
+		#
+		# FIXME: Unfortunately, even that isn't enough in some languages
+		# as they have quite complex plural-form rules. Unfortunately,
+		# msgcat doesn't seem to support that kind of string
+		# translation.
+		#
+		if {$untracked_cnt == 1} {
+			set query [mc \
+				"Delete untracked file %s?" \
+				[short_path [lindex $untracked_list]] \
+				]
+		} else {
+			set query [mc \
+				"Delete these %i untracked files?" \
+				$untracked_cnt \
+				]
+		}
 
-[mc "Any unstaged changes will be permanently lost by the revert."]" \
-		question \
-		1 \
-		[mc "Do Nothing"] \
-		[mc "Revert Changes"] \
-		]
-	if {$reply == 1} {
-		checkout_index \
-			$txt \
+		set reply [tk_dialog \
+			.confirm_revert \
+			"[appname] ([reponame])" \
+			"$query
+
+[mc "Files will be permanently deleted."]" \
+			question \
+			1 \
+			[mc "Do Nothing"] \
+			[mc "Delete Files"] \
+			]
+
+		if {$reply == 1} {
+			$after_chord eval { set should_reshow_diff 1 }
+
+			delete_files $untracked_list [$after_chord add_note]
+		}
+	}
+
+	# Activate the common note. If no other notes were created, this
+	# completes the chord. If other notes were created, then this common
+	# note prevents a race condition where the chord might complete early.
+	$after_common_note
+}
+
+# Delete all of the specified files, performing deletion in batches to allow the
+# UI to remain responsive and updated.
+proc delete_files {path_list after} {
+	# Enable progress bar status updates
+	set status_bar_operation [$::main_status \
+		start \
+		[mc "Deleting"] \
+		[mc "files"]]
+
+	set path_index 0
+	set deletion_errors [list]
+	set batch_size 50
+
+	delete_helper \
+		$path_list \
+		$path_index \
+		$deletion_errors \
+		$batch_size \
+		$status_bar_operation \
+		$after
+}
+
+# Helper function to delete a list of files in batches. Each call deletes one
+# batch of files, and then schedules a call for the next batch after any UI
+# messages have been processed.
+proc delete_helper {path_list path_index deletion_errors batch_size \
+	status_bar_operation after} {
+	global file_states
+
+	set path_cnt [llength $path_list]
+
+	set batch_remaining $batch_size
+
+	while {$batch_remaining > 0} {
+		if {$path_index >= $path_cnt} { break }
+
+		set path [lindex $path_list $path_index]
+
+		set deletion_failed [catch {file delete -- $path} deletion_error]
+
+		if {$deletion_failed} {
+			lappend deletion_errors [list "$deletion_error"]
+		} else {
+			remove_empty_directories [file dirname $path]
+
+			# Don't assume the deletion worked. Remove the file from
+			# the UI, but only if it no longer exists.
+			if {![path_exists $path]} {
+				unset file_states($path)
+				display_file $path __
+			}
+		}
+
+		incr path_index 1
+		incr batch_remaining -1
+	}
+
+	# Update the progress bar to indicate that this batch has been
+	# completed. The update will be visible when this procedure returns
+	# and allows the UI thread to process messages.
+	$status_bar_operation update $path_index $path_cnt
+
+	if {$path_index < $path_cnt} {
+		# The Tcler's Wiki lists this as the best practice for keeping
+		# a UI active and processing messages during a long-running
+		# operation.
+
+		after idle [list after 0 [list \
+			delete_helper \
 			$path_list \
-			[concat $after [list ui_ready]]
+			$path_index \
+			$deletion_errors \
+			$batch_size \
+			$status_bar_operation \
+			$after
+			]]
 	} else {
-		unlock_index
+		# Finish the status bar operation.
+		$status_bar_operation stop
+
+		# Report error, if any, based on how many deletions failed.
+		set deletion_error_cnt [llength $deletion_errors]
+
+		if {($deletion_error_cnt > 0)
+		 && ($deletion_error_cnt <= [MAX_VERBOSE_FILES_IN_DELETION_ERROR])} {
+			set error_text [mc "Encountered errors deleting files:\n"]
+
+			foreach deletion_error $deletion_errors {
+				append error_text "* [lindex $deletion_error 0]\n"
+			}
+
+			error_popup $error_text
+		} elseif {$deletion_error_cnt == $path_cnt} {
+			error_popup [mc \
+				"None of the %d selected files could be deleted." \
+				$path_cnt \
+				]
+		} elseif {$deletion_error_cnt > 1} {
+			error_popup [mc \
+				"%d of the %d selected files could not be deleted." \
+				$deletion_error_cnt \
+				$path_cnt \
+				]
+		}
+
+		uplevel #0 $after
+	}
+}
+
+proc MAX_VERBOSE_FILES_IN_DELETION_ERROR {} { return 10; }
+
+# This function is from the TCL documentation:
+#
+#   https://wiki.tcl-lang.org/page/file+exists
+#
+# [file exists] returns false if the path does exist but is a symlink to a path
+# that doesn't exist. This proc returns true if the path exists, regardless of
+# whether it is a symlink and whether it is broken.
+proc path_exists {name} {
+	expr {![catch {file lstat $name finfo}]}
+}
+
+# Remove as many empty directories as we can starting at the specified path,
+# walking up the directory tree. If we encounter a directory that is not
+# empty, or if a directory deletion fails, then we stop the operation and
+# return to the caller. Even if this procedure fails to delete any
+# directories at all, it does not report failure.
+proc remove_empty_directories {directory_path} {
+	set parent_path [file dirname $directory_path]
+
+	while {$parent_path != $directory_path} {
+		set contents [glob -nocomplain -dir $directory_path *]
+
+		if {[llength $contents] > 0} { break }
+		if {[catch {file delete -- $directory_path}]} { break }
+
+		set directory_path $parent_path
+		set parent_path [file dirname $directory_path]
 	}
 }
 
diff --git a/lib/merge.tcl b/lib/merge.tcl
index 9f253db5b3..8df8ffae55 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -241,23 +241,27 @@ Continue with resetting the current changes?"]
 	if {[ask_popup $op_question] eq {yes}} {
 		set fd [git_read --stderr read-tree --reset -u -v HEAD]
 		fconfigure $fd -blocking 0 -translation binary
-		fileevent $fd readable [namespace code [list _reset_wait $fd]]
-		$::main_status start [mc "Aborting"] [mc "files reset"]
+		set status_bar_operation [$::main_status \
+			start \
+			[mc "Aborting"] \
+			[mc "files reset"]
+		fileevent $fd readable [namespace code [list \
+			_reset_wait $fd $status_bar_operation]]
 	} else {
 		unlock_index
 	}
 }
 
-proc _reset_wait {fd} {
+proc _reset_wait {fd status_bar_operation} {
 	global ui_comm
 
-	$::main_status update_meter [read $fd]
+	$status_bar_operation update_meter [read $fd]
 
 	fconfigure $fd -blocking 1
 	if {[eof $fd]} {
 		set fail [catch {close $fd} err]
-		$::main_status stop
 		unlock_index
+		$status_bar_operation stop
 
 		$ui_comm delete 0.0 end
 		$ui_comm edit modified false
diff --git a/lib/status_bar.tcl b/lib/status_bar.tcl
index 02111a1742..6a73988b23 100644
--- a/lib/status_bar.tcl
+++ b/lib/status_bar.tcl
@@ -1,16 +1,42 @@
 # git-gui status bar mega-widget
 # Copyright (C) 2007 Shawn Pearce
 
+# The status_bar class manages the entire status bar. It is possible for
+# multiple overlapping asynchronous operations to want to display status
+# simultaneously. Each one receives a status_bar_operation when it calls the
+# start method, and the status bar combines all active operations into the
+# line of text it displays. Most of the time, there will be at most one
+# ongoing operation.
+#
+# Note that the entire status bar can be either in single-line or two-line
+# mode, depending on the constructor. Multiple active operations are only
+# supported for single-line status bars.
+
 class status_bar {
 
+field allow_multiple ; # configured at construction
+
 field w         ; # our own window path
 field w_l       ; # text widget we draw messages into
 field w_c       ; # canvas we draw a progress bar into
 field c_pack    ; # script to pack the canvas with
-field status  {}; # single line of text we show
-field prefix  {}; # text we format into status
-field units   {}; # unit of progress
-field meter   {}; # current core git progress meter (if active)
+
+field baseline_text   ; # text to show if there are no operations
+field status_bar_text ; # combined text for all operations
+
+field operations ; # list of current ongoing operations
+
+# The status bar can display a progress bar, updated when consumers call the
+# update method on their status_bar_operation. When there are multiple
+# operations, the status bar shows the combined status of all operations.
+#
+# When an overlapping operation completes, the progress bar is going to
+# abruptly have one fewer operation in the calculation, causing a discontinuity.
+# Therefore, whenever an operation completes, if it is not the last operation,
+# this counter is increased, and the progress bar is calculated as though there
+# were still another operation at 100%. When the last operation completes, this
+# is reset to 0.
+field completed_operation_count
 
 constructor new {path} {
 	global use_ttk NS
@@ -18,12 +44,19 @@ constructor new {path} {
 	set w_l $w.l
 	set w_c $w.c
 
+	# Standard single-line status bar: Permit overlapping operations
+	set allow_multiple 1
+
+	set baseline_text ""
+	set operations [list]
+	set completed_operation_count 0
+
 	${NS}::frame $w
 	if {!$use_ttk} {
 		$w configure -borderwidth 1 -relief sunken
 	}
 	${NS}::label $w_l \
-		-textvariable @status \
+		-textvariable @status_bar_text \
 		-anchor w \
 		-justify left
 	pack $w_l -side left
@@ -44,9 +77,15 @@ constructor two_line {path} {
 	set w_l $w.l
 	set w_c $w.c
 
+	# Two-line status bar: Only one ongoing operation permitted.
+	set allow_multiple 0
+
+	set baseline_text ""
+	set operations [list]
+
 	${NS}::frame $w
 	${NS}::label $w_l \
-		-textvariable @status \
+		-textvariable @status_bar_text \
 		-anchor w \
 		-justify left
 	pack $w_l -anchor w -fill x
@@ -56,7 +95,7 @@ constructor two_line {path} {
 	return $this
 }
 
-method start {msg uds} {
+method ensure_canvas {} {
 	if {[winfo exists $w_c]} {
 		$w_c coords bar 0 0 0 20
 	} else {
@@ -68,31 +107,169 @@ method start {msg uds} {
 		$w_c create rectangle 0 0 0 20 -tags bar -fill navy
 		eval $c_pack
 	}
+}
+
+method show {msg {test {}}} {
+	if {$test eq {} || $status eq $test} {
+		$this ensure_canvas
+		set baseline_text $msg
+		$this refresh
+	}
+}
+
+method start {msg uds} {
+	set baseline_text ""
+
+	if {!$allow_multiple && [llength $operations]} {
+		return [lindex $operations 0]
+	}
+
+	$this ensure_canvas
+
+	set operation [status_bar_operation::new $this $msg $uds]
+
+	lappend operations $operation
+
+	$this refresh
+
+	return $operation
+}
+
+method refresh {} {
+	set new_text ""
+
+	set total [expr $completed_operation_count * 100]
+	set have $total
+
+	foreach operation $operations {
+		if {$new_text != ""} {
+			append new_text " / "
+		}
+
+		append new_text [$operation get_status]
+
+		set total [expr $total + 100]
+		set have [expr $have + [$operation get_progress]]
+	}
+
+	if {$new_text == ""} {
+		set new_text $baseline_text
+	}
+
+	set status_bar_text $new_text
+
+	set pixel_width 0
+	if {$have > 0} {
+		set pixel_width [expr {[winfo width $w_c] * $have / $total}]
+	}
+
+	$w_c coords bar 0 0 $pixel_width 20
+}
+
+method stop {operation stop_msg} {
+	set idx [lsearch $operations $operation]
+
+	if {$idx >= 0} {
+		set operations [lreplace $operations $idx $idx]
+		set completed_operation_count [expr \
+			$completed_operation_count + 1]
+
+		if {[llength operations] == 0} {
+			set completed_operation_count 0
+
+			destroy $w_c
+			if {$stop_msg ne {}} {
+				set baseline_text $stop_msg
+			}
+		}
+
+		$this refresh
+	}
+}
+
+method stop_all {{stop_msg {}}} {
+	set operations_copy $operations
+	set operations [list] # This makes the operation's call to stop a no-op.
+
+	foreach $operation operations_copy {
+		$operation stop
+	}
+
+	if {$stop_msg ne {}} {
+		set baseline_text $stop_msg
+	}
+
+	$this refresh
+}
+
+method _delete {current} {
+	if {$current eq $w} {
+		delete_this
+	}
+}
+
+}
+
+# The status_bar_operation class tracks a single consumer's ongoing status bar
+# activity, with the context that there are a few situations where multiple
+# overlapping asynchronous operations might want to display status information
+# simultaneously. Instances of status_bar_operation are created by calling
+# start on the status_bar, and when the caller is done with its stauts bar
+# operation, it calls stop on the operation.
+
+class status_bar_operation {
+
+field status_bar; # reference back to the status_bar that owns this object
+
+field is_active;
+
+field status   {}; # single line of text we show
+field progress {}; # current progress (0 to 100)
+field prefix   {}; # text we format into status
+field units    {}; # unit of progress
+field meter    {}; # current core git progress meter (if active)
+
+constructor new {owner msg uds} {
+	set status_bar $owner
 
 	set status $msg
+	set progress 0
 	set prefix $msg
 	set units  $uds
 	set meter  {}
+
+	set is_active 1
+
+	return $this
 }
 
+method get_is_active {} { return $is_active }
+method get_status {} { return $status }
+method get_progress {} { return $progress }
+
 method update {have total} {
-	set pdone 0
-	set cdone 0
+	if {!$is_active} { return }
+
+	set progress 0
+
 	if {$total > 0} {
-		set pdone [expr {100 * $have / $total}]
-		set cdone [expr {[winfo width $w_c] * $have / $total}]
+		set progress [expr {100 * $have / $total}]
 	}
 
 	set prec [string length [format %i $total]]
+
 	set status [mc "%s ... %*i of %*i %s (%3i%%)" \
 		$prefix \
 		$prec $have \
 		$prec $total \
-		$units $pdone]
-	$w_c coords bar 0 0 $cdone 20
+		$units $progress]
+
+	$status_bar refresh
 }
 
 method update_meter {buf} {
+	if {!$is_active} { return }
+
 	append meter $buf
 	set r [string last "\r" $meter]
 	if {$r == -1} {
@@ -109,23 +286,25 @@ method update_meter {buf} {
 	}
 }
 
-method stop {{msg {}}} {
-	destroy $w_c
-	if {$msg ne {}} {
-		set status $msg
+method stop {{stop_msg {}}} {
+	if {$is_active} {
+		set is_active 0
+		$status_bar stop $this $stop_msg
 	}
 }
 
 method show {msg {test {}}} {
+	if {!$is_active} { return }
+
 	if {$test eq {} || $status eq $test} {
 		set status $msg
+		$status_bar refresh
 	}
 }
 
-method _delete {current} {
-	if {$current eq $w} {
-		delete_this
-	}
+method _delete {} {
+	stop
+	delete_this
 }
 
 }
-- 
gitgitgadget
