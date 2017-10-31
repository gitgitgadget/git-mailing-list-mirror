Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8BD32055E
	for <e@80x24.org>; Tue, 31 Oct 2017 17:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753864AbdJaR2m (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:28:42 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:45802 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbdJaR2l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:28:41 -0400
Received: by mail-yw0-f173.google.com with SMTP id j4so15424725ywb.2
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tprg-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=U1t6257psOirczMxUFmyRb7r5TfMcFXZ/e3iclfpkQ0=;
        b=msc3Yb49Bm7nXDQPUTMWWeELvLVf/eifbRLcUoGhhfb9Mp2gvNApPC0t/GDPKuT9YU
         3QPG5Sm/0wctPwrH5LOsy9cf4o9luQwnpkdlDnJsKa1ablUbl0XYWg5X0TvjD9KMSQ9g
         c9vUJ8WcWdKCxMUflpGQ9ulgFXIbPq1JrmA/3Kx1GOfco9fDiylgteYQoQ+PfuTY6BWN
         WxV4iAZ4ZcXt3NmEPDFCu8oeDsBeuTSqCTmkHavzmNswAbhbhoAFeCok88VR46BtshQH
         YGHjkbunbc1ywPfj33Gpz8CCWXvbRKRIWIApzIQIa1ZVCQY48bsXsyoutQOZh8s4WijM
         JKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=U1t6257psOirczMxUFmyRb7r5TfMcFXZ/e3iclfpkQ0=;
        b=jsyJ729OvM7O+QSCdaTgcrh9/xEcTy1vgCnYbd9xJeNbukTX1L9EiDkiYa8Q2HF7Do
         5f4uWVpAg9IWo2Lxgf/AiQdQga5Lhz7oECzRc10qYdEMpvz3701Dw5aFCTAqdltE4hKC
         L6/EQ1aIZCM/JmVrGvNbxqm5Nywj6ZTZPEB93Ve3wvI2XZ8YBbA9T9w5aTcbXXrKBbgY
         TYJNjxIprMgYiqCAMVjhvmebC18xoS9X7g8HH5k+/SLydc2xKG761dtG5UlMfNm+pUG1
         V3D7NdDB9nLSXBc5Yl0QyfFDTAdC8MDquv12uwioRH25mKMLEvhhazYVXY8aw05LJmt2
         KVig==
X-Gm-Message-State: AMCzsaVWWkFJ2813REratSXr/7ghK7l9rUZHC3L/fVRa2UeBbMzc++zL
        peucfTTFggWsk4hWZQVvU0asP5qPUP3nXY9jBWbEhTW9NXDeRrWQHin3a1iMH0qY70j2dDkP3DK
        WW+4i/6SUDaW5oM070tqi5v4+ySA=
X-Google-Smtp-Source: ABhQp+RgOaMv/D5ZswwPk9uQL9bNLKa6AwTDj8DdHHRNPENWws+P0E+v9RRcx4fUri41DJhI4QztM9QsYB24421BN/8=
X-Received: by 10.129.201.6 with SMTP id o6mr1679913ywi.443.1509470920933;
 Tue, 31 Oct 2017 10:28:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.161.103 with HTTP; Tue, 31 Oct 2017 10:28:40 -0700 (PDT)
From:   Eyjolfur Eyjolfsson <eyjolfureyjolfsson@tprg.com>
Date:   Tue, 31 Oct 2017 17:28:40 +0000
Message-ID: <CAO-WtQhAPjoWnWyMPi5SkCSUM_y8A=hsbLk-MUfnCSBvWnBRNQ@mail.gmail.com>
Subject: Is it possible to convert a Json file to xml file with Git
To:     git@vger.kernel.org
X-tprg-gsuite: true
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I have a question.
Is it possible to convert a Json file to XML with Git

Best regards

Eyjolfur Eyjolfsson

(e) eyjolfureyjolfsson@tprg.com
(w) tpretailgroup.com

--=20
This email and any files transmitted with it are confidential and intended=
=20
for the sole use of the individual or entity to whom they are addressed.=20
 Any unauthorised dissemination or copying of this email or its attachments=
=20
or disclosure of any information contained in them is strictly prohibited.=
=20
 If you have received the email in error, please notify the sender by email=
=20
immediately and delete it from your system.  The content of the email does=
=20
not necessarily represent Theo Paphitis Retail Group and associated=20
companies and any views or opinions presented are solely those of the=20
author.  Whilst we check communications we send for virus infection, you=20
should check this email and any attachments to it for viruses as we accept=
=20
no responsibility for any loss or damage caused by any virus transmitted by=
=20
this email.  Email transmission cannot be guaranteed secure or error-free.

Theo Paphitis Retail Group is the collective name for Ryman Group Limited,=
=20
registered in England and Wales, Company Number 02714395, VAT Number=20
672523729,  Registered Office: Ryman House, Savoy Road, Crewe, Cheshire,=20
CW1 6NA; Ryman Limited, registered in England and Wales, Company Number=20
3007166, VAT Number 672523729,  Registered Office: Ryman House, Savoy Road,=
=20
Crewe, Cheshire, CW1 6NA;  Robert Dyas Holdings Limited, registered in=20
England and Wales, Company Number 4041884; VAT number 742720153, Registered=
=20
Office:  1 St George=E2=80=99s Road, Wimbledon, London, SW19 4DR;  Boux Ave=
nue=20
Limited, registered in England and Wales, Company Number 7191520, VAT=20
Number 125504638,  Registered Office: 1 St George=E2=80=99s Road, Wimbledon=
,=20
London, SW19 4DR;  Boux Avenue International Limited, registered in England=
=20
and Wales, Company Number 8047333, VAT Number 125504638, Registered office:=
=20
1 St George=E2=80=99s Road, Wimbledon, London, SW19 4DR; and London Graphic=
 Centre=20
Limited, registered in England and Wales, Company Number 6062021,  VAT=20
Number 251820524, Registered Office:  Ryman House, Savoy Road, Crewe,=20
Cheshire, CW1 6NA.
