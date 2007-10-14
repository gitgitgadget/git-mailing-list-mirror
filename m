From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/7] Bisect: fix some white spaces and empty lines
 breakages.
Date: Sun, 14 Oct 2007 14:29:07 +0200
Message-ID: <20071014142907.b457c0c7.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 14:22:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih2U5-00010g-Lw
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 14:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbXJNMWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 08:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755703AbXJNMWF
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 08:22:05 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:39069 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755761AbXJNMWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 08:22:04 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id DECDA1AB2DF;
	Sun, 14 Oct 2007 14:22:01 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id A4AE51AB2E8;
	Sun, 14 Oct 2007 14:22:01 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60836>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 388887a..436ccf6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -64,7 +64,7 @@ bisect_start() {
 		    branch=`cat "$GIT_DIR/head-name"`
 		else
 		    branch=master
-	        fi
+		fi
 		git checkout $branch || exit
 		;;
 	refs/heads/*)
@@ -95,11 +95,11 @@ bisect_start() {
 	    arg="$1"
 	    case "$arg" in
 	    --)
-	        shift
+		shift
 		break
 		;;
 	    *)
-	        rev=$(git rev-parse --verify "$arg^{commit}" 2>/dev/null) || {
+		rev=$(git rev-parse --verify "$arg^{commit}" 2>/dev/null) || {
 		    test $has_double_dash -eq 1 &&
 		        die "'$arg' does not appear to be a valid revision"
 		    break
@@ -110,10 +110,10 @@ bisect_start() {
 		else
 		    bisect_write_good "$rev"
 		fi
-	        shift
+		shift
 		;;
 	    esac
-        done
+	done
 
 	sq "$@" >"$GIT_DIR/BISECT_NAMES"
 	echo "git-bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG"
@@ -143,7 +143,7 @@ bisect_write_bad() {
 
 bisect_good() {
 	bisect_autostart
-        case "$#" in
+	case "$#" in
 	0)    revs=$(git rev-parse --verify HEAD) || exit ;;
 	*)    revs=$(git rev-parse --revs-only --no-flags "$@") &&
 		test '' != "$revs" || die "Bad rev input: $@" ;;
@@ -153,7 +153,6 @@ bisect_good() {
 		rev=$(git rev-parse --verify "$rev^{commit}") || exit
 		bisect_write_good "$rev"
 		echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
-
 	done
 	bisect_auto_next
 }
@@ -207,7 +206,7 @@ bisect_auto_next() {
 }
 
 bisect_next() {
-        case "$#" in 0) ;; *) usage ;; esac
+	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
 	bisect_next_check good
 
@@ -255,7 +254,7 @@ bisect_reset() {
 	       exit 1
 	   }
 	   branch="$1" ;;
-        *)
+	*)
 	    usage ;;
 	esac
 	if git checkout "$branch"; then
-- 
1.5.3.4.213.g68ad5
