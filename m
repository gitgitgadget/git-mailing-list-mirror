Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF171F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 17:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbdKHR2K convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 8 Nov 2017 12:28:10 -0500
Received: from mail1.bemta12.messagelabs.com ([216.82.251.4]:36534 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751370AbdKHR2J (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2017 12:28:09 -0500
Received: from [216.82.251.43] by server-4.bemta-12.messagelabs.com id 8E/1D-02223-8AE330A5; Wed, 08 Nov 2017 17:28:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRWlGSWpSXmKPExsXiVbjvie4KO+Y
  og8M3xC26rnQzOTB6fN4kF8AYxZqZl5RfkcCacffHFdaC32wVM97NYGpgfMTaxcjFISRwjFHi
  ++3JbBDOO0aJaW3nmSGcnYwS744+ZYJw1jNKzPizD6iHk4NNQFui7eds9i5GDg4RAX2JvguiI
  GFhAV2Jm1cmM4HYIgJ6Ev/X/2GFsI0k5jfdB7NZBFQkbu9aywrSyivgJbFkkTFImFFATOL7qT
  VgrcwC4hK3nswHsyUEBCSW7AG5B8QWlXj5+B8rhG0gsXXpPhYIW17i/cllbBC9ehI3pk6BsrU
  lli18DdbLKyAocXLmE6h6O4k/e/ewQdg6Eos/bmSbwCg2C8nqWUhGzUIyahaSUQsYWVYxahSn
  FpWlFukaWeolFWWmZ5TkJmbm6BoaGunlphYXJ6an5iQmFesl5+duYgTGUT0DA+MOxn9ffA8xS
  nIwKYnyPnjFFCXEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgveXDXOUkGBRanpqRVpmDjCiYdISHD
  xKIrzitkBp3uKCxNzizHSI1ClGY44bD6//YeJ4NvN1A7MQS15+XqqUOO8VkEkCIKUZpXlwg2C
  J5hKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYV55kIU8mXklcPteAZ3CBHTK/hAGkFNKEhFS
  Ug2Mu5p8X0zmVZt6o8/xinLJgdf/Z23ovOy9XvLoNpXpXjNKmjz5L3w996VwyndBAcUjUrwFz
  3Z3mWiZ9PbNya+y/twkNF1g0b1d963rHZx5Hbz9drfs8T7yaebFn4bBDIqZ/uGTOD76Z3d1lI
  R67XMtDs5NmHo4VScnTuCh3rb44m5GE1O9zElKLMUZiYZazEXFiQD+ekWuLwMAAA==
X-Env-Sender: josephst@bhphoto.com
X-Msg-Ref: server-16.tower-196.messagelabs.com!1510162087!140827645!1
X-Originating-IP: [74.113.190.228]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 41172 invoked from network); 8 Nov 2017 17:28:08 -0000
Received: from unknown (HELO dc2-mx7.bnh.com) (74.113.190.228)
  by server-16.tower-196.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 8 Nov 2017 17:28:08 -0000
Received: from DC2-DLPMTA1 (lb-fmg-svc.bhphoto.net [10.50.8.10])
        by dc2-mx7.bnh.com (8.15.1+Sun/8.14.9) with ESMTP id vA8HRVjc011929
        for <git@vger.kernel.org>; Wed, 8 Nov 2017 12:27:31 -0500 (EST)
Received: from [10.150.2.237] (helo=GTB)
        by DC2-DLPMTA1 with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.88)
        (envelope-from <josephst@bhphoto.com>)
        id 1eCU8L-000GkR-Gf
        for git@vger.kernel.org; Wed, 08 Nov 2017 12:27:25 -0500
Received: from EXMBX01B.bhphotovideo.local (10.150.2.236) by
 EXMBX02B.bhphotovideo.local (10.150.2.237) with Microsoft SMTP Server (TLS)
 id 15.0.1178.4; Wed, 8 Nov 2017 12:27:26 -0500
Received: from EXMBX01B.bhphotovideo.local ([::1]) by
 EXMBX01B.bhphotovideo.local ([fe80::25f4:bb1:4552:838b%14]) with mapi id
 15.00.1178.000; Wed, 8 Nov 2017 12:27:25 -0500
From:   Joseph Strauss <josephst@bhphoto.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Bug - Status - Space in Filename
Thread-Topic: Bug - Status - Space in Filename
Thread-Index: AdNYtjH+1q6di6aQTuO9RF9GIpihrQAAGAYw
Date:   Wed, 8 Nov 2017 17:27:24 +0000
Message-ID: <655aaa9d2abf4be1b6ade0574d88c999@EXMBX01B.bhphotovideo.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.150.0.10]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MTA-device-Scanned: Yes (on DC2-DLPMTA1) 910 bytes in 0 secs
X-UOID: E437107A-6179-4C22-8CDC-78E719B5EF31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I believe I have found a bug in the way git status -s lists filenames.

According to the documentation:
  The fields (including the ->) are separated from each other by a single space. If a filename contains whitespace or other nonprintable characters,   that field will be quoted in the manner of a C string literal: surrounded by ASCII double quote (34) characters, and with interior special characters backslash-escaped.

While this is true in most situations, it does not seem to apply to merge conflicts. When a file has merge conflicts I am getting the following:
 $ git status -s
 UU some/path/with space/in/the/name
 M  "another/path/with space/in/the/name "

I found the same problem for the following versions:
. git version 2.15.0.windows.1
. git version 2.10.0



Joseph Kalman Strauss
Lifecycle Management Engineer
B&H Photo
212-239-7500 x2212
josephst@bhphoto.com

