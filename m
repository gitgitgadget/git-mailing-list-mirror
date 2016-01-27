From: =?iso-8859-1?Q?Charles_B=E9langer?= <cbelanger@addenergie.ca>
Subject: Need support with git credential storage
Date: Wed, 27 Jan 2016 21:49:38 +0000
Message-ID: <CY1PR0701MB1836FFF6CEAC69DFB5E86DACB7D90@CY1PR0701MB1836.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 23:04:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOYC0-0001ut-UI
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 23:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936124AbcA0WD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 17:03:56 -0500
Received: from mail-bn1on0082.outbound.protection.outlook.com ([157.56.110.82]:43456
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S936105AbcA0WDw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 17:03:52 -0500
X-Greylist: delayed 3317 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2016 17:03:52 EST
Received: from CY1PR0701MB1836.namprd07.prod.outlook.com (10.163.42.157) by
 CY1PR0701MB1835.namprd07.prod.outlook.com (10.163.42.156) with Microsoft SMTP
 Server (TLS) id 15.1.396.15; Wed, 27 Jan 2016 21:49:39 +0000
Received: from CY1PR0701MB1836.namprd07.prod.outlook.com ([10.163.42.157]) by
 CY1PR0701MB1836.namprd07.prod.outlook.com ([10.163.42.157]) with mapi id
 15.01.0396.015; Wed, 27 Jan 2016 21:49:39 +0000
Thread-Topic: Need support with git credential storage
Thread-Index: AdFZTJVuVLRNcWWeQCSVMGhbZ6ElHA==
Accept-Language: fr-CA, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cbelanger@addenergie.ca; 
x-originating-ip: [69.159.124.142]
x-microsoft-exchange-diagnostics: 1;CY1PR0701MB1835;5:klrgPLS7v8OB7QVeGD7kgQlApAsAK0mDzpx83aj3qn5mXPzBrJX5QwLuDuGwDcJuB7eqmXvTtThWI9aRXDmLm4n9LKzWwZ26uOnC8otUtUtzyJbSgg1y3Ae9HHrh/CryNVt++CgeeRtP7MS/itmXkg==;24:a+T9pJ/4TmNdURUx+n71YrGcV73YOW4C8jCNZmWUJaDBqddAQJFX1OOMcU4jrY1lRJ55eagTiaRv4VRb+YxaCoDHL1vMcXaCSteS4UzitBI=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1835;
x-ms-office365-filtering-correlation-id: c9428151-de6b-4b3c-3ed0-08d32763c198
x-microsoft-antispam-prvs: <CY1PR0701MB1835F6534C4E0EF88106C30EB7D90@CY1PR0701MB1835.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:CY1PR0701MB1835;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1835;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(199003)(189002)(66066001)(33656002)(101416001)(50986999)(11100500001)(54356999)(74316001)(10400500002)(229853001)(86362001)(2351001)(5004730100002)(87936001)(99286002)(106356001)(105586002)(15975445007)(5002640100001)(551544002)(77096005)(40100003)(76576001)(19580405001)(19580395003)(5008740100001)(5001960100002)(107886002)(3280700002)(122556002)(110136002)(97736004)(74482002)(81156007)(2906002)(5003600100002)(92566002)(2501003)(450100001)(1220700001)(189998001)(3846002)(102836003)(586003)(6116002)(1096002)(2900100001)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1835;H:CY1PR0701MB1836.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: addenergie.ca does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
X-OriginatorOrg: addenergie.ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2016 21:49:38.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 430c8e9b-f6ed-4977-ac62-88730327849b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1835
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git Community,

I'm working at AddEnergie at Quebec city in Canada and I'm currently working on making a Build Server in a Virtual Machine running Ubuntu.
We are using git for our source code and I'm the first one here that need to use git store credentials for an Automated Build Server that would run overnight.

I'm wondering if you could provide me support about it because I'm having issue making it works.
The clue I have right now about my git store credential issue is when I'm doing a git clone of my project repo, I'm having following errors:

Here's the git clone command launch by a .sh script file called from ~/.profile:
git clone https://MyUserName@bitbucket.org/CompanyName/ProjectName.git ~/Projects/SubFolderName/ProjectName

Here's the error from bash .profile:
Fatal: unable to access 'https://MyUserName@bitbucket.org/CompanyName/ProjectName.git/':
Could not resolve host: bitbucket.org

I followed the excellent Web page here:
https://git-scm.com/book/be/v2/Git-Tools-Credential-Storage

Here's what I use as commands:
git credential-store --file ~/git.store store
protocol=https
host=bitbucket.org/CompanyName/ProjectName.git
username=MyUserName
password=MyPassword
(type enter on a blank line to exit)

git credential-store --file ~/git.store get
protocol=https
host=bitbucket.org/CompanyName/ProjectName.git
(type enter on a blank line to exit)


Here's what the ~/git.store file looks like:
        https://MyUserName:MyPassword@bitbucket.org%2fCompanyName%2fProjectName.git

I tried changing the %2f by / inside the git.store file and also tried // but it's still showing the same fatal error.
Perhaps I don't use the host=  property correctly.

May I ask you helping me with this ?

Best Regards,

Charles Belanger
