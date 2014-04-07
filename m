From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] git-multimail: update to version 1.0.0
Date: Mon,  7 Apr 2014 17:20:40 +0200
Message-ID: <1396884040-26014-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 17:21:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXBM2-0004Q1-3O
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 17:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbaDGPUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2014 11:20:52 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48887 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753281AbaDGPUs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 11:20:48 -0400
X-AuditID: 1207440d-f79d86d0000043db-60-5342c24f1044
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F5.B1.17371.F42C2435; Mon,  7 Apr 2014 11:20:47 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37FKikJ003693
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 11:20:45 -0400
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqOt/yCnYYEcTm0XXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGes//KKveDoecaKz0faWBsY
	T81m7GLk5JAQMJG4NGMtK4QtJnHh3no2EFtI4DKjxKeG9C5GLiD7GJNEQ+MHsCI2AV2JRT3N
	TCC2iICaxMS2QywgNrOAg8Tmz41gQ4UFzCX+fDoFNohFQFWivfMCWJxXwEWi8coLFohlchIn
	j01mhYgLSpyc+QQozgE0R11i/TwhiJHyEs1bZzNPYOSbhaRqFkLVLCRVCxiZVzHKJeaU5urm
	JmbmFKcm6xYnJ+blpRbpGunlZpbopaaUbmKEhCLvDsb/62QOMQpwMCrx8K485BgsxJpYVlyZ
	e4hRkoNJSZQ3fL9TsBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXq7VQDnelMTKqtSifJiUNAeL
	kjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgSvwEGgRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8
	lNSixNKSjHhQ5MUXA2MPJMUDtHf/AZC9xQWJuUBRiNZTjIpS4rxTQRICIImM0jy4sbAE84pR
	HOhLYV4+kO08wOQE1/0KaDAT0GBDV7DBJYkIKakGxuYU6ad3Xkdu2rdn0mzxEwJF1jvnfvff
	OHMDKye/+f4Fb+xqfBli/HL1KqzWdyZs71zix1bm/ODOrJKL6pkuOizyDWufHxDcmtS2TucM
	p+uyD5L1EYq1dy/sm8I1xevgsnOn15cULZl0RCAw9Ymu1tND1fcLzv+ev9ywosrh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245863>

This commit contains the squashed changes from the upstream
git-multimail repository since the last code drop.  Highlights:

* Fix encoding of non-ASCII email addresses in email headers.

* Fix backwards-compatibility bugs for older Python 2.x versions.

* Fix a backwards-compatibility bug for Git 1.7.1.

* Add an option commitDiffOpts to customize logs for revisions.

* Pass "-oi" to sendmail by default to prevent premature
  termination
  on a line containing only ".".

* Stagger email "Date:" values in an attempt to help mail clients
  thread the emails in the right order.

* If a mailing list setting is missing, just skip sending the
  corresponding email (with a warning) instead of failing.

* Add a X-Git-Host header that can be used for email filtering.

* Allow the sender's fully-qualified domain name to be configured.

* Minor documentation improvements.

* Add a CHANGES file.

Contributions-by: Rapha=C3=ABl Hertzog <hertzog@debian.org>
Contributions-by: Eric Berberich <eric.berberich@gmail.com>
Contributions-by: Michiel Holtkamp <git@elfstone.nl>
Contributions-by: Malte Swart <mswart@devtation.de>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Junio, how would you like other people's contributions to be recorded
within the Git project?  I have listed them above as
"Contributions-by".  All of these people have signed off on their
contributions (recorded in my GitHub repo).  So should I also/instead
add "Signed-off-by" for those people?

 contrib/hooks/multimail/CHANGES          |  33 +++++
 contrib/hooks/multimail/README           |  46 ++++---
 contrib/hooks/multimail/README.Git       |   4 +-
 contrib/hooks/multimail/git_multimail.py | 218 +++++++++++++++++++++++=
+++-----
 contrib/hooks/multimail/post-receive     |   4 +-
 5 files changed, 249 insertions(+), 56 deletions(-)
 create mode 100644 contrib/hooks/multimail/CHANGES

