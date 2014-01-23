From: Mihai Marinescu <Mihai.Marinescu@bksv.com>
Subject: Incomplete data: Delta source ended unexpectedly, now what ?
Date: Thu, 23 Jan 2014 08:14:38 +0000
Message-ID: <734F5D2870B56246A49C4552870CB132C6C5C2F1@dkexmbx01.bkogc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 23 09:15:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6FRu-0003kC-0M
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 09:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbaAWIPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 03:15:38 -0500
Received: from mail-db3lp0084.outbound.protection.outlook.com ([213.199.154.84]:23736
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751157AbaAWIPh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 03:15:37 -0500
Received: from DB3PR05CA007.eurprd05.prod.outlook.com (10.242.134.37) by
 DB3PR05MB122.eurprd05.prod.outlook.com (10.255.251.141) with Microsoft SMTP
 Server (TLS) id 15.0.851.11; Thu, 23 Jan 2014 08:15:05 +0000
Received: from AM1FFO11FD052.protection.gbl (2a01:111:f400:7e00::123) by
 DB3PR05CA007.outlook.office365.com (2a01:111:e400:9814::37) with Microsoft
 SMTP Server (TLS) id 15.0.859.15 via Frontend Transport; Thu, 23 Jan 2014
 08:15:05 +0000
Received: from dkexedge01.bksv.com (152.115.1.40) by
 AM1FFO11FD052.mail.protection.outlook.com (10.174.65.215) with Microsoft SMTP
 Server (TLS) id 15.0.847.12 via Frontend Transport; Thu, 23 Jan 2014 08:15:04
 +0000
Received: from dkexhub02.bkogc.com (10.20.25.17) by dkexedge01.bksv.com
 (152.115.1.40) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 23 Jan
 2014 09:15:04 +0100
Received: from dkexmbx01.bkogc.com ([169.254.1.85]) by dkexhub02.bkogc.com
 ([10.20.25.17]) with mapi id 14.03.0174.001; Thu, 23 Jan 2014 09:14:38 +0100
Thread-Topic: Incomplete data: Delta source ended unexpectedly, now what ?
Thread-Index: Ac8YEMZHU32Z0MOPTEWMZt1uTXpdpQAAktRQ
Accept-Language: en-US, da-DK
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.122.246]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:152.115.1.40;CTRY:DK;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10009001)(6009001)(189002)(199002)(365934002)(85306002)(33656001)(81542001)(90146001)(51856001)(63696002)(20776003)(74876001)(81342001)(53806001)(76482001)(54356001)(23726002)(81686001)(65816001)(92726001)(85852003)(56816005)(76796001)(74706001)(69226001)(54316002)(74502001)(76786001)(77096001)(81816001)(85806002)(83072002)(79102001)(49866001)(77982001)(46102001)(76176001)(56776001)(6806004)(55846006)(92566001)(19580395003)(16796002)(53416003)(80022001)(47776003)(50466002)(59766001)(80976001)(74366001)(31966008)(47446002)(50986001)(74662001)(46406003)(47736001)(44976005)(93516002)(47976001)(93136001)(83322001)(4396001)(87936001)(86362001)(2656002)(87266001)(94316002)(554374003);DIR:OUT;SFP:1101;SCL:1;SRVR:D
 B3PR05MB122;H:dkexedge01.bksv.com;CLIP:152.115.1.40;FPR:;RD:InfoDomainNonexistent;MX:1;A:1;LANG:en 
X-Forefront-PRVS: 0100732B76
X-OriginatorOrg: bksv.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240904>

Hi,
I have been migrating our svn repo to Git and we are not quite ready to move yet so I am keeping the Git repo update everyday by doing git svn fetch but today I ran into an issue which I don't know how to solve :

I get following error when I run git svn fetch :

Incomplete data: Delta source ended unexpectedly at /usr/lib/perl5/site_perl/Git/SVN/Ra.pm line 290

Anybody who can help ?

Btw. I am using Git 1.8.5.2.

/Mihai


This e-mail is confidential and may be read, copied and used only by the intended recipient. If you have received it in error, please contact the sender immediately by return e-mail. Please then delete the e-mail and do not disclose its contents to any other person.
