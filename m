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
	by dcvr.yhbt.net (Postfix) with ESMTP id 64A791F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 06:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfKQG4T (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 01:56:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54987 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfKQG4S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 01:56:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id z26so14016606wmi.4
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 22:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Iuyp8z8Aqp1CQLCvaU5TYmrRhHLfW4VlKCO7byFRQxo=;
        b=Qw1ngFI40acVFv1fjp/LzxCadOZNQLQxxMY+do0ddqWhmp4FDVlLTLs6y4ql1RfkJ8
         m83cMSIghJMPpWFg9Sa5JCZOII24TqUgRfvDkjXRuvhyXoeJoQPWMq74SiKKp68ZXjs9
         uxpg6OcT9B8hEutl+7Y1t3tlysbuQ2lzU6BnsyeuDqQZ7GW2hcMXIyqCBcaT918TXrmR
         Vf29BL7tCLJ+eP84MOj4LQDvffBYHJpVPE43dTuM/E3vsFqVMDOO2V2YX+BjUo3GqMbm
         HETCuUbVrSzPmwaxUNlV8LtR5fLK3uWTO4dAzyeFO5cqufhGxseGO55WA/4AO5Jl7cTP
         Bw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Iuyp8z8Aqp1CQLCvaU5TYmrRhHLfW4VlKCO7byFRQxo=;
        b=uBdi9HLN/YxxhDY0CIseiqEcCTmYAb8e0Wb8H+G2yCVF0iOXv7i+h3IZo0WoFTJVZx
         5JWJlo6M6MfRM8c9MJWfOVx0IlQ79GoG41Yd0ACsvIjY3GDrKkFO6YgMb4HXVFBqjmRh
         MPBoFpXs0yzZkY8L4niWMLrCpaNjMmMScSVRs2P5mC22+JNg+AkeUCa/DrbytJ1/oL0E
         Suw6gNezK4ryL4LIHfHJjgkq5TtWlVrJZIEF98twfb0s+uqzhhHiCFfesoDxxFgWzQ+P
         LICgXhM+C4wsVMzfZaNGfRqmruzjucXKmqCLstKEqOViiz7agWjYizYWqemTpbKntS1d
         vlQw==
X-Gm-Message-State: APjAAAWA0nFGGNxHlqpGhPPXvGFhzj0kWfWDkm5wmxlUF4kmR45mINjJ
        e+oMXqTm4+EGVyIIKMVDoe5HDjxk
X-Google-Smtp-Source: APXvYqyp+DRjeOsHqIDkEkF9v0rhr7TtllxRQMlJs9hGA2Vst4IoGvM2szUgYD/FMOjax1Xn6wz3vA==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr23954018wmd.176.1573973772231;
        Sat, 16 Nov 2019 22:56:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h124sm16970143wme.30.2019.11.16.22.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2019 22:56:11 -0800 (PST)
Message-Id: <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v3.git.1573638988.gitgitgadget@gmail.com>
References: <pull.436.v3.git.1573638988.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 06:56:08 +0000
Subject: [PATCH v4 0/2] git-gui: revert untracked files by deleting them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My development environment sometimes makes automatic changes that I don't
want to keep. In some cases, this involves new files being added that I
don't want to commit or keep (but I also don't want to outright .gitignore 
forever). I have typically had to explicitly delete those files externally
to Git Gui, which is a context switch to a manual operation, and I want to
be able to just select those newly-created untracked files in the UI and
"revert" them into oblivion.

This change updates the revert_helper proc to check for untracked files as
well as changes, and then changes to be reverted and untracked files are
handled by independent blocks of code. The user is prompted independently
for untracked files, since the underlying action is fundamentally different
(rm -f). If after deleting untracked files, the directory containing them
becomes empty, then the directory is removed as well. A new proc 
delete_files takes care of actually deleting the files, using the Tcler's
Wiki recommended approach for keeping the UI responsive.

Since the checkout_index and delete_files calls are both asynchronous and
could potentially complete in any order, a "chord" is used to coordinate
unlocking the index and returning the UI to a usable state only after both
operations are complete.

