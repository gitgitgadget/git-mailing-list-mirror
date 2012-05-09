From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re:  [RFC PATCH] Documentation: diff produces patches, which can be 'apply'd
Date: Wed, 9 May 2012 22:38:22 +0100
Organization: OPDS
Message-ID: <A717EB2D296E40C2AF5A3A19C97C24DA@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003F_01CD2E34.704EC540"
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 09 23:38:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSEaW-0008Jq-TA
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 23:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213Ab2EIViU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 17:38:20 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:58398 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758093Ab2EIViT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 17:38:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAFAPXiqk9cHlGK/2dsb2JhbABEiz2oAIEIggcBBAEBDQEBTAIsAggCAQMRAwEBAQo5AQQaBgcPDhMIAgECAwGFOAeCKBoHmhuGS5ptiwwZhS1jBIgwhUp9iBePMIJqgVUHAQ
X-IronPort-AV: E=Sophos;i="4.75,559,1330905600"; 
   d="scan'208,223";a="380402230"
Received: from host-92-30-81-138.as13285.net (HELO PhilipOakley) ([92.30.81.138])
  by out1.ip05ir2.opaltelecom.net with SMTP; 09 May 2012 22:38:17 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197517>

This is a multi-part message in MIME format.

------=_NextPart_000_003F_01CD2E34.704EC540
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit

With attachment this time. In-text readable copy below.

From: "Philip Oakley" <philipoakley@iee.org> Sent: Wednesday, May 09, 2012 2:17 PM
> This attached patch (my first) suggests a couple of small documenation changes for 'diff' based on Junio's supportive comments at
> http://article.gmane.org/gmane.comp.version-control.git/197282
> 
> The purpose of the patch is to make users aware of the apply command as a companion to diff.
> 
> If changing the NAME text is considered inappropriate, the same change could just as easily be applied to the start of the 
> DESCRIPTION.
> 
> I haven't sorted out using 'send-mail' for patches yet, so I've attached it.
> The patch was generated with "git format-patch -M" as per directions.
> The patch was on top of tag v1.7.10.msysgit.0 from https://github.com/msysgit/git
> 
> Comments?
> 
> Philip
>
This may be white space damaged
---
From 54824f78e0b8389d506661a7db35b6a7f74d0664 Mon Sep 17 00:00:00 2001
From: Philip Oakley <philipoakley@iee.org>
Date: Tue, 8 May 2012 17:28:41 +0100
Subject: [PATCH] Documentation: diff produces patches, which can be 'apply'd

Tell users from different work environments that the diff format
is usually a patch. Tell them the git command to implement such
a patch is 'git apply'.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

If changing the NAME text is considered inappropriate, the same change
could just as easily be applied to the start of the DESCRIPTION.

 Documentation/git-diff.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index f8d0819..b2d2c06 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -3,7 +3,7 @@ git-diff(1)
 
 NAME
 ----
-git-diff - Show changes between commits, commit and working tree, etc
+git-diff - Show changes, usually as a patch, between commits, commit and working tree, etc
 
 
 SYNOPSIS
@@ -18,7 +18,8 @@ DESCRIPTION
 -----------
 Show changes between the working tree and the index or a tree, changes
 between the index and a tree, changes between two trees, or changes
-between two files on disk.
+between two files on disk. You can implement a diff's patch using linkgit:git-apply[1].
+
 
 'git diff' [--options] [--] [<path>...]::
 
-- 
1.7.8.msysgit.0


------=_NextPart_000_003F_01CD2E34.704EC540
Content-Type: application/octet-stream;
	name="0001-Documentation-diff-produces-patches-which-can-be-app.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Documentation-diff-produces-patches-which-can-be-app.patch"

>From 54824f78e0b8389d506661a7db35b6a7f74d0664 Mon Sep 17 00:00:00 2001=0A=
From: Philip Oakley <philipoakley@iee.org>=0A=
Date: Tue, 8 May 2012 17:28:41 +0100=0A=
Subject: [PATCH] Documentation: diff produces patches, which can be =
'apply'd=0A=
=0A=
Tell users from different work environments that the diff format=0A=
is usually a patch. Tell them the git command to implement such=0A=
a patch is 'git apply'.=0A=
=0A=
Signed-off-by: Philip Oakley <philipoakley@iee.org>=0A=
---=0A=
=0A=
If changing the NAME text is considered inappropriate, the same change=0A=
could just as easily be applied to the start of the DESCRIPTION.=0A=
=0A=
 Documentation/git-diff.txt |    5 +++--=0A=
 1 files changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt=0A=
index f8d0819..b2d2c06 100644=0A=
--- a/Documentation/git-diff.txt=0A=
+++ b/Documentation/git-diff.txt=0A=
@@ -3,7 +3,7 @@ git-diff(1)=0A=
 =0A=
 NAME=0A=
 ----=0A=
-git-diff - Show changes between commits, commit and working tree, etc=0A=
+git-diff - Show changes, usually as a patch, between commits, commit =
and working tree, etc=0A=
 =0A=
 =0A=
 SYNOPSIS=0A=
@@ -18,7 +18,8 @@ DESCRIPTION=0A=
 -----------=0A=
 Show changes between the working tree and the index or a tree, changes=0A=
 between the index and a tree, changes between two trees, or changes=0A=
-between two files on disk.=0A=
+between two files on disk. You can implement a diff's patch using =
linkgit:git-apply[1].=0A=
+=0A=
 =0A=
 'git diff' [--options] [--] [<path>...]::=0A=
 =0A=
-- =0A=
1.7.8.msysgit.0=0A=
=0A=

------=_NextPart_000_003F_01CD2E34.704EC540--
