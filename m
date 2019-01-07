Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5121F803
	for <e@80x24.org>; Mon,  7 Jan 2019 19:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfAGTXQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 7 Jan 2019 14:23:16 -0500
Received: from mut-mta1-se01b-zose1-rescue-fr.yulpa.io ([185.49.22.249]:34604
        "EHLO mut-mta1-se01b-zose1-rescue-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbfAGTXP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Jan 2019 14:23:15 -0500
X-Greylist: delayed 5584 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jan 2019 14:23:12 EST
Received: from mut-zose1-mta-hub-out01-fr.yulpa.io ([185.49.20.54] helo=mut-zose1-mta-hub-outmua01b-fr.yulpa.io)
        by mut-mta1-se01a-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <git@matthieu-moy.fr>)
        id 1ggZ1o-000TWV-IG; Mon, 07 Jan 2019 18:49:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTP id 8071B102031;
        Mon,  7 Jan 2019 18:49:29 +0100 (CET)
Received: from mut-zose1-mta-hub-outmua01b-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outmua01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3YYlu0W5tyce; Mon,  7 Jan 2019 18:49:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTP id 9C9B8102038;
        Mon,  7 Jan 2019 18:49:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at mut-zose1.yulpa.io
Received: from mut-zose1-mta-hub-outmua01b-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outmua01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zyb_ZETXoPJB; Mon,  7 Jan 2019 18:49:27 +0100 (CET)
Received: from moylip.univ-lyon1.fr (209.56.68.91.rev.sfr.net [91.68.56.209])
        (Authenticated sender: matthieu.moy@matthieu-moy.fr)
        by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTPSA id 7E1D5102031;
        Mon,  7 Jan 2019 18:49:21 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Matthieu Moy <git@matthieu-moy.fr>,
        William Stewart <william.stewart@booking.com>,
        =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>,
        Dirk Olmes <dirk.olmes@codedo.de>,
        =?UTF-8?q?Bj=C3=B6rn=20Kautler?= <Bjoern@Kautler.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Gareth Pye <garethp@gpsatsys.com.au>,
        David Lazar <lazard@csail.mit.edu>
Subject: [PATCH] git-multimail: update to release 1.5.0
Date:   Mon,  7 Jan 2019 18:48:38 +0100
Message-Id: <20190107174838.9078-1-git@matthieu-moy.fr>
X-Mailer: git-send-email 2.20.1.98.gecbdaf0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: 185.49.20.54
X-yulPa-Domain: mut-zose1.yulpa.io
X-yulPa-Username: 185.49.20.54
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.54@mut-zose1.yulpa.io
X-yulPa-Outgoing-Class: ham
X-yulPa-Outgoing-Evidence: SB/global_tokens (3.70969621047e-05)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5kSZVM1WUzB+qwiIR/Jy1+F602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOyjGjt6koVZwtYs9iReWoZydbif7G/123Q8k7GKxT31D5OTfdEgfcqepQMGJZqyGSs7z
 cbWxzj7Y+7KGHOS4WyjPWYG7djF9O2UN7zwBvOVpseRZgPZR8JnQLe3NYt8g8T/ystfUYSUqMCGZ
 DMMI35ULWlWJb1PVpH9nUkRHY41xCzWK2q3YKYcr0yt8e6mQP30Qj05cDgXGYdwyq279PNi9Gy55
 pziEz3ZE7QAjtEstHg1629f5BpMxExx5BHO3tJlUthEBUwsIrR5iHIquXHsUFu+PMn4g1JEKXegU
 LNWCZrXj9qUnavnThq66306vOG46BUGv78GepwjPoeBxbdQEybI1sOftHmSKUCHCvcq04/7fwzyJ
 FlgwbsEiDPvBk1HSaVHScXJs1lSTWVymGNJnv2WgVYazpoeNQn2Hs1VCsi+5m7mmEWZZyR13gEsl
 HyBqflY7HU0pbqzl3Wk1+b5hZyXrKRBPYViuIbpKWhIxTUL6AuWRVvY3OxpnHH+HwgCMjUk1lauH
 Wb4nrj0TFEwRxj25oEPwKMRd0zxd/9oPCtnID9h/I5rd6RaRmcUWaT838XldXNA+GUQJCYeapDRH
 BQQL7n9+OTZ37LZfI/sWvLeYVKhfH1erQ4K/EGECITjFWGCFnUnNAZETtAGp7MvY2dgVhFBmmtik
 er54swgmlskAQwbuPSuoQTCn5wyWwFrG8ZcFpIGp1RsIqUapFD14rR9AqkoQmEeYR3NBaCwmcxw3
 qqhc+N6cuEg4XWh5Fuvpme4gANZFnM+PFEg48jRuy1ZbSSIShnyGIfBDlewm56wFsZ1H6qXCuIez
 AtA4P+ssGffrLwCxwS8SaDgSwk+IGD9oDGSD7sHtJVz5TyHrAh6iP3PCo1InPxIeYJn5vEIscsPw
 zUACJ0dbTyQp6gWIRO5D0MABG5gZ5j9nLffDAlwffQ3RP/KIOAH4sfA9mQSqS+Soiz4WQqfDFH3c
 FPU70YRXd8Qof1K7XQP1vlOsluGMFzUuOSfCasyp/QAJmsR0m4ij2q4IHQvkvPNyHvkTJwLfRNdx
 T9IlbtQbfcrxfqb5R4VemuUI6bcEARsm0MZ9QdIceBvomhS9t+3G86glF4NXcAJ3szZf1ikD+sWA
 IjK8JS6k7vN1r75Fkv0cKgq2JkkUd2dtm7QKNgZc7+Gu2wbIzHYo2XsgxNxAoC99KyEiG/wG2UXk
 fTg2WGnyd8eYkose/c+g/lAAhNa7UYKDUizUEG3XJh64gXwEFM+l9jihx+Za/cV70jOJzN2r4A==
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes are described in CHANGES.

