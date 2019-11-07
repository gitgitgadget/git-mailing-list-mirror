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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E80B1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 07:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKGHFm (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 02:05:42 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:54040 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfKGHFl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 02:05:41 -0500
Received: by mail-wm1-f49.google.com with SMTP id x4so1215514wmi.3
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 23:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j6ajetf0iy0abZi2hFtRzD1KDaZ+IqswZtvVLQ03WyM=;
        b=TOwnV5icM2yWQcqd+mVMjp7BkAqeLMHXUwmAJV7MexXQ5jmjgJvtoQglpARNiHaqnZ
         yvmoBGvoFMsBLt3NCcMrlXd+BCilfAUULS6Ezd+G99DKPFF+8bIPJKrsXUdQ2vLEXP9A
         iH4lqaT/6orecIRgs0nE1QWHGKp8VcWDuakLMkzST6mL0VRH6GxE7u1H8sXTP9Z2Vx/q
         FUvLLktgCQCvWbNGl2Fvx8mByHM+IBF3B+q5LrPS+GGlBeu5KXUEL4BJj0M0CFJQMzjl
         6unzBGBuz+rM1gp4WHgARDFE4ZYVOhPbuLkaECwud7cd7p5Sapp2NJpJ2n0vNTHxHM9l
         ZhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j6ajetf0iy0abZi2hFtRzD1KDaZ+IqswZtvVLQ03WyM=;
        b=LmKRkW7d3QwGGpmt5FIgHLcs7cXJBran+Y4i9qpXyrjnjOZ0UXDo0Z4vIF42nnntjt
         /f31OEu+WXTWxO4VR93B8sdJ3uJ+RfZijqbUDOv4qfW43oiNcxBBBVFOSbKnlQTv5Jau
         8CWzLNW99JGj87KqXKpsX9k+Bx1FECuDLiPrQLtLsOkOCDVsQ9cIumo4EzgrNKvL9dJA
         Du68HsHKIwNd9phESs0UPTJzlhN4ft66GPFIPp6s58uqvO2cdiEbdu1PecAnuPo3wDuK
         f9uBfSIpPOJP7lfDjNBKKn61ZlTbIGOwv/tT74gOqgvchqgUcuW2P5CKXCrzAO9IqKO4
         w79w==
X-Gm-Message-State: APjAAAUZ+LB3XP7q0jU/+LiCa++IBB8QBVNoKIpOd0UFqAEDtek7S/O/
        w5r7hMdtX+dSl96s//mfxx98Yht9
X-Google-Smtp-Source: APXvYqyByekjBj/T43UvJ+qXss5Pzyo+gVEe3yflTDVVZ/j6byETYfBH9leLyybiGuetz28IeH+C3A==
X-Received: by 2002:a05:600c:2909:: with SMTP id i9mr1313699wmd.39.1573110338111;
        Wed, 06 Nov 2019 23:05:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm1101415wrq.96.2019.11.06.23.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 23:05:37 -0800 (PST)
Message-Id: <9469beb59937f87647190cf7f56544b8c27e20b6.1573110335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
        <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 07:05:35 +0000
Subject: [PATCH v2 2/2] git-gui: revert untracked files by deleting them
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

Update the revert_helper procedure to also detect untracked files. If
files are present, the user is asked if they want them deleted. Perform
the deletion in batches, using new proc delete_files with helper
delete_helper, to allow the UI to remain responsive. Coordinate the
completion of multiple overlapping asynchronous operations using a new
construct called a "chord". Migrate unlocking of the index out of
_close_updateindex to a responsibility of the caller, to permit paths
that don't directly unlock the index.

Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
---
 lib/chord.tcl | 137 ++++++++++++++++++++++++
 lib/index.tcl | 288 +++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 385 insertions(+), 40 deletions(-)
 create mode 100644 lib/chord.tcl

diff --git a/lib/chord.tcl b/lib/chord.tcl
new file mode 100644
index 0000000000..2d13af14fc
--- /dev/null
+++ b/lib/chord.tcl
@@ -0,0 +1,137 @@
+# SimpleChord class:
+#   Represents a procedure that conceptually has multiple entrypoints that must
+#   all be called before the procedure executes. Each entrypoint is called a
+#   "note". The chord is only "completed" when all the notes are "activated".
+#
+#   Constructor:
+#     set chord [SimpleChord new {body}]
+#       Creates a new chord object with the specified body script. The body
+#       script is evaluated at most once, when a note is activated and the
+#       chord has no other non-activated notes.
+#
+#   Methods:
+#     $chord eval {script}
+#       Runs the specified script in the same context (namespace) in which the
+#       chord body will be evaluated. This can be used to set variable values
+#       for the chord body to use.
+#
+#     set note [$chord add_note]
+#       Adds a new note to the chord, an instance of ChordNote. Raises an
+#       error if the chord is already completed, otherwise the chord is updated
+#       so that the new note must also be activated before the body is
+#       evaluated.
+#
+#     $chord notify_note_activation
+#       For internal use only.
+#
+# ChordNote class:
+#   Represents a note within a chord, providing a way to activate it. When the
+#   final note of the chord is activated (this can be any note in the chord,
+#   with all other notes already previously activated in any order), the chord's
+#   body is evaluated.
+#
+#   Constructor:
+#     Instances of ChordNote are created internally by calling add_note on
+#     SimpleChord objects.
+#
+#   Methods:
+#     [$note is_activated]
+#       Returns true if this note has already been activated.
+#
+#     $note
+#       Activates the note, if it has not already been activated, and completes
+#       the chord if there are no other notes awaiting activation. Subsequent
+#       calls will have no further effect.
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
+oo::class create SimpleChord {
+	variable Notes
+	variable Body
+	variable IsCompleted
+
+	constructor {body} {
+		set Notes [list]
+		set Body $body
+		set IsCompleted 0
+	}
+
+	method eval {script} {
+		namespace eval [self] $script
+	}
+
+	method add_note {} {
+		if {$IsCompleted} { error "Cannot add a note to a completed chord" }
+
+		set note [ChordNote new [self]]
+
+		lappend Notes $note
+
+		return $note
+	}
+
+	method notify_note_activation {} {
+		if {!$IsCompleted} {
+			foreach note $Notes {
+				if {![$note is_activated]} { return }
+			}
+
+			set IsCompleted 1
+
+			namespace eval [self] $Body
+			namespace delete [self]
+		}
+	}
+}
+
+oo::class create ChordNote {
+	variable Chord IsActivated
+
+	constructor {chord} {
+		set Chord $chord
+		set IsActivated 0
+	}
+
+	method is_activated {} {
+		return $IsActivated
+	}
+
+	method unknown {} {
+		if {!$IsActivated} {
+			set IsActivated 1
+			$Chord notify_note_activation
+		}
+	}
+}
diff --git a/lib/index.tcl b/lib/index.tcl
index 28d4d2a54e..64046d6833 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -7,7 +7,7 @@ proc _delete_indexlock {} {
 	}
 }
 
