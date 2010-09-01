From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 05/13] gettextize: git-add refresh_index message
Date: Wed,  1 Sep 2010 20:43:57 +0000
Message-ID: <1283373845-2022-6-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 22:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquBS-000790-7d
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629Ab0IAUoj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:44:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34335 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab0IAUog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:44:36 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so9681721wyb.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8L9+AE4Myiubj8jGM/iQRmmtFVJhUCBZzA+UUsqvQIk=;
        b=KrrXmnLiS38KTC1/930ILzy27khc9E8ScIe59g+ifBN6hgUM5zPuu+B+qh5G4B0tRz
         ZYhLgaqi7D0daT2F5XBbhsSr2wvKuf/jlxYQRpGD++hdRKgKs6iaxGQ0f9RgICvmiod4
         PZc1ttENT7A7/Iby9yuWqLrIk63AZXBI8YBWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Jy/WSD4BlbgD4Hg1C4oTJDqC5EDWRTeUwVUXaqI/uLqSU5adwn9+RpSVHvD+Wsb+p5
         9IFvQg9zUu07NZYa/A+GVthYjei/9ob52vRKnhBPuQ0hnCndUHcm60FTtS0mRNee3wmI
         2oxmkxaMKEBoM5L382B2K75E9BT04X8K306GE=
Received: by 10.216.44.141 with SMTP id n13mr374148web.16.1283373875932;
        Wed, 01 Sep 2010 13:44:35 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm6461150weq.16.2010.09.01.13.44.34
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:44:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.579.g2183d
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155085>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

I can't find the command that makes this message appear, but it seems
to be a human-readable header printed by "git-add".

 builtin/add.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 6578cdd..eed37bf 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -188,7 +188,7 @@ static void refresh(int verbose, const char **paths=
pec)
 		/* nothing */;
 	seen =3D xcalloc(specs, 1);
 	refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QU=
IET,
-		      pathspec, seen, "Unstaged changes after refreshing the index:"=
);
+		      pathspec, seen, _("Unstaged changes after refreshing the index=
:"));
 	for (i =3D 0; i < specs; i++) {
 		if (!seen[i])
 			die(_("pathspec '%s' did not match any files"), pathspec[i]);
--=20
1.7.2.2.579.g2183d