Contributions-by: Matthieu Moy <git@matthieu-moy.fr>
Contributions-by: William Stewart <william.stewart@booking.com>
Contributions-by: Ville Skyttä <ville.skytta@iki.fi>
Contributions-by: Dirk Olmes <dirk.olmes@codedo.de>
Contributions-by: Björn Kautler <Bjoern@Kautler.net>
Contributions-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Contributions-by: Gareth Pye <garethp@gpsatsys.com.au>
Contributions-by: David Lazar <lazard@csail.mit.edu>
Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
---

A very long time since I did a git-multimail release, sorry for the
lack of activity on this project. OTOH, there have not been many
pull-requests nor feature requests, which may be a sign that the
project reached some kind of maturity.

Help is welcome if some people would like to see git-multimail evolve
faster.

 contrib/hooks/multimail/CHANGES               |  56 ++++++
 contrib/hooks/multimail/CONTRIBUTING.rst      |  28 ++-
 contrib/hooks/multimail/README.Git            |   4 +-
 .../hooks/multimail/{README => README.rst}    |  38 +++-
 contrib/hooks/multimail/doc/gitolite.rst      |   9 +
 contrib/hooks/multimail/git_multimail.py      | 188 ++++++++++++++----
 .../hooks/multimail/migrate-mailhook-config   |  13 +-
 contrib/hooks/multimail/post-receive.example  |   2 +-
 8 files changed, 281 insertions(+), 57 deletions(-)
 rename contrib/hooks/multimail/{README => README.rst} (95%)

diff --git a/contrib/hooks/multimail/CHANGES b/contrib/hooks/multimail/CHANGES
index 2076cf972b..35791fd02c 100644
--- a/contrib/hooks/multimail/CHANGES
+++ b/contrib/hooks/multimail/CHANGES
@@ -1,3 +1,59 @@
+Release 1.5.0
+=============
+
+Backward-incompatible change
+----------------------------
+
+The name of classes for environment was misnamed as `*Environement`.
+It is now `*Environment`.
+
+New features
+------------
+
+* A Thread-Index header is now added to each email sent (except for
+  combined emails where it would not make sense), so that MS Outlook
+  properly groups messages by threads even though they have a
+  different subject line. Unfortunately, even adding this header the
+  threading still seems to be unreliable, but it is unclear whether
+  this is an issue on our side or on MS Outlook's side (see discussion
+  here: https://github.com/git-multimail/git-multimail/pull/194).
+
+* A new variable multimailhook.ExcludeMergeRevisions was added to send
+  notification emails only for non-merge commits.
+
+* For gitolite environment, it is now possible to specify the mail map
+  in a separate file in addition to gitolite.conf, using the variable
+  multimailhook.MailaddressMap.
+
+Internal changes
+----------------
+
+* The testsuite now uses GIT_PRINT_SHA1_ELLIPSIS where needed for
+  compatibility with recent Git versions. Only tests are affected.
+
+* We don't try to install pyflakes in the continuous integration job
+  for old Python versions where it's no longer available.
+
+* Stop using the deprecated cgi.escape in Python 3.
+
+* New flake8 warnings have been fixed.
+
+* Python 3.6 is now tested against on Travis-CI.
+
+* A bunch of lgtm.com warnings have been fixed.
+
+Bug fixes
+---------
+
+* SMTPMailer logs in only once now. It used to re-login for each email
+  sent which triggered errors for some SMTP servers.
+
+* migrate-mailhook-config was broken by internal refactoring, it
+  should now work again.
+
+This version was tested with Python 2.6 to 3.7. It was tested with Git
+1.7.10.406.gdc801, 2.15.1 and 2.20.1.98.gecbdaf0.
+
 Release 1.4.0
 =============
 
