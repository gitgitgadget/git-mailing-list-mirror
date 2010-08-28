From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/3] gettext: msgmerge is.po and add Language: header
Date: Sat, 28 Aug 2010 17:54:23 +0000
Message-ID: <1283018063-4256-4-git-send-email-avarab@gmail.com>
References: <1283018063-4256-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 28 19:54:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpPcE-0001Lz-82
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 19:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab0H1Ryu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Aug 2010 13:54:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39604 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab0H1Ryh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 13:54:37 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so5021859wyb.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=nkQAEQJJdlbN8EQwcqBEe7cKPU7trSUO4zqD9aw6FO8=;
        b=aWtE24ElhpqW8DJkylvjDGe3Q1eogUR8a6VunpbyTZZVDilG4WecVGcWVRlmw44q+t
         zwX9p3uySGWhj4WDfTjgi28ez/Th1ogo6ZYOkr4BdNXTuvCMgip5sxnYv6BOAqmSx0OC
         1q4CGY7FtpHQVZzffyeHf8vLKfJbX1Ha7yc60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Xxlf7SdYwp7Hohhudn1ymviDLvOPmFeEDz6PYF4xMDQm9AsbzSBx5LBrarCRu6uYji
         jdIUMwvHrquA5bttXPozXwE2arofZN+lf+frciHO2+uMQlfsFqLCbM0/LjlO8AwNSshv
         RJBM9am4y2MGfjI/hW5px47GaMHe4b4d3vrXs=
Received: by 10.216.30.207 with SMTP id k57mr2528117wea.88.1283018076757;
        Sat, 28 Aug 2010 10:54:36 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id o15sm78280wer.39.2010.08.28.10.54.35
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 10:54:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.g82b8
In-Reply-To: <1283018063-4256-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154653>

Change is.po to use the header order added by msgmerge(1), this'll
make subsequent diffs to it smaller and easier to manage. While I'm at
it add a Language header indicating that the file is in
Icelandic.

When we add more *.po files later we should add a Language header to
those as well.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/is.po |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/po/is.po b/po/is.po
index 2f3a220..d34cade 100644
--- a/po/is.po
+++ b/po/is.po
@@ -1,10 +1,12 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: Git\n"
-"PO-Revision-Date: 2010-06-05 19:06 +0000\n"
-"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2010-08-28 17:38+0000\n"
+"PO-Revision-Date: 2010-08-28 17:27+0000\n"
 "Last-Translator: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
=2Ecom>\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"Language: is\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
--=20
1.7.2.2.513.g82b8
