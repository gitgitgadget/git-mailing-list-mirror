Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30D420248
	for <e@80x24.org>; Tue,  9 Apr 2019 19:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDIT20 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 15:28:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:58663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfDIT20 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 15:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554838095;
        bh=Z3ZgOyCb8SlSsEFyEHXBRHnajkehqOLHPLntjcOd53A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=QBMUntBMoSRpk/DJLcZXv8tkWLxR+ojgXa2dF/rBLWik1pWhwJNld0oybnoEw6Hit
         IUhlOb9HKXINtvnYeg3x1fpwgDjM1+cm4GSeYvf7Uuf4u0Nwti8Ne7WusrUfrX8iUC
         rd+3kWAWSiuYv/5KTfIp3fiIlL/cuv4+M4oVk+8E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.118.159.3]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MEGIi-1h7IaV33Hc-00FWwy; Tue, 09
 Apr 2019 21:28:15 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brian M Carlson <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] send-email: fix transferencoding config option
Date:   Tue,  9 Apr 2019 21:27:33 +0200
Message-Id: <20190409192733.10173-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B+Llt/dkY6caPLBkJ7NVsE2cwJD8PmXAv6mq3l72/HUOAXIAlNn
 0/VyGg7D5RCGEvC5h4yxwfqXrcBiKHJXhpHfgyKbK3c3RRol2tGLpkKCj2Taplu6jZ61H7T
 vUu/i9OyD7WN4GmQcXTxKJpZWS/TEiKpToWy8MeipKyHbHAYCXwSLLXlatJdgnl9IUlNHZt
 rVFs3tgVrrQUkQzps7syQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RaOidZc+lP8=:kRAUgEueSYxgr/mb6eCo6l
 GmKXmr1Wi9kx0cpKRgVoUM/Drf5Qkx15L9peVPeI1zK86OmRO/nDeC0BXT+qZPnsa6gt7NF8o
 DE8L1tp/ruNspm74cccBHHg01iRIaz6F4bDCP9kAz7CU4L/MFnCtgc9rQmt0hqLAwrZjkwQe5
 dOTu5etx0U1eu6ijveDV/dpjeRmNp3IfWtC3nJANFZ10MCQM8ZYEw/OCjdWAvT2ZiuHOIL7PR
 oXdp2HRHZnKSjtooTV63AFlmMtPr6AUSPpwOOq1dBFILVIMUEvuiXrA3+jeH58M33IeNq0M2o
 Ms/eiKo9x7ycaaVhjfXRuQEi5se7xRSCh51clf9zjqQdIu0BVPhClX1N2DakqxmCnKwm8Yc4D
 TEjdJCFntRb4ChU7rLIMzqbKzZgMeKf2eKNyk/2PZJzUczRPBMVDpJkqNrCzOExaqVopsSCRp
 5b8LAmkdXPFXnjaAnDN5Fh7Ky/NrOSTTPjpiQz1ASRjF/qhugJ5fj7Ah0DyWVjKhe1+BSH1un
 lkn80XuL/IaN2yjfRNKWgRR4bSJC+LIjm9KNlFI+3t57fEUI1DpaCIftfPeyWorqIx6DxTYCg
 NP3jCr8JKuNRrD1X+P2M88GOfe2fa4inrTjiVlq3WOIKNI5O7w4ThuPfx9V7jXiKc0MZi+yTX
 w8ozSN4aq+BF6qiLy9KOoZYDbD9XzNnRapl5eCgVvQ8P7r1ElacG14q5+ElyV7VSNrFcUznRn
 48vKnmDu7c810nBUVvx5UEsBbaFlUyk1QbdNsI0mOr0eMVsz7YMI1bh772dCTdswyw8i4WuDh
 S2C1oVhdCYZ+aHVh8AOsu/w07DKXzuf9e/ZSFIqRqwtC+WTytyWp6NxFmDdeUBjDgw1yd41pT
 ZutJk6NOBbAJ0dBocgaZXKKc5n3FOH0BcZRpzdDhVWQQ6/qC4bWZ1GHZpEMcBl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since e67a228cd8a ("send-email: automatically determine transfer-encoding"=
)
the value of sendmail.transferencoding is ignored because when parsing
the configuration $target_xfer_encoding is not initial anymore.

Instead of initializing variable $target_xfer_encoding on definition we
have to set it to the default value of 'auto' if is initial after parsing
the configuration files.

The documentation erroneously mentions the option as
sendmail.transferEncoding. Fix that typo.

Fixes: e67a228cd8a ("send-email: automatically determine transfer-encoding=
")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 Documentation/git-send-email.txt | 2 +-
 git-send-email.perl              | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-ema=
il.txt
index 1afe9fc858..884e776add 100644
=2D-- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -146,7 +146,7 @@ Note that no attempts whatsoever are made to validate =
the encoding.
 	even more opaque.  auto will use 8bit when possible, and quoted-printabl=
e
 	otherwise.
 +
-Default is the value of the `sendemail.transferEncoding` configuration
+Default is the value of the `sendemail.transferencoding` configuration
 value; if that is unspecified, default to `auto`.

 --xmailer::
diff --git a/git-send-email.perl b/git-send-email.perl
index 8200d58cdc..0e23193939 100755
=2D-- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -239,7 +239,7 @@ sub do_edit {
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 my ($compose_encoding);
-my $target_xfer_encoding =3D 'auto';
+my ($target_xfer_encoding);

 my ($debug_net_smtp) =3D 0;		# Net::SMTP, see send_message()

@@ -446,6 +446,8 @@ sub read_config {
 			$smtp_encryption =3D 'ssl';
 		}
 	}
+
+	$target_xfer_encoding =3D 'auto' unless (defined $target_xfer_encoding);
 }

 # read configuration from [sendemail "$identity"], fall back on [sendemai=
l]
=2D-
2.20.1