diff --git a/contrib/hooks/multimail/CHANGES b/contrib/hooks/multimail/=
CHANGES
new file mode 100644
index 0000000..3603d56
--- /dev/null
+++ b/contrib/hooks/multimail/CHANGES
@@ -0,0 +1,33 @@
+Release 1.0.0
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+* Fix encoding of non-ASCII email addresses in email headers.
+
+* Fix backwards-compatibility bugs for older Python 2.x versions.
+
+* Fix a backwards-compatibility bug for Git 1.7.1.
+
+* Add an option commitDiffOpts to customize logs for revisions.
+
+* Pass "-oi" to sendmail by default to prevent premature termination
+  on a line containing only ".".
+
+* Stagger email "Date:" values in an attempt to help mail clients
+  thread the emails in the right order.
+
+* If a mailing list setting is missing, just skip sending the
+  corresponding email (with a warning) instead of failing.
+
+* Add a X-Git-Host header that can be used for email filtering.
+
+* Allow the sender's fully-qualified domain name to be configured.
+
+* Minor documentation improvements.
+
+* Add this CHANGES file.
+
+
+Release 0.9.0
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+* Initial release.
diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/R=
EADME
index 9904396..477d65f 100644
--- a/contrib/hooks/multimail/README
+++ b/contrib/hooks/multimail/README
@@ -91,9 +91,10 @@ Requirements
   been tested; if you do so, please report your results.)
=20
 * To send emails using the default configuration, a standard sendmail
-  program must be located at '/usr/sbin/sendmail' and configured
-  correctly to send emails.  If this is not the case, see the
-  multimailhook.mailer configuration variable below for how to
+  program must be located at '/usr/sbin/sendmail' or
+  '/usr/lib/sendmail' and must be configured correctly to send emails.
+  If this is not the case, set multimailhook.sendmailCommand, or see
+  the multimailhook.mailer configuration variable below for how to
   configure git-multimail to send emails via an SMTP server.
=20
=20
@@ -169,7 +170,7 @@ multimailhook.repoName
     for gitolite repositories, or otherwise to derive this value from
     the repository path name.
=20
-multimailhook.mailinglist
+multimailhook.mailingList
=20
     The list of email addresses to which notification emails should be
     sent, as RFC 2822 email addresses separated by commas.  This
@@ -184,26 +185,29 @@ multimailhook.refchangeList
     reference changes should be sent, as RFC 2822 email addresses
     separated by commas.  This configuration option can be
     multivalued.  The default is the value in
-    multimailhook.mailinglist.  Set this value to the empty string to
-    prevent reference change emails from being sent.
+    multimailhook.mailingList.  Set this value to the empty string to
+    prevent reference change emails from being sent even if
+    multimailhook.mailingList is set.
=20
 multimailhook.announceList
=20
     The list of email addresses to which emails about new annotated
     tags should be sent, as RFC 2822 email addresses separated by
     commas.  This configuration option can be multivalued.  The
-    default is the value in multimailhook.refchangelist or
-    multimailhook.mailinglist.  Set this value to the empty string to
-    prevent annotated tag announcement emails from being sent.
+    default is the value in multimailhook.refchangeList or
+    multimailhook.mailingList.  Set this value to the empty string to
+    prevent annotated tag announcement emails from being sent even if
+    one of the other values is set.
=20
 multimailhook.commitList
=20
     The list of email addresses to which emails about individual new
     commits should be sent, as RFC 2822 email addresses separated by
     commas.  This configuration option can be multivalued.  The
-    default is the value in multimailhook.mailinglist.  Set this value
+    default is the value in multimailhook.mailingList.  Set this value
     to the empty string to prevent notification emails about
-    individual commits from being sent.
+    individual commits from being sent even if
+    multimailhook.mailingList is set.
=20
 multimailhook.announceShortlog
=20
@@ -237,10 +241,11 @@ multimailhook.mailer
            quoting is allowed in the value of this setting, but rememb=
er that
            Git requires double-quotes to be escaped; e.g.,
=20
-             git config multimailhook.sendmailcommand '/usr/sbin/sendm=
ail -t -F \"Git Repo\"'
+             git config multimailhook.sendmailcommand '/usr/sbin/sendm=
ail -oi -t -F \"Git Repo\"'
=20
-           Default is '/usr/sbin/sendmail -t' or '/usr/lib/sendmail
-           -t' (depending on which file is present and executable).
+           Default is '/usr/sbin/sendmail -oi -t' or
+           '/usr/lib/sendmail -oi -t' (depending on which file is
+           present and executable).
=20
        multimailhook.envelopeSender
