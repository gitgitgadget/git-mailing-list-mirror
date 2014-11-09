From: Tom Freudenberg <th.freudenberg@googlemail.com>
Subject: Feedback on submitting patches / here submodule
Date: Sun, 09 Nov 2014 12:39:36 +0100
Message-ID: <D08510BB.15149%th.freudenberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 12:39:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnQqV-0006N5-Ez
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 12:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbaKILjr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 06:39:47 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42977 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbaKILjp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2014 06:39:45 -0500
Received: by mail-wi0-f178.google.com with SMTP id bs8so8057002wib.5
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 03:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:user-agent:date:subject:to:message-id:thread-topic
         :mime-version:content-type:content-transfer-encoding;
        bh=/uZDjVe97aMfZvkdmC1MclU7fSxIz3YYh50mVaRtc+w=;
        b=zCmG3/gUgSfUAf2U583tLZsRsoonUjbLAjVuK0/d6vcapFj+/EPx+p4+IsfZAYZorF
         /psC/bfLJeMVwH9ayMIlchkoSGIww8YjNitse0l3YFgSV5Nktm+j5kVUdl6jRLzTgzl6
         8h8aHBgS0WCRSR8YacStzAvC+VY71MlQuYj4HbW1PX1pvuid7O0ypGZFGKDSSP3RJwvF
         3ov8I43Al/MUMHVx8f8agzjfIL22hBsV7e1mm87dfpxRh9M38JAijtXjZI15bTNc2g4j
         BekTzrIg49l5tRuWv+TTW1agaZ2uGTHJKy772PLMEACFpekxVmmUglcTBzTOmkVx/mDY
         Vz0w==
X-Received: by 10.181.13.139 with SMTP id ey11mr21035148wid.14.1415533184548;
        Sun, 09 Nov 2014 03:39:44 -0800 (PST)
Received: from [10.255.255.60] (ip1f117cb6.dynamic.kabel-deutschland.de. [31.17.124.182])
        by mx.google.com with ESMTPSA id wm6sm18870752wjb.5.2014.11.09.03.39.41
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 09 Nov 2014 03:39:44 -0800 (PST)
X-Google-Original-From: Tom Freudenberg <th.freudenberg@gmail.com>
User-Agent: Microsoft-MacOutlook/14.4.5.141003
Thread-Topic: Feedback on submitting patches / here submodule
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, a few weeks ago I send out attached message and patch to
gitster-at-pobox.com tried to follow the guidelines.

Have not get any feedback until now, neither acceptance nor decline =E2=
=80=A6 just
no feedback.

I am not sure if the message was received or this is some kind of inten=
ded
procedure.=20
=46rom my personal point of view it would be nice and polite to get an
answer for postings.

Hopefully I got some feedback from this list to whom I should send the
patch for review or denial.

Thanks=20
Tom


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=3D

Subject: FEATURE: submodule: checkout and update from remote stay track=
ed
to upstream


Hi, hopefully I added everything that you will check this feature
if it could be merged to git-submodule.sh

If have not yet added tests nor documentation. If you agree on
this feature in general, I will make the additional work for
tests and documentation.

Patch is for working on maint as well as on master.

Diff is available also on my git fork on github at:

https://github.com/TomFreudenberg/git/compare/git:master...TomFreudenbe=
rg:m
aster-added-feature-submodule-track


Thanks for some feedback.
Tom


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


submodule: checkout and update from remote stay tracked to upstream

With this change, cloning submodules for the first time or running
updates afterwards via:

$ git submodule update =E2=80=B9remote =E2=80=B9track ...

will get a local branch instead of a detached HEAD. Following updates
check track to upstream branch and merge if matching. Checkout to
detached head can be forced afterwards. Checkout will test and warn
if checkout modes are not compatible.

