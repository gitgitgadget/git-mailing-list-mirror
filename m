From: worley@alum.mit.edu (Dale R. Worley)
Subject: [PATCH] SubmittingPatches: clarify some details of the patch format
Date: Tue, 6 Aug 2013 14:20:28 -0400
Message-ID: <201308061833.r76IXr6R026692@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 20:34:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6m53-00068S-CB
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 20:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746Ab3HFSd5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Aug 2013 14:33:57 -0400
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:34469
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756735Ab3HFSd4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Aug 2013 14:33:56 -0400
Received: from omta22.westchester.pa.mail.comcast.net ([76.96.62.73])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id 9RYU1m0061ap0As56WZvba; Tue, 06 Aug 2013 18:33:55 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta22.westchester.pa.mail.comcast.net with comcast
	id 9WZu1m00R1KKtkw3iWZvc0; Tue, 06 Aug 2013 18:33:55 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r76IXrxA026693;
	Tue, 6 Aug 2013 14:33:54 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r76IXr6R026692;
	Tue, 6 Aug 2013 14:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1375814035;
	bh=XSCaMjk17qZIE4jtBwx1Khr1fy5YnPI6+iSMrKBvW3c=;
	h=Received:Received:Received:Received:Message-Id:From:To:Date:
	 Subject:MIME-version:Content-type;
	b=nhboQY3R7yALsCmcKLNfKNJCENpm4gsashzotc8nfDhr4g8hk9NMWx667gQYkcqgQ
	 bxUFsu8K3H1oUAxpF4CiRmyD5lFyUPIgEISGtrwiRCtZJFgqteYGiTgPJNJJuEYOwE
	 Zupe2AXxmi/gowx36WbyGtbwt6ghhr1d2jmLm+8U0tpyIrekVXDK6/NjHoNPSwmWnj
	 ogjI3Y9vqWJEUuId4nkYy4WowaMXZLRMyB0+DER2EPISrF1Yo32awVd8xtbvDvjVQ1
	 JCFgjKqK34KnBALFqUp3Gk9uDJl5/Yb4b48DllioDbu46SdJQJ7XKYVDeG0Cu/LwC3
	 jh9HpvFiLO6kg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231774>

---
This is a first draft of a patch that clarifies a number of points
about how patches should be formatted that have tripped me up.  I have
re-filled a few of the paragraphs, which makes it hard to see from the
diff what I've changed.  This listing shows the changed words between
{ ... }:

     { This first line should be a separate paragraph, that is, it shou=
ld be
    followed by an empty line, which is then followed by the body of th=
e
    commit message } .

     { At the end of the commit message should be a Signed-off-by line =
giving
    your name.  This can be added to the commit message automatically b=
y
    giving "git commit" the "--signoff" option.  This line has legal
    implications, see "Sign your work" below } .

    People on the Git mailing list need to be able to read and comment =
on
    the changes you are submitting.  It is important for a developer to=
 be
    able to "quote" your changes, using standard e-mail tools, so that
    they may comment on specific portions of your code.  For this reaso=
n,
    all patches should be submitted "inline" { rather than as message
    attachments } .  If your log message (including your name on the
    Signed-off-by line) is not writable in ASCII, make sure that you se=
nd
    off { the } message in the correct encoding.

    "git format-patch" command follows the best current practice to
    format the { patch for transmission as an e-mail message.  The file=
s
    that it outputs are sample e-mail messages in "mh" format.  The
    initial lines are sample From, To, Date, and Subject headers, which
    you will likely have to remove or revise, depending on how your MUA
    operates } .

    At the beginning of the patch should come your commit message ( { t=
he
    first line in the Subject header, the remainder in the body of the
    message } ), ending with the Signed-off-by: lines, and a line that
    consists of three dashes, followed by the diffstat information and =
the
    patch itself.  If you are forwarding a patch from somebody else,
    optionally, at the beginning of the e-mail message just before the
    commit message starts, you can put a "From: " line to name that
    person.

    You often want to add additional explanation about the patch,
    other than the commit message itself.  Place such "cover letter"
    material between the three-dash { line } and the diffstat. Git-note=
s
    can also be inserted using the `--notes` option.

> From: Junio C Hamano <gitster@pobox.com>
>=20
> I am not sure if SubmittingPatches is a good place, though.
> The document is a guidance for people who contribute to _this_
> project.
>=20
> But the specialness of the first paragraph applies to any project
> that uses Git, so people other than those who contribute to this
> project should be aware of it.

All of that is true.  But what can we do to ensure that someone who
submits a patch does so with the right format?  The special treatment
of the first line is not a requirement.  See, e.g., the git-commit
manual page:

       Though not required, it=E2=80=99s a good idea to begin the commi=