=20
@@ -344,6 +349,14 @@ multimailhook.logOpts
       [multimailhook]
               logopts =3D --pretty=3Dformat:\"%h %aN <%aE>%n%s%n%n%b%n=
\"
=20
+multimailhook.commitLogOpts
+
+    Options passed to "git log" to generate additional info for
+    revision change emails.  For example, adding --ignore-all-spaces
+    will suppress whitespace changes.  The default options are "-C
+    --stat -p --cc".  Shell quoting is allowed; see
+    multimailhook.logOpts for details.
+
 multimailhook.emailDomain
=20
     Domain name appended to the username of the person doing the push
@@ -381,8 +394,8 @@ Email filtering aids
=20
 All emails include extra headers to enable fine tuned filtering and
 give information for debugging.  All emails include the headers
-"X-Git-Repo", "X-Git-Refname", and "X-Git-Reftype".  ReferenceChange
-emails also include headers "X-Git-Oldrev" and "X-Git-Newrev";
+"X-Git-Host", "X-Git-Repo", "X-Git-Refname", and "X-Git-Reftype".
+ReferenceChange emails also include headers "X-Git-Oldrev" and "X-Git-=
Newrev";
 Revision emails also include header "X-Git-Rev".
=20
=20
@@ -463,6 +476,7 @@ The git-multimail project itself is currently hoste=
d on GitHub:
 We use the GitHub issue tracker to keep track of bugs and feature
 requests, and GitHub pull requests to exchange patches (though, if you
 prefer, you can send patches via the Git mailing list with cc to me).
+Please sign off your patches as per the Git project practice.
=20
 Please note that although a copy of git-multimail will probably be
 distributed in the "contrib" section of the main Git project,
diff --git a/contrib/hooks/multimail/README.Git b/contrib/hooks/multima=
il/README.Git
index 9c2e66a..129b771 100644
--- a/contrib/hooks/multimail/README.Git
+++ b/contrib/hooks/multimail/README.Git
@@ -6,10 +6,10 @@ website:
     https://github.com/mhagger/git-multimail
=20
 The version in this directory was obtained from the upstream project
-on 2013-07-14 and consists of the "git-multimail" subdirectory from
+on 2014-04-07 and consists of the "git-multimail" subdirectory from
 revision
=20
-    1a5cb09c698a74d15a715a86b09ead5f56bf4b06
+    1b32653bafc4f902535b9fc1cd9cae911325b870
=20
 Please see the README file in this directory for information about how
 to report bugs or contribute to git-multimail.
diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/m=
ultimail/git_multimail.py
index 81c6a51..8b58ed6 100755
--- a/contrib/hooks/multimail/git_multimail.py
+++ b/contrib/hooks/multimail/git_multimail.py
@@ -1,6 +1,6 @@
 #! /usr/bin/env python2
=20
-# Copyright (c) 2012,2013 Michael Haggerty
+# Copyright (c) 2012-2014 Michael Haggerty and others
 # Derived from contrib/hooks/post-receive-email, which is
 # Copyright (c) 2007 Andy Parkins
 # and also includes contributions by other authors.
@@ -49,21 +49,25 @@ import sys
 import os
 import re
 import bisect
+import socket
 import subprocess
 import shlex
 import optparse
 import smtplib
+import time
=20
 try:
     from email.utils import make_msgid
     from email.utils import getaddresses
     from email.utils import formataddr
+    from email.utils import formatdate
     from email.header import Header
 except ImportError:
     # Prior to Python 2.5, the email module used different names:
     from email.Utils import make_msgid
     from email.Utils import getaddresses
     from email.Utils import formataddr
+    from email.Utils import formatdate
     from email.Header import Header
=20
=20
@@ -73,6 +77,7 @@ ZEROS =3D '0' * 40
 LOGBEGIN =3D '- Log --------------------------------------------------=
---------------\n'
 LOGEND =3D '----------------------------------------------------------=
-------------\n'
=20
+ADDR_HEADERS =3D set(['from', 'to', 'cc', 'bcc', 'reply-to', 'sender']=
)
=20
 # It is assumed in many places that the encoding is uniformly UTF-8,
 # so changing these constants is unsupported.  But define them here
