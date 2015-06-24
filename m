From: BGaudreault Brian <BGaudreault@edrnet.com>
Subject: Repository Code Security (Plan Text)
Date: Wed, 24 Jun 2015 18:18:00 +0000
Message-ID: <BLUPR0701MB19693B73E05DF433C6B70182D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 20:18:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7pFQ-0002nY-Ou
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 20:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbbFXSSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 14:18:04 -0400
Received: from mail-bn1bon0069.outbound.protection.outlook.com ([157.56.111.69]:50010
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752908AbbFXSSD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2015 14:18:03 -0400
Received: from BLUPR0701MB1971.namprd07.prod.outlook.com (10.163.121.22) by
 BLUPR0701MB1044.namprd07.prod.outlook.com (10.160.36.139) with Microsoft SMTP
 Server (TLS) id 15.1.190.14; Wed, 24 Jun 2015 18:18:01 +0000
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com (10.163.121.20) by
 BLUPR0701MB1971.namprd07.prod.outlook.com (10.163.121.22) with Microsoft SMTP
 Server (TLS) id 15.1.195.15; Wed, 24 Jun 2015 18:18:01 +0000
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com ([10.163.121.20]) by
 BLUPR0701MB1969.namprd07.prod.outlook.com ([10.163.121.20]) with mapi id
 15.01.0195.005; Wed, 24 Jun 2015 18:18:01 +0000
Thread-Topic: Repository Code Security (Plan Text)
Thread-Index: AdCuqem2MqHLznfSRzO/+eUOqJToog==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;
x-originating-ip: [12.188.185.200]
x-microsoft-exchange-diagnostics: 1;BLUPR0701MB1971;5:c04KhR1Ax+qdBlZ2VR1GXKzH7SndAAo6o4niteC0BduxvW+aVYoSZ5fwGoLIV0xCOK5ste5P+548dlfratuYlAxr2L0soKEyJ4yfWUs5yfJtGleVWlDwWj9BAGvwt9KTJTPrWzrD6VpTJT0RY2TZZg==;24:t5cLHguHm4Dfx/89Fw06isCDIbt30KmQMReyH+cPXCqNvwHZJYM7m+RlAEBS/ABQWzjvxVLugOU+dV2EThLk2ziZjsE1t5nsHv/ptDrIki0=;20:2+3c6ZBsXNWWxdfS2kK5vqObwFOMr9h0D+jpvboW9ebcL3qbnUjDWtBJGm8py3KDOv0NbtW+ZevF77s5PGo6bw==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1971;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1044;
x-microsoft-antispam-prvs: <BLUPR0701MB197110047EA59226A9622D7FD7AF0@BLUPR0701MB1971.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BLUPR0701MB1971;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1971;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(164054003)(77096005)(46102003)(558084003)(189998001)(450100001)(66066001)(99286002)(2501003)(107886002)(102836002)(5001960100002)(2900100001)(229853001)(40100003)(2351001)(110136002)(33656002)(5003600100002)(87936001)(2656002)(92566002)(5002640100001)(86362001)(122556002)(77156002)(80792005)(62966003)(76576001)(54356999)(74316001)(50986999);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1971;H:BLUPR0701MB1969.namprd07.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2015 18:18:01.0091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5294837-2991-446b-82ba-9a6e606fbfae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1971
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1044;2:+EHlHI1cy62vTDeyhzFJPWzKJTcBN+yotzUHygEPJos0nXVyL6YdIa2iJvQ3htWd;2:2f817FaxjN6vX6zm5aFkrwVrkSu0zd0w9oGch7uhJO6e5AZDNHjKJWlRukxJqm9AkuoL9bivlu5k21yIhzEsto2YYhldTLvexDMUEX+y+Z4YikJfcp3B3gzoZJbcts+UerGO3+ZMzUiMi/AGxYczSw==;9:o+m2dlZhZZ49T/eKnmDQ24G9xyteOxWHNOn7uXrSNsuouRRJ6EKjqcmsVuHsWrnKvjGnGnwT3F7XmWA2reOZ7Uaohe/jbjjIApyfjXy3HNUwG7ErKriZwsa/Ee//F4GQFOpG0BnHbvtT4zsDgZekJA==
X-OriginatorOrg: edrnet.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272573>

Hello,

If someone downloads code to their notebook PC and leaves the company, what protection do we have against them not being able to access the local code copy anymore?

Thanks,
Brian
