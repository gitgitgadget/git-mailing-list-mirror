From: BGaudreault Brian <BGaudreault@edrnet.com>
Subject: proxy_windows_386.exe Firewall Notification
Date: Thu, 11 Jun 2015 17:46:58 +0000
Message-ID: <BLUPR0701MB196906E314F2F1083B5DEC2BD7BC0@BLUPR0701MB1969.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 21:20:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z381v-0001O7-GR
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 21:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328AbbFKTUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 15:20:19 -0400
Received: from mail-bl2on0055.outbound.protection.outlook.com ([65.55.169.55]:53280
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753589AbbFKTUF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jun 2015 15:20:05 -0400
X-Greylist: delayed 5585 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jun 2015 15:20:05 EDT
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com (25.163.121.20) by
 BLUPR0701MB1971.namprd07.prod.outlook.com (25.163.121.22) with Microsoft SMTP
 Server (TLS) id 15.1.184.17; Thu, 11 Jun 2015 17:46:58 +0000
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com ([25.163.121.20]) by
 BLUPR0701MB1969.namprd07.prod.outlook.com ([25.163.121.20]) with mapi id
 15.01.0184.014; Thu, 11 Jun 2015 17:46:58 +0000
Thread-Topic: proxy_windows_386.exe Firewall Notification
Thread-Index: AdCkbWnQka317D+AQMy6hcSJKdL0RA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;
x-originating-ip: [12.188.185.200]
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1971;
x-microsoft-antispam-prvs: <BLUPR0701MB19711938DB7CF5CAFCA5758DD7BC0@BLUPR0701MB1971.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(520003)(3002001);SRVR:BLUPR0701MB1971;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1971;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(164054003)(110136002)(5001960100002)(107886002)(76576001)(5001920100001)(189998001)(5002640100001)(19580395003)(54356999)(50986999)(66066001)(2656002)(106116001)(87936001)(2501003)(80792005)(33656002)(86362001)(40100003)(92566002)(122556002)(2900100001)(5003600100002)(102836002)(2351001)(74316001)(46102003)(77156002)(450100001)(62966003)(229853001)(460985005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1971;H:BLUPR0701MB1969.namprd07.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-OriginatorOrg: edrnet.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2015 17:46:58.6614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5294837-2991-446b-82ba-9a6e606fbfae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1971
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271453>

Hello, when connecting to a Vagrant Shared VM via SSH, I'm getting a Windows Firewall prompt about 'proxy_windows_386.exe' (in C:\Program Files\hashicorp\vagrant\embedded\gems\gems\vagrant-share-1.1.0\localbin\), which looks like a malware-type name.  Here's the message: "Windows Security Alert.  Windows Firewall has blocked some features of this app.  Windows Firewall has blocked some features of proxy_windows_386.exe on all public and private networks.".

So I did a quick search for this file name on the Internet as well as the Git-SCM.com/community site and haven't found any clear explinations about what this file is and if it's safe.  If this is a legitimate safe file, I think it's important that this is clearly documented in the Git documentation.  Can someone verify the details about this file?

Thanks,
BRIAN