diff --git a/contrib/hooks/multimail/CONTRIBUTING.rst b/contrib/hooks/multimail/CONTRIBUTING.rst
index da65570e9b..de20a54287 100644
--- a/contrib/hooks/multimail/CONTRIBUTING.rst
+++ b/contrib/hooks/multimail/CONTRIBUTING.rst
@@ -4,9 +4,8 @@ Contributing
 git-multimail is an open-source project, built by volunteers. We would
 welcome your help!
 
-The current maintainers are Matthieu Moy
-<matthieu.moy@grenoble-inp.fr> and Michael Haggerty
-<mhagger@alum.mit.edu>.
+The current maintainers are `Matthieu Moy <http://matthieu-moy.fr>`__ and
+`Michael Haggerty <https://github.com/mhagger>`__.
 
 Please note that although a copy of git-multimail is distributed in
 the "contrib" section of the main Git project, development takes place
@@ -33,6 +32,29 @@ mailing list`_.
 Please CC emails regarding git-multimail to the maintainers so that we
 don't overlook them.
 
+Help needed: testers/maintainer for specific environments/OS
+------------------------------------------------------------
+
+The current maintainer uses and tests git-multimail on Linux with the
+Generic environment. More testers, or better contributors are needed
+to test git-multimail on other real-life setups:
+
+* Mac OS X, Windows: git-multimail is currently not supported on these
+  platforms. But since we have no external dependencies and try to
+  write code as portable as possible, it is possible that
+  git-multimail already runs there and if not, it is likely that it
+  could be ported easily.
+
+  Patches to improve support for Windows and OS X are welcome.
+  Ideally, there would be a sub-maintainer for each OS who would test
+  at least once before each release (around twice a year).
+
+* Gerrit, Stash, Gitolite environments: although the testsuite
+  contains tests for these environments, a tester/maintainer for each
+  environment would be welcome to test and report failure (or success)
+  on real-life environments periodically (here also, feedback before
+  each release would be highly appreciated).
+
 
 .. _`git-multimail repository on GitHub`: https://github.com/git-multimail/git-multimail
 .. _`Git mailing list`: git@vger.kernel.org
diff --git a/contrib/hooks/multimail/README.Git b/contrib/hooks/multimail/README.Git
index 161b0230a0..044444245d 100644
--- a/contrib/hooks/multimail/README.Git
+++ b/contrib/hooks/multimail/README.Git
@@ -6,10 +6,10 @@ website:
     https://github.com/git-multimail/git-multimail
 
 The version in this directory was obtained from the upstream project
-on August 17 2016 and consists of the "git-multimail" subdirectory from
+on January 07 2019 and consists of the "git-multimail" subdirectory from
 revision
 
-    07b1cb6bfd7be156c62e1afa17cae13b850a869f refs/tags/1.4.0
+    04e80e6c40be465cc62b6c246f0fcb8fd2cfd454 refs/tags/1.5.0
 
 Please see the README file in this directory for information about how
 to report bugs or contribute to git-multimail.
diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README.rst
similarity index 95%
rename from contrib/hooks/multimail/README
rename to contrib/hooks/multimail/README.rst
index 5105373aea..7c0fc4a6ef 100644
--- a/contrib/hooks/multimail/README
+++ b/contrib/hooks/multimail/README.rst
@@ -1,4 +1,4 @@
-git-multimail version 1.4.0
+git-multimail version 1.5.0
 ===========================
 
 .. image:: https://travis-ci.org/git-multimail/git-multimail.svg?branch=master
@@ -20,8 +20,8 @@ GPLv2 (see the COPYING file for details).
 
 Please note: although, as a convenience, git-multimail may be
 distributed along with the main Git project, development of
-git-multimail takes place in its own, separate project.  See section
-"Getting involved" below for more information.
+git-multimail takes place in its own, separate project.  Please, read
+`<CONTRIBUTING.rst>`__ for more information.
 
 
 By default, for each push received by the repository, git-multimail:
@@ -89,6 +89,10 @@ Requirements
   the multimailhook.mailer configuration variable below for how to
   configure git-multimail to send emails via an SMTP server.
 
+* git-multimail is currently tested only on Linux. It may or may not
+  work on other platforms such as Windows and Mac OS. See
+  `<CONTRIBUTING.rst>`__ to improve the situation.
+
 
 Invocation
 ----------
@@ -369,7 +373,7 @@ multimailhook.mailer
         unset, then the value of multimailhook.from is used.
 
       multimailhook.smtpServerTimeout
-        Timeout in seconds.
+        Timeout in seconds. Default is 10.
 
       multimailhook.smtpEncryption
         Set the security type. Allowed values: ``none``, ``ssl``, ``tls`` (starttls).
@@ -419,8 +423,20 @@ multimailhook.from, multimailhook.fromCommit, multimailhook.fromRefchange
     If config values are unset, the value of the From: header is
     determined as follows:
 
-    1. (gitolite environment only) Parse gitolite.conf, looking for a
-       block of comments that looks like this::
+    1. (gitolite environment only)
+       1.a) If ``multimailhook.MailaddressMap`` is set, and is a path
+       to an existing file (if relative, it is considered relative to
+       the place where ``gitolite.conf`` is located), then this file
+       should contain lines like::
+
+           username Firstname Lastname <email@example.com>
+
+       git-multimail will then look for a line where ``$GL_USER``
+       matches the ``username`` part, and use the rest of the line for
+       the ``From:`` header.
+
+       1.b) Parse gitolite.conf, looking for a block of comments that
+       looks like this::
 
            # BEGIN USER EMAILS
            # username Firstname Lastname <email@example.com>
@@ -436,6 +452,11 @@ multimailhook.from, multimailhook.fromCommit, multimailhook.fromRefchange
 
     3. Use the value of multimailhook.envelopeSender.
 
+multimailhook.MailaddressMap
+    (gitolite environment only)
+    File to look for a ``From:`` address based on the user doing the
+    push. Defaults to unset. See ``multimailhook.from`` for details.
+
 multimailhook.administrator
     The name and/or email address of the administrator of the Git
     repository; used in FOOTER_TEMPLATE.  Default is
@@ -484,6 +505,11 @@ multimailhook.maxCommitEmails
     mailbombing, for example on an initial push.  To disable commit
     emails limit, set this option to 0.  The default is 500.
 
+multimailhook.excludeMergeRevisions
+    When sending out revision emails, do not consider merge commits (the
+    functional equivalent of `rev-list --no-merges`).
+    The default is `false` (send merge commit emails).
+
 multimailhook.emailStrictUTF8
     If this boolean option is set to `true`, then the main part of the
     email body is forced to be valid UTF-8.  Any characters that are
diff --git a/contrib/hooks/multimail/doc/gitolite.rst b/contrib/hooks/multimail/doc/gitolite.rst
index 00aedd9c57..5054833105 100644
--- a/contrib/hooks/multimail/doc/gitolite.rst
+++ b/contrib/hooks/multimail/doc/gitolite.rst
@@ -46,6 +46,15 @@ and add::
       config multimailhook.mailingList = # Where emails should be sent
       config multimailhook.from = # From address to use
 
+Note that by default, gitolite forbids ``<`` and ``>`` in variable
+values (for security/paranoia reasons, see
+`compensating for UNSAFE_PATT
+<http://gitolite.com/gitolite/git-config/index.html#compensating-for-unsafe95patt>`__
+in gitolite's documentation for explanations and a way to disable
+this). As a consequence, you will not be able to use ``First Last
+<First.Last@example.com>`` as recipient email, but specifying
+``First.Last@example.com`` alone works.
+
 Obviously, you can customize all parameters on a per-repository basis by
 adding these ``config multimailhook.*`` lines in the section
 corresponding to a repository or set of repositories.
diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/multimail/git_multimail.py
index 73fdda6b14..8823399e75 100755
--- a/contrib/hooks/multimail/git_multimail.py
+++ b/contrib/hooks/multimail/git_multimail.py
@@ -1,6 +1,6 @@
 #! /usr/bin/env python
 
-__version__ = '1.4.0'
+__version__ = '1.5.0'
 
 # Copyright (c) 2015-2016 Matthieu Moy and others
 # Copyright (c) 2012-2014 Michael Haggerty and others
@@ -64,7 +64,9 @@
     # Python < 2.6 do not have ssl, but that's OK if we don't use it.
     pass
 import time
-import cgi
+
+import uuid
+import base64
 
 PYTHON3 = sys.version_info >= (3, 0)
 
@@ -73,7 +75,7 @@ def all(iterable):
         for element in iterable:
             if not element:
                 return False
-            return True
+        return True
 
 
 def is_ascii(s):
@@ -108,6 +110,12 @@ def read_line(f):
             return out.decode(sys.getdefaultencoding())
         except UnicodeEncodeError:
             return out.decode(ENCODING)
+
+    import html
+
+    def html_escape(s):
+        return html.escape(s)
+
 else:
     def is_string(s):
         try:
@@ -130,6 +138,10 @@ def read_line(f):
     def next(it):
         return it.next()
 
