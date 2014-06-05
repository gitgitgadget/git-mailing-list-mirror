From: Fran Mico <fran.mico@schoolworks.co.uk>
Subject: FW: Git crash in windows 2012 R2
Date: Thu, 5 Jun 2014 13:42:49 +0000
Message-ID: <b7ef9c4922a24fba91686ded022991dd@AMXPR04MB085.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 05 15:43:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsXxS-0008TI-U7
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 15:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbaFENmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 09:42:53 -0400
Received: from mail-am1lp0016.outbound.protection.outlook.com ([213.199.154.16]:51255
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751162AbaFENmw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2014 09:42:52 -0400
Received: from AMXPR04MB085.eurprd04.prod.outlook.com (10.242.71.16) by
 AMXPR04MB085.eurprd04.prod.outlook.com (10.242.71.16) with Microsoft SMTP
 Server (TLS) id 15.0.954.9; Thu, 5 Jun 2014 13:42:49 +0000
Received: from AMXPR04MB085.eurprd04.prod.outlook.com ([169.254.16.94]) by
 AMXPR04MB085.eurprd04.prod.outlook.com ([169.254.16.94]) with mapi id
 15.00.0954.000; Thu, 5 Jun 2014 13:42:49 +0000
Thread-Topic: Git crash in windows 2012 R2
Thread-Index: Ac+Aw7mp7QA+RrbQQU68SeKU5GNiuwAADKpQ
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [87.81.130.229]
x-microsoft-antispam: BL:0;ACTION:Default;RISK:Low;SCL:0;SPMLVL:NotSpam;PCL:0;RULEID:
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(71364002)(66654002)(99396002)(555904002)(33646001)(76482001)(64706001)(79102001)(80022001)(77982001)(86362001)(21056001)(74316001)(46102001)(92566001)(66066001)(83322001)(81342001)(54356999)(50986999)(85852003)(74662001)(83072002)(76576001)(4396001)(20776003)(81542001)(101416001)(87936001)(31966008)(74502001)(74482001)(2656002)(24736002)(36394004);DIR:OUT;SFP:;SCL:1;SRVR:AMXPR04MB085;H:AMXPR04MB085.eurprd04.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (: schoolworks.co.uk does not designate permitted sender
 hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fran.mico@schoolworks.co.uk; 
X-OriginatorOrg: schoolworks.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250837>

Hi,

My name is Fran, we are a development team who uses git. We have our Development Environment in the server office (Windows 2008 R2) where everything runs without problems. We are planning to move to Windows Azure so we bought a virtual server to try our Development Environment and check the performance and if we will be able to do everything we are doing at the moment in the office server in the virtual server (Windows Azure).

We came across with a problem when installing Git in the Virtual server (Window Azure - Windows 2012 R2 64bits)

All the installation process went ok (except once that it didn't finished, the only thing missing was the Environment Variable that I had to introduce manually) , the only problem is that when we run in the Window Command Prompt the command 'git' the command prompt crashes and do not respond anymore.

This is the installation options we have tried:

First installation (Git 1.9.2)
	Windows Explorer integration (Advanced context menu git-cheetah plugin)
	Use Git from the Windows Command Prompt
Second installation (Git 1.9.2)
	Windows Explorer integration (Git Bash Here, Git GUI Here)
	Use Git from the Windows command prompt
Third installation (Portable Git 1.9.0)
	We have try as well downloading the portable version and setting the Environment variables

All the installations cause the same behaviour in the command prompt when running the command 'git' on it

If you need any more information (screenshoots...) that could be useful for you, let me know and I will send it over.

Many thanks.

Kind regards,
Fran Mico
