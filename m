Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786AD1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 18:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfFMSxp (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 14:53:45 -0400
Received: from sonic314-24.consmr.mail.ne1.yahoo.com ([66.163.189.150]:39306
        "EHLO sonic314-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729211AbfFMSxb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jun 2019 14:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1560452010; bh=CcvPntN/9RNunK3FH9X4yrCmC/ZPUsAd6gwAhwvHSbI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aBPWhnBzOIEZHtQTbIQtsm3D9mNCW3MQvbP7HotuipuWnN5Pf6W6g8COMqzVZPRUV8ULAt/aWNteLOEE1nuyl8cuxawiwAtgDxmLtk+4KKiw+G+rXTpuLkd7rk4QdqeJPZjyIN8pfw4oL0b+vBg3vGAwGVEGDI4KG0GmWxiB2uEg25V1uMtK/4srsjZKBbhYqw+B8vOACXdBYquB9NiD4dEOII8br42M3v/kHWdWM2s8R3m51k7uYkctkMfEwH7897CGilTuuZe9fapvoP1PSXf0EFCkE/Nl6mMc+ftGZF2jmDJrvw4xFUgZsZJiLNxgWFC+zRqMcg/S4CUzpzbkQQ==
X-YMail-OSG: DNEFGM0VM1ngxF2t51TYyFsOahoTZfsxQAl_VLyBVnoTS.clh8mOF0apOtd.Em2
 7WudqzerBD7ggS.LwyjsHHrAKmRYiXBUNPU3QWTlC90sPkFs_ANzbXAtDEL7IhXmHrwaYW2QKV27
 FYL7SO1QYEW8baiQdFON2q0BnbPv3fnGXL139ZONlsFgHS9SXxPzdtos2ZO9jCe_ldDYOMEOy6zg
 Hd3ZMlzOOvG30sM1oSiBKIt8XUJkPk_Vf5e_1vuSQDj52uaC3EGljtiunREai_nbOQ.IBFFzbfam
 I5ESBakaKVOuc.my8SrA2I_Kgt8ijLQHQ_Rh3Y9SSc6hvj_twKiD2zo7mi.nJzli9FRlN_8bvMOL
 DnlLp1mLh.iUBJOOfUtqRdOusXgi8OzlOmGFaUB2QBRGEHZ0Wm95fy5gAFcTwwgnB3AW08jnrBWL
 U__SUxCBZeVTgR8r.3YIjDRu_4cNtOkyfyjpA8Oy3qX6h2tM2FO2TPVAdJlKsI1bMu6ifj_fTovW
 jh0Eml6tM64vvprYA6efYj22vRUXnATxR6khL1tDlRLqKlxQKMSd2Igmr7bqLPpW9ZJ1_xS_CV2V
 7OIBfhdPJW09NC4GPHAPRdvaGXWeuZQpVZ3IVUQj5EFyDx0NBoYBYzrxunDN4bCgJcYn5kepI93A
 D6R61bTXC4OFKOx8c5D6JTmjKDI4IDy8GZAK4kxzUVmLj4sDxsephd9AlLAvTrIOMpje_hu2UvAy
 yX52rSiiqsvOJd.ou4y.IrR485.sKvKBbnIzTnjlCzzHoeW30sG0LSNk.VYUWrCnW4qX5cVMjtiA
 dopJu1UtY.31hCRUR.jBdciYJ2bebGPolMIvmKWGZk39AYTNhrzpDKv7hqotbPnpw0N5EIwX2O0.
 1WLeGj2VRAiRuGjLcdwy06RI8FZiwKmrYOa2O5QYNnFMKnKrH_agMfFMqcGqvYgoN1lAbe4dOryR
 0B8rUPTyr5swNcVfiwKXXRVsBC6A5Lpc2arJaC03sSejBkzkP9jPHb30qYr9AG7rSBoxsBXEVBwk
 0FP.VvWjljZRq1AoX0qD98DdR62vPv2lrB7hsNvjFDUn4._jqZlSogvc85TuBT34RSjR5gxU4Vi0
 _4wS_iMzckYNfWNFsI2L9cxgqPbcQHOk2hiH6BKPQuW6VzY9yPS1L9PIJUGGQ8bQRw.QpkZHtp4V
 a9zcwPlG6__u1_FdejQKCFda8TpjBl8v29I7Q9HgMwr4d0bYAbHf0StTElK9pUOpWOvXuQ11b2bB
 kls_zre65mWZvXlpsl.tDq5P65LM0vCzsJyY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Jun 2019 18:53:30 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp432.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0df5561e6e714d6e0f0f0c310b112dc6;
          Thu, 13 Jun 2019 18:53:26 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch 1/5] t9600-cvsimport: exclude test if cvs is not installed
Date:   Thu, 13 Jun 2019 14:53:09 -0400
Message-Id: <20190613185313.16120-2-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190613185313.16120-1-randall.s.becker@rogers.com>
References: <20190613185313.16120-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The t9600-cvsimport test requires the cvs package to be installed on
the system on which the test is being run. The test will fail if cvs
is not installed. The patch checks that cvs is installed by running
the object without arguments, which should complete successfully if
available.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t9600-cvsimport.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 251fdd66c4..d6bf38918b 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -3,6 +3,13 @@
 test_description='git cvsimport basic tests'
 . ./lib-cvs.sh
 
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+	skip_all='skipping git-cvsimport tests, cvs not found'
+	test_done
+fi
+
 if ! test_have_prereq NOT_ROOT; then
 	skip_all='When cvs is compiled with CVS_BADROOT commits as root fail'
 	test_done
-- 
2.22.0