+    import cgi
+
+    def html_escape(s):
+        return cgi.escape(s, True)
 
 try:
     from email.charset import Charset
@@ -190,6 +202,7 @@ def next(it):
 Message-ID: %(msgid)s
 From: %(fromaddr)s
 Reply-To: %(reply_to)s
+Thread-Index: %(thread_index)s
 X-Git-Host: %(fqdn)s
 X-Git-Repo: %(repo_shortname)s
 X-Git-Refname: %(refname)s
@@ -322,6 +335,7 @@ def next(it):
 Reply-To: %(reply_to)s
 In-Reply-To: %(reply_to_msgid)s
 References: %(reply_to_msgid)s
+Thread-Index: %(thread_index)s
 X-Git-Host: %(fqdn)s
 X-Git-Repo: %(repo_shortname)s
 X-Git-Refname: %(refname)s
@@ -763,6 +777,9 @@ def get_summary(self):
     def __eq__(self, other):
         return isinstance(other, GitObject) and self.sha1 == other.sha1
 
+    def __ne__(self, other):
+        return not self == other
+
     def __hash__(self):
         return hash(self.sha1)
 
@@ -852,7 +869,7 @@ def expand_lines(self, template, html_escape_val=False, **extra_values):
         if html_escape_val:
             for k in values:
                 if is_string(values[k]):
-                    values[k] = cgi.escape(values[k], True)
+                    values[k] = html_escape(values[k])
         for line in template.splitlines(True):
             yield line % values
 
@@ -909,7 +926,7 @@ def generate_email_intro(self, html_escape_val=False):
 
         raise NotImplementedError()
 
-    def generate_email_body(self):
+    def generate_email_body(self, push):
         """Generate the main part of the email body, a line at a time.
 
         The text in the body might be truncated after a specified
@@ -936,7 +953,7 @@ def _wrap_for_html(self, lines):
             yield "<pre style='margin:0'>\n"
 
             for line in lines:
-                yield cgi.escape(line)
+                yield html_escape(line)
 
             yield '</pre>\n'
         else:
@@ -1011,7 +1028,7 @@ def generate_email(self, push, body_filter=None, extra_header_values={}):
                     fgcolor = '404040'
 
                 # Chop the trailing LF, we don't want it inside <pre>.
-                line = cgi.escape(line[:-1])
+                line = html_escape(line[:-1])
 
                 if bgcolor or fgcolor:
                     style = 'display:block; white-space:pre;'
@@ -1060,6 +1077,10 @@ def __init__(self, reference_change, rev, num, tot):
         self.author = read_git_output(['log', '--no-walk', '--format=%aN <%aE>', self.rev.sha1])
         self.recipients = self.environment.get_revision_recipients(self)
 
+        # -s is short for --no-patch, but -s works on older git's (e.g. 1.7)
+        self.parents = read_git_lines(['show', '-s', '--format=%P',
+                                      self.rev.sha1])[0].split()
+
         self.cc_recipients = ''
         if self.environment.get_scancommitforcc():
             self.cc_recipients = ', '.join(to.strip() for to in self._cc_recipients())
@@ -1090,6 +1111,7 @@ def _compute_values(self):
             oneline = oneline[:max_subject_length - 6] + ' [...]'
 
         values['rev'] = self.rev.sha1
+        values['parents'] = ' '.join(self.parents)
         values['rev_short'] = self.rev.short
         values['change_type'] = self.change_type
         values['refname'] = self.refname
@@ -1097,6 +1119,7 @@ def _compute_values(self):
         values['short_refname'] = self.reference_change.short_refname
         values['refname_type'] = self.reference_change.refname_type
         values['reply_to_msgid'] = self.reference_change.msgid
+        values['thread_index'] = self.reference_change.thread_index
         values['num'] = self.num
         values['tot'] = self.tot
         values['recipients'] = self.recipients
@@ -1244,6 +1267,23 @@ def create(environment, oldrev, newrev, refname):
             old=old, new=new, rev=rev,
             )
 
+    @staticmethod
+    def make_thread_index():
+        """Return a string appropriate for the Thread-Index header,
+        needed by MS Outlook to get threading right.
+
+        The format is (base64-encoded):
+        - 1 byte must be 1
+        - 5 bytes encode a date (hardcoded here)
+        - 16 bytes for a globally unique identifier
+
+        FIXME: Unfortunately, even with the Thread-Index field, MS
+        Outlook doesn't seem to do the threading reliably (see
+        https://github.com/git-multimail/git-multimail/pull/194).
+        """
+        thread_index = b'\x01\x00\x00\x12\x34\x56' + uuid.uuid4().bytes
+        return base64.standard_b64encode(thread_index).decode('ascii')
+
     def __init__(self, environment, refname, short_refname, old, new, rev):
         Change.__init__(self, environment)
         self.change_type = {
@@ -1257,6 +1297,7 @@ def __init__(self, environment, refname, short_refname, old, new, rev):
         self.new = new
         self.rev = rev
         self.msgid = make_msgid()
+        self.thread_index = self.make_thread_index()
         self.diffopts = environment.diffopts
         self.graphopts = environment.graphopts
         self.logopts = environment.logopts
@@ -1276,6 +1317,7 @@ def _compute_values(self):
         values['refname'] = self.refname
         values['short_refname'] = self.short_refname
         values['msgid'] = self.msgid
+        values['thread_index'] = self.thread_index
         values['recipients'] = self.recipients
         values['oldrev'] = str(self.old)
         values['oldrev_short'] = self.old.short
@@ -1941,6 +1983,9 @@ class Mailer(object):
     def __init__(self, environment):
         self.environment = environment
 
+    def close(self):
+        pass
+
     def send(self, lines, to_addrs):
         """Send an email consisting of lines.
 
