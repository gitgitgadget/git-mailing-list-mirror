From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 10/20] gettextize: git-bisect add git-sh-i18n
Date: Tue, 14 Sep 2010 13:52:10 +0000
Message-ID: <1284472340-7049-11-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 16:00:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvW3k-0001BA-PQ
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 16:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab0INOAT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 10:00:19 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59709 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab0INOAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 10:00:16 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so146788wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=tanOvnkGt450NI8JPXZhx6q5HTjG95OXGn6vtQA8ODE=;
        b=gC0MOjXvaDcdaWCLGRMXj3mRZWuGWZpCPFrzu1U/JQrgSCzKdqtO305Pc0MyDkfkfr
         PqegbJieDhYcqgxUcQr07xBlhj3IiJvwkKfZX/2XRbx1Zk8ikOYiuJZqTxPdjOjbp0xg
         ecQJjPBsh7NaReglbyOaa88vnz4iKUUw/jGE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pnD8c4BXHLpdldPAlo5ZACBHrjTsD6aYPbo+0R/UNz/YHjL6My1ijhqX65jx94lx/l
         8zEDT3KtII6AyWbFi0wNt3UbFSjZ+yJryiodsJeJVyREbzBJEo2NePv9chvSfp3W7w3b
         YJGVPigbvmbqHhzIGU+8wY+42Au2jffFt/RY8=
Received: by 10.216.11.131 with SMTP id 3mr3925871wex.92.1284472394917;
        Tue, 14 Sep 2010 06:53:14 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.53.12
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:53:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156190>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 6e2acb8..d0d95f6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -28,6 +28,7 @@ Please use "git help bisect" to get the full man page=
=2E'
=20
 OPTIONS_SPEC=3D
 . git-sh-setup
+. git-sh-i18n
 require_work_tree
=20
 _x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
--=20
1.7.3.rc1.234.g8dc15
