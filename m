From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 2/7] i18n: mark merge "Could not read from" message for translation
Date: Sun, 10 Apr 2011 19:34:03 +0000
Message-ID: <1302464048-21806-3-git-send-email-avarab@gmail.com>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 21:34:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90P3-00036n-Ht
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab1DJTeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 15:34:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37883 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874Ab1DJTeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 15:34:21 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1532438ewy.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=pkWd6wSbOa2v6/YnEXk2JLC7wasoUsjhiXyCu8i4yy8=;
        b=sQyegdxZI+kXcotASfyS5L6UhB3RF1oiw8n+0zQuPREt6i99YYXhabnoAHG0v0WBH2
         vlzpLVmJkqorp/SsHDFXSgLsa4H5os1/IHdwpbKr8BBIC2DvejsWO0DxlQlBxnixg0SI
         6OXrrJ6VubS5Okm+edFoYLLm9VYsgEn4OLfM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LSwHImxDYwTZ+ibqOgs0nCu/eGUWjLD9c6rT3pj5GT+TkTuoqOWPKCabKj21ehuFXr
         rGouarKUahZivztUcL0UWRciKgZCDBr/uQFtFSF7mvTP/mb/Mgx8mJSTOcJv3MFoorUm
         K72lIhKFnAq/RjNy8OmOKJzqPTwRoZ3p9dv2s=
Received: by 10.213.32.147 with SMTP id c19mr728461ebd.29.1302464060358;
        Sun, 10 Apr 2011 12:34:20 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id m55sm1147236eei.8.2011.04.10.12.34.18
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:34:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171275>

Mark the "Could not read from '%s'" message that was added to
builtin/merge.c in v1.7.4.2~25^2 (merge: honor prepare-commit-msg
hook) by Jay Soffian for translation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/merge.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d54e7dd..7eda05d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -822,7 +822,7 @@ static void read_merge_msg(void)
 {
 	strbuf_reset(&merge_msg);
 	if (strbuf_read_file(&merge_msg, git_path("MERGE_MSG"), 0) < 0)
-		die_errno("Could not read from '%s'", git_path("MERGE_MSG"));
+		die_errno(_("Could not read from '%s'"), git_path("MERGE_MSG"));
 }
=20
 static void run_prepare_commit_msg(void)
--=20
1.7.4.1
