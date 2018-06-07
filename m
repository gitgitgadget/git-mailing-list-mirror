Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046951F403
	for <e@80x24.org>; Thu,  7 Jun 2018 12:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeFGMkf (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 08:40:35 -0400
Received: from esa1.hc2413-78.iphmx.com ([216.71.152.18]:45945 "EHLO
        esa1.hc2413-78.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbeFGMke (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 08:40:34 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520913600"; 
   d="scan'208";a="2788995"
X-Attachment_name: 
X-BodySize: 9088
Received: from mail-dm3nam03lp0015.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([207.46.163.15])
  by ob1.hc2413-78.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2018 08:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aaane.onmicrosoft.com;
 s=selector1-aaanortheast-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w31jpgGBugjMnaB868GXbaJrm1f/Bth8fOkv1Yuy1hE=;
 b=TWjhsDPm3B1mySoqPv1ApJ1TUPfi6X94tMB3BulRxW6k8tcgwNbib4KOWBUanUXmeBnpius59P4kzMf9fvjnmSo/ibBRiS5F3JYYUPsZH1/Zt3nt0b65IqbQlY2A27eAQv36DOnH30qRGkpj+NcToTyZVzxNXpBjPXttRF44TO8=
Received: from BN7PR15MB2339.namprd15.prod.outlook.com (52.132.217.158) by
 BN7PR15MB2306.namprd15.prod.outlook.com (52.132.217.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 7 Jun 2018 12:40:29 +0000
Received: from BN7PR15MB2339.namprd15.prod.outlook.com
 ([fe80::ad23:ffbe:ed6b:a909]) by BN7PR15MB2339.namprd15.prod.outlook.com
 ([fe80::ad23:ffbe:ed6b:a909%6]) with mapi id 15.20.0841.011; Thu, 7 Jun 2018
 12:40:29 +0000
From:   "Heinz, Steve" <SHeinz@aaanortheast.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git question from a newbie
Thread-Topic: git question from a newbie
Thread-Index: AdP9E4Hrau+PXdtYS1KEfyewyALLmQAB7kYAAFBOWiA=
Date:   Thu, 7 Jun 2018 12:40:29 +0000
Message-ID: <BN7PR15MB2339C81C23CAF414722EB089BB640@BN7PR15MB2339.namprd15.prod.outlook.com>
References: <BN7PR15MB23394E6E4AB05C17287E8F55BB660@BN7PR15MB2339.namprd15.prod.outlook.com>
 <000901d3fd1b$3eeb7900$bcc26b00$@nexbridge.com>
In-Reply-To: <000901d3fd1b$3eeb7900$bcc26b00$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=SHeinz@aaanortheast.com; 
x-originating-ip: [12.40.107.100]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR15MB2306;7:2YufRc8h1apwUdfD0wgZwM0fMZ61CF25Xuh5JjfQK44tBc8xSqRhTu1w/x0FFjm1AO847LT+TGszNINxuMXUtIVFA1PqikRD9354VF8TE1nuEzVag+UJIdiCYS/Sb3JNDkNZ9DvPhFVD0Jo80coVS7nBTqFI6YdqKkVfCTHdbksl15Nv2FDj4tGdPlMwKST6z54dpiz+xiSW1uWx68A4nKrMsgk7tNHLjFawDL83o3QIEXtcvZ4QcTrTGJMqF4Pq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR15MB2306;
x-ms-traffictypediagnostic: BN7PR15MB2306:
x-microsoft-antispam-prvs: <BN7PR15MB2306ED8170C4156D536EB03FBB640@BN7PR15MB2306.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(9452136761055)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR15MB2306;BCL:0;PCL:0;RULEID:;SRVR:BN7PR15MB2306;
x-forefront-prvs: 06968FD8C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(39860400002)(366004)(396003)(13464003)(189003)(199004)(6246003)(53936002)(229853002)(6436002)(2900100001)(2906002)(68736007)(5660300001)(3660700001)(3846002)(6116002)(3280700002)(99286004)(7696005)(316002)(110136005)(2501003)(5250100002)(5890100001)(105586002)(106356001)(33656002)(86362001)(97736004)(186003)(80792005)(26005)(76176011)(102836004)(59450400001)(6506007)(53546011)(8936002)(486006)(66066001)(74316002)(476003)(72206003)(966005)(14454004)(9686003)(6306002)(11346002)(25786009)(81166006)(81156014)(8676002)(7736002)(446003)(478600001)(55016002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR15MB2306;H:BN7PR15MB2339.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:3;
received-spf: None (protection.outlook.com: aaanortheast.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: Ry0NJCMaSRb9jCsQgxNKjqiGLTE8TXT0wpETx7YwNd4NWhnkaO9QZwvFdXxqFnlVz/BMxqyOntV8y+R/qjfSwl1mjBZQvNucnebUu2ozCN6XCBt+WiJnCEF/V7LXuDGZPKyWQgxRUEH1nldQzdXUmUF9qrz71qR5fvTIukzh2CLbBr0ZUP3bFL+1ntRcWGD0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9069e46b-0bda-486d-4439-08d5cc73da25
X-OriginatorOrg: aaanortheast.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9069e46b-0bda-486d-4439-08d5cc73da25
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2018 12:40:29.4562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ccc4f56-0dac-42a5-a6f6-467387e586c0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall

Thank you, I tried it but that didn't work either.  I did find out what my =
issue was.  I need some type of client that would be setup to listen for th=
e requests.

Steve


-----Original Message-----
From: Randall S. Becker <rsbecker@nexbridge.com>
Sent: Tuesday, June 05, 2018 6:19 PM
To: Heinz, Steve <SHeinz@aaanortheast.com>; git@vger.kernel.org
Subject: RE: git question from a newbie

On June 5, 2018 5:24 PM, Steve Heinz wrote:
> I am new to Git and have read quite a few articles on it.
> I am planning on setting up a remote repository on a windows 2012 R2
server
> and will access it via HTTPS.
> I am setting up a local repository on my desk top (others in my group
> will
do
> the same).
> On "server1":  I install Git and create a repository "repos".
> On "server1":  I create a dummy webpage "default.htm" and place it in
> the repo folder.
> On "server1":  I create a web application in IIS pointing to Git
> On Server1":   change permissions so IIS_User  has access to the folders.
> On "server1":  inside the "repos" folder and right click and choose
> "bash here"
> On "server1":   $ git init  -bare    (it's really 2 hyphens)
>
> On Desktop:  open Chrome and type in URL to make sure we can access it
> https://xyz/repos/default.htm
>       ** make sure you have access, no certificate issues or firewall
issues.  The
> pages shows up fine
>
> On Desktop:  install Git and create repository "repos".
> On Desktop:  right click in "repos" folder and choose "bash here"
> On Desktop:  $ git init
> On Desktop : add a folder "testProject" under the "repos" folder and
> add some files to the folder
> On Desktop:  $ git add .                 (will add files and folder to
working tree)
> On Desktop   $ git status               (shows it recognizes the filed
were added)
> On Desktop   $ git commit -m "test project commit"           (will stage
changes)
> On Desktop   $ git push https://xyz.domainname.com/repos master
>
> ** this is the error I get,  I have tried many different things.  I am
sure I am
> doing something stupid
> ** I have tried a bunch of variations but I always get the same error.
> It
looks
> like some type of network/permission
> ** thing but everything seems OK.
>        Fatal: repository 'https://xyz.domainname.com/repos/' not found
>
> *** this is where I get the error trying to push staged items to the
remote
> repository.
> *** I have tried to clone the empty remote repository still same error
> *** I checked port 443 is opened and being used for https
> *** tried to set origin to https://xyz.domainname.com/repos" and then $gi=
t
> push origin master   (same error)
> *** I tried passing credentials to the remote server as well

Missing glue - git remote

git remote add origin https://xyz.domainname.com/repos

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000  UNIX developer s=
ince approximately 421664400
-- In my real life, I talk too much.



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
