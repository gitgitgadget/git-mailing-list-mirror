From: Gary England <GEngland@myvrx.com>
Subject: Re: Bug report: Unhandled Exception
Date: Fri, 19 Jun 2015 14:09:17 +0000
Message-ID: <DM2PR06MB4931E4534120B4A65580CA7D1A40@DM2PR06MB493.namprd06.prod.outlook.com>
References: <DM2PR06MB4936C92C10128BD37E4ABC1D1BC0@DM2PR06MB493.namprd06.prod.outlook.com>,<d13c20eaeeed4fefe6a7911bc08ea59f@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 16:09:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wz9-0006Aw-Gr
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 16:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbbFSOJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 10:09:31 -0400
Received: from zixgateway01.myvrx.com ([192.41.40.104]:54806 "EHLO
	zixgateway01.myvrx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbbFSOJW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 10:09:22 -0400
Received: from 127.0.0.1 (ZixVPM [127.0.0.1])
	by Outbound.myvrx.com (Proprietary) with SMTP id 37681522A6
	for <git@vger.kernel.org>; Fri, 19 Jun 2015 08:08:28 -0600 (MDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by zixgateway01.myvrx.com (Proprietary) with ESMTPS id 6974752295;
	Fri, 19 Jun 2015 08:08:27 -0600 (MDT)
Received: from DM2PR06MB493.namprd06.prod.outlook.com (10.141.159.143) by
 DM2PR06MB495.namprd06.prod.outlook.com (10.141.159.150) with Microsoft SMTP
 Server (TLS) id 15.1.190.14; Fri, 19 Jun 2015 14:09:18 +0000
Received: from DM2PR06MB493.namprd06.prod.outlook.com ([10.141.159.143]) by
 DM2PR06MB493.namprd06.prod.outlook.com ([10.141.159.143]) with mapi id
 15.01.0190.013; Fri, 19 Jun 2015 14:09:18 +0000
Thread-Topic: Bug report: Unhandled Exception
Thread-Index: AQHQpHvjXwz0ypi5fUG3gxOiHquz0Z2z1lqAgAATEP0=
In-Reply-To: <d13c20eaeeed4fefe6a7911bc08ea59f@www.dscho.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;
x-originating-ip: [50.79.71.233]
x-microsoft-exchange-diagnostics: 1;DM2PR06MB495;3:Ct4pELtDb4XXS90iIGgiDeJs6xZ1r11wNUsK3xpfZLeeD5qQhoaPtChIEdjZMXvDt165KuPDy3vlhhuw3BXo3x0E097NfvkX3JpYAD8YE1vJ0h3hVjNwPTvcRotvZqCZcuVzqaZ5hhQO6axpAVoZRw==;10:xEWmCtct3jpK3FczWpHgevCuyy8AjLXWh+3BuDp9B+HO0iY1JbPtqdRCMBr9JUIvw4rrRCrT89kadBacfAyOB17oU6Lw7Hnb/7I0Uj9ZCfs=;6:3KH17a5F+qpsUzuxZ2xrpgClPTL7qmb1Dffpgt0/q0N6W0l4aoaO6F58dej0hXiK
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM2PR06MB495;
x-microsoft-antispam-prvs: <DM2PR06MB49581AB96DEC2CE9C99D48CD1A40@DM2PR06MB495.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:DM2PR06MB495;BCL:0;PCL:0;RULEID:;SRVR:DM2PR06MB495;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(377424004)(164054003)(24454002)(377454003)(15975445007)(102836002)(99286002)(74316001)(106116001)(19580405001)(76576001)(77096005)(77156002)(62966003)(2900100001)(40100003)(2950100001)(92566002)(46102003)(122556002)(189998001)(5001920100001)(110136002)(5003600100002)(5001960100002)(33656002)(50986999)(66066001)(19580395003)(80792005)(54356999)(87936001)(2656002)(5002640100001)(76176999)(86362001)(7059030);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR06MB495;H:DM2PR06MB493.namprd06.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-OriginatorOrg: myvrx.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2015 14:09:17.8232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6161f9fd-e776-4f16-b146-64e3f1184f0b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR06MB495
X-VPM-HOST: zixgateway01.myvrx.com
X-VPM-GROUP-ID: 5600db91-484e-4875-a625-6d04ae98c69c
X-VPM-MSG-ID: 5b76e13f-0e90-4b17-be86-053b9cd2f29f
X-VPM-ENC-REGIME: Plaintext
X-VPM-CERT-FLAG: 0
X-VPM-IS-HYBRID: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272156>

Hi Johannes,

Will do. It's unlikely that I'll be able to reproduce the error. But, in the event that it happens again, I'll let you know.

Thanks,
Gary

________________________________________
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Sent: Friday, June 19, 2015 6:58 AM
To: Gary England
Cc: git@vger.kernel.org
Subject: Re: Bug report: Unhandled Exception

Hi Gary,

On 2015-06-11 21:21, Gary England wrote:

> Using git version 1.9.2-preview20140411, in Git Bash for Windows,
> performing a "git pull --rebase", received an unhandled exception.

Please note that the newest 1.9.x release is 1.9.5. Could you re-test with that version, please? Or maybe you want to give the 2nd release candidate of Git for Windows 2.x a try: https://git-for-windows.github.io/#download

Ciao,
Johannes
