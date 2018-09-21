Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC9B1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 08:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389231AbeIUObc convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 21 Sep 2018 10:31:32 -0400
Received: from smtppost.atos.net ([193.56.114.166]:29683 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeIUObc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 10:31:32 -0400
Received: from mail2-ext.my-it-solutions.net (mail2-ext.my-it-solutions.net) by smarthost2.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 5939_a66a_2179a11f_eb71_4cbe_b4af_b2802c8b60b8;
        Fri, 21 Sep 2018 10:43:40 +0200
Received: from mail3-int.my-it-solutions.net ([10.92.32.10])
        by mail2-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id w8L8hfMV005825
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:43:41 +0200
Received: from DEFTHW99ETTMSX.ww931.my-it-solutions.net ([10.86.142.101])
        by mail3-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id w8L8he3N023334
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:43:41 +0200
Received: from DEERLM99ETUMSX.ww931.my-it-solutions.net (10.86.142.96) by
 DEFTHW99ETTMSX.ww931.my-it-solutions.net (10.86.142.101) with Microsoft SMTP
 Server (TLS) id 14.3.408.0; Fri, 21 Sep 2018 10:43:40 +0200
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.96) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 21 Sep 2018 10:43:40 +0200
Received: from DB6PR0201MB2455.eurprd02.prod.outlook.com (10.169.224.7) by
 DB6PR0201MB2055.eurprd02.prod.outlook.com (10.168.52.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Fri, 21 Sep 2018 08:43:39 +0000
Received: from DB6PR0201MB2455.eurprd02.prod.outlook.com
 ([fe80::d926:1980:3ef5:3f3b]) by DB6PR0201MB2455.eurprd02.prod.outlook.com
 ([fe80::d926:1980:3ef5:3f3b%7]) with mapi id 15.20.1143.019; Fri, 21 Sep 2018
 08:43:39 +0000
From:   "FIGADERE, LAURENT" <laurent.figadere@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: 
Thread-Index: AdRRhzBY/0zbUVpJS0WKZ+nnZDkWaw==
Date:   Fri, 21 Sep 2018 08:43:39 +0000
Message-ID: <DB6PR0201MB245532DA30DD1EA21C3CF0FAE6120@DB6PR0201MB2455.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurent.figadere@atos.net; 
x-originating-ip: [80.78.5.105]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0201MB2055;6:Pn1IQOOWNPudQjXNq8lQYXDx9ENim55Mj69LPhBT92kG7iUAW0DnMyOHTyuYpobWW7dK7Rj1HCh/fXxnyCPd7iFQdlvmnea/ssr4VD5wPUP6HkKGJ9iiu2fkSxC4YTe6IKk4nkshjAff180HrbzNwkdr2ojs5H/yL7fJC2wExXOsyS+uQyJ2TFk6k/Aix2uwjHkugM1w8UM2yjBUuzxlzep1VgGtriz+09g5mgmOOlHy8aDwGzGbKkjMwPuCeU5uEIqrzYhVPu29e2/ERYJqIUAZxPqs3hlZXpj6axqpHCJ9Y57t756T8Uetcwyr4VOvA7L7wRFXiEoTCZyjAH0Ddu2xH0sQAZBjHb7/FkD6Yzc7x8XJfrgcSmg4LfREU9xjikjWg8BKUNcEpMk1e7sJdBjMFb4CgYwbI08RPdlbrXzZfHbalGNrd5eJjPsMF/pGR2jg3efdHEr6mU+9pQGDqw==;5:P0nE7ZJO9jUbu8q5neH8S1W9stcZN3e6fGIugR+F8St+gkp4fc0N8qfX/QSpBRFCnVwJo/EKtHdBdJ+q/tmZmhV3K5wzboYo86jQfX+gKkReFPwogkeQvaqECAzy20CnrT7CIsignmgA2mhg74LnuGe9iflOLZ4jWT5Ad3wFKno=;7:RgZTe1OqRzrjIq0lBwChG0bvNn+xFF5lyQlt9WanJMnEwFaGIa0q/zHBt+mN8rWPnC9Lds+rqoh0DinXMVCAJiiXfhNR6pw3VcQaCYpsPxDRcGhnnF/5W+LA1WhoZHVtDNmQdmWV/JJvtbhzH5UJZk+nDKYiMDm+HKMgmBmT3A40hy0MWfiJt9zWxhKZaehgUPjHF5OP8rUt5o1LHBaNRiog2Er+GZ+TJpZD0lelZWlpkIgmC2V8AZ6ngFMZ+ndg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 58a621f4-8ce9-43f1-bd3d-08d61f9e53d1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2055;
x-ms-traffictypediagnostic: DB6PR0201MB2055:
x-microsoft-antispam-prvs: <DB6PR0201MB20552CA03B8AB838651ACF6CE6120@DB6PR0201MB2055.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:DB6PR0201MB2055;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2055;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(346002)(376002)(199004)(189003)(14444005)(476003)(316002)(5250100002)(2351001)(2900100001)(66066001)(5640700003)(7696005)(9686003)(6436002)(33656002)(5406001)(7736002)(305945005)(3846002)(5660300001)(2906002)(55016002)(74316002)(256004)(6506007)(1730700003)(102836004)(478600001)(8936002)(26005)(99286004)(53936002)(53346004)(5416005)(81156014)(486006)(81166006)(186003)(6116002)(6916009)(86362001)(106356001)(25786009)(97736004)(25636003)(14454004)(2501003)(105586002)(53546011)(68736007)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2055;H:DB6PR0201MB2455.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: usJihaCjC51GbTteKll89NSiYg5+rApCTBxiLapqKs6rURyV1TMJwMGzpPDEkgmfapzSueDmyDlbMbYYHngNXS3Tuinqk4aMJBALoKUTDbW+C0uhOTyyYvd0IBqcVw9sJfz9V6bPDBf5b7hCus0TOxQ7NfJ3HdldFImSEwiHWRGIeQCL5y1qSQEHTKtKWOcR5x1NMilAaHLlSJEJZ4dorvNdGQTJlzvd/xNjBG+5ALzAYHGqusxSLv8Gb67RdlTnEh2Sd2WTNlMcqOcRgzWANFY5m6jvjQuRUZS79Z6f2L8d68ROAApeaLjawVOFmiHuzvBcRq1K6ELGHPGHTmJvlgJecqRHfSatRluf3ZQmbDs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a621f4-8ce9-43f1-bd3d-08d61f9e53d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 08:43:39.0427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2055
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Coming back to you with some updates.

I understand finally interest of difference between 'from' and 'at'.

The point is: is it a bug if the 'git status' provide the origin/HEAD instead of HEAD SHA1? 

If you want a test case with screenshots, let me know.

Regards,
Laurent

_____________________________________________
From: FIGADERE, LAURENT 
Sent: Thursday, September 20, 2018 3:26 PM
To: 'git@vger.kernel.org' <mailto:git@vger.kernel.org>
Subject: git status - difference between from and at


Hi guys,

Recently I used git on a top repository which integrated few other submodules.

The 'git submodule' command provides the right information on SHA1 used for each submodule.
When I 'cd' into a submodule and run the command 'git status', I got this message:
HEAD detached from 55846b8
nothing to commit, working tree clean
Which was not the right checked out SHA1: it should be 2422597

I verified in a git log command, and I was using really the '2422597' SHA1 and not 55846b8.
The command: 
      git log --graph --oneline --abbrev-commit --all
Output:
*   55846b8 (tag: 01.050.002, origin/master, origin/HEAD, master) 
...
*   2422597 (HEAD)
...

After running :
	git co master
	cd ..
	git submodule update

I ran again git status command inside the submodule.
This time, I got this message:
HEAD detached at 2422597
nothing to commit, working tree clean

First question: do you confirm that 'HEAD detached FROM' provides the SHA1 of origin/HEAD?
And 'HEAD detached AT' provides the SHA1 we are using : HEAD?

Second question: what is the goal of such information?
Because from my opinion it can be difficult for end users to understand what SHA1 they are using in the submodule.

Thanks by advance for you feedbacks.

Regards,
Laurent Figadere


