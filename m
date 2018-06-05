Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5801F403
	for <e@80x24.org>; Tue,  5 Jun 2018 21:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeFEVds (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 17:33:48 -0400
Received: from esa2.hc2413-78.iphmx.com ([216.71.148.46]:7568 "EHLO
        esa2.hc2413-78.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbeFEVds (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 17:33:48 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jun 2018 17:33:47 EDT
X-IronPort-AV: E=Sophos;i="5.49,479,1520913600"; 
   d="scan'208";a="2609781"
X-Attachment_name: 
X-BodySize: 8116
Received: from mail-cys01nam02lp0054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([207.46.163.54])
  by ob1.hc2413-78.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jun 2018 17:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aaane.onmicrosoft.com;
 s=selector1-aaanortheast-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4WAwua5MRf/yZ8xvLNaMlHMfAO9tmBaE9n8kXwUTgw=;
 b=T+e+c+MT6XLlaS8vc/rM2AYMcHu5COSZnK0W4kXt7fpHJP+zwY7k6gyRsnxwtK2ljtLWNqOvkmEVQfCDs0Yz0Nifophk9xmKCWBIZq+1JsEsf3P/cIsAb3NW5YQsWaCn58AAkOATB5etR67M0G1VbZ0gd1ys9saHzWb1TqWAfCc=
Received: from BN7PR15MB2339.namprd15.prod.outlook.com (52.132.217.158) by
 BN7PR15MB2418.namprd15.prod.outlook.com (52.132.218.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Tue, 5 Jun 2018 21:24:14 +0000
Received: from BN7PR15MB2339.namprd15.prod.outlook.com
 ([fe80::ad23:ffbe:ed6b:a909]) by BN7PR15MB2339.namprd15.prod.outlook.com
 ([fe80::ad23:ffbe:ed6b:a909%5]) with mapi id 15.20.0820.015; Tue, 5 Jun 2018
 21:24:13 +0000
From:   "Heinz, Steve" <SHeinz@aaanortheast.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Heinz, Steve" <SHeinz@aaanortheast.com>
Subject: git question from a newbie
Thread-Topic: git question from a newbie
Thread-Index: AdP9E4Hrau+PXdtYS1KEfyewyALLmQ==
Date:   Tue, 5 Jun 2018 21:24:13 +0000
Message-ID: <BN7PR15MB23394E6E4AB05C17287E8F55BB660@BN7PR15MB2339.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=SHeinz@aaanortheast.com; 
x-originating-ip: [12.40.107.100]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR15MB2418;7:VbRtmlHxVVkVmduHUlRkFOt7tB+EV3lsc2tLUI3btL3KPod3cAqQuxnatnaeYXIQdd71sKQCFUDoR/bqjh5iKhaD0vk9p8acRW2rWY8Xg/GEzzQ+gGoW3gHsLx5KMLYVpAEtiILoMf278d+vFnTbp2tjS5KpI5U84Dp0t3IsqPCAAilMQTBOJDJEQZxhEwPkD8Z3/nAEEMqF30KuHa8anKBKxWnK3pKcT6v7BZj5gf8R9EsnAtPKe8OUFBXdygRG
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(376002)(396003)(346002)(199004)(189003)(6506007)(6916009)(99286004)(8676002)(2906002)(966005)(3660700001)(7696005)(476003)(7736002)(97736004)(316002)(5660300001)(72206003)(478600001)(8936002)(6436002)(102836004)(6306002)(55016002)(1730700003)(66066001)(14454004)(486006)(68736007)(5640700003)(4326008)(81166006)(59450400001)(2351001)(81156014)(26005)(3280700002)(2501003)(25786009)(5250100002)(5890100001)(86362001)(9686003)(33656002)(74316002)(186003)(6116002)(2900100001)(53936002)(107886003)(106356001)(3846002)(105586002)(80792005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR15MB2418;H:BN7PR15MB2339.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR15MB2418;
x-ms-traffictypediagnostic: BN7PR15MB2418:
x-microsoft-antispam-prvs: <BN7PR15MB2418E291D011CDF83519A5C4BB660@BN7PR15MB2418.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR15MB2418;BCL:0;PCL:0;RULEID:;SRVR:BN7PR15MB2418;
x-forefront-prvs: 0694C54398
received-spf: None (protection.outlook.com: aaanortheast.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: BwOU4++Bk8lU6qUUPzrjX6BS0+PFPUqiZWG+6/hTO0ex0SUhlEBmmVKQv1DTayNAfLr58GV87EaOf3ygXs16T0Er+9orozygO6c+3gSM0ikx2qHbEAYVUorMOnLow7v9ak2Ulmm3g4bvUKaq+72DCRLtW14I58Ct8LlG9Rbni4+EXlp4c0Cx///VTL5hj1ai
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4de8a024-04e0-4da0-5af8-08d5cb2aafab
X-OriginatorOrg: aaanortheast.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de8a024-04e0-4da0-5af8-08d5cb2aafab
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2018 21:24:13.7850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ccc4f56-0dac-42a5-a6f6-467387e586c0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2418
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I am new to Git and have read quite a few articles on it.
I am planning on setting up a remote repository on a windows 2012 R2 server=
 and will access it via HTTPS.
I am setting up a local repository on my desk top (others in my group will =
do the same).
On "server1":  I install Git and create a repository "repos".
On "server1":  I create a dummy webpage "default.htm" and place it in the r=
epo folder.
On "server1":  I create a web application in IIS pointing to Git
On Server1":   change permissions so IIS_User  has access to the folders.
On "server1":  inside the "repos" folder and right click and choose "bash h=
ere"
On "server1":   $ git init  -bare    (it's really 2 hyphens)

On Desktop:  open Chrome and type in URL to make sure we can access it    h=
ttps://xyz/repos/default.htm
      ** make sure you have access, no certificate issues or firewall issue=
s.  The pages shows up fine

On Desktop:  install Git and create repository "repos".
On Desktop:  right click in "repos" folder and choose "bash here"
On Desktop:  $ git init
On Desktop : add a folder "testProject" under the "repos" folder and add so=
me files to the folder
On Desktop:  $ git add .                 (will add files and folder to work=
ing tree)
On Desktop   $ git status               (shows it recognizes the filed were=
 added)
On Desktop   $ git commit -m "test project commit"           (will stage ch=
anges)
On Desktop   $ git push https://xyz.domainname.com/repos master

** this is the error I get,  I have tried many different things.  I am sure=
 I am doing something stupid
** I have tried a bunch of variations but I always get the same error.  It =
looks like some type of network/permission
** thing but everything seems OK.
       Fatal: repository 'https://xyz.domainname.com/repos/' not found

*** this is where I get the error trying to push staged items to the remote=
 repository.
*** I have tried to clone the empty remote repository still same error
*** I checked port 443 is opened and being used for https
*** tried to set origin to https://xyz.domainname.com/repos" and then $git =
push origin master   (same error)
*** I tried passing credentials to the remote server as well


Any ideas would be greatly appreciated.
Thanks
Steve



The information contained in this email message is intended only for the pr=
ivate and confidential use of the recipient(s) named above, unless the send=
er expressly agrees otherwise. In no event shall AAA Northeast or any of it=
s affiliates accept any responsibility for the loss, use or misuse of any i=
nformation including confidential information, which is sent to AAA Northea=
st or its affiliates via email, or email attachment. AAA Northeast does not=
 guarantee the accuracy of any email or email attachment. If the reader of =
this message is not the intended recipient and/or you have received this em=
ail in error, you must take no action based on the information in this emai=
l and you are hereby notified that any dissemination, misuse or copying or =
disclosure of this communication is strictly prohibited. If you have receiv=
ed this communication in error, please notify us immediately by email and d=
elete the original message.
