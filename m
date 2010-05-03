From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] Documentation/notes: nitpicks
Date: Mon, 3 May 2010 18:47:20 -0500
Message-ID: <20100503234720.GD27483@progeny.tock>
References: <20100503233604.GA27451@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 01:47:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O95M4-0005sQ-SH
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 01:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759521Ab0ECXrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 19:47:11 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:58617 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491Ab0ECXrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 19:47:09 -0400
Received: by ywh36 with SMTP id 36so1479171ywh.4
        for <git@vger.kernel.org>; Mon, 03 May 2010 16:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vSw029fFgbItg0HTIGxihZ931akcLxFV+k3k4LkXrFY=;
        b=LLn4tX0uOoaQuewCCe0+r3I2X6EXBPVHq+CWAJ1GAyQ4ws4S6uuqkDP8bOO6E1Ffd5
         2QUGXorm3uvKfQjyTfyw8sdrDJwdvS0OqiGWyfkTQgX6E95AmJ3/BdkeBrsGZELCT/cp
         IwR0WkkcuLPjRM4ZyZioaNtYLmKGsZ5pdWgVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xLxZuVtfc0FtJQJRw153LygwfBfajRQ+F4lUhK/JIvQ47HgHP5TMJ+/89WXU95VT7N
         hjj3e5m6Z2hNPHNSKKmACr50cgdffNB1QkJiAvcteNQM6pQUkyQUiQILbBqQwZr7TPNH
         ocJTXZ41IijUnx1RVTHqGeprnuuNWV+j+sx5w=
Received: by 10.151.88.13 with SMTP id q13mr12000643ybl.21.1272930427404;
        Mon, 03 May 2010 16:47:07 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm4712647iwn.9.2010.05.03.16.47.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 16:47:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100503233604.GA27451@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146274>

Spell out =E2=80=9Cor=E2=80=9D in the NAME line and simplify the leadin=
g sentence
in the DESCRIPTION.

Some other language cleanups, too.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That=E2=80=99s the end of the series.  Nothing dramatic, but I thought =
this
basic information could help.  Thanks for looking it over.

While I have your attention: the original man page said

  To disable commit notes, you have to set the config variable
  core.notesRef to the empty string.  Alternatively, you can set it
  to a different ref, something like "refs/notes/bugzilla".  This setti=
ng
  can be overridden by the environment variable "GIT_NOTES_REF".

which sounds helpful to me, both as an example and as a way to help
people who do not want to use the feature.  Any idea where we could
add it back?

 Documentation/git-notes.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 273264b..b953575 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -3,7 +3,7 @@ git-notes(1)
=20
 NAME
 ----
-git-notes - Add/inspect object notes
+git-notes - Add or inspect object notes
=20
 SYNOPSIS
 --------
@@ -20,8 +20,8 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-This command allows you to add/remove notes to/from objects, without
-changing the objects themselves.
+Adds, removes, or reads notes attached to objects, without touching
+the objects themselves.
=20
 By default, notes are saved to and read from `refs/notes/commits`, but
 this default can be overridden.  See the CONFIGURATION and ENVIRONMENT
@@ -31,14 +31,14 @@ Notes can contain any sequence of non-null bytes.  =
Since they are
 sanitized with linkgit:git-stripspace[1], empty lines other than a
 single line separating paragraphs are not significant.
=20
-A typical use of notes is to extend a commit message without having
-to change the commit itself. Such commit notes can be shown by `git lo=
g`
-along with the original commit message. To discern these notes from th=
e
+A typical use of notes is to supplement a commit message without
+changing the commit itself. Notes can be shown by 'git log' along with
+the original commit message. To distinguish these notes from the
 message stored in the commit object, the notes are indented like the
 message, after an unindented line saying "Notes (<refname>):" (or
-"Notes:" for the default setting).
+"Notes:" for the main notes ref).
=20
-See the "notes.rewrite.<command>" configuration for a way of carrying
+See the "notes.rewrite.<command>" configuration for a way to carry
 notes across commands that rewrite commits.
=20
=20
--=20
1.7.1