@@ -95,6 +100,7 @@ REF_DELETED_SUBJECT_TEMPLATE =3D (
     )
=20
 REFCHANGE_HEADER_TEMPLATE =3D """\
+Date: %(send_date)s
 To: %(recipients)s
 Subject: %(subject)s
 MIME-Version: 1.0
@@ -103,6 +109,7 @@ Content-Transfer-Encoding: 8bit
 Message-ID: %(msgid)s
 From: %(fromaddr)s
 Reply-To: %(reply_to)s
+X-Git-Host: %(fqdn)s
 X-Git-Repo: %(repo_shortname)s
 X-Git-Refname: %(refname)s
 X-Git-Reftype: %(refname_type)s
@@ -221,6 +228,7 @@ how to provide full information about this referenc=
e change.
=20
=20
 REVISION_HEADER_TEMPLATE =3D """\
+Date: %(send_date)s
 To: %(recipients)s
 Subject: %(emailprefix)s%(num)02d/%(tot)02d: %(oneline)s
 MIME-Version: 1.0
@@ -230,6 +238,7 @@ From: %(fromaddr)s
 Reply-To: %(reply_to)s
 In-Reply-To: %(reply_to_msgid)s
 References: %(reply_to_msgid)s
+X-Git-Host: %(fqdn)s
 X-Git-Repo: %(repo_shortname)s
 X-Git-Refname: %(refname)s
 X-Git-Reftype: %(refname_type)s
@@ -263,13 +272,43 @@ class ConfigurationException(Exception):
     pass