@@ -2054,6 +2099,7 @@ def __init__(self, environment,
         self.username = smtpuser
         self.password = smtppass
         self.smtpcacerts = smtpcacerts
+        self.loggedin = False
         try:
             def call(klass, server, timeout):
                 try:
@@ -2130,20 +2176,30 @@ def call(klass, server, timeout):
                 % (self.smtpserver, sys.exc_info()[1]))
             sys.exit(1)
 
-    def __del__(self):
+    def close(self):
         if hasattr(self, 'smtp'):
             self.smtp.quit()
             del self.smtp
 
+    def __del__(self):
+        self.close()
+
     def send(self, lines, to_addrs):
         try:
             if self.username or self.password:
-                self.smtp.login(self.username, self.password)
+                if not self.loggedin:
+                    self.smtp.login(self.username, self.password)
+                    self.loggedin = True
             msg = ''.join(lines)
             # turn comma-separated list into Python list if needed.
             if is_string(to_addrs):
                 to_addrs = [email for (name, email) in getaddresses([to_addrs])]
             self.smtp.sendmail(self.envelopesender, to_addrs, msg)
+        except socket.timeout:
+            self.environment.get_logger().error(
+                '*** Error sending email ***\n'
+                '*** SMTP server timed out (timeout is %s)\n'
+                % self.smtpservertimeout)
         except smtplib.SMTPResponseException:
             err = sys.exc_info()[1]
             self.environment.get_logger().error(
@@ -2171,7 +2227,8 @@ class OutputMailer(Mailer):
 
     SEPARATOR = '=' * 75 + '\n'
 
-    def __init__(self, f):
+    def __init__(self, f, environment=None):
+        super(OutputMailer, self).__init__(environment=environment)
         self.f = f
 
     def send(self, lines, to_addrs):
@@ -2382,6 +2439,7 @@ def __init__(self, osenv=None):
         self.html_in_footer = False
         self.commitBrowseURL = None
         self.maxcommitemails = 500
+        self.excludemergerevisions = False
         self.diffopts = ['--stat', '--summary', '--find-copies-harder']
         self.graphopts = ['--oneline', '--decorate']
         self.logopts = []
@@ -2621,6 +2679,8 @@ def __init__(self, config, **kw):
 
         self.commitBrowseURL = config.get('commitBrowseURL')
 
+        self.excludemergerevisions = config.get('excludeMergeRevisions')
+
         maxcommitemails = config.get('maxcommitemails')
         if maxcommitemails is not None:
             try:
@@ -3152,7 +3212,10 @@ def get_pusher(self):
         return self.osenv.get('GL_USER', 'unknown user')
 
 
-class GitoliteEnvironmentLowPrecMixin(Environment):
+class GitoliteEnvironmentLowPrecMixin(
+        ConfigEnvironmentMixin,
+        Environment):
+
     def get_repo_shortname(self):
         # The gitolite environment variable $GL_REPO is a pretty good
         # repo_shortname (though it's probably not as good as a value
@@ -3162,6 +3225,16 @@ def get_repo_shortname(self):
             super(GitoliteEnvironmentLowPrecMixin, self).get_repo_shortname()
             )
 
+    @staticmethod
+    def _compile_regex(re_template):
+        return (
+            re.compile(re_template % x)
+            for x in (
+                r'BEGIN\s+USER\s+EMAILS',
+                r'([^\s]+)\s+(.*)',
+                r'END\s+USER\s+EMAILS',
+                ))
+
     def get_fromaddr(self, change=None):
         GL_USER = self.osenv.get('GL_USER')
         if GL_USER is not None:
