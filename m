Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD1F20C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbdLHRqm (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:46:42 -0500
Received: from mout.web.de ([212.227.15.3]:53304 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752379AbdLHRqj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:46:39 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lh6bn-1estVy1xaR-00oV5s; Fri, 08
 Dec 2017 18:46:37 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, ashishnegi33@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 2/2] t0027: Adapt the new MIX tests to Windows
Date:   Fri,  8 Dec 2017 18:46:36 +0100
Message-Id: <20171208174636.9946-1-tboegi@web.de>
X-Mailer: git-send-email 2.15.1.271.g1a4e40aa5d
In-Reply-To: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:pPsRCFHP9iDc6O0lrx1flEAk/mG3VVuMwyjabV76KW7GS3Jfjpa
 fDkfoae7lvogb72oxqys4OhBvuty9ic2wsgRn4t+M0bvV/Je8KIqyoBcdHXNiyGfqmzH2o/
 0O2qL1yFOUmbddcm+jfDdVatbdN/jbBtJ8hankYejH2y39QZlHKmOGj6Wt1L+lWSni/DEMy
 dGbo6ICAfRQHjU+XAQN/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4c0Zu7681nI=:xonzOsO0z66PSpAywaAtwa
 4K5mtqDz9cHiEm1TQgSBwqaxXDXJXX4ZzKXOQC5Am+EZpnMnO4HY9jE2vErq7oeqnX3jBi3LI
 S+LUBr4GtgVIqSLxmtrodA7KRNymTRYV6lVpWvV9LFtBlltoqa4IxSqW27nUsc30YEKKsSpAc
 x+3GBAs3QbeNX7mX74yPMqB6IpxvEDuD5FLQ6oUV9AjmQW9J0lxwLQLvnzALa1usclbOw0SwP
 2ENfhk3+p58mi8r+1wlVzLbErewKlSaVNUNTgxFs4UuKyxS/8GukE+xNrrrKZdZJVKDo35ce3
 GOEjdmwvQ2IhWJMUFdni5dTSPaIWbwF0Oh3Yi5HATGSilcxTHzCJfCoJ/yDUfvfIyVwL3INAD
 /dr9Lp2UGA9zOmAb5BJZvUFNHIEYMbGTBIKzuuUcKJS/ojw0D5uCVsG7vSjNz/EJgSgleuje7
 sN9p4cWAydtjKlP9zPabAIyRRgvqdWB8AFv2Pkcqot/97Hr/rOjY/s8J8FR5+S8mLtkqYz7Jo
 LzVk6qQq1t3DI1YxpYX5Xp42tmKOxa+Jbd4P1b/oCd+rSyrubkw7EpziPDa3HNDVak+6WY6i4
 KXlc7myvEubDSTEbWbjcWcKSB/a5qLXVhzg/Q7+nDl42SkePzVtiNGoEKhuCWPJ/0stdXvtWW
 ACCdNFPGQKwh4DYU/kS3IRGgX6HYg8Ps2xXbfiBjN6RYjDbuMs6y3PJuVPjmUPi7p/XOv3gKA
 ybOMzDPbvo293+2NhcELrnJ0/nJbAYQY/xDwo8IseIyEVTSoQfJKLk/hHUW3/2EHLP3FRZ1yh
 YkTKSpewWpBdn3DNaJy5YbkvsXQsamZl0a9eXhueFb8+Kyo/YQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

The new MIX tests don't pass under Windows, adapt them
to use the correct native line ending.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

 Sorry for the breakage.
 This needs to go on top of tb/check-crlf-for-safe-crlf
 
 t/t0027-auto-crlf.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 97154f5c79..8d929b76dc 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -170,22 +170,22 @@ commit_MIX_chkwrn () {
 		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
 	done
 
-	test_expect_success "commit file with mixed EOL crlf=$crlf attr=$attr LF" '
+	test_expect_success "commit file with mixed EOL onto LF crlf=$crlf attr=$attr" '
 		check_warning "$lfwarn" ${pfx}_LF.err
 	'
-	test_expect_success "commit file with mixed EOL attr=$attr aeol=$aeol crlf=$crlf CRLF" '
+	test_expect_success "commit file with mixed EOL onto CLRF attr=$attr aeol=$aeol crlf=$crlf" '
 		check_warning "$crlfwarn" ${pfx}_CRLF.err
 	'
 
-	test_expect_success "commit file with mixed EOL attr=$attr aeol=$aeol crlf=$crlf CRLF_mix_LF" '
+	test_expect_success "commit file with mixed EOL onto CRLF_mix_LF attr=$attr aeol=$aeol crlf=$crlf" '
 		check_warning "$lfmixcrlf" ${pfx}_CRLF_mix_LF.err
 	'
 
-	test_expect_success "commit file with mixed EOL attr=$attr aeol=$aeol crlf=$crlf LF_mix_cr" '
+	test_expect_success "commit file with mixed EOL onto LF_mix_cr attr=$attr aeol=$aeol crlf=$crlf " '
 		check_warning "$lfmixcr" ${pfx}_LF_mix_CR.err
 	'
 
-	test_expect_success "commit file with mixed EOL attr=$attr aeol=$aeol crlf=$crlf CRLF_nul" '
+	test_expect_success "commit file with mixed EOL onto CRLF_nul attr=$attr aeol=$aeol crlf=$crlf" '
 		check_warning "$crlfnul" ${pfx}_CRLF_nul.err
 	'
 }
@@ -378,7 +378,7 @@ test_expect_success 'setup master' '
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\r\nLINETWO\rLINETHREE"   >CRLF_mix_CR &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONEQ\r\nLINETWO\r\nLINETHREE" | q_to_nul >CRLF_nul &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONEQ\nLINETWO\nLINETHREE" | q_to_nul >LF_nul &&
-	create_NNO_MIX_files CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF CRLF_mix_LF &&
+	create_NNO_MIX_files &&
 	git -c core.autocrlf=false add NNO_*.txt MIX_*.txt &&
 	git commit -m "mixed line endings" &&
 	test_tick
@@ -441,13 +441,14 @@ test_expect_success 'commit files attr=crlf' '
 '
 
 # Commit "CRLFmixLF" on top of these files already in the repo:
-# LF, CRLF, CRLFmixLF LF_mix_CR CRLFNULL
+#                                         mixed     mixed     mixed       mixed       mixed
+#                                         onto      onto      onto        onto        onto
 #                 attr                    LF        CRLF      CRLFmixLF   LF_mix_CR   CRLFNUL
 commit_MIX_chkwrn ""      ""      false   ""        ""        ""          ""          ""
 commit_MIX_chkwrn ""      ""      true    "LF_CRLF" ""        ""          "LF_CRLF"   "LF_CRLF"
 commit_MIX_chkwrn ""      ""      input   "CRLF_LF" ""        ""          "CRLF_LF"   "CRLF_LF"
 
-commit_MIX_chkwrn "auto"  ""      false   "CRLF_LF" ""        ""          "CRLF_LF"   "CRLF_LF"
+commit_MIX_chkwrn "auto"  ""      false   "$WAMIX"  ""        ""          "$WAMIX"    "$WAMIX"
 commit_MIX_chkwrn "auto"  ""      true    "LF_CRLF" ""        ""          "LF_CRLF"   "LF_CRLF"
 commit_MIX_chkwrn "auto"  ""      input   "CRLF_LF" ""        ""          "CRLF_LF"   "CRLF_LF"
 
-- 
2.15.1.271.g1a4e40aa5d

