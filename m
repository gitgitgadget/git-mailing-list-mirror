From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/8] Documentation/notes: nitpicks
Date: Sat, 8 May 2010 22:37:21 -0500
Message-ID: <20100509033721.GH7958@progeny.tock>
References: <20100509031357.GA7926@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 05:36:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAxJY-00057h-21
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 05:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656Ab0EIDgT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 23:36:19 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:45704 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab0EIDgS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 23:36:18 -0400
Received: by yxe1 with SMTP id 1so1740506yxe.33
        for <git@vger.kernel.org>; Sat, 08 May 2010 20:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dlQA0JxNaU/5yh60V0/wBNWmF434M2LxLWGlsOl/BPg=;
        b=nsBAyrZ2aPv82hRQkmlqP8Lj0jwPPLzVrZHsqgfgXpy+0mMky9wUdKTjETVP+dftup
         qdis4Guuu9piK1j+hSMNWEdvMu32JikxcmFZqm/cuYCbQiWYHZcT42s+ee8LAFEygS/D
         X+Trl2VB/p6ia8/3JAc7AcyHB992FyErkRibg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sTeHbIz9YUVpXCRtHpuBaFynC/VPnrVtKpxGy5Jkj67Yzj8sBhBMn+ugIAKI2RG2wQ
         3PkH2hiHRpYRvDsXjDV3eqkaah91ztslaSgix7b1Kbuog+x1l78bGMvaJnTAoelayrqf
         PjC9SUMA61aa+1x5MkGlj4j64m9z0uj5hsUBg=
Received: by 10.150.132.17 with SMTP id f17mr6004632ybd.286.1273376177664;
        Sat, 08 May 2010 20:36:17 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2581621yxe.5.2010.05.08.20.36.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 20:36:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509031357.GA7926@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146699>

Spell out =E2=80=9Cor=E2=80=9D in the NAME line and simplify the leadin=
g sentence
in the DESCRIPTION.

Some other language cleanups, too.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before, except the =E2=80=9Cdefault setting=E2=80=9D nitpick moved t=
o an earlier
patch.

That=E2=80=99s the end of the series.  Thanks for your help.

Good night,
Jonathan

 Documentation/git-notes.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index d868535..de63ef0 100644
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
@@ -20,17 +20,17 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-This command allows you to add/remove notes to/from objects, without
-changing the objects themselves.
+Adds, removes, or reads notes attached to objects, without touching
+the objects themselves.
=20
 By default, notes are saved to and read from `refs/notes/commits`, but
 this default can be overridden.  See the OPTIONS, CONFIGURATION, and
 ENVIRONMENT sections below.  If this ref does not exist, it will be
 quietly created when it is first needed to store a note.
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
 "Notes:" for `refs/notes/commits`).
--=20
1.7.1
