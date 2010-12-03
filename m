From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 2/7] web--browse: coding style
Date: Fri,  3 Dec 2010 17:47:36 +0100
Message-ID: <1291394861-11989-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 17:48:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POYoH-0007II-L5
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 17:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab0LCQsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 11:48:09 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38941 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354Ab0LCQsH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 11:48:07 -0500
Received: by wyb28 with SMTP id 28so9636145wyb.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 08:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZlrI4qpfnD/vlyOuihN0CdqmeH/7oVkOl/V4qRPwAbA=;
        b=tOMHnDiFZd+gE22QxCNktUdRJX5C4zu/Gwb14PqE/42HlmPDxuyXNZi6tr6iGjmWsC
         tN143z44JeHVi0tPpOP086f496AFeCrKHdCf0Drv0f4xYNedGGCjMSh9cW1UBMMY6jlk
         mlD15bwVoovTIs+Ysp2ZdB2jwzDnV38zLVroc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=p0XF0LyArwwS2nUk555HJCylHbQIYJlTSsh0ApzNL9pqJz/6eJ0p29WZ5NjgjxUr6H
         53gGzs7opgy1pkh00XuAzuEXZGbYSih9EpLaYn8r6bCTuTnJokY/yNSMa8dApmXz0Pch
         B0BlZjRm41bV5QAiqeBvCkuurHrFYPLKO/lX0=
Received: by 10.227.201.14 with SMTP id ey14mr1771188wbb.170.1291394885478;
        Fri, 03 Dec 2010 08:48:05 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id y15sm974312weq.30.2010.12.03.08.48.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 08:48:04 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
In-Reply-To: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162808>

Retab and deindent choices in case statements.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-web--browse.sh |  166 ++++++++++++++++++++++++++--------------------------
 1 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 3fc4166..7c4568f 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,11 +31,11 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-		firefox | iceweasel | chrome | google-chrome | chromium | konqueror | w3m | links | lynx | dillo | open | start)
-			;; # happy
-		*)
-			valid_custom_tool "$1" || return 1
-			;;
+	firefox | iceweasel | chrome | google-chrome | chromium | konqueror | w3m | links | lynx | dillo | open | start)
+		;; # happy
+	*)
+		valid_custom_tool "$1" || return 1
+		;;
 	esac
 }
 
@@ -46,139 +46,139 @@ init_browser_path() {
 
 while test $# != 0
 do
-    case "$1" in
+	case "$1" in
 	-b|--browser*|-t|--tool*)
-	    case "$#,$1" in
+		case "$#,$1" in
 		*,*=*)
-		    browser=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-		    ;;
+			browser=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+			;;
 		1,*)
-		    usage ;;
+			usage ;;
 		*)
-		    browser="$2"
-		    shift ;;
-	    esac
-	    ;;
+			browser="$2"
+			shift ;;
+		esac
+		;;
 	-c|--config*)
-	    case "$#,$1" in
+		case "$#,$1" in
 		*,*=*)
-		    conf=`expr "z$1" : 'z-[^=]*=\(.*\)'`
-		    ;;
+			conf=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+			;;
 		1,*)
-		    usage ;;
+			usage ;;
 		*)
-		    conf="$2"
-		    shift ;;
-	    esac
-	    ;;
+			conf="$2"
+			shift ;;
+		esac
+		;;
 	--)
-	    break
-	    ;;
+		break
+		;;
 	-*)
-	    usage
-	    ;;
+		usage
+		;;
 	*)
-	    break
-	    ;;
-    esac
-    shift
+		break
+		;;
+	esac
+	shift
 done
 
 test $# = 0 && usage
 
 if test -z "$browser"
 then
-    for opt in "$conf" "web.browser"
-    do
-	test -z "$opt" && continue
-	browser="`git config $opt`"
-	test -z "$browser" || break
-    done
-    if test -n "$browser" && ! valid_tool "$browser"; then
-	echo >&2 "git config option $opt set to unknown browser: $browser"
-	echo >&2 "Resetting to default..."
-	unset browser
-    fi
+	for opt in "$conf" "web.browser"
+	do
+		test -z "$opt" && continue
+		browser="`git config $opt`"
+		test -z "$browser" || break
+	done
+	if test -n "$browser" && ! valid_tool "$browser"; then
+		echo >&2 "git config option $opt set to unknown browser: $browser"
+		echo >&2 "Resetting to default..."
+		unset browser
+	fi
 fi
 
 if test -z "$browser" ; then
