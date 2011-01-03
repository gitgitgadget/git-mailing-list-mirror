From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: fatal: ambiguous message
Date: Sun, 02 Jan 2011 16:16:21 -0800
Message-ID: <4D211555.1040502@gmail.com>
References: <4D1D33D7.7040809@gmail.com> <4D1DFF96.4010004@redhat.com>
	<4D20BE0B.6040104@gmail.com> <20110102183453.GA13463@burratino>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020507080704030404030103"
Cc: GNU Autoconf mailing list <autoconf@gnu.org>,
	Eric Blake <eblake@redhat.com>, GIT Development <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: autoconf-bounces+gnu-autoconf=m.gmane.org@gnu.org Mon Jan 03 01:16:54 2011
Return-path: <autoconf-bounces+gnu-autoconf=m.gmane.org@gnu.org>
Envelope-to: gnu-autoconf@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <autoconf-bounces+gnu-autoconf=m.gmane.org@gnu.org>)
	id 1PZY6S-0001eE-Gi
	for gnu-autoconf@m.gmane.org; Mon, 03 Jan 2011 01:16:53 +0100
Received: from localhost ([127.0.0.1]:45661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1PZY6L-0005RZ-7O
	for gnu-autoconf@m.gmane.org; Sun, 02 Jan 2011 19:16:41 -0500
Received: from [140.186.70.92] (port=47794 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1PZY6B-0005RR-V6
	for autoconf@gnu.org; Sun, 02 Jan 2011 19:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bruce.korb@gmail.com>) id 1PZY6A-0004Aw-61
	for autoconf@gnu.org; Sun, 02 Jan 2011 19:16:31 -0500
Received: from mail-gy0-f169.google.com ([209.85.160.169]:47703)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bruce.korb@gmail.com>) id 1PZY6A-0004Ao-01
	for autoconf@gnu.org; Sun, 02 Jan 2011 19:16:30 -0500
Received: by gyd10 with SMTP id 10so2232970gyd.0
	for <autoconf@gnu.org>; Sun, 02 Jan 2011 16:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from
	:user-agent:mime-version:to:cc:subject:references:in-reply-to
	:content-type; bh=lSI/l28X99XtwIfvevTaUp34uICJmFJQE6Nc1zW3yRA=;
	b=D8HDKmcUOv1qmzVsBYXfUiJqmNl1HDsGNd05+iEE1q/ywIdcPr71paVK38Ywdbk4yA
	/JQwoFUJNCKIlep5eFigrmzfwGCEDax5CasQyk2WpTQshySL3J+NjDNwWVvEXVINo2yD
	W2onjQOOE8e/sRbHuuvwsZiYHF6ce1eiqaVWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type;
	b=e+HQuINoZ/0rjXJxsjtv8fdfhb/w8M2kdfeWdnsXh+KfM8JM2oUvNhiJgZaUW4o9dh
	X7icBIepV58GIn/cYzyF8Go2juaoRqR7RljNMK9/PBJIIh4NrXUY5XE6EUBQHGsNxuWm
	Bx51hcKcqNebKVXNDyKXqDVArjvgNooKxiS88=
Received: by 10.100.195.4 with SMTP id s4mr9189958anf.166.1294013789291;
	Sun, 02 Jan 2011 16:16:29 -0800 (PST)
Received: from [10.10.1.101] (adsl-75-2-133-184.dsl.pltn13.sbcglobal.net
	[75.2.133.184])
	by mx.google.com with ESMTPS id j14sm27312154anb.19.2011.01.02.16.16.27
	(version=TLSv1/SSLv3 cipher=RC4-MD5);
	Sun, 02 Jan 2011 16:16:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
In-Reply-To: <20110102183453.GA13463@burratino>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6 (newer, 2)
X-BeenThere: autoconf@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Discussion list for the autoconf build system <autoconf.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/autoconf>,
	<mailto:autoconf-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/autoconf>
List-Post: <mailto:autoconf@gnu.org>
List-Help: <mailto:autoconf-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/autoconf>,
	<mailto:autoconf-request@gnu.org?subject=subscribe>
Sender: autoconf-bounces+gnu-autoconf=m.gmane.org@gnu.org
Errors-To: autoconf-bounces+gnu-autoconf=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164427>

This is a multi-part message in MIME format.
--------------020507080704030404030103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On Sun, Jan 2, 2011 at 10:34 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Were you been able to reproduce that outside the script?

No, I was blind to the invocation.  You found it.  I was looking
without seeing.  Thank you.

Given that shells without functions can be considered sufficiently
obsolete to not be a consideration, perhaps a better solution is
to put the I-don't-care-about-error-messages code into a separate
function with stderr redirected.  Doing that turned out messier
than I had hoped....


--------------020507080704030404030103
Content-Type: text/x-patch;
 name="gvg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gvg.patch"

diff --git a/build-aux/git-version-gen b/build-aux/git-version-gen
index c278f6a..8a238b0 100755
--- a/build-aux/git-version-gen
+++ b/build-aux/git-version-gen
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Print a version string.
-scriptversion=2010-10-13.20; # UTC
+scriptversion=2011-01-03.00; # UTC
 
 # Copyright (C) 2007-2011 Free Software Foundation, Inc.
 #
