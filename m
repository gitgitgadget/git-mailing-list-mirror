Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786FB20248
	for <e@80x24.org>; Fri, 22 Feb 2019 15:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfBVPjl (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 10:39:41 -0500
Received: from mail.xcmg-erc.com ([217.7.126.107]:52063 "EHLO
        mail.xcmg-erc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfBVPjk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 10:39:40 -0500
Received: from SRV-ERC-MAIL01.XCMG-ERC.LOCAL (10.10.4.13) by
 SRV-ERC-MAIL01.XCMG-ERC.LOCAL (10.10.4.13) with Microsoft SMTP Server (TLS)
 id 15.0.1395.4; Fri, 22 Feb 2019 16:39:54 +0100
Received: from SRV-ERC-MAIL01.XCMG-ERC.LOCAL ([10.10.4.13]) by
 SRV-ERC-MAIL01.XCMG-ERC.LOCAL ([10.10.4.13]) with mapi id 15.00.1395.000;
 Fri, 22 Feb 2019 16:39:54 +0100
From:   "Celestino, Federico" <Celestino@xcmg-erc.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: .gitignore alleged bug
Thread-Topic: .gitignore alleged bug
Thread-Index: AdTKxNqE6kyTDHqgQLG6yVJKIKWOAg==
Date:   Fri, 22 Feb 2019 15:39:53 +0000
Message-ID: <b23df617fddf45389406da2360dceb63@SRV-ERC-MAIL01.XCMG-ERC.LOCAL>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.10.4.150]
x-esetresult: clean, is OK
x-esetid: 37303A2986AD6E6C617D66
Content-Type: multipart/mixed;
        boundary="_002_b23df617fddf45389406da2360dceb63SRVERCMAIL01XCMGERCLOCA_"
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--_002_b23df617fddf45389406da2360dceb63SRVERCMAIL01XCMGERCLOCA_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear Support Team,

I am facing a serious issue with .gitignore (see attachment).

The problem is that the folder contents of 04 - Software/SW Code/STM32/Lib/=
Drivers/CMSIS/Device/ are ignored because of a suspected misinterpretation =
of .gitignore.

Here are some results that you could find useful:

$ git clean -ndX
Would remove 04 - Software/SW Code/STM32/Lib/Drivers/CMSIS/Device/

$ git check-ignore -v "04 - Software/SW Code/STM32/Lib/Drivers/CMSIS/Device=
/"
04 - Software/SW Code/STM32/Lib/Drivers/CMSIS/.gitignore:2:Device       04 =
- Software/SW Code/STM32/Lib/Drivers/CMSIS/Device/

Since in the path there is no '~' (tilde) character, it seems a bug to me.

Git version: 2.20.1.windows.1

Freundliche Gr=FC=DFe / Kind regards
i.A. Federico Celestino
Entwicklungsingenieur


Fon +49 2151 7830 324
Fax +49 2151 7830 499
www.xcmg-erc.com
Celestino@xcmg-erc.com

---------------------------------------------------------------------------=
---------
XCMG European Research Center GmbH
Europark Fichtenhain B4
47807 Krefeld
Deutschland
Amtsgericht Krefeld
Handelsregister HRB 14302
Gesch=E4ftsf=FChrer: Dr.-Ing. Oliver-Carlos G=F6hler, Dr.-Ing. Hui Sun=20
---------------------------------------------------------------------------=
---------=20

--_002_b23df617fddf45389406da2360dceb63SRVERCMAIL01XCMGERCLOCA_
Content-Type: application/octet-stream; name="ATT44153.gitignore"
Content-Description: ATT44153.gitignore
Content-Disposition: attachment; filename="ATT44153.gitignore"; size=413;
	creation-date="Fri, 22 Feb 2019 14:01:11 GMT";
	modification-date="Fri, 22 Feb 2019 14:01:11 GMT"
Content-Transfer-Encoding: base64

Ki5hdXgNCn4qDQoqLm8NCiouZA0KKi5vYmoNCi54ZGNoZWxwDQpEZWJ1Zy8NCiFEZWJ1Zy8qLm1h
cA0KIURlYnVnLyoub3V0DQpSZWxlYXNlLw0KIVJlbGVhc2UvKi5tYXANCiFSZWxlYXNlLyoub3V0
DQouY29uZmlnLw0KLmxhdW5jaGVzLw0KKi5sZGINCjA0W1s6c3BhY2U6XV0tW1s6c3BhY2U6XV1T
b2Z0d2FyZS9TV1tbOnNwYWNlOl1dQ29kZS9UTVM1NzAvUGxhdGZvcm1zL05hdGl2ZS9IZXJjdWxl
cy9wcm9qZWN0cy9TSUwyX01DVVNUX0hlcmN1bGVzX0xpYi9UTVM1NzBMUzMxMzcvTW9kdWxlcy9z
b3VyY2UvKi5wcA0KMDRbWzpzcGFjZTpdXS1bWzpzcGFjZTpdXVNvZnR3YXJlL1NXW1s6c3BhY2U6
XV1Db2RlL1RNUzU3MC9QbGF0Zm9ybXMvTmF0aXZlL0hlcmN1bGVzL2xpYi9TSUwyX01DVVNUX1RN
UzU3MExTMzEzNy5saWI=

--_002_b23df617fddf45389406da2360dceb63SRVERCMAIL01XCMGERCLOCA_--
