From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] correct a few doubled-word nits in comments and documentation
Date: Wed, 28 Mar 2012 18:21:13 +0200
Message-ID: <878viku26e.fsf@rho.meyering.net>
References: <87d37xun9r.fsf@rho.meyering.net>
	<7vty18wweh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 18:21:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCvcn-00069o-Ox
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 18:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758462Ab2C1QVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 12:21:24 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:47647 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758421Ab2C1QVX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 12:21:23 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id C5F70D4808A
	for <git@vger.kernel.org>; Wed, 28 Mar 2012 18:21:15 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id E7C9260064;
	Wed, 28 Mar 2012 18:21:13 +0200 (CEST)
In-Reply-To: <7vty18wweh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 28 Mar 2012 08:57:42 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194143>


Found by running this command:
$ git ls-files -z|xargs -0 perl -0777 -n \
 -e 'while (/\b(then?|[iao]n|i[fst]|but|f?or|at|and|[dt]o)\s+\1\b/gims)' \
 -e '  {' \
 -e '    $n = ($` =~ tr/\n/\n/ + 1);' \
 -e '    ($v = $&) =~ s/\n/\\n/g;' \
 -e '    print "$ARGV:$n:$v\n";' \
 -e '  }'

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
> Thanks; by the way, you have an extra patch message concatenated after
> the main one.

Sorry about that.  In case it helps, here's a better version.


 Documentation/git-sh-i18n--envsubst.txt |    2 +-
 attr.h                                  |    2 +-
 gitweb/static/js/lib/cookies.js         |    2 +-
 po/README                               |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-sh-i18n--envsubst.txt b/Documentation/git-sh-i18n--envsubst.txt
index 5c3ec32..2ffaf93 100644
--- a/Documentation/git-sh-i18n--envsubst.txt
+++ b/Documentation/git-sh-i18n--envsubst.txt
@@ -25,7 +25,7 @@ plumbing scripts and/or are writing new ones.
 'git sh-i18n{litdd}envsubst' is Git's stripped-down copy of the GNU
 `envsubst(1)` program that comes with the GNU gettext package. It's
 used internally by linkgit:git-sh-i18n[1] to interpolate the variables
-passed to the the `eval_gettext` function.
+passed to the `eval_gettext` function.

 No promises are made about the interface, or that this
 program won't disappear without warning in the next version
diff --git a/attr.h b/attr.h
index eb8ca0d..dea590a 100644
--- a/attr.h
+++ b/attr.h
@@ -40,7 +40,7 @@ int git_check_attr(const char *path, int, struct git_attr_check *);

 /*
  * Retrieve all attributes that apply to the specified path.  *num
- * will be set the the number of attributes on the path; **check will
+ * will be set the number of attributes on the path; **check will
  * be set to point at a newly-allocated array of git_attr_check
  * objects describing the attributes and their values.  *check must be
  * free()ed by the caller.
diff --git a/gitweb/static/js/lib/cookies.js b/gitweb/static/js/lib/cookies.js
index 72b51cd..66b9a07 100644
--- a/gitweb/static/js/lib/cookies.js
+++ b/gitweb/static/js/lib/cookies.js
@@ -30,7 +30,7 @@
  *                            If a negative value is specified or a date in the past),
  *                            the cookie will be deleted.
  *                            If set to null or omitted, the cookie will be a session cookie
- *                            and will not be retained when the the browser exits.
+ *                            and will not be retained when the browser exits.
  * @param {String} [options.path] Restrict access of a cookie to particular directory
  *                               (default: path of page that created the cookie).
  * @param {String} [options.domain] Override what web sites are allowed to access cookie
diff --git a/po/README b/po/README
index 188ea2c..c1520e8 100644
--- a/po/README
+++ b/po/README
@@ -178,7 +178,7 @@ used:

 C:

- - Include builtin.h at the top, it'll pull in in gettext.h, which
+ - Include builtin.h at the top, it'll pull in gettext.h, which
    defines the gettext interface. Consult with the list if you need to
    use gettext.h directly.

--
1.7.9.3
