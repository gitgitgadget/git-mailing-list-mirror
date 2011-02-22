From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 09/73] gettextize: git-clone "Cloning into" message
Date: Tue, 22 Feb 2011 23:41:28 +0000
Message-ID: <1298418152-27789-10-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1wp-0001H8-KF
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab1BVXnt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:49 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab1BVXnk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:40 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=M3z7S/T0p6NgcsQiyBYERLKmCeIj8OSrRdDempqzV9I=;
        b=qaGSRqv7Et3o7JO/Z+Th2P5HEt7KlWzjbyjrUkOJrjk9pKHBrPzDARFgYlCemUJRwV
         8ARUiMBlB8loZ4MeOLGBRPLFwDehSRqV0XbfXjskn8XBKEo0SuZgbjJf6PT1BGNO3dZI
         /a5uC0sytHOwcaLoxqNTzzlbltUwJvuu18tLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Elk+FV0jLoJmSqjGjGtdRDLMWkAKI3DHI3wPlxMV9wjt79EAYEkeWC/0sa4e2lcBv1
         o3dkwgvXi4113ZZUeWaW1/xh2w3Bup9Wd5aUy5meAqIqpwVD3mr+Hy5Ka9b4SJF4v+4v
         368hs1GuJ21eMJieBp11YvK1o0Zfcx4kDqBTc=
Received: by 10.204.14.204 with SMTP id h12mr3113209bka.183.1298418219517;
        Tue, 22 Feb 2011 15:43:39 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.38
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:38 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167644>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/clone.c  |    4 ++--
 t/t5601-clone.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index db0240d..b9394c4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -470,9 +470,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (0 <=3D option_verbosity) {
 		if (option_bare)
-			printf("Cloning into bare repository %s...\n", dir);
+			printf(_("Cloning into bare repository %s...\n"), dir);
 		else
-			printf("Cloning into %s...\n", dir);
+			printf(_("Cloning into %s...\n"), dir);
 	}
 	init_db(option_template, INIT_DB_QUIET);
=20
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 987e0c8..9e6fa3b 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -31,7 +31,7 @@ test_expect_success 'clone with excess parameters (2)=
' '
=20
 '
=20
-test_expect_success 'output from clone' '
+test_expect_success C_LOCALE_OUTPUT 'output from clone' '
 	rm -fr dst &&
 	git clone -n "file://$(pwd)/src" dst >output &&
 	test $(grep Clon output | wc -l) =3D 1
--=20
1.7.2.3