@@ -3174,18 +3247,42 @@ def get_fromaddr(self, change=None):
             GL_CONF = self.osenv.get(
                 'GL_CONF',
                 os.path.join(GL_ADMINDIR, 'conf', 'gitolite.conf'))
+
+            mailaddress_map = self.config.get('MailaddressMap')
+            # If relative, consider relative to GL_CONF:
+            if mailaddress_map:
+                mailaddress_map = os.path.join(os.path.dirname(GL_CONF),
+                                               mailaddress_map)
+                if os.path.isfile(mailaddress_map):
+                    f = open(mailaddress_map, 'rU')
+                    try:
+                        # Leading '#' is optional
+                        re_begin, re_user, re_end = self._compile_regex(
+                            r'^(?:\s*#)?\s*%s\s*$')
+                        for l in f:
+                            l = l.rstrip('\n')
+                            if re_begin.match(l) or re_end.match(l):
+                                continue  # Ignore these lines
+                            m = re_user.match(l)
+                            if m:
+                                if m.group(1) == GL_USER:
+                                    return m.group(2)
+                                else:
+                                    continue  # Not this user, but not an error
+                            raise ConfigurationException(
+                                "Syntax error in mail address map.\n"
+                                "Check file {}.\n"
+                                "Line: {}".format(mailaddress_map, l))
+
+                    finally:
+                        f.close()
+
             if os.path.isfile(GL_CONF):
                 f = open(GL_CONF, 'rU')
                 try:
                     in_user_emails_section = False
-                    re_template = r'^\s*#\s*%s\s*$'
-                    re_begin, re_user, re_end = (
-                        re.compile(re_template % x)
-                        for x in (
-                            r'BEGIN\s+USER\s+EMAILS',
-                            re.escape(GL_USER) + r'\s+(.*)',
-                            r'END\s+USER\s+EMAILS',
-                            ))
+                    re_begin, re_user, re_end = self._compile_regex(
+                        r'^\s*#\s*%s\s*$')
                     for l in f:
                         l = l.rstrip('\n')
                         if not in_user_emails_section:
@@ -3195,8 +3292,8 @@ def get_fromaddr(self, change=None):
                         if re_end.match(l):
                             break
                         m = re_user.match(l)
-                        if m:
-                            return m.group(1)
+                        if m and m.group(1) == GL_USER:
+                            return m.group(2)
                 finally:
                     f.close()
         return super(GitoliteEnvironmentLowPrecMixin, self).get_fromaddr(change)
@@ -3228,7 +3325,7 @@ def __init__(self, user=None, repo=None, **kw):
         self.__repo = repo
 
     def get_pusher(self):
-        return re.match('(.*?)\s*<', self.__user).group(1)
+        return re.match(r'(.*?)\s*<', self.__user).group(1)
 
     def get_pusher_email(self):
         return self.__user
@@ -3262,7 +3359,7 @@ def get_pusher(self):
             if self.__submitter.find('<') != -1:
                 # Submitter has a configured email, we transformed
                 # __submitter into an RFC 2822 string already.
-                return re.match('(.*?)\s*<', self.__submitter).group(1)
+                return re.match(r'(.*?)\s*<', self.__submitter).group(1)
             else:
                 # Submitter has no configured email, it's just his name.
                 return self.__submitter
@@ -3615,6 +3712,9 @@ def send_emails(self, mailer, body_filter=None):
 
             for (num, sha1) in enumerate(sha1s):
                 rev = Revision(change, GitObject(sha1), num=num + 1, tot=len(sha1s))
+                if len(rev.parents) > 1 and change.environment.excludemergerevisions:
+                    # skipping a merge commit
+                    continue
                 if not rev.recipients and rev.cc_recipients:
                     change.environment.log_msg('*** Replacing Cc: with To:')
                     rev.recipients = rev.cc_recipients
@@ -3664,11 +3764,14 @@ def run_as_post_receive_hook(environment, mailer):
         changes.append(
             ReferenceChange.create(environment, oldrev, newrev, refname)
             )
-    if changes:
-        push = Push(environment, changes)
+    if not changes:
+        mailer.close()
+        return
+    push = Push(environment, changes)
+    try:
         push.send_emails(mailer, body_filter=environment.filter_body)
-    if hasattr(mailer, '__del__'):
-        mailer.__del__()
+    finally:
+        mailer.close()
 
 
 def run_as_update_hook(environment, mailer, refname, oldrev, newrev, force_send=False):
@@ -3687,10 +3790,14 @@ def run_as_update_hook(environment, mailer, refname, oldrev, newrev, force_send=
             refname,
             ),
         ]
