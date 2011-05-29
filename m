From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] git-sh-i18n--envsubst: add SYNOPSIS section to the documentation
Date: Sun, 29 May 2011 11:00:35 +0000
Message-ID: <1306666835-8978-1-git-send-email-avarab@gmail.com>
References: <BANLkTikjfyxAzLu2e5aJFVhgKq8UBiJAQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 13:00:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQdjp-0003nX-Jp
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 13:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab1E2LAs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2011 07:00:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55933 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab1E2LAr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 07:00:47 -0400
Received: by ewy4 with SMTP id 4so1064160ewy.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 04:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=aFG20ODFwoUfgc1VUOd0S8nVgNdsI78EFNOxewfkIh0=;
        b=Hst6Ta2ZMyrvoVSz1ka0RvEDTk7O9HRdryhRBZHXJ2fz9RH2hwDXMwR/3Mgcofw6Q9
         /NVXidy1oO3hkHaZiXsSrLDVUU71U7XyuFjfddi0CRWgv5U+OEQgWkuYo/sSfCvOWAiS
         VePBBCz+GODJBgyw+Te71UUZWtyP/rtqgWKJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GpDlAanCvb2t+PznoQUAGgoW56PX0kQNrcwu7klYjBWX6omXhGLpbHu/osvD9xIU40
         TBXgh6Obf920QRMjWUo6RSOtQ51eFUWthUYM1dz1h8bsZFeVeBUFv9GaE1SFzQK8jatU
         GIK5Vre2siuBv4SdGEl/40VdxxvI4E/KByJFE=
Received: by 10.213.110.6 with SMTP id l6mr1439580ebp.48.1306666846323;
        Sun, 29 May 2011 04:00:46 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id s53sm1689969ees.21.2011.05.29.04.00.45
        (version=SSLv3 cipher=OTHER);
        Sun, 29 May 2011 04:00:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <BANLkTikjfyxAzLu2e5aJFVhgKq8UBiJAQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174687>

Change the documentation for the git-sh-i18n--envsubst program to
include a SYNOPSIS section. Include the invocation of the program from
git-sh-i18n.sh.

Not having a SYNOPSIS section caused the "doc" target to fail on
Centos 5.5 with asciidoc 8.2.5, while building with 8.6.4 on Debian
works just fine.

The relevant error was:

    ERROR: git-sh-i18n--envsubst.txt: line 9: second section must be na=
med SYNOPSIS

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/git-sh-i18n--envsubst.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-sh-i18n--envsubst.txt b/Documentation/gi=
t-sh-i18n--envsubst.txt
index f5bbf77..61e4c08 100644
--- a/Documentation/git-sh-i18n--envsubst.txt
+++ b/Documentation/git-sh-i18n--envsubst.txt
@@ -5,6 +5,16 @@ NAME
 ----
 git-sh-i18n--envsubst - Git's own envsubst(1) for i18n fallbacks
=20
+SYNOPSIS
+--------
+[verse]
+eval_gettext () {
+	printf "%s" "$1" | (
+		export PATH $('git sh-i18n--envsubst' --variables "$1");
+		'git sh-i18n--envsubst' "$1"
+	)
+}
+
 DESCRIPTION
 -----------
=20
--=20
1.7.5.1