=20
=20
+# The "git" program (this could be changed to include a full path):
+GIT_EXECUTABLE =3D 'git'
+
+
+# How "git" should be invoked (including global arguments), as a list
+# of words.  This variable is usually initialized automatically by
+# read_git_output() via choose_git_command(), but if a value is set
+# here then it will be used unconditionally.
+GIT_CMD =3D None
+
+
+def choose_git_command():
+    """Decide how to invoke git, and record the choice in GIT_CMD."""
+
+    global GIT_CMD
+
+    if GIT_CMD is None:
+        try:
+            # Check to see whether the "-c" option is accepted (it was
+            # only added in Git 1.7.2).  We don't actually use the
+            # output of "git --version", though if we needed more
+            # specific version information this would be the place to
+            # do it.
+            cmd =3D [GIT_EXECUTABLE, '-c', 'foo.bar=3Dbaz', '--version=
']
+            read_output(cmd)
+            GIT_CMD =3D [GIT_EXECUTABLE, '-c', 'i18n.logoutputencoding=
=3D%s' % (ENCODING,)]
+        except CommandError:
+            GIT_CMD =3D [GIT_EXECUTABLE]
+
+
 def read_git_output(args, input=3DNone, keepends=3DFalse, **kw):
     """Read the output of a Git command."""
=20
-    return read_output(
-        ['git', '-c', 'i18n.logoutputencoding=3D%s' % (ENCODING,)] + a=
rgs,
-        input=3Dinput, keepends=3Dkeepends, **kw
-        )
+    if GIT_CMD is None:
+        choose_git_command()
+
+    return read_output(GIT_CMD + args, input=3Dinput, keepends=3Dkeepe=
nds, **kw)
=20
=20
 def read_output(cmd, input=3DNone, keepends=3DFalse, **kw):
@@ -297,6 +336,31 @@ def read_git_lines(args, keepends=3DFalse, **kw):
     return read_git_output(args, keepends=3DTrue, **kw).splitlines(kee=
pends)
=20
=20
+def header_encode(text, header_name=3DNone):
+    """Encode and line-wrap the value of an email header field."""
+
+    try:
+        if isinstance(text, str):
+            text =3D text.decode(ENCODING, 'replace')
+        return Header(text, header_name=3Dheader_name).encode()
+    except UnicodeEncodeError:
+        return Header(text, header_name=3Dheader_name, charset=3DCHARS=
ET,
+                      errors=3D'replace').encode()
+
+
+def addr_header_encode(text, header_name=3DNone):
+    """Encode and line-wrap the value of an email header field contain=
ing
+    email addresses."""
+
+    return Header(
+        ', '.join(
+            formataddr((header_encode(name), emailaddr))
+            for name, emailaddr in getaddresses([text])
+            ),
+        header_name=3Dheader_name
+        ).encode()
+
+
 class Config(object):
     def __init__(self, section, git_config=3DNone):
         """Represent a section of the git configuration.
@@ -578,11 +642,11 @@ class Change(object):
                         % (e.args[0], line,)
                         )
             else:
-                try:
-                    h =3D Header(value, header_name=3Dname)
-                except UnicodeDecodeError:
-                    h =3D Header(value, header_name=3Dname, charset=3D=
CHARSET, errors=3D'replace')
-                for splitline in ('%s: %s\n' % (name, h.encode(),)).sp=
litlines(True):
+                if name.lower() in ADDR_HEADERS:
+                    value =3D addr_header_encode(value, name)
+                else:
+                    value =3D header_encode(value, name)
+                for splitline in ('%s: %s\n' % (name, value)).splitlin=
es(True):
                     yield splitline
=20
     def generate_email_header(self):
@@ -616,15 +680,19 @@ class Change(object):
=20
         raise NotImplementedError()
=20
-    def generate_email(self, push, body_filter=3DNone):
+    def generate_email(self, push, body_filter=3DNone, extra_header_va=
lues=3D{}):
         """Generate an email describing this change.
=20
         Iterate over the lines (including the header lines) of an
         email describing this change.  If body_filter is not None,
         then use it to filter the lines that are intended for the
-        email body."""
+        email body.
+
+        The extra_header_values field is received as a dict and not as
+        **kwargs, to allow passing other keyword arguments in the
+        future (e.g. passing extra values to generate_email_intro()"""
=20
-        for line in self.generate_email_header():
+        for line in self.generate_email_header(**extra_header_values):
             yield line
         yield '\n'
         for line in self.generate_email_intro():
@@ -680,8 +748,10 @@ class Revision(Change):
=20
         return values
=20
-    def generate_email_header(self):
-        for line in self.expand_header_lines(REVISION_HEADER_TEMPLATE)=
:
+    def generate_email_header(self, **extra_values):
+        for line in self.expand_header_lines(
+            REVISION_HEADER_TEMPLATE, **extra_values
+            ):
             yield line
=20
     def generate_email_intro(self):
@@ -692,11 +762,7 @@ class Revision(Change):
         """Show this revision."""
=20
         return read_git_lines(
-            [
-                'log', '-C',
-                 '--stat', '-p', '--cc',
-                '-1', self.rev.sha1,
-                ],
+            ['log'] + self.environment.commitlogopts + ['-1', self.rev=
=2Esha1],
             keepends=3DTrue,
             )
=20
@@ -800,6 +866,7 @@ class ReferenceChange(Change):
         self.msgid =3D make_msgid()
         self.diffopts =3D environment.diffopts
         self.logopts =3D environment.logopts
+        self.commitlogopts =3D environment.commitlogopts
         self.showlog =3D environment.refchange_showlog
=20
     def _compute_values(self):
@@ -835,9 +902,12 @@ class ReferenceChange(Change):
             }[self.change_type]
         return self.expand(template)
=20
-    def generate_email_header(self):
+    def generate_email_header(self, **extra_values):
+        if 'subject' not in extra_values:
+            extra_values['subject'] =3D self.get_subject()
+
         for line in self.expand_header_lines(
-            REFCHANGE_HEADER_TEMPLATE, subject=3Dself.get_subject(),
+            REFCHANGE_HEADER_TEMPLATE, **extra_values
             ):
             yield line
=20
@@ -1273,7 +1343,7 @@ class Mailer(object):
=20
=20
 class SendMailer(Mailer):
-    """Send emails using 'sendmail -t'."""
+    """Send emails using 'sendmail -oi -t'."""
=20
     SENDMAIL_CANDIDATES =3D [
         '/usr/sbin/sendmail',
@@ -1302,7 +1372,7 @@ class SendMailer(Mailer):
         if command:
             self.command =3D command[:]
         else:
-            self.command =3D [self.find_sendmail(), '-t']
+            self.command =3D [self.find_sendmail(), '-oi', '-t']
=20
         if envelopesender:
             self.command.extend(['-f', envelopesender])
@@ -1495,6 +1565,12 @@ class Environment(object):
             'git log' when generating the detailed log for a set of
             commits (see refchange_showlog)
=20
+        commitlogopts (list of strings)
+
+            The options that should be passed to 'git log' for each
+            commit mail.  The value should be a list of strings
+            representing words to be passed to the command.
+
     """
=20
     REPO_NAME_RE =3D re.compile(r'^(?P<name>.+?)(?:\.git)$')
@@ -1506,6 +1582,7 @@ class Environment(object):
         self.diffopts =3D ['--stat', '--summary', '--find-copies-harde=
r']
         self.logopts =3D []
         self.refchange_showlog =3D False
+        self.commitlogopts =3D ['-C', '--stat', '-p', '--cc']
=20
         self.COMPUTED_KEYS =3D [
             'administrator',
@@ -1672,6 +1749,10 @@ class ConfigOptionsEnvironmentMixin(ConfigEnviro=
nmentMixin):
         if logopts is not None:
             self.logopts =3D shlex.split(logopts)
=20
+        commitlogopts =3D config.get('commitlogopts')
+        if commitlogopts is not None:
+            self.commitlogopts =3D shlex.split(commitlogopts)
+
         reply_to =3D config.get('replyTo')
         self.__reply_to_refchange =3D config.get('replyToRefchange', d=
efault=3Dreply_to)
         if (
@@ -1829,6 +1910,47 @@ class ConfigMaxlinesEnvironmentMixin(
             )
=20
=20
+class FQDNEnvironmentMixin(Environment):
+    """A mixin that sets the host's FQDN to its constructor argument."=
""
+
+    def __init__(self, fqdn, **kw):
+        super(FQDNEnvironmentMixin, self).__init__(**kw)
+        self.COMPUTED_KEYS +=3D ['fqdn']
+        self.__fqdn =3D fqdn
+
+    def get_fqdn(self):
+        """Return the fully-qualified domain name for this host.
+
+        Return None if it is unavailable or unwanted."""
+
+        return self.__fqdn
+
+
+class ConfigFQDNEnvironmentMixin(
+    ConfigEnvironmentMixin,
+    FQDNEnvironmentMixin,
+    ):
+    """Read the FQDN from the config."""
+
+    def __init__(self, config, **kw):
+        fqdn =3D config.get('fqdn')
+        super(ConfigFQDNEnvironmentMixin, self).__init__(
+            config=3Dconfig,
+            fqdn=3Dfqdn,
+            **kw
+            )
+
+
+class ComputeFQDNEnvironmentMixin(FQDNEnvironmentMixin):
+    """Get the FQDN by calling socket.getfqdn()."""
+
+    def __init__(self, **kw):
+        super(ComputeFQDNEnvironmentMixin, self).__init__(
+            fqdn=3Dsocket.getfqdn(),
+            **kw
+            )
+
+
 class PusherDomainEnvironmentMixin(ConfigEnvironmentMixin):
     """Deduce pusher_email from pusher by appending an emaildomain."""
=20
@@ -1861,6 +1983,10 @@ class StaticRecipientsEnvironmentMixin(Environme=
nt):
         # actual *contents* of the change being reported, we only
         # choose based on the *type* of the change.  Therefore we can
         # compute them once and for all:
+        if not (refchange_recipients
+                or announce_recipients
+                or revision_recipients):
+            raise ConfigurationException('No email recipients configur=
ed!')
         self.__refchange_recipients =3D refchange_recipients
         self.__announce_recipients =3D announce_recipients
         self.__revision_recipients =3D revision_recipients
@@ -1911,17 +2037,8 @@ class ConfigRecipientsEnvironmentMixin(
             retval =3D config.get_recipients(name)
             if retval is not None:
                 return retval
-        if len(names) =3D=3D 1:
-            hint =3D 'Please set "%s.%s"' % (config.section, name)
         else:
-            hint =3D (
-                'Please set one of the following:\n    "%s"'
-                % ('"\n    "'.join('%s.%s' % (config.section, name) fo=
r name in names))
-                )
-
-        raise ConfigurationException(
-            'The list of recipients for %s is not configured.\n%s' % (=
names[0], hint)
-            )
+            return ''
=20
=20
 class ProjectdescEnvironmentMixin(Environment):
@@ -1956,6 +2073,7 @@ class GenericEnvironmentMixin(Environment):
 class GenericEnvironment(
     ProjectdescEnvironmentMixin,
     ConfigMaxlinesEnvironmentMixin,
+    ComputeFQDNEnvironmentMixin,
     ConfigFilterLinesEnvironmentMixin,
     ConfigRecipientsEnvironmentMixin,
     PusherDomainEnvironmentMixin,
@@ -1980,9 +2098,27 @@ class GitoliteEnvironmentMixin(Environment):
         return self.osenv.get('GL_USER', 'unknown user')
=20
=20
+class IncrementalDateTime(object):
+    """Simple wrapper to give incremental date/times.
+
+    Each call will result in a date/time a second later than the
+    previous call.  This can be used to falsify email headers, to
+    increase the likelihood that email clients sort the emails
+    correctly."""
+
+    def __init__(self):
+        self.time =3D time.time()
+
+    def next(self):
+        formatted =3D formatdate(self.time, True)
+        self.time +=3D 1
+        return formatted
+
+
 class GitoliteEnvironment(
     ProjectdescEnvironmentMixin,
     ConfigMaxlinesEnvironmentMixin,
+    ComputeFQDNEnvironmentMixin,
     ConfigFilterLinesEnvironmentMixin,
     ConfigRecipientsEnvironmentMixin,
     PusherDomainEnvironmentMixin,
@@ -2187,6 +2323,7 @@ class Push(object):
         # guarantee that one (and only one) email is generated for
         # each new commit.
         unhandled_sha1s =3D set(self.get_new_commits())
+        send_date =3D IncrementalDateTime()
         for change in self.changes:
             # Check if we've got anyone to send to
             if not change.recipients:
@@ -2197,7 +2334,11 @@ class Push(object):
                     )
             else:
                 sys.stderr.write('Sending notification emails to: %s\n=
' % (change.recipients,))
-                mailer.send(change.generate_email(self, body_filter), =
change.recipients)
+                extra_values =3D {'send_date' : send_date.next()}
+                mailer.send(
+                    change.generate_email(self, body_filter, extra_val=
ues),
+                    change.recipients,
+                    )
=20
             sha1s =3D []
             for sha1 in reversed(list(self.get_new_commits(change))):
@@ -2217,7 +2358,11 @@ class Push(object):
             for (num, sha1) in enumerate(sha1s):
                 rev =3D Revision(change, GitObject(sha1), num=3Dnum+1,=
 tot=3Dlen(sha1s))
                 if rev.recipients:
-                    mailer.send(rev.generate_email(self, body_filter),=
 rev.recipients)
+                    extra_values =3D {'send_date' : send_date.next()}
+                    mailer.send(
+                        rev.generate_email(self, body_filter, extra_va=
lues),
+                        rev.recipients,
+                        )
=20
         # Consistency check:
         if unhandled_sha1s:
@@ -2288,6 +2433,7 @@ def choose_environment(config, osenv=3DNone, env=3D=
None, recipients=3DNone):
     environment_mixins =3D [
         ProjectdescEnvironmentMixin,
         ConfigMaxlinesEnvironmentMixin,
+        ComputeFQDNEnvironmentMixin,
         ConfigFilterLinesEnvironmentMixin,
         PusherDomainEnvironmentMixin,
         ConfigOptionsEnvironmentMixin,
diff --git a/contrib/hooks/multimail/post-receive b/contrib/hooks/multi=
mail/post-receive
index 93ebb43..4d46828 100755
--- a/contrib/hooks/multimail/post-receive
+++ b/contrib/hooks/multimail/post-receive
@@ -66,10 +66,10 @@ mailer =3D git_multimail.choose_mailer(config, envi=
ronment)
 # Alternatively, you may hardcode the mailer using code like one of
 # the following:
=20
-# Use "/usr/sbin/sendmail -t" to send emails.  The envelopesender
+# Use "/usr/sbin/sendmail -oi -t" to send emails.  The envelopesender
 # argument is optional:
 #mailer =3D git_multimail.SendMailer(
-#    command=3D['/usr/sbin/sendmail', '-t'],
+#    command=3D['/usr/sbin/sendmail', '-oi', '-t'],
 #    envelopesender=3D'git-repo@example.com',
 #    )
=20
--=20
1.9.1