Since the checkout_index and delete_files calls are both asynchronous and
overlap, they clash in wanting to update the status bar. To address this,
the status bar is reworked so that when an operation wants to display
ongoing updates/progress, it explicitly starts an "operation", which is
tracked by its own object, and the status bar handles multiple concurrent
operations by merging their progress and concatenating their text.

The _close_updateindex proc contains error handling (added in d4e890e5) that
has the potential to interact badly with unlock_index running at the
completion of an async operation. I have refactored the procedure into
separate procs _close_updateindex and rescan_on_error, and the original
functionality is captured with _close_updateindex_rescan_on_error. Call
sites have been updated appropriately, and checkout_index has been reworked
to take a functor that captures any errors that occur in a caller-defined
way. revert_helper uses this to supply a lambda function that stashes the
error within the chord's body namespace, so that it can call rescan_on_error 
when the chord is completed, which might be substantially after 
checkout_index encounters its error. If a rescan is called for, it is done
once the deletion is complete.

This is the fifth revision of this change, which differs from the fourth
version in the following ways:

 * The status_bar.tcl code has been reworked so that tracking an operation
   with updates and progress is now done in instances of a separate 
   status_bar_operation class. main_status start returns an operation
   instead of directly setting the state on the main progress bar, and then
   you send all your updates to the operation. This model allows the main
   progress bar to support multiple ongoing operations, in which case their
   progress data is merged: The status text is concatenated (separated by
   '/'), and the progress is combined mathematically into a single progress
   bar.
   
   
 * All call sites that used to directly send updates to main_status have
   been updated to use the new model.
   
   
 * The initialization code in git-gui.sh (which I'm assuming translates
   somehow to git-gui.tcl in the installation?) now explicitly clears the
   "Initializing..." status bar text, since the new status bar model won't
   do this automatically when operations are performed.
   
   
 * rescan_on_error makes a call to a special status bar function to stop and
   unhook all ongoing operations, on the assumption that the rescan is
   superseding any and all ongoing operations. Of course, if the operations
   are still actually running, errors will result, but this seemed the
   clearest mapping from the previous revision's $::main_status stop call
   inside the rescan code.
   
   
 * _close_updateindex_rescan_on_error has been renamed to 
   close_and_unlock_updateindex_rescan_on_error, and once again takes $after
   . As indicated by the name change, it also encapsulates the unlocking of
   the index, so that is removed from the call sites.
   
   
 * rescan_on_error takes $after as well, in case 
   close_and_unlock_updateindex_rescan_on_error needs to call it.
   
   
 * The after_chord body in revert_helper only calls unlock_index if it
   doesn't call rescan_on_error.
   
   

git remote add logiclrd https://github.com/logiclrd/git.git
git fetch logiclrd git-gui-revert-untracked revision4
git diff dc12c16..23d4f5d

Jonathan Gilbert (2):
  git-gui: consolidate naming conventions
  git-gui: revert untracked files by deleting them

 git-gui.sh          |   7 +-
 lib/checkout_op.tcl |  15 +-
 lib/chord.tcl       | 160 ++++++++++++++
 lib/index.tcl       | 517 +++++++++++++++++++++++++++++++++-----------
 lib/merge.tcl       |  14 +-
 lib/status_bar.tcl  | 221 +++++++++++++++++--
 6 files changed, 771 insertions(+), 163 deletions(-)
 create mode 100644 lib/chord.tcl


base-commit: b524f6b399c77b40c8bf2b6217585fde4731472a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-436%2Flogiclrd%2Fgit-gui-revert-untracked-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-436/logiclrd/git-gui-revert-untracked-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/436