@@ -78,76 +78,96 @@ tag_sed_script="${2:-s/x/x/}"
 nl='
 '
 
-# Avoid meddling by environment variable of the same name.
-v=
+get_ver()
+{
+    local PS4='>gv> '
+    git status >/dev/null 2>&1 || {
+        printf UNKNOWN
+        exit 0
+    }
 
-# First see if there is a tarball-only version file.
-# then try "git describe", then default.
-if test -f $tarball_version_file
-then
-    v=`cat $tarball_version_file` || exit 1
-    case $v in
-	*$nl*) v= ;; # reject multi-line output
-	[0-9]*) ;;
-	*) v= ;;
+    test "`git log -1 --pretty=format:x . 2>&1`" = x || {
+        printf UNKNOWN
+        exit 0
+    }
+
+    X=`git describe --abbrev=4 --match='v*' HEAD || \
+        git describe --abbrev=4 HEAD` || {
+        printf UNKNOWN
+        exit 0
+    }
+
+    case "$X" in
+    v[0-9]* ) : ;;
+    * )
+        printf UNKNOWN
+        exit 0
+        ;;
     esac
-    test -z "$v" \
-	&& echo "$0: WARNING: $tarball_version_file seems to be damaged" 1>&2
-fi
 
-if test -n "$v"
-then
-    : # use $v
-# Otherwise, if there is at least one git commit involving the working
-# directory, and "git describe" output looks sensible, use that to
-# derive a version string.
-elif test "`git log -1 --pretty=format:x . 2>&1`" = x \
-    && v=`git describe --abbrev=4 --match='v*' HEAD 2>/dev/null \
-	  || git describe --abbrev=4 HEAD 2>/dev/null` \
-    && v=`printf '%s\n' "$v" | sed "$tag_sed_script"` \
-    && case $v in
-	 v[0-9]*) ;;
-	 *) (exit 1) ;;
-       esac
-then
     # Is this a new git that lists number of commits since the last
     # tag or the previous older version that did not?
     #   Newer: v6.10-77-g0f8faeb
     #   Older: v6.10-g0f8faeb
-    case $v in
+    case $X in
 	*-*-*) : git describe is okay three part flavor ;;
 	*-*)
 	    : git describe is older two part flavor
 	    # Recreate the number of commits and rewrite such that the
 	    # result is the same as if we were using the newer version
 	    # of git describe.
-	    vtag=`echo "$v" | sed 's/-.*//'`
+	    vtag=`echo "$X" | sed 's/-.*//'`
 	    numcommits=`git rev-list "$vtag"..HEAD | wc -l`
-	    v=`echo "$v" | sed "s/\(.*\)-\(.*\)/\1-$numcommits-\2/"`;
+	    X=`echo "$X" | sed "s/\(.*\)-\(.*\)/\1-$numcommits-\2/"`;
 	    ;;
     esac
 
+    # Don't declare a version "dirty" merely because a time stamp has changed.
+    silent_git update-index --refresh >/dev/null 2>&1
+
+    dirty=`git diff-index --name-only HEAD` || dirty=
+    case "$dirty" in
+    '') ;;
+    *) # Append the suffix only if there isn't one already.
+	case $X in
+	  *-dirty) ;;
+	  *) X="$X-dirty" ;;
+	esac
+        ;;
+    esac
+
     # Change the first '-' to a '.', so version-comparing tools work properly.
     # Remove the "g" in git describe's output string, to save a byte.
-    v=`echo "$v" | sed 's/-/./;s/\(.*\)-g/\1-/'`;
+    echo "$X" | sed 's/^v//;s/-/./;s/\(.*\)-g/\1-/'
+}
+
+# First see if there is a tarball-only version file.
+# then try "git describe", then default.
+if test -f $tarball_version_file
+then
+    v=`cat $tarball_version_file` || exit 1
+    case $v in
+	*$nl*) v= ;; # reject multi-line output
+	[0-9]*) ;;
+	*) v= ;;
+    esac
+    test -z "$v" \
+	&& echo "$0: WARNING: $tarball_version_file seems to be damaged" 1>&2
 else
-    v=UNKNOWN
+    v=
 fi
 
-v=`echo "$v" |sed 's/^v//'`
-
-# Don't declare a version "dirty" merely because a time stamp has changed.
-git update-index --refresh > /dev/null 2>&1
+if test -n "$v"
+then
+    : # use $v
 
-dirty=`sh -c 'git diff-index --name-only HEAD' 2>/dev/null` || dirty=
-case "$dirty" in
-    '') ;;
-    *) # Append the suffix only if there isn't one already.
-	case $v in
-	  *-dirty) ;;
-	  *) v="$v-dirty" ;;
-	esac ;;
-esac
+else
+    # Otherwise, if there is at least one git commit involving the
+    # working directory, and "git describe" output looks sensible, use
+    # that to derive a version string.
+    #
+    v=`get_ver` 2>/dev/null
+fi
 
 # Omit the trailing newline, so that m4_esyscmd can use the result directly.
 echo "$v" | tr -d "$nl"

--------------020507080704030404030103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Autoconf mailing list
Autoconf@gnu.org
http://lists.gnu.org/mailman/listinfo/autoconf

--------------020507080704030404030103--
