From: Holger =?utf-8?B?V2Vpw58=?= <holger@zedat.fu-berlin.de>
Subject: [PATCH] Documentation: Fix description of archive "--prefix"
Date: Wed, 29 Apr 2009 15:42:36 +0200
Organization: Freie =?utf-8?Q?Universit=C3=A4t?= Berlin
Message-ID: <20090429134236.GU36958498@CIS.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 15:42:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzA3l-00016M-D7
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 15:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbZD2Nml convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 09:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbZD2Nmk
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 09:42:40 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:35533 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751260AbZD2Nmk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 09:42:40 -0400
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1LzA3a-0002kx-MS>; Wed, 29 Apr 2009 15:42:38 +0200
Received: from mail.cis.fu-berlin.de ([160.45.11.138])
          by relay1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1LzA3Y-0003al-Vk>; Wed, 29 Apr 2009 15:42:37 +0200
Received: by Mail.CIS.FU-Berlin.DE (Exim 4.69)
          with local
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1LzA3Y-02iNjC-QB>; Wed, 29 Apr 2009 15:42:36 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Content-Disposition: inline
X-Operating-System: IRIX64 6.5.30f
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Originating-IP: 160.45.11.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117890>

The description of the "--prefix" option suggested that a slash would
automatically be appended to the specified <prefix>, which is not the
case.

Signed-off-by: Holger Wei=C3=9F <holger@zedat.fu-berlin.de>
---
 Documentation/git-archive.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index ad38f7f..6848e62 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -9,7 +9,7 @@ git-archive - Create an archive of files from a named t=
ree
 SYNOPSIS
 --------
 [verse]
-'git archive' --format=3D<fmt> [--list] [--prefix=3D<prefix>/] [<extra=
>]
+'git archive' --format=3D<fmt> [--list] [--prefix=3D<prefix>] [<extra>=
]
 	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <tree-ish>
 	      [path...]
=20
@@ -44,8 +44,8 @@ OPTIONS
 --verbose::
 	Report progress to stderr.
=20
---prefix=3D<prefix>/::
-	Prepend <prefix>/ to each filename in the archive.
+--prefix=3D<prefix>::
+	Prepend <prefix> to each filename in the archive.
=20
 <extra>::
 	This can be any options that the archiver backend understands.
--=20
1.6.2.4
