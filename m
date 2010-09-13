From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 1/8] gettextize: git-pull add git-sh-i18n
Date: Mon, 13 Sep 2010 19:35:51 +0000
Message-ID: <1284406558-23684-2-git-send-email-avarab@gmail.com>
References: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 21:36:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvEpO-0005HT-0k
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 21:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183Ab0IMTgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 15:36:12 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56015 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab0IMTgL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 15:36:11 -0400
Received: by eyb6 with SMTP id 6so2866593eyb.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OCS9c6BJ58Wf4rvbxEGOC1RXjU5oWEuw0YdfxL7dYqo=;
        b=GrUvbp2AUa1On29KANeFqbsONhXz0UiAb+ZhiMwEKODFI9KWcEPs0c6ROSyxh8ibOM
         kQdbgQHYskesPjVXxG0hsu0KJHvFbATIAI2/VJnovA4ji9OInJC5BZbaXtIhfDvsOw42
         6PmtyMh9ND+Any59kixqBZvvvqMXlU1eJSL/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AvOmVQ3EK3BO0OLdwaMhfEr84wN/7rGa+88hYOhrWBShcxcrv/4j2W9w3TQJbP16PN
         hM1BRbCNBXeb2ZlaIzlr08P4akxMT0jFSvd3YGVLjOnShKbY4EfnMPifDIA12nen2P4Y
         0jRkxmozUDxf0KIA4SIuw0JA2/FQ/+zentmRU=
Received: by 10.216.22.131 with SMTP id t3mr3734599wet.39.1284406570292;
        Mon, 13 Sep 2010 12:36:10 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm4178195wej.2.2010.09.13.12.36.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 12:36:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.110.g6776a.dirty
In-Reply-To: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156121>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 8eb74d4..544b73f 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -9,6 +9,7 @@ LONG_USAGE=3D'Fetch one or more remote refs and merge i=
t/them into the current HEA
 SUBDIRECTORY_OK=3DYes
 OPTIONS_SPEC=3D
 . git-sh-setup
+. git-sh-i18n
 set_reflog_action "pull $*"
 require_work_tree
 cd_to_toplevel
--=20
1.7.3.rc1.110.g6776a.dirty
