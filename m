From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/15] clone: mark "Cloning into" message for translation
Date: Mon, 21 Feb 2011 04:19:19 -0600
Message-ID: <20110221101919.GJ32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:19:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSrb-0002kw-Hp
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246Ab1BUKT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:19:27 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39984 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab1BUKT0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:19:26 -0500
Received: by iyb26 with SMTP id 26so558151iyb.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ff/RHIVhQJktsmyxD/8lkph8zPKqbSQP2kBi6bY51XQ=;
        b=qfPfsKJ96G9vKhH5WxxMzsj4gZJE30aagI8mzVLPKgiM9ReyyshDOQa/fd5v+LrhAj
         BuEVx2gkbCHTUMHnseKl4DwnJpf8yhUKkDmwUNWlMSKkNAru6SGM5OT8q0QQVCNuAPK4
         yR3yuM7hGbU3ps+ssuUUSPUNV+aCosjIH5Uis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uIHSsRASWMx8Bjd7qZWz3SG2Qa6dDzYizXpWzJYEnDCXe9vtiQDRGgwCVb7bPFS6Vg
         EqTJf6iIJ7k+KjnIIMK8Ep7XeOEhHGhTYk/9KFFNz/ej0mVfEj2kS/tbS/6o2T31ql2n
         N2xYM4kvuPF3BD166C2RpghmwH/0vGML3+MC4=
Received: by 10.42.224.2 with SMTP id im2mr1747089icb.53.1298283565498;
        Mon, 21 Feb 2011 02:19:25 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id d21sm5040133ibg.3.2011.02.21.02.19.23
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:19:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167464>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date: Wed, 1 Sep 2010 15:54:30 +0000

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
1.7.4.1
