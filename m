From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] gitignore: Ignore the new /git-remote-{ext,fd} helpers
Date: Mon, 19 Jul 2010 18:50:27 +0000
Message-ID: <1279565427-413-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 19 20:50:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OavQR-0004Mv-WA
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 20:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025Ab0GSSuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 14:50:44 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53122 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936486Ab0GSSun (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 14:50:43 -0400
Received: by eya25 with SMTP id 25so1053700eya.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=0L9qgd1h2EVc923naMkFSCOamPkXeUqKHjO2tz9uurM=;
        b=Sj5cbdzAuuqT/5Gb9uBVzzeq8Y/Aas1O1RC9FRMBFg3KTzMn6bBEnhOIdqSIGcZoN2
         GJNlI27PJHV23Ce1t7/O4yiqLnGJpUtx95ELTyD8I5ks/Kswq1tu8G6L3UgJDqIhl0Lt
         qb0DzKuH/YdXIJddexgXc9PrnwdoaCMDfVbFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=SUc4SMpq3crQPWqBUbjvA9+n1Z56iQz1fGZJN807TVwakIls4BP+zvI/ctxP8ebIHf
         7CzDhtAvfaEutFsmV4o1vkZVyo5Gb/wrIUvmwMUsI8sz9VjjZbz9+gn645IssUEibt1S
         jkob6O3FxT3Ars1OCjpm5vaKUd7v73dJUxSZw=
Received: by 10.213.7.2 with SMTP id b2mr3452330ebb.40.1279565440345;
        Mon, 19 Jul 2010 11:50:40 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-233-160.pools.arcor-ip.net [88.67.233.160])
        by mx.google.com with ESMTPS id z55sm49764987eeh.21.2010.07.19.11.50.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 11:50:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.125.g94e09.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151269>

Change the top-level .gitignore to include the new
/git-remote-{ext,fd} helpers. They were added as part of the
il/rfc-remote-fd-ext, but .gitignore wasn't proprely updated in that
series..

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2cb4e8e..eda6fbc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -108,6 +108,8 @@
 /git-relink
 /git-remote
 /git-remote-curl
+/git-remote-ext
+/git-remote-fd
 /git-remote-http
 /git-remote-https
 /git-remote-ftp
--=20
1.7.2.rc3.125.g94e09.dirty
