Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0371FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 13:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbcFYNze (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 09:55:34 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33952 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbcFYNzd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 09:55:33 -0400
Received: by mail-lf0-f67.google.com with SMTP id l184so24503623lfl.1
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 06:55:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/f7I08fSg7a7HLahs7A68Y4aWx7LYwfJOB7RhYFQ3k=;
        b=C7Y631o57hqS96NrmOOUzMVhbGiph/gP2UbPlpOrxrOLVWp7x2n9HVFCdlaSxaOmuf
         Gl4Jd5h0tbp8WADVjX2JNcbptPmYQK39iHNRjLDDD7KlrSLpUZ2UOxyidLWxsEfxF13G
         jo7TgJF9hutEF9RFLCqf+Tn1S/ys1HBI2ITRQWFGzIqSaTYbb9CzsYbJzb/AcRjCsimc
         vzkiUlvFLnbl0wYda543s89H1Fd/rpAw3a/2NWaQ7kWilfNyehcTE0wEYVovU344DK70
         N7L1rcQVJEK0WTgng0G+2xm1eTKaHNUxvE00VKzEcjlI9e70bNDPqSnc2vjb5nCssAUf
         p0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/f7I08fSg7a7HLahs7A68Y4aWx7LYwfJOB7RhYFQ3k=;
        b=IK/hDfoQyXIXZT8hbLj91ZVNqjRVlZz9g7FjYifLLKSmHK1LTglERnGmw/BdPW+yA8
         sf8DRiooQucyAGajJ5dUenbyScKtj3+3AVfryhGuoAzhGN84lhAKuYCWnBQ66pe1jeCj
         QQ3on0CiTe/AO3cUuPHjGUaeiXhKoiCnby1kFaTNAVGs6w4IjvgHrZkrhLMN+85yq+W/
         tMQZNTbr4Q+jwbLQI36/1ZYCOUWZfe2pXR35wxcPEXQ001FK3nCBfCmSsiCfEofDEpJi
         NcSXC0pOkGeF5W+29/QCF1udevGoQExmRhlV/ZvLGPLHCZBaplccX86K2NkdEjo//A4Y
         EDNA==
X-Gm-Message-State: ALyK8tKGkoetT5eW1Gd10yE4qy2WSPhti9av1xNOdrfDpeWRjif2Ob8WU6IbQED12ByLtw==
X-Received: by 10.46.33.226 with SMTP id h95mr2772293lji.35.1466862931185;
        Sat, 25 Jun 2016 06:55:31 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 10sm1741921ljf.5.2016.06.25.06.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 06:55:30 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] new-command.txt: correct the command description file
Date:	Sat, 25 Jun 2016 15:55:14 +0200
Message-Id: <20160625135514.27809-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It has always been command-list.txt even at the time this
new-command.txt document is added.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/howto/new-command.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/new-command.txt
index 6d772bd..15a4c80 100644
--- a/Documentation/howto/new-command.txt
+++ b/Documentation/howto/new-command.txt
@@ -94,7 +94,7 @@ your language, document it in the INSTALL file.
 6. There is a file command-list.txt in the distribution main directory
 that categorizes commands by type, so they can be listed in appropriate
 subsections in the documentation's summary command list.  Add an entry
-for yours.  To understand the categories, look at git-commands.txt
+for yours.  To understand the categories, look at command-list.txt
 in the main directory.  If the new command is part of the typical Git
 workflow and you believe it common enough to be mentioned in 'git help',
 map this command to a common group in the column [common].
-- 
2.8.2.526.g02eed6d