+    if not changes:
+        mailer.close()
+        return
     push = Push(environment, changes, force_send)
-    push.send_emails(mailer, body_filter=environment.filter_body)
-    if hasattr(mailer, '__del__'):
-        mailer.__del__()
+    try:
+        push.send_emails(mailer, body_filter=environment.filter_body)
+    finally:
+        mailer.close()
 
 
 def check_ref_filter(environment):
@@ -3860,7 +3967,7 @@ def build_environment_klass(env_name):
         low_prec_mixin = known_env['lowprec']
         environment_mixins.append(low_prec_mixin)
     environment_mixins.append(Environment)
-    klass_name = env_name.capitalize() + 'Environement'
+    klass_name = env_name.capitalize() + 'Environment'
     environment_klass = type(
         klass_name,
         tuple(environment_mixins),
@@ -4057,21 +4164,21 @@ def flush(self):
                 environment, 'git_multimail.error', environment.error_log_file, logging.ERROR)
             self.loggers.append(error_log_file)
 
-    def info(self, msg):
+    def info(self, msg, *args, **kwargs):
         for l in self.loggers:
-            l.info(msg)
+            l.info(msg, *args, **kwargs)
 
-    def debug(self, msg):
+    def debug(self, msg, *args, **kwargs):
         for l in self.loggers:
-            l.debug(msg)
+            l.debug(msg, *args, **kwargs)
 
-    def warning(self, msg):
+    def warning(self, msg, *args, **kwargs):
         for l in self.loggers:
-            l.warning(msg)
+            l.warning(msg, *args, **kwargs)
 
-    def error(self, msg):
+    def error(self, msg, *args, **kwargs):
         for l in self.loggers:
-            l.error(msg)
+            l.error(msg, *args, **kwargs)
 
 
 def main(args):
@@ -4189,7 +4296,7 @@ def main(args):
             show_env(environment, sys.stderr)
 
         if options.stdout or environment.stdout:
-            mailer = OutputMailer(sys.stdout)
+            mailer = OutputMailer(sys.stdout, environment)
         else:
             mailer = choose_mailer(config, environment)
 
@@ -4234,5 +4341,6 @@ def main(args):
             sys.stderr.write(msg)
         sys.exit(1)
 
+
 if __name__ == '__main__':
     main(sys.argv[1:])
diff --git a/contrib/hooks/multimail/migrate-mailhook-config b/contrib/hooks/multimail/migrate-mailhook-config
index 992657bbdc..241ba22fa3 100755
--- a/contrib/hooks/multimail/migrate-mailhook-config
+++ b/contrib/hooks/multimail/migrate-mailhook-config
@@ -110,11 +110,12 @@ def is_section_empty(section, local):
 
     try:
         read_output(
-            ['git', 'config']
-            + local_option
-            + ['--get-regexp', '^%s\.' % (section,)]
+            ['git', 'config'] +
+            local_option +
+            ['--get-regexp', '^%s\.' % (section,)]
             )
-    except CommandError, e:
+    except CommandError:
+        t, e, traceback = sys.exc_info()
         if e.retcode == 1:
             # This means that no settings were found.
             return True
@@ -188,7 +189,9 @@ def migrate_config(strict=False, retain=False, overwrite=False):
             sys.stderr.write(
                 '...copying "%s.%s" to "%s.%s"\n' % (old.section, name, new.section, name)
                 )
-            new.set_recipients(name, old.get_recipients(name))
+            old_recipients = old.get_all(name, default=None)
+            old_recipients = ', '.join(o.strip() for o in old_recipients)
+            new.set_recipients(name, old_recipients)
 
     if strict:
         sys.stderr.write(
diff --git a/contrib/hooks/multimail/post-receive.example b/contrib/hooks/multimail/post-receive.example
index 1ea113d274..b9bb11834e 100755
--- a/contrib/hooks/multimail/post-receive.example
+++ b/contrib/hooks/multimail/post-receive.example
@@ -30,7 +30,6 @@ script's behavior could be changed or customized.
 """
 
 import sys
-import os
 
 # If necessary, add the path to the directory containing
 # git_multimail.py to the Python path as follows.  (This is not
@@ -86,6 +85,7 @@ mailer = git_multimail.choose_mailer(config, environment)
 
 # Use Python's smtplib to send emails.  Both arguments are required.
 #mailer = git_multimail.SMTPMailer(
+#    environment=environment,
 #    envelopesender='git-repo@example.com',
 #    # The smtpserver argument can also include a port number; e.g.,
 #    #     smtpserver='mail.example.com:25'
-- 
2.20.1.98.gecbdaf0

