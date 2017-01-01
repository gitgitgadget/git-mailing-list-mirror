Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AFF21FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 20:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932446AbdAAUae (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 15:30:34 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:38680 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbdAAUad (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 15:30:33 -0500
Received: by mail-it0-f49.google.com with SMTP id x2so266497398itf.1
        for <git@vger.kernel.org>; Sun, 01 Jan 2017 12:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P7BrWWhtZEyUUA6RalBrbsKnNj88APU9hrf1GDFZsTU=;
        b=WoHu/COZh8nUnq071G63coGkyco9zZq6gG2ALvWbzmUOKu+6q9/s2ibzEA/k1f82z6
         p7VPaHwvx2f2c0f95Gvh9RcL/NvOW5lwGNp/5SehimhQ2EAa9URqD5GDnbi5RmYQTy6T
         uUvDrWJW12wjy5t6mRwJ3S9MLHDpZifxn1MI/Ain3VhzpTbi2BIv7RWlyEB1cZXwAxe8
         fD8vooMffPON5eu0FPJ2WHBZjPnOvYDrlqkZr4G4FlI9k8Ea2qSdU2cXtWIBMkHLLHfE
         TQFtrmgb92o9SFcDznRLKWxG0lgOAjajv3D+Rmzf7BBZf5aO31PI1npzKLl3+Fl72AcC
         DFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P7BrWWhtZEyUUA6RalBrbsKnNj88APU9hrf1GDFZsTU=;
        b=Yseub9KPGyOgq7yjxh/l+8Qb/v9MKMxNKgPCUC2orqvy4IGmxJyqLZyP95ccIso+uI
         bXVYHaVdXYnHJyJehprUeUl106wi4jFNIlMNjIgstpSwYP940OEnFf6b1uSoz9yiEduh
         61iDD6pcK44PDWFs/w7GCbxjgEGJpC9CPyX+O/mHFzyVW2784BnfZ5WW9KH7EY3L3TiG
         v337aGLsn6p2KOjNmWsfSf7Qp5hEdR3M0EOsaobkcTPtKxaGKwFKrd4WImT/+dm+EwpI
         IOazrlYLCDezXkacgpIC/OBdE/6mJw8FxhL5RlNCX8hDlnW+0b7RI5AW76iHrqeB/EVJ
         VeRg==
X-Gm-Message-State: AIkVDXJNodCj7YrAKi6DMqKmCmQo/NUbg0k//QuX5WgVhpW4Kuji5TM3j+V2EebEELkxCp+nCVVCT28y2Y4Y9A==
X-Received: by 10.36.137.196 with SMTP id s187mr39089262itd.70.1483302632770;
 Sun, 01 Jan 2017 12:30:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.186.138 with HTTP; Sun, 1 Jan 2017 12:30:12 -0800 (PST)
In-Reply-To: <20161212015823.GF18316@fergus.ozlabs.ibm.com>
References: <CAHdOBFrYWxfSXew5wHwcMym9=s+7cu2E9-MJJe29y+3zV89x7g@mail.gmail.com>
 <CAGZ79kbwrdW=XyPXBNcqBJU1dK8ZvfqyWbgtSt7mvT+m3LQB6g@mail.gmail.com>
 <CAHdOBFpOm3hf4XPjpSZ0+8rVgyKj+e3qT0cecU4j9ms=+chnDg@mail.gmail.com> <20161212015823.GF18316@fergus.ozlabs.ibm.com>
From:   =?UTF-8?Q?Florian_Sch=C3=BCller?= <florian.schueller@gmail.com>
Date:   Sun, 1 Jan 2017 21:30:12 +0100
Message-ID: <CAHdOBFoOdXxE6dhmGV9fBYCZb9dcfKwhwJzWmxm7aKNkwKYD5Q@mail.gmail.com>
Subject: Re: [PATCH] Gitk Inotify support
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just automatically update gitk when working in a terminal on the same repo

The commit is also on github if that makes things easier
https://github.com/schuellerf/gitk.git
(inotify branch)
https://github.com/schuellerf/gitk/tree/inotify

Features:
* Detects inotify support
  if inotify is not detected the options is not available
  in the preferences
* Enable/Disable auto update in the preferences
* Select "debounce" time for redraw
  i.e. the redraw will be postponed for the given time.
  if a new change is detected in this time the redraw is postponed
  even more
* Automatically scroll to the new HEAD after redrawing
* Depending on the type of change the UI is "Updated" or "Reloaded"

Open points for now:
* release watches for deleted directories seems to
  cause problems in tcl-inotify (so I don't)
  I'm not sure how often that happens in ".git/"

Signed-off-by: Florian Sch=C3=BCller <florian.schueller@gmail.com>
---
 gitk | 171 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 170 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index a14d7a1..a2850d7 100755
--- a/gitk
+++ b/gitk
@@ -8,6 +8,12 @@ exec wish "$0" -- "$@"
 # either version 2, or (at your option) any later version.

 package require Tk
+try {
+    package require inotify
+    set have_inotify true
+} on error {em} {
+    set have_inotify false
+}

 proc hasworktree {} {
     return [expr {[exec git rev-parse --is-bare-repository] =3D=3D "false"=
 &&
@@ -11489,6 +11495,7 @@ proc prefspage_general {notebook} {
     global NS maxwidth maxgraphpct showneartags showlocalchanges
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_at=
trs
     global hideremotes want_ttk have_ttk maxrefs
+    global autoupdate have_inotify autoupdatedebounce

     set page [create_prefs_page $notebook.general]

@@ -11505,13 +11512,21 @@ proc prefspage_general {notebook} {
     ${NS}::checkbutton $page.showlocal -text [mc "Show local changes"] \
  -variable showlocalchanges
     grid x $page.showlocal -sticky w
+
     ${NS}::checkbutton $page.autoselect -text [mc "Auto-select SHA1
(length)"] \
  -variable autoselect
     spinbox $page.autosellen -from 1 -to 40 -width 4 -textvariable autosel=
len
     grid x $page.autoselect $page.autosellen -sticky w
+
     ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs"] \
  -variable hideremotes
     grid x $page.hideremotes -sticky w
+    if { $have_inotify } {
+        ${NS}::checkbutton $page.autoupdate -text [mc "Auto-update
upon change (ms)"] \
+            -variable autoupdate
+        spinbox $page.autoupdatedebounce -from 10 -to 60000 -width 7
-textvariable autoupdatedebounce
+        grid x $page.autoupdate $page.autoupdatedebounce -sticky w
+    }

     ${NS}::label $page.ddisp -text [mc "Diff display options"]
     grid $page.ddisp - -sticky w -pady 10
@@ -11765,7 +11780,8 @@ proc prefsok {} {
     global oldprefs prefstop showneartags showlocalchanges
     global fontpref mainfont textfont uifont
     global limitdiffs treediffs perfile_attrs
-    global hideremotes
+    global hideremotes autoupdate
+    global gitdir

     catch {destroy $prefstop}
     unset prefstop
@@ -11814,6 +11830,8 @@ proc prefsok {} {
     if {$hideremotes !=3D $oldprefs(hideremotes)} {
  rereadrefs
     }
+
+    handle_inotify $gitdir true
 }

 proc formatdate {d} {
@@ -12295,6 +12313,13 @@ set autoselect 1
 set autosellen 40
 set perfile_attrs 0
 set want_ttk 1
+set autoupdate 1
+set autoupdatedebounce 100
+#timer id for inotify reloading
+set reload_id -1
+#timer id for inotify updating (less than reload)
+set update_id -1
+set inotify_instance -1

 if {[tk windowingsystem] eq "aqua"} {
     set extdifftool "opendiff"
@@ -12390,6 +12415,7 @@ set config_variables {
     filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
     indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
+    autoupdate autoupdatedebounce
 }
 foreach var $config_variables {
     config_init_trace $var
@@ -12477,6 +12503,149 @@ if {$i >=3D [llength $argv] && $revtreeargs ne {}=
} {
     }
 }

+#function to be called after inotify reload-timeout
+proc reload_helper {} {
+    #puts "RELOAD"
+    global reload_id
+    set reload_id -1
+    reloadcommits
+    set head [exec git rev-parse HEAD]
+    selbyid $head
+}
+
+#function to be called after inotify update-timeout
+proc update_helper {} {
+    #puts "UPDATE"
+    global update_id
+    set update_id -1
+    updatecommits
+    set head [exec git rev-parse HEAD]
+    selbyid $head
+}
+
+proc inotify_handler { fd } {
+    global autoupdate reload_id update_id autoupdatedebounce
+    set events [inotify_watch read]
+    set watch_info [inotify_watch info]
+    set update_view false
+    set reloadcommits false
+
+    #cancel pending timer
+    if { $reload_id ne -1 } {
+        #puts "cancel a reload"
+        after cancel $reload_id
+        set reload_id -1
+        set update_view true
+        set reloadcommits true
+    }
+
+    if { $update_id ne -1 } {
+        #puts "cancel an update"
+        after cancel $update_id
+        set update_id -1
+        set update_view true
+    }
+
+    foreach {event} $events {
+        set current_watchid [dict get $event watchid]
+        set flags [dict get $event flags]
+        set event_filename [dict get $event filename]
+
+        foreach {path watchid watch_flags} $watch_info {
+            if {$watchid eq $current_watchid} {
+                set watch_path $path
+            }
+        }
+
+        set full_filename [file join $watch_path $event_filename]
+        #check wether we should do update or reload below
+        #puts "Got: $full_filename / $event_filename ($flags)"
+
+        if {$flags eq "nD"} {
+            inotify_watch add $full_filename "nwds"
+        }
+        if {![string match *.lock $event_filename]} {
+            if { $flags eq "d" } {
+                #stuff like deleting branches should result in reloading
+                set reloadcommits true
+            }
+            set update_view true
+        }
+
+        #simple commit just needs updating right?
+        #if { $event_filename eq "COMMIT_EDITMSG" } {
+        #    set reloadcommits true
+        #}
+    }
+
+    #reloadcommits or updatecommits - depending on file and operation?
+    if { $update_view } {
+        if { $reloadcommits } {
+            #puts "schedule reload"
+            set reload_id [after $autoupdatedebounce reload_helper]
+        } else {
+            #puts "schedule update"
+            set update_id [after $autoupdatedebounce update_helper]
+        }
+    }
+}
+
+proc watch_recursive { dir } {
+    inotify_watch add $dir "nwaCmMds"
+
+    foreach i [glob -nocomplain -dir $dir *] {
+        if {[file type $i] eq {directory}} {
+            watch_recursive $i
+        }
+    }
+}
+
+proc enable_inotify { dir redraw} {
+    global inotify_instance autoupdatedebounce reload_id
+
+    if { $inotify_instance ne -1 } {
+        updatecommits
+    } else {
+        set inotify_instance [inotify create "inotify_watch"
"::inotify_handler"]
+        watch_recursive $dir
+        if { $redraw } {
+            set reload_id [after $autoupdatedebounce reload_helper]
+        }
+    }
+}
+
+proc disable_inotify {} {
+    global inotify_instance reload_id update_id
+
+    if { $inotify_instance ne -1 } {
+        rename inotify_watch {}
+        set inotify_instance -1
+    }
+
+    if { $reload_id ne -1 } {
+        after cancel $reload_id
+        set reload_id -1
+    }
+
+    if { $update_id ne -1 } {
+        after cancel $update_id
+        set update_id -1
+    }
+}
+
+proc handle_inotify { dir redraw } {
+    global have_inotify autoupdate
+    if { $have_inotify } {
+        if { $autoupdate } {
+            enable_inotify $dir $redraw
+        } else {
+            disable_inotify
+        }
+    }
+}
+
+handle_inotify $gitdir false
+
 set nullid "0000000000000000000000000000000000000000"
 set nullid2 "0000000000000000000000000000000000000001"
 set nullfile "/dev/null"
--=20
2.7.4
