From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 10/48] i18n: git-am "Falling back" say message
Date: Sat, 21 May 2011 18:43:51 +0000
Message-ID: <1306003469-22939-11-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCt-0001Bj-Rd
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235Ab1EUSrU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:47:20 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64800 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540Ab1EUSpL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:11 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444610eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=YioGMHiw8JZTAdGzviPxDBWBDXlXG0NBOZaGQwaGvFI=;
        b=RM0QKLZxan0CrnixrQj4Xeuy3Iw4uKVWTtMjkiKXDAzJHtA2drbd+NOWyb5+ehrdNq
         izwSgu4nuMXECAuuML+OSs8DdNUjFj+/iWFJ3Wcnfs8f7xQIKBZ7+6OtKsYV2tk75l8D
         fBV3Ioid5JM7Xw9ZnF1TLV9oJAhj6NvrDCYaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=n61/2m0+KWygPdKOAFx5hSpxEIAZlYZspbo0JDkFxU9qTsF4nzoRac95gLjDjekwtb
         I1zGd1IEhkErPvCZZgtiMf8QZbVa8uP4LzMrFBd4Q7O40XghvlUiL3E0udEdMGZbwGNE
         dqm7qBdt/h83+uLWkCgSbM54Ruj+bLJbbf0os=
Received: by 10.14.50.3 with SMTP id y3mr255408eeb.225.1306003511252;
        Sat, 21 May 2011 11:45:11 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.10
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174160>

Make the "Falling back to patching base and 3-way merge..." message
used by fall_back_3way() translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e5edb55..aa52b51 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -151,7 +151,7 @@ It does not apply to blobs recorded in its index.")=
"
     orig_tree=3D$(cat "$dotest/patch-merge-base") &&
     rm -fr "$dotest"/patch-merge-* || exit 1
=20
-    say Falling back to patching base and 3-way merge...
+    say "$(gettext "Falling back to patching base and 3-way merge...")=
"
=20
     # This is not so wrong.  Depending on which base we picked,
     # orig_tree may be wildly different from ours, but his_tree
--=20
1.7.5.1