t message with
       a single short (less than 50 character) line summarizing the cha=
nge,
       followed by a blank line and then a more thorough description. T=
ools
       that turn commits into email, for example, use the first line on=
 the
       Subject: line and the rest of the commit in the body.

> Originally we literally used "first line", but that made many things
> like shortlog output and patch Subject: useless when people write a
> block of text starting from the first line without a title.  Also
> after resurrecting such a text from e-mail, "am" couldn't tell if
> the "first line" on the "Subject:" is meant to be the first line of
> the same first paragraph (which is not what we encourage), or it is
> properly a single line title, and need a blank line before the first
> line of the body.  So quite a while ago, we changed the rule to take
> "the first paragraph" and use that in these places where we want to
> give a title of a patch.

And as you note, if organizing the first line this way was a
requirement, git-am would be able to unambiguously reconstruct the
commit message from an e-mail.  The only way to minimize errors in
this probject is to clearly specify what is required within this
project.

Dale


 Documentation/SubmittingPatches |   47 +++++++++++++++++++++++++------=
-------
 1 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/Submitting=
Patches
index d0a4733..e974dd7 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -85,6 +85,10 @@ identifier for the general area of the code being mo=
dified, e.g.
 If in doubt which identifier to use, run "git log --no-merges" on the
 files you are modifying to see the current conventions.
=20
+This first line should be a separate paragraph, that is, it should be
+followed by an empty line, which is then followed by the body of the
+commit message.
+
 The body should provide a meaningful commit message, which:
=20
   . explains the problem the change tries to solve, iow, what is wrong
@@ -102,6 +106,10 @@ its behaviour.  Try to make sure your explanation =
can be understood
 without external resources. Instead of giving a URL to a mailing list
 archive, summarize the relevant points of the discussion.
=20
+At the end of the commit message should be a Signed-off-by line giving
+your name.  This can be added to the commit message automatically by
+giving "git commit" the "--signoff" option.  This line has legal
+implications, see "Sign your work" below.
=20
 (3) Generate your patch using Git tools out of your commits.
=20
@@ -122,14 +130,14 @@ that is fine, but please mark it as such.
=20
 (4) Sending your patches.
=20
-People on the Git mailing list need to be able to read and
-comment on the changes you are submitting.  It is important for
-a developer to be able to "quote" your changes, using standard
-e-mail tools, so that they may comment on specific portions of
-your code.  For this reason, all patches should be submitted
-"inline".  If your log message (including your name on the
-Signed-off-by line) is not writable in ASCII, make sure that
-you send off a message in the correct encoding.
+People on the Git mailing list need to be able to read and comment on
+the changes you are submitting.  It is important for a developer to be
+able to "quote" your changes, using standard e-mail tools, so that
+they may comment on specific portions of your code.  For this reason,
+all patches should be submitted "inline" rather than as message
+attachments.  If your log message (including your name on the
+Signed-off-by line) is not writable in ASCII, make sure that you send
+off the message in the correct encoding.
=20
 WARNING: Be wary of your MUAs word-wrap
 corrupting your patch.  Do not cut-n-paste your patch; you can
@@ -145,17 +153,24 @@ not ready to be applied but it is for discussion,=
 [PATCH v2],
 what you have previously sent.
=20
 "git format-patch" command follows the best current practice to
-format the body of an e-mail message.  At the beginning of the
-patch should come your commit message, ending with the
-Signed-off-by: lines, and a line that consists of three dashes,
-followed by the diffstat information and the patch itself.  If
-you are forwarding a patch from somebody else, optionally, at
-the beginning of the e-mail message just before the commit
-message starts, you can put a "From: " line to name that person.
+format the patch for transmission as an e-mail message.  The files
+that it outputs are sample e-mail messages in "mh" format.  The
+initial lines are sample From, To, Date, and Subject headers, which
+you will likely have to remove or revise, depending on how your MUA
+operates.
+
+At the beginning of the patch should come your commit message (the
+first line in the Subject header, the remainder in the body of the
+message), ending with the Signed-off-by: lines, and a line that
+consists of three dashes, followed by the diffstat information and the
+patch itself.  If you are forwarding a patch from somebody else,
+optionally, at the beginning of the e-mail message just before the
+commit message starts, you can put a "From: " line to name that
+person.
=20
 You often want to add additional explanation about the patch,
 other than the commit message itself.  Place such "cover letter"
-material between the three dash lines and the diffstat. Git-notes
+material between the three-dash line and the diffstat. Git-notes
 can also be inserted using the `--notes` option.
=20
 Do not attach the patch as a MIME attachment, compressed or not.
--=20
1.7.7.6