The motivation for the change is that developers doing local work
inside the submodule are likely to select a non-checkout-mode for
updates so their local work is integrated with upstream work.
Developers who are not doing local submodule work stick with
checkout-mode updates so any apparently local work is blown away
during updates.  For example, if upstream rolls back the remote branch
or gitlinked commit to an earlier version, the checkout-mode developer
wants their old submodule checkout to be rolled back as well, instead
of getting a no-op merge/rebase with the rolled-back reference.

By using the update mode to distinguish submodule developers from
black-box submodule consumers, we can setup local branches for the
developers who will want local branches, and stick with detached HEADs
for the developers that don't care.



Testing
=3D=3D=3D=3D=3D=3D=3D

Not yet updated



Documentation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Not yet updated



Signed-off-by: Tom Freudenberg <tom.freudenberg@4commerce.de>




=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



diff --git a/git-submodule.sh b/git-submodule.sh
index 9245abf..60a2145 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE=3D"[--quiet] add [-b <branch>] [-f|--force] [--na=
me
<name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--]
[<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch]
[-f|--force] [--checkout|--merge|--rebase] [--reference <repository>]
[--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote [--track]]
[-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference
<repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit
<n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -31,6 +31,7 @@ recursive=3D
init=3D
files=3D
remote=3D
+track=3D
nofetch=3D
update=3D
prefix=3D
@@ -736,6 +737,9 @@ cmd_update()
		--remote)
			remote=3D1
			;;
+		--track)
+			test -n "$remote" && track=3D"--track" || usage
+			;;
		-N|--no-fetch)
			nofetch=3D1
			;;
@@ -837,10 +841,14 @@ Maybe you want to use 'update --init'?")"
			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
			cloned_modules=3D"$cloned_modules;$name"
			subsha1=3D
+			subupstream=3D
		else
			subsha1=3D$(clear_local_git_env; cd "$sm_path" &&
				git rev-parse --verify HEAD) ||
			die "$(eval_gettext "Unable to find current revision in submodule pa=
th
'\$displaypath'")"
+			# get optional upstream info
+			subupstream=3D$(clear_local_git_env; cd "$sm_path" &&
+				git rev-parse --symbolic-full-name --abbrev-ref '@{u}' 2>/dev/null=
)
		fi
		if test -n "$remote"
@@ -855,6 +863,21 @@ Maybe you want to use 'update --init'?")"
			sha1=3D$(clear_local_git_env; cd "$sm_path" &&
				git rev-parse --verify "${remote_name}/${branch}") ||
			die "$(eval_gettext "Unable to find current ${remote_name}/${branch}
revision in submodule path '\$sm_path'")"
+			# track upsteam
+			if test -n "$track"
+			then
+				if test -z "$subsha1"
+				then
+					# first time checkout use symbol name to track
+					sha1=3D"${remote_name}/${branch}"
+				else
+					# test that already on the same upstream
+					test "${remote_name}/${branch}" =3D "$subupstream" ||
+					die "$(eval_gettext "Unable to merge. Current does not track
upstream ${remote_name}/${branch} in submodule path '\$sm_path'")"
+					# just merge with upstream
+					update_module=3D"merge"
+				fi
+			fi
		fi
		if test "$subsha1" !=3D "$sha1" || test -n "$force"
@@ -883,10 +906,17 @@ Maybe you want to use 'update --init'?")"
				update_module=3Dcheckout ;;
			esac
+			if test "$update_module" =3D "checkout"
+			then
+				# warn and abort if on upstream and not forced
+				test -n "$subupstream" -a -z "$subforce" &&
+					die "$(eval_gettext "Use --force to checkout detached HEAD.
Currently on upstream ${remote_name}/${branch} in submodule path
'\$sm_path'")"
+			fi
+
			must_die_on_failure=3D
			case "$update_module" in
			checkout)
-				command=3D"git checkout $subforce -q"
+				command=3D"git checkout $subforce $track -q"
				die_msg=3D"$(eval_gettext "Unable to checkout '\$sha1' in submodule
path '\$displaypath'")"
				say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': checked =
out
'\$sha1'")"
				;;