-proc _close_updateindex {fd after} {
+proc _close_updateindex {fd} {
 	global use_ttk NS
 	fconfigure $fd -blocking 1
 	if {[catch {close $fd} err]} {
@@ -52,8 +52,6 @@ proc _close_updateindex {fd after} {
 	}
 
 	$::main_status stop
-	unlock_index
-	uplevel #0 $after
 }
 
 proc update_indexinfo {msg path_list after} {
@@ -90,7 +88,9 @@ proc write_update_indexinfo {fd path_list total_cnt batch after} {
 	global file_states current_diff_path
 
 	if {$update_index_cp >= $total_cnt} {
-		_close_updateindex $fd $after
+		_close_updateindex $fd
+		unlock_index
+		uplevel #0 $after
 		return
 	}
 
@@ -156,7 +156,9 @@ proc write_update_index {fd path_list total_cnt batch after} {
 	global file_states current_diff_path
 
 	if {$update_index_cp >= $total_cnt} {
-		_close_updateindex $fd $after
+		_close_updateindex $fd
+		unlock_index
+		uplevel #0 $after
 		return
 	}
 
@@ -233,7 +235,8 @@ proc write_checkout_index {fd path_list total_cnt batch after} {
 	global file_states current_diff_path
 
 	if {$update_index_cp >= $total_cnt} {
-		_close_updateindex $fd $after
+		_close_updateindex $fd $do_unlock_index $after
+		uplevel #0 $after
 		return
 	}
 
@@ -393,61 +396,266 @@ proc revert_helper {txt paths} {
 
 	if {![lock_index begin-update]} return
 
+	# Common "after" functionality that waits until multiple asynchronous
+	# operations are complete (by waiting for them to activate their notes
+	# on the chord).
+	set after_chord [SimpleChord new {
+		unlock_index
+		if {$should_reshow_diff} { reshow_diff }
+		ui_ready
+	}]
+
+	$after_chord eval { set should_reshow_diff 0 }
+
+	# We don't know how many notes we're going to create (it's dynamic based
+	# on conditional paths below), so create a common note that will delay
+	# the chord's completion until we activate it, and then activate it
+	# after all the other notes have been created.
+	set after_common_note [$after_chord add_note]
+
 	set path_list [list]
+	set untracked_list [list]
 	set after {}
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
-	}
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
 
-	set reply [tk_dialog \
-		.confirm_revert \
-		"[appname] ([reponame])" \
-		"$query
+		set reply [tk_dialog \
+			.confirm_revert \
+			"[appname] ([reponame])" \
+			"$query
 
 [mc "Any unstaged changes will be permanently lost by the revert."]" \
-		question \
-		1 \
-		[mc "Do Nothing"] \
-		[mc "Revert Changes"] \
-		]
-	if {$reply == 1} {
-		checkout_index \
-			$txt \
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
+				[$after_chord add_note]
+		}
+	}
+
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
+
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
+	$::main_status start [mc "Deleting"] [mc "files"]
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
+		$after
+}
+
+# Helper function to delete a list of files in batches. Each call deletes one
+# batch of files, and then schedules a call for the next batch after any UI
+# messages have been processed.
+proc delete_helper {path_list path_index deletion_errors batch_size after} {
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
+	$::main_status update $path_index $path_cnt
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
+			$after
+			]]
 	} else {
-		unlock_index
+		# Finish the status bar operation.
+		$::main_status stop
+
+		# Report error, if any, based on how many deletions failed.
+		set deletion_error_cnt [llength $deletion_errors]
+
+		if {($deletion_error_cnt > 0) && ($deletion_error_cnt <= [MAX_VERBOSE_FILES_IN_DELETION_ERROR])} {
+			set error_text "Encountered errors deleting files:\n"
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
 
-- 
gitgitgadget
