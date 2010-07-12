From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH v3 13/13] some document update
Date: Mon, 12 Jul 2010 22:12:57 +0800
Message-ID: <AANLkTinO9uLByOvUMRf4Y9vcne1jNAfPnvT3Dq0l4xa9@mail.gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
	<1278829141-11900-13-git-send-email-struggleyb.nku@gmail.com>
	<m3hbk6l901.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 16:13:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYJl6-0003OX-TV
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 16:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416Ab0GLONG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 10:13:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61654 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359Ab0GLOND convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 10:13:03 -0400
Received: by gwj18 with SMTP id 18so2033860gwj.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9ul3tPMkMPwTNRM3tqtLxWd6l1RA8nmfrkVLgNh4TcQ=;
        b=IU50Wpicj46TDU/44wjZa3iQ8QX9RZiDUnAhvUXVwDRd8pGsTlxJsnE0ztCBZ0ftC2
         ewYvdt4xLH9e95kNlEx8i8QHxo4PsOqDs6JkbsalCkG9W2EDjfAD3a41ybt20wCj1Wwn
         E4SBPGUvc9bChgQxr+AbVCDPyxPoGauew2xkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QCHDHVoWlnI9qQ0IdkGfGPWQ/rxNvuR7r+L+q9k+eY296QLP8F7FLwOh6rdd/R9gC7
         H88J4ZTyXC5ncwvwNTT96EVmL9wk6IXx/iUH0cohb7T233UcpZmh8NDUigy+IshkSZME
         LnN6BDOV0MyGVl5qNPyboyy9GMvv9nkkwfHpo=
Received: by 10.224.105.4 with SMTP id r4mr5029305qao.83.1278943977707; Mon, 
	12 Jul 2010 07:12:57 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Mon, 12 Jul 2010 07:12:57 -0700 (PDT)
In-Reply-To: <m3hbk6l901.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150813>

Hi Jakub,

On Sun, Jul 11, 2010 at 4:27 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>
> If the parsing code for -L <start>,<end> is the same for git-blame an=
d
> for git-log, and therefore documentation is the same or nearly the
> same for this option, wouldn't it be better to separate this
> documentation into separate file, e.g. line-range-option.txt, and
> include it both in git-blame and git-log manpages? =A0If there are mi=
nor
> differences, they can be covered by ifdefs.
>

Thanks a lot for your advice, I have revised the patch.

-----------------------------------------------------------
=46rom 88ed88a53d83c2d46fa4917008efadc531ba1068 Mon Sep 17 00:00:00 200=
1
=46rom: Bo Yang <struggleyb.nku@gmail.com>
Date: Sat, 26 Jun 2010 01:35:48 -0700
Subject: [PATCH v3 revised 13/13] some document update

Both 'git log' and 'git blame' support the same
format of '-L' arguments, so put the argument
format description into a new file.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Documentation/blame-options.txt     |   19 +------------------
 Documentation/git-log.txt           |   13 +++++++++++++
 Documentation/line-range-format.txt |   18 ++++++++++++++++++
 3 files changed, 32 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/line-range-format.txt

diff --git a/Documentation/blame-options.txt b/Documentation/blame-opti=
ons.txt
index 16e3c68..3526835 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -13,24 +13,7 @@
 	Annotate only the given line range.  <start> and <end> can take
 	one of these forms:

-	- number
-+
-If <start> or <end> is a number, it specifies an
-absolute line number (lines count from 1).
-+
-
-- /regex/
-+
-This form will use the first line matching the given
-POSIX regex.  If <end> is a regex, it will search
-starting at the line given by <start>.
-+
-
-- +offset or -offset
-+
-This is only valid for <end> and will specify a number
-of lines before or after the line given by <start>.
-+
+include::line-range-format.txt[]

 -l::
 	Show long rev (Default: off).
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0e6ff31..4781f8b 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -9,6 +9,7 @@ git-log - Show commit logs
 SYNOPSIS
 --------
 'git log' [<options>] [<since>..<until>] [[\--] <path>...]
+'git log' [<options>] -L n,m <path>

 DESCRIPTION
 -----------
@@ -19,6 +20,9 @@ command to control what is shown and how, and
options applicable to
 the 'git diff-*' commands to control how the changes
 each commit introduces are shown.

+With '-L' option, the command will help to trace the history of user s=
pecified
+line ranges. It can trace multiple ranges coming from multiple files.
+

 OPTIONS
 -------
@@ -72,6 +76,15 @@ include::diff-options.txt[]
 	to be prefixed with "\-- " to separate them from options or
 	refnames.

+-L <start>,<end>::
+	The line range.  <start> and <end> can take one of these forms:
+
+include::line-range-format.txt[]
+
+--always-print::
+	Always print the interesting range even if the current commit
+	does not change any line of the range.
+

 include::rev-list-options.txt[]

diff --git a/Documentation/line-range-format.txt
b/Documentation/line-range-format.txt
new file mode 100644
index 0000000..265bc23
--- /dev/null
+++ b/Documentation/line-range-format.txt
@@ -0,0 +1,18 @@
+- number
++
+If <start> or <end> is a number, it specifies an
+absolute line number (lines count from 1).
++
+
+- /regex/
++
+This form will use the first line matching the given
+POSIX regex.  If <end> is a regex, it will search
+starting at the line given by <start>.
++
+
+- +offset or -offset
++
+This is only valid for <end> and will specify a number
+of lines before or after the line given by <start>.
++
--=20
1.7.0.2.273.gc2413.dirty
