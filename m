From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] gitattributes.txt: mention exceptions to gitignore rules
Date: Tue,  4 Jan 2011 20:31:55 +0700
Message-ID: <1294147915-1475-1-git-send-email-pclouds@gmail.com>
References: <iftvu6@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Marcin=20Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 14:33:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa712-0008Eb-VT
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 14:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028Ab1ADNd2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 08:33:28 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:44482 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab1ADNd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 08:33:27 -0500
Received: by pxi15 with SMTP id 15so2599509pxi.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 05:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8byQi8ymRYaBOxQmYbkAva0aT7+nTm1NsgBu68HoOYM=;
        b=sodC1eWFpn5LP1iktp9rOtNGPLqueQnSVauY/YC8lP6EWpXQJgVKmdrNVYTc2vadjm
         fr/ms2K9g+HKQDnhUGkwTntKwQd/JAklFYoWenmav/0FWNGZTELs4u4jXkM9eiLReyu9
         lL9hGysK+oWicgWEBo2nHczJ6fYs5MqoLN3Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fMIUPYTU3s0jq/ww5q2gTcLg6l/tzbJdKBMIW34VkAy3Kr/dNOb+Aw1qsPOOCIikTY
         M7D9LdZyKyMNKs+UKShRMnyCO2Qhr/xqyFk2KsSwIPFPGkPvS07Lz0ubGywDkRyOgDRf
         VYW6y8f5KD/saGXlWZ+5rOAV5jIn4mVeN8BlQ=
Received: by 10.142.141.17 with SMTP id o17mr17762193wfd.124.1294148006670;
        Tue, 04 Jan 2011 05:33:26 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.202.17])
        by mx.google.com with ESMTPS id w22sm30888548wfd.19.2011.01.04.05.33.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 05:33:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 04 Jan 2011 20:31:57 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <iftvu6@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164492>

gitattr and .gitignore are supposed to use the same rules for matching
patterns. Unfortunately it's not exactly the same in reality. Mention
the differences so users won't be surprised, until gitattr gets
updates.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2011/1/4 Marcin Wi=C5=9Bnicki <mwisnicki@gmail.com>:
 > I think that for the time being at least the manual page must change=
 to
 > reflect reality.

 Looks like changes will be more than just a few lines because path_mat=
ches()
 needs to learn about directories (iow less likely to get fixed right a=
way).
 So, yes, good idea.

 I skimmed through excluded_from_list() (gitignore) and path_matches (g=
itattr).
 Seems no other differences.

 Documentation/gitattributes.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 5a7f936..cfaf107 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -56,6 +56,7 @@ When more than one pattern matches the path, a later =
line
 overrides an earlier line.  This overriding is done per
 attribute.  The rules how the pattern matches paths are the
 same as in `.gitignore` files; see linkgit:gitignore[5].
+However patterns that end with a slash is not supported.
=20
 When deciding what attributes are assigned to a path, git
 consults `$GIT_DIR/info/attributes` file (which has the highest
--=20
1.7.3.4.878.g439c7
