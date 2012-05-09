From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 04/19] completion: respect $GIT_DIR
Date: Wed, 09 May 2012 10:09:30 +0200
Message-ID: <4FAA263A.4000207@viscovery.net>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de> <1336524290-30023-5-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 10:09:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS1y4-0005Xx-Sh
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 10:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757977Ab2EIIJg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 04:09:36 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:29556 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757926Ab2EIIJc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 04:09:32 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SS1xj-0001S0-88; Wed, 09 May 2012 10:09:31 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EAF301660F;
	Wed,  9 May 2012 10:09:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1336524290-30023-5-git-send-email-szeder@ira.uka.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197459>

Am 5/9/2012 2:44, schrieb SZEDER G=C3=A1bor:
> +test_expect_success 'gitdir - non-existing $GIT_DIR' '
> +	(
> +		GIT_DIR=3D"$TRASH_DIRECTORY/non-existing" &&
> +		export GIT_DIR &&
> +		test_must_fail __gitdir
> +	)
> +'

Another fixup, but it is only for consistency.

--- >8 ---
=46rom: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] fixup! completion: respect $GIT_DIR

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9903-bash-prompt.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index cf8e0ca..0318288 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -108,7 +108,7 @@ test_expect_success 'gitdir - $GIT_DIR set while .g=
it directory in parent' '
=20
 test_expect_success 'gitdir - non-existing $GIT_DIR' '
 	(
-		GIT_DIR=3D"$TRASH_DIRECTORY/non-existing" &&
+		GIT_DIR=3D"$(pwd)/non-existing" &&
 		export GIT_DIR &&
 		test_must_fail __gitdir
 	)
--=20
1.7.10.1.1689.gacdfbde
