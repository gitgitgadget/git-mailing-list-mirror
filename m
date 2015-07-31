From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 2/2] Testing the new code
Date: Fri, 31 Jul 2015 16:09:07 -0700
Message-ID: <1438384147-3275-3-git-send-email-sbeller@google.com>
References: <1438384147-3275-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
	hvoigt@hvoigt.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 01:09:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLJQw-0001WE-93
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 01:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbbGaXJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2015 19:09:40 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34693 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbbGaXJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 19:09:37 -0400
Received: by pacan13 with SMTP id an13so48375334pac.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:in-reply-to:references:content-type
         :content-transfer-encoding;
        bh=sfUpvj7cDMqDboK9nxeY4QAU1woSKUKFF2VJ6Cn6Xuc=;
        b=ZEsLXYiCLQYQEWhPUA0NFFMBr1Cf4ZrIRuA/oJmFf9IkVq+2TkesnnXVg2uzBIBwq0
         sSjvJdgYlOeTeleQhBPYP7iCwL9Z7PR6WY/zFBwn8b8wIn+sBwYEbZcmfxgnB7FX270H
         dMPYYzT5FPa2/jLBiRh6Dx3VVMde50J9HOfAHj1bBO/KeYVNKlGnhMCS6b35eO05XIXR
         Y5cZcF7duGCHt7Pg5B6AaJe+5aWVdp1NdI5ZpbeWOEw/aXDJospD+FYFrR43OnoFk07P
         YhzQZ3XxFiGjr/xFlzaifBx1rWZgjhGNJFR1chSB6/wwpAgeTaiVOT9BrVvBvnNH9Oar
         aSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:in-reply-to:references:content-type
         :content-transfer-encoding;
        bh=sfUpvj7cDMqDboK9nxeY4QAU1woSKUKFF2VJ6Cn6Xuc=;
        b=QOB/BDKazn/pTL6ChQumQ95NuhNjml9jPVUS9T2AT5essglw9XEULtxL98MDBfc7g+
         v59nkB1n4vpU8CzjykRgp3MPRL/ctGqQnHiTOq/lV7eDcRvAb3F0XE0hO426pDZ8A4qI
         4grHyTZm1hyiYT7Nqj4F95312wTdTuMknkEDDdfZ+bOhMRMKizQOVZWRrsdtFOcub48Y
         g9vFInZM55/hlIGpXPk5vnrxrVAASS3nqErQTlezaJowcam9vbK0Q8x/1H9b7ikhdoV/
         Bmht6VpTykELX5c2+3KvYhDWVbA7/ePlF2L3bF/QuqO9Rx3oLPbKkoltapNcd1VeYBZs
         h4wg==
X-Gm-Message-State: ALoCoQkBqTCsWs+U83lQmrBn8U4c2cY/z/E+ZG3/i+bBuNVox/H3nsXGGE36HEx3dub49a5p4Hv2
X-Received: by 10.66.97.105 with SMTP id dz9mr12022738pab.23.1438384177251;
        Fri, 31 Jul 2015 16:09:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e5af:ce62:986f:5269])
        by smtp.gmail.com with ESMTPSA id ts1sm11160pbc.74.2015.07.31.16.09.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 16:09:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.5.gf4cd9ae.dirty
In-Reply-To: <1438384147-3275-1-git-send-email-sbeller@google.com>
In-Reply-To: <1438301956-1658-1-git-send-email-sbeller@google.com>
References: <1438301956-1658-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275089>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    The output of the differential testing is below,
    which points out 2 bugs:
    * resolving relative paths seems is broken, so we
      would need to have the equivalent of
        eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
      (091a6eb0, 2013-06-16,  submodule: drop the top-level requirement=
)
    * The handling of funny characters is broken.
   =20
    ----------------------------------------------
    ../init
    160000 9ab41d0d44279924747e3eafa6da77966579aa45 0	init
    ----
    ----
    ----
    fatal: ../init: '../init' is outside repository
    ----------------------------------------------
    ../init
    160000 37b832c3ae4dcc0830b173572ff59be6b089bdcd 0	init
    ----
    ----
    ----
    fatal: ../init: '../init' is outside repository
    ----------------------------------------------
    ../init
    160000 9ab41d0d44279924747e3eafa6da77966579aa45 0	init
    ----
    ----
    ----
    fatal: ../init: '../init' is outside repository
    ----------------------------------------------
   =20
    160000 37b832c3ae4dcc0830b173572ff59be6b089bdcd 0	example2
    160000 9ab41d0d44279924747e3eafa6da77966579aa45 0	init
    160000 01b25b1d44b1049978e053768790100df8b8d9d9 0	=C3=A5 =C3=A4=C3=B6
    ----
    160000 37b832c3ae4dcc0830b173572ff59be6b089bdcd 0	example2
    160000 9ab41d0d44279924747e3eafa6da77966579aa45 0	init
    160000 01b25b1d44b1049978e053768790100df8b8d9d9 0	"\303\245 \303\24=
4\303\266"
    ----
    ----

 git-submodule.sh | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 36797c3..717b74d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -149,7 +149,7 @@ relative_path ()
 # Get submodule info for registered submodules
 # $@ =3D path to limit submodule list
 #
-module_list()
+module_list_shell()
 {
 	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
 	(
@@ -187,6 +187,29 @@ module_list()
 	'
 }
=20
+module_list()
+{
+	# call both the old and new code
+	module_list_shell $@ >/u/git_submodule_module_list_shell 2>/u/git_sub=
module_module_list_shell2
+	git submodule--helper --module_list $@ >/u/git_submodule_module_list =
2>/u/git_submodule_module_list2
+	# if there is a diff record it
+	DIFF=3D$(diff /u/git_submodule_module_list_shell /u/git_submodule_mod=
ule_list)
+	if [ "$DIFF" !=3D "" ]
+	then
+		echo "----------------------------------------------">>/u/git_submod=
ule_module_diffs
+		echo $@ >>/u/git_submodule_module_diffs
+		cat /u/git_submodule_module_list_shell >>/u/git_submodule_module_dif=
fs
+		echo "----" >>/u/git_submodule_module_diffs
+		cat /u/git_submodule_module_list >>/u/git_submodule_module_diffs
+		echo "----" >>/u/git_submodule_module_diffs
+		cat /u/git_submodule_module_list_shell2 >>/u/git_submodule_module_di=
ffs
+		echo "----" >>/u/git_submodule_module_diffs
+		cat /u/git_submodule_module_list2 >>/u/git_submodule_module_diffs
+	fi
+	# output to the caller
+	cat /u/git_submodule_module_list
+}
+
 die_if_unmatched ()
 {
 	if test "$1" =3D "#unmatched"
--=20
2.5.0.5.gf4cd9ae.dirty