Range-diff vs v3:

 1:  da1704c56e = 1:  da1704c56e git-gui: consolidate naming conventions
 2:  dc12c1668d ! 2:  23d4f5d829 git-gui: revert untracked files by deleting them
     @@ -11,7 +11,8 @@
          out of _close_updateindex to a responsibility of the caller, to permit
          paths that don't directly unlock the index, and refactor the error
          handling added in d4e890e5 so that callers can make flow control
     -    decisions in the event of errors.
     +    decisions in the event of errors. Rework status_bar to explicitly handle
     +    multiple overlapping operations, and update all call sites.
      
          A new proc delete_files takes care of actually deleting the files in
          batches, using the Tcler's Wiki recommended approach for keeping the UI
     @@ -23,6 +24,14 @@
          only after both operations are complete. The `SimpleChord` class,
          based on TclOO (Tcl/Tk 8.6), is added in this commit.
      
     +    Since the checkout_index and delete_files calls are both asynchronous
     +    and overlap, they clash in wanting to update the status bar. This commit
     +    reworks the status bar so that when an operation wants to display
     +    ongoing updates/progress, it explicitly starts an "operation", which is
     +    tracked by its own object, and the status bar handles multiple
     +    concurrent operations by merging their progress and concatenating their
     +    text.
     +
          Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
      
       diff --git a/git-gui.sh b/git-gui.sh
     @@ -39,6 +48,73 @@
       } {
       	catch {wm withdraw .}
       	tk_messageBox \
     +@@
     + 	do_explore
     + }
     + 
     ++# Clear "Initializing..." status
     ++after idle {after 500 {$main_status show ""}}
     ++
     + # Local variables:
     + # mode: tcl
     + # indent-tabs-mode: t
     +
     + diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
     + --- a/lib/checkout_op.tcl
     + +++ b/lib/checkout_op.tcl
     +@@
     + 	global HEAD
     + 
     + 	set readtree_d {}
     +-	$::main_status start \
     ++	set status_bar_operation [$::main_status start \
     + 		[mc "Updating working directory to '%s'..." [_name $this]] \
     +-		[mc "files checked out"]
     ++		[mc "files checked out"]]
     + 
     + 	set fd [git_read --stderr read-tree \
     + 		-m \
     +@@
     + 		$new_hash \
     + 		]
     + 	fconfigure $fd -blocking 0 -translation binary
     +-	fileevent $fd readable [cb _readtree_wait $fd]
     ++	fileevent $fd readable [cb _readtree_wait $fd $status_bar_operation]
     + }
     + 
     +-method _readtree_wait {fd} {
     ++method _readtree_wait {fd status_bar_operation} {
     + 	global current_branch
     + 
     + 	set buf [read $fd]
     +-	$::main_status update_meter $buf
     ++	$status_bar_operation update_meter $buf
     + 	append readtree_d $buf
     + 
     + 	fconfigure $fd -blocking 1
     + 	if {![eof $fd]} {
     + 		fconfigure $fd -blocking 0
     ++		$status_bar_operation stop
     + 		return
     + 	}
     + 
     + 	if {[catch {close $fd}]} {
     + 		set err $readtree_d
     + 		regsub {^fatal: } $err {} err
     +-		$::main_status stop [mc "Aborted checkout of '%s' (file level merging is required)." [_name $this]]
     ++		$status_bar_operation stop [mc "Aborted checkout of '%s' (file level merging is required)." [_name $this]]
     + 		warn_popup [strcat [mc "File level merge required."] "
     + 
     + $err
     +@@
     + 		return
     + 	}
     + 
     +-	$::main_status stop
     ++	$status_bar_operation stop
     + 	_after_readtree $this
     + }
     + 
      
       diff --git a/lib/chord.tcl b/lib/chord.tcl
       new file mode 100644
     @@ -215,18 +291,7 @@
       
      -proc _close_updateindex {fd after} {
      -	global use_ttk NS
     -+# Returns true if the operation succeeded, false if a rescan has been initiated.
     -+proc _close_updateindex_rescan_on_error {fd} {
     -+	if {![catch {_close_updateindex $fd} err]} {
     -+		return true
     -+	} else {
     -+		rescan_on_error $err
     -+		return false
     -+	}
     -+}
     -+
     -+proc _close_updateindex {fd} {
     - 	fconfigure $fd -blocking 1
     +-	fconfigure $fd -blocking 1
      -	if {[catch {close $fd} err]} {
      -		set w .indexfried
      -		Dialog $w
     @@ -261,16 +326,29 @@
      -		"
      -		wm deiconify $w
      -		tkwait window $w
     -+	close $fd
     -+	$::main_status stop
     -+}
     - 
     +-
      -		$::main_status stop
     --		unlock_index
     ++# Returns true if the operation succeeded, false if a rescan has been initiated.
     ++proc close_and_unlock_updateindex_rescan_on_error {fd after} {
     ++	if {![catch {_close_updateindex $fd} err]} {
     + 		unlock_index
      -		rescan $after 0
      -		return
     --	}
     -+proc rescan_on_error {err} {
     ++		uplevel #0 $after
     ++		return 1
     ++	} else {
     ++		rescan_on_error $err $after
     ++		return 0
     + 	}
     ++}
     + 
     +-	$::main_status stop
     ++proc _close_updateindex {fd} {
     ++	fconfigure $fd -blocking 1
     ++	close $fd
     ++}
     ++
     ++proc rescan_on_error {err {after {}}} {
      +	global use_ttk NS
      +
      +	set w .indexfried
     @@ -306,42 +384,91 @@
      +	"
      +	wm deiconify $w
      +	tkwait window $w
     - 
     - 	$::main_status stop
     ++
     ++	$::main_status stop_all
       	unlock_index
      -	uplevel #0 $after
     -+	rescan ui_ready 0
     ++	rescan [concat $after [list ui_ready]] 0
       }
       
       proc update_indexinfo {msg path_list after} {
      @@
     + 	set batch [expr {int($total_cnt * .01) + 1}]
     + 	if {$batch > 25} {set batch 25}
     + 
     +-	$::main_status start $msg [mc "files"]
     ++	set status_bar_operation [$::main_status start $msg [mc "files"]]
     + 	set fd [git_write update-index -z --index-info]
     + 	fconfigure $fd \
     + 		-blocking 0 \
     +@@
     + 		$path_list \
     + 		$total_cnt \
     + 		$batch \
     ++		$status_bar_operation \
     + 		$after \
     + 		]
     + }
     + 
     +-proc write_update_indexinfo {fd path_list total_cnt batch after} {
     ++proc write_update_indexinfo {fd path_list total_cnt batch status_bar_operation \
     ++	after} {
     + 	global update_index_cp
       	global file_states current_diff_path
       
       	if {$update_index_cp >= $total_cnt} {
      -		_close_updateindex $fd $after
     -+		if {[_close_updateindex_rescan_on_error $fd]} {
     -+			unlock_index
     -+		}
     -+
     -+		uplevel #0 $after
     ++		$status_bar_operation stop
     ++		close_and_unlock_updateindex_rescan_on_error $fd $after
       		return
       	}
       
      @@
     + 		display_file $path $new
     + 	}
     + 
     +-	$::main_status update $update_index_cp $total_cnt
     ++	$status_bar_operation update $update_index_cp $total_cnt
     + }
     + 
     + proc update_index {msg path_list after} {
     +@@
     + 	set batch [expr {int($total_cnt * .01) + 1}]
     + 	if {$batch > 25} {set batch 25}
     + 
     +-	$::main_status start $msg [mc "files"]
     ++	set status_bar_operation [$::main_status start $msg [mc "files"]]
     + 	set fd [git_write update-index --add --remove -z --stdin]
     + 	fconfigure $fd \
     + 		-blocking 0 \
     +@@
     + 		$path_list \
     + 		$total_cnt \
     + 		$batch \
     ++		$status_bar_operation \
     + 		$after \
     + 		]
     + }
     + 
     +-proc write_update_index {fd path_list total_cnt batch after} {
     ++proc write_update_index {fd path_list total_cnt batch status_bar_operation \
     ++	after} {
     + 	global update_index_cp
       	global file_states current_diff_path
       
       	if {$update_index_cp >= $total_cnt} {
      -		_close_updateindex $fd $after
     -+		if {[_close_updateindex_rescan_on_error $fd]} {
     -+			unlock_index
     -+		}
     -+
     -+		uplevel #0 $after
     ++		$status_bar_operation stop
     ++		close_and_unlock_updateindex_rescan_on_error $fd $after
       		return
       	}
       
      @@
     - 	$::main_status update $update_index_cp $total_cnt
     + 		display_file $path $new
     + 	}
     + 
     +-	$::main_status update $update_index_cp $total_cnt
     ++	$status_bar_operation update $update_index_cp $total_cnt
       }
       
      -proc checkout_index {msg path_list after} {
     @@ -350,20 +477,34 @@
       
       	if {![lock_index update]} return
      @@
     + 	set batch [expr {int($total_cnt * .01) + 1}]
     + 	if {$batch > 25} {set batch 25}
     + 
     +-	$::main_status start $msg [mc "files"]
     ++	set status_bar_operation [$::main_status start $msg [mc "files"]]
     + 	set fd [git_write checkout-index \
     + 		--index \
     + 		--quiet \
     +@@
     + 		$path_list \
       		$total_cnt \
       		$batch \
     ++		$status_bar_operation \
       		$after \
      +		$capture_error \
       		]
       }
       
      -proc write_checkout_index {fd path_list total_cnt batch after} {
     -+proc write_checkout_index {fd path_list total_cnt batch after capture_error} {
     ++proc write_checkout_index {fd path_list total_cnt batch status_bar_operation \
     ++	after capture_error} {
       	global update_index_cp
       	global file_states current_diff_path
       
       	if {$update_index_cp >= $total_cnt} {
      -		_close_updateindex $fd $after
     ++		$status_bar_operation stop
     ++
      +		if {[catch {_close_updateindex $fd} err]} {
      +			uplevel #0 $capture_error [list $err]
      +		}
     @@ -373,6 +514,15 @@
       		return
       	}
       
     +@@
     + 		}
     + 	}
     + 
     +-	$::main_status update $update_index_cp $total_cnt
     ++	$status_bar_operation update $update_index_cp $total_cnt
     + }
     + 
     + proc unstage_helper {txt paths} {
      @@
       	add_helper [mc "Adding all changed files"] $paths
       }
     @@ -394,10 +544,10 @@
      +	# The asynchronous operations are each indicated below by a comment
      +	# before the code block that starts the async operation.
      +	set after_chord [SimpleChord new {
     -+		unlock_index
      +		if {[string trim $err] != ""} {
      +			rescan_on_error $err
      +		} else {
     ++			unlock_index
      +			if {$should_reshow_diff} { reshow_diff }
      +			ui_ready
      +		}
     @@ -467,11 +617,6 @@
      +				"Revert changes in these %i files?" \
      +				$path_cnt]
      +		}
     -+
     -+		set reply [tk_dialog \
     -+			.confirm_revert \
     -+			"[appname] ([reponame])" \
     -+			"$query
       
      -	# Split question between singular and plural cases, because
      -	# such distinction is needed in some languages. Previously, the
     @@ -491,6 +636,11 @@
      -		set query [mc "Revert changes in file %s?" [short_path [lindex $path_list]]]
      -	} else {
      -		set query [mc "Revert changes in these %i files?" $n]
     ++		set reply [tk_dialog \
     ++			.confirm_revert \
     ++			"[appname] ([reponame])" \
     ++			"$query
     ++
      +[mc "Any unstaged changes will be permanently lost by the revert."]" \
      +			question \
      +			1 \
     @@ -571,7 +721,10 @@
      +# UI to remain responsive and updated.
      +proc delete_files {path_list after} {
      +	# Enable progress bar status updates
     -+	$::main_status start [mc "Deleting"] [mc "files"]
     ++	set status_bar_operation [$::main_status \
     ++		start \
     ++		[mc "Deleting"] \
     ++		[mc "files"]]
      +
      +	set path_index 0
      +	set deletion_errors [list]
     @@ -582,13 +735,15 @@
      +		$path_index \
      +		$deletion_errors \
      +		$batch_size \
     ++		$status_bar_operation \
      +		$after
      +}
      +
      +# Helper function to delete a list of files in batches. Each call deletes one
      +# batch of files, and then schedules a call for the next batch after any UI
      +# messages have been processed.
     -+proc delete_helper {path_list path_index deletion_errors batch_size after} {
     ++proc delete_helper {path_list path_index deletion_errors batch_size \
     ++	status_bar_operation after} {
      +	global file_states
      +
      +	set path_cnt [llength $path_list]
     @@ -622,7 +777,7 @@
      +	# Update the progress bar to indicate that this batch has been
      +	# completed. The update will be visible when this procedure returns
      +	# and allows the UI thread to process messages.
     -+	$::main_status update $path_index $path_cnt
     ++	$status_bar_operation update $path_index $path_cnt
      +
      +	if {$path_index < $path_cnt} {
      +		# The Tcler's Wiki lists this as the best practice for keeping
     @@ -636,12 +791,13 @@
      +			$path_index \
      +			$deletion_errors \
      +			$batch_size \
     ++			$status_bar_operation \
      +			$after
      +			]]
       	} else {
      -		unlock_index
      +		# Finish the status bar operation.
     -+		$::main_status stop
     ++		$status_bar_operation stop
      +
      +		# Report error, if any, based on how many deletions failed.
      +		set deletion_error_cnt [llength $deletion_errors]
     @@ -704,3 +860,348 @@
       	}
       }
       
     +
     + diff --git a/lib/merge.tcl b/lib/merge.tcl
     + --- a/lib/merge.tcl
     + +++ b/lib/merge.tcl
     +@@
     + 	if {[ask_popup $op_question] eq {yes}} {
     + 		set fd [git_read --stderr read-tree --reset -u -v HEAD]
     + 		fconfigure $fd -blocking 0 -translation binary
     +-		fileevent $fd readable [namespace code [list _reset_wait $fd]]
     +-		$::main_status start [mc "Aborting"] [mc "files reset"]
     ++		set status_bar_operation [$::main_status \
     ++			start \
     ++			[mc "Aborting"] \
     ++			[mc "files reset"]
     ++		fileevent $fd readable [namespace code [list \
     ++			_reset_wait $fd $status_bar_operation]]
     + 	} else {
     + 		unlock_index
     + 	}
     + }
     + 
     +-proc _reset_wait {fd} {
     ++proc _reset_wait {fd status_bar_operation} {
     + 	global ui_comm
     + 
     +-	$::main_status update_meter [read $fd]
     ++	$status_bar_operation update_meter [read $fd]
     + 
     + 	fconfigure $fd -blocking 1
     + 	if {[eof $fd]} {
     + 		set fail [catch {close $fd} err]
     +-		$::main_status stop
     + 		unlock_index
     ++		$status_bar_operation stop
     + 
     + 		$ui_comm delete 0.0 end
     + 		$ui_comm edit modified false
     +
     + diff --git a/lib/status_bar.tcl b/lib/status_bar.tcl
     + --- a/lib/status_bar.tcl
     + +++ b/lib/status_bar.tcl
     +@@
     + # git-gui status bar mega-widget
     + # Copyright (C) 2007 Shawn Pearce
     + 
     ++# The status_bar class manages the entire status bar. It is possible for
     ++# multiple overlapping asynchronous operations to want to display status
     ++# simultaneously. Each one receives a status_bar_operation when it calls the
     ++# start method, and the status bar combines all active operations into the
     ++# line of text it displays. Most of the time, there will be at most one
     ++# ongoing operation.
     ++#
     ++# Note that the entire status bar can be either in single-line or two-line
     ++# mode, depending on the constructor. Multiple active operations are only
     ++# supported for single-line status bars.
     ++
     + class status_bar {
     + 
     ++field allow_multiple ; # configured at construction
     ++
     + field w         ; # our own window path
     + field w_l       ; # text widget we draw messages into
     + field w_c       ; # canvas we draw a progress bar into
     + field c_pack    ; # script to pack the canvas with
     +-field status  {}; # single line of text we show
     +-field prefix  {}; # text we format into status
     +-field units   {}; # unit of progress
     +-field meter   {}; # current core git progress meter (if active)
     ++
     ++field baseline_text   ; # text to show if there are no operations
     ++field status_bar_text ; # combined text for all operations
     ++
     ++field operations ; # list of current ongoing operations
     ++
     ++# The status bar can display a progress bar, updated when consumers call the
     ++# update method on their status_bar_operation. When there are multiple
     ++# operations, the status bar shows the combined status of all operations.
     ++#
     ++# When an overlapping operation completes, the progress bar is going to
     ++# abruptly have one fewer operation in the calculation, causing a discontinuity.
     ++# Therefore, whenever an operation completes, if it is not the last operation,
     ++# this counter is increased, and the progress bar is calculated as though there
     ++# were still another operation at 100%. When the last operation completes, this
     ++# is reset to 0.
     ++field completed_operation_count
     + 
     + constructor new {path} {
     + 	global use_ttk NS
     +@@
     + 	set w_l $w.l
     + 	set w_c $w.c
     + 
     ++	# Standard single-line status bar: Permit overlapping operations
     ++	set allow_multiple 1
     ++
     ++	set baseline_text ""
     ++	set operations [list]
     ++	set completed_operation_count 0
     ++
     + 	${NS}::frame $w
     + 	if {!$use_ttk} {
     + 		$w configure -borderwidth 1 -relief sunken
     + 	}
     + 	${NS}::label $w_l \
     +-		-textvariable @status \
     ++		-textvariable @status_bar_text \
     + 		-anchor w \
     + 		-justify left
     + 	pack $w_l -side left
     +@@
     + 	set w_l $w.l
     + 	set w_c $w.c
     + 
     ++	# Two-line status bar: Only one ongoing operation permitted.
     ++	set allow_multiple 0
     ++
     ++	set baseline_text ""
     ++	set operations [list]
     ++
     + 	${NS}::frame $w
     + 	${NS}::label $w_l \
     +-		-textvariable @status \
     ++		-textvariable @status_bar_text \
     + 		-anchor w \
     + 		-justify left
     + 	pack $w_l -anchor w -fill x
     +@@
     + 	return $this
     + }
     + 
     +-method start {msg uds} {
     ++method ensure_canvas {} {
     + 	if {[winfo exists $w_c]} {
     + 		$w_c coords bar 0 0 0 20
     + 	} else {
     +@@
     + 		$w_c create rectangle 0 0 0 20 -tags bar -fill navy
     + 		eval $c_pack
     + 	}
     ++}
     ++
     ++method show {msg {test {}}} {
     ++	if {$test eq {} || $status eq $test} {
     ++		$this ensure_canvas
     ++		set baseline_text $msg
     ++		$this refresh
     ++	}
     ++}
     ++
     ++method start {msg uds} {
     ++	set baseline_text ""
     ++
     ++	if {!$allow_multiple && [llength $operations]} {
     ++		return [lindex $operations 0]
     ++	}
     ++
     ++	$this ensure_canvas
     ++
     ++	set operation [status_bar_operation::new $this $msg $uds]
     ++
     ++	lappend operations $operation
     ++
     ++	$this refresh
     ++
     ++	return $operation
     ++}
     ++
     ++method refresh {} {
     ++	set new_text ""
     ++
     ++	set total [expr $completed_operation_count * 100]
     ++	set have $total
     ++
     ++	foreach operation $operations {
     ++		if {$new_text != ""} {
     ++			append new_text " / "
     ++		}
     ++
     ++		append new_text [$operation get_status]
     ++
     ++		set total [expr $total + 100]
     ++		set have [expr $have + [$operation get_progress]]
     ++	}
     ++
     ++	if {$new_text == ""} {
     ++		set new_text $baseline_text
     ++	}
     ++
     ++	set status_bar_text $new_text
     ++
     ++	set pixel_width 0
     ++	if {$have > 0} {
     ++		set pixel_width [expr {[winfo width $w_c] * $have / $total}]
     ++	}
     ++
     ++	$w_c coords bar 0 0 $pixel_width 20
     ++}
     ++
     ++method stop {operation stop_msg} {
     ++	set idx [lsearch $operations $operation]
     ++
     ++	if {$idx >= 0} {
     ++		set operations [lreplace $operations $idx $idx]
     ++		set completed_operation_count [expr \
     ++			$completed_operation_count + 1]
     ++
     ++		if {[llength operations] == 0} {
     ++			set completed_operation_count 0
     ++
     ++			destroy $w_c
     ++			if {$stop_msg ne {}} {
     ++				set baseline_text $stop_msg
     ++			}
     ++		}
     ++
     ++		$this refresh
     ++	}
     ++}
     ++
     ++method stop_all {{stop_msg {}}} {
     ++	set operations_copy $operations
     ++	set operations [list] # This makes the operation's call to stop a no-op.
     ++
     ++	foreach $operation operations_copy {
     ++		$operation stop
     ++	}
     ++
     ++	if {$stop_msg ne {}} {
     ++		set baseline_text $stop_msg
     ++	}
     ++
     ++	$this refresh
     ++}
     ++
     ++method _delete {current} {
     ++	if {$current eq $w} {
     ++		delete_this
     ++	}
     ++}
     ++
     ++}
     ++
     ++# The status_bar_operation class tracks a single consumer's ongoing status bar
     ++# activity, with the context that there are a few situations where multiple
     ++# overlapping asynchronous operations might want to display status information
     ++# simultaneously. Instances of status_bar_operation are created by calling
     ++# start on the status_bar, and when the caller is done with its stauts bar
     ++# operation, it calls stop on the operation.
     ++
     ++class status_bar_operation {
     ++
     ++field status_bar; # reference back to the status_bar that owns this object
     ++
     ++field is_active;
     ++
     ++field status   {}; # single line of text we show
     ++field progress {}; # current progress (0 to 100)
     ++field prefix   {}; # text we format into status
     ++field units    {}; # unit of progress
     ++field meter    {}; # current core git progress meter (if active)
     ++
     ++constructor new {owner msg uds} {
     ++	set status_bar $owner
     + 
     + 	set status $msg
     ++	set progress 0
     + 	set prefix $msg
     + 	set units  $uds
     + 	set meter  {}
     ++
     ++	set is_active 1
     ++
     ++	return $this
     + }
     + 
     ++method get_is_active {} { return $is_active }
     ++method get_status {} { return $status }
     ++method get_progress {} { return $progress }
     ++
     + method update {have total} {
     +-	set pdone 0
     +-	set cdone 0
     ++	if {!$is_active} { return }
     ++
     ++	set progress 0
     ++
     + 	if {$total > 0} {
     +-		set pdone [expr {100 * $have / $total}]
     +-		set cdone [expr {[winfo width $w_c] * $have / $total}]
     ++		set progress [expr {100 * $have / $total}]
     + 	}
     + 
     + 	set prec [string length [format %i $total]]
     ++
     + 	set status [mc "%s ... %*i of %*i %s (%3i%%)" \
     + 		$prefix \
     + 		$prec $have \
     + 		$prec $total \
     +-		$units $pdone]
     +-	$w_c coords bar 0 0 $cdone 20
     ++		$units $progress]
     ++
     ++	$status_bar refresh
     + }
     + 
     + method update_meter {buf} {
     ++	if {!$is_active} { return }
     ++
     + 	append meter $buf
     + 	set r [string last "\r" $meter]
     + 	if {$r == -1} {
     +@@
     + 	}
     + }
     + 
     +-method stop {{msg {}}} {
     +-	destroy $w_c
     +-	if {$msg ne {}} {
     +-		set status $msg
     ++method stop {{stop_msg {}}} {
     ++	if {$is_active} {
     ++		set is_active 0
     ++		$status_bar stop $this $stop_msg
     + 	}
     + }
     + 
     + method show {msg {test {}}} {
     ++	if {!$is_active} { return }
     ++
     + 	if {$test eq {} || $status eq $test} {
     + 		set status $msg
     ++		$status_bar refresh
     + 	}
     + }
     + 
     +-method _delete {current} {
     +-	if {$current eq $w} {
     +-		delete_this
     +-	}
     ++method _delete {} {
     ++	stop
     ++	delete_this
     + }
     + 
     + }

-- 
gitgitgadget