-    if test -n "$DISPLAY"; then
-	browser_candidates="firefox iceweasel google-chrome chrome chromium konqueror w3m links lynx dillo"
-	if test "$KDE_FULL_SESSION" = "true"; then
-	    browser_candidates="konqueror $browser_candidates"
+	if test -n "$DISPLAY"; then
+		browser_candidates="firefox iceweasel google-chrome chrome chromium konqueror w3m links lynx dillo"
+		if test "$KDE_FULL_SESSION" = "true"; then
+			browser_candidates="konqueror $browser_candidates"
+		fi
+	else
+		browser_candidates="w3m links lynx"
 	fi
-    else
-	browser_candidates="w3m links lynx"
-    fi
-    # SECURITYSESSIONID indicates an OS X GUI login session
-    if test -n "$SECURITYSESSIONID" \
-	    -o "$TERM_PROGRAM" = "Apple_Terminal" ; then
-	browser_candidates="open $browser_candidates"
-    fi
-    # /bin/start indicates MinGW
-    if test -x /bin/start; then
-	browser_candidates="start $browser_candidates"
-    fi
-
-    for i in $browser_candidates; do
-	init_browser_path $i
-	if type "$browser_path" > /dev/null 2>&1; then
-	    browser=$i
-	    break
+	# SECURITYSESSIONID indicates an OS X GUI login session
+	if test -n "$SECURITYSESSIONID" \
+		-o "$TERM_PROGRAM" = "Apple_Terminal" ; then
+		browser_candidates="open $browser_candidates"
 	fi
-    done
-    test -z "$browser" && die "No known browser available."
+	# /bin/start indicates MinGW
+	if test -x /bin/start; then
+		browser_candidates="start $browser_candidates"
+	fi
+
+	for i in $browser_candidates; do
+		init_browser_path $i
+		if type "$browser_path" > /dev/null 2>&1; then
+			browser=$i
+			break
+		fi
+	done
+	test -z "$browser" && die "No known browser available."
 else
-    valid_tool "$browser" || die "Unknown browser '$browser'."
+	valid_tool "$browser" || die "Unknown browser '$browser'."
 
-    init_browser_path "$browser"
+	init_browser_path "$browser"
 
-    if test -z "$browser_cmd" && ! type "$browser_path" > /dev/null 2>&1; then
-	die "The browser $browser is not available as '$browser_path'."
-    fi
+	if test -z "$browser_cmd" && ! type "$browser_path" > /dev/null 2>&1; then
+		die "The browser $browser is not available as '$browser_path'."
+	fi
 fi
 
 case "$browser" in
-    firefox|iceweasel)
+firefox|iceweasel)
 	# Check version because firefox < 2.0 does not support "-new-tab".
 	vers=$(expr "$($browser_path -version)" : '.* \([0-9][0-9]*\)\..*')
 	NEWTAB='-new-tab'
 	test "$vers" -lt 2 && NEWTAB=''
 	"$browser_path" $NEWTAB "$@" &
 	;;
-    google-chrome|chrome|chromium)
+google-chrome|chrome|chromium)
 	# Actual command for chromium is chromium-browser.
 	# No need to specify newTab. It's default in chromium
 	eval "$browser_path" "$@" &
 	;;
-    konqueror)
+konqueror)
 	case "$(basename "$browser_path")" in
-	    konqueror)
+	konqueror)
 		# It's simpler to use kfmclient to open a new tab in konqueror.
 		browser_path="$(echo "$browser_path" | sed -e 's/konqueror$/kfmclient/')"
 		type "$browser_path" > /dev/null 2>&1 || die "No '$browser_path' found."
 		eval "$browser_path" newTab "$@"
 		;;
-	    kfmclient)
+	kfmclient)
 		eval "$browser_path" newTab "$@"
 		;;
-	    *)
+	*)
 		"$browser_path" "$@" &
 		;;
 	esac
 	;;
-    w3m|links|lynx|open)
+w3m|links|lynx|open)
 	eval "$browser_path" "$@"
 	;;
-    start)
-        exec "$browser_path" '"web-browse"' "$@"
-        ;;
-    dillo)
+start)
+	exec "$browser_path" '"web-browse"' "$@"
+	;;
+dillo)
 	"$browser_path" "$@" &
 	;;
-    *)
+*)
 	if test -n "$browser_cmd"; then
-	    ( eval $browser_cmd "$@" )
+		( eval $browser_cmd "$@" )
 	fi
 	;;
 esac
-- 
1.7.3.2.664.g294b8.dirty
