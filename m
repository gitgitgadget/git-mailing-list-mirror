From: BGaudreault Brian <BGaudreault@edrnet.com>
Subject: RE: Repository Code Security (Plan Text)
Date: Wed, 24 Jun 2015 18:59:45 +0000
Message-ID: <BLUPR0701MB196947C0396E91F8CCE39200D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
References: <BLUPR0701MB19693B73E05DF433C6B70182D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
 <20150624213111.61ce6933040bbb7220d5903c@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Wed Jun 24 20:59:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7ptr-0005tb-Bh
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 20:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbbFXS7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 14:59:50 -0400
Received: from mail-bn1bon0066.outbound.protection.outlook.com ([157.56.111.66]:65308
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752620AbbFXS7s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2015 14:59:48 -0400
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com (10.163.121.20) by
 BLUPR0701MB1972.namprd07.prod.outlook.com (10.163.121.23) with Microsoft SMTP
 Server (TLS) id 15.1.195.15; Wed, 24 Jun 2015 18:59:45 +0000
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com ([10.163.121.20]) by
 BLUPR0701MB1969.namprd07.prod.outlook.com ([10.163.121.20]) with mapi id
 15.01.0195.005; Wed, 24 Jun 2015 18:59:45 +0000
Thread-Topic: Repository Code Security (Plan Text)
Thread-Index: AdCuqem2MqHLznfSRzO/+eUOqJToogAAgfmAAABNYKA=
In-Reply-To: <20150624213111.61ce6933040bbb7220d5903c@domain007.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: 007spb.ru; dkim=none (message not signed)
 header.d=none;
x-originating-ip: [12.188.185.200]
x-microsoft-exchange-diagnostics: 1;BLUPR0701MB1972;5:p4UjWo5iYF47sGT5m8bxAmkjXKw/6t1qcqi7zO3KF/VGNnb4BZBV/mWtHMRdtfbGT3fnM7fMemi+P/I2tITXfXmFiA7PWGOvSrDVcuQZIgHskrs4Zq9O3QidSGhChMkU1c5rffuaOJcLiv8NWevLUw==;24:2TRcQrrKM4lrmA+KYrSBrz7FM/3eFdOwriihDU1yQxTuewbhLpjYS/30fjRbqyWyFi88QKnBwkLJBU6+v3jdNNu5rkGsmwxpmj8PXEMzK3w=;20:FP5oV8vIWRFGtMgieWt89m002WtPZAWfIWG1t7OwjBgbTqEfS7uY8YBrgLfAhHhpOTTnSuZkK+LsjmovON9fBw==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1972;
x-microsoft-antispam-prvs: <BLUPR0701MB1972D3CE10F01F0D6ACB931ED7AF0@BLUPR0701MB1972.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BLUPR0701MB1972;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1972;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(164054003)(13464003)(377454003)(66066001)(62966003)(40100003)(50986999)(76176999)(5003600100002)(87936001)(2656002)(46102003)(54356999)(80792005)(2950100001)(76576001)(77156002)(102836002)(122556002)(2900100001)(77096005)(5001960100002)(110136002)(189998001)(5002640100001)(74316001)(86362001)(99286002)(19580405001)(92566002)(33656002)(19580395003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1972;H:BLUPR0701MB1969.namprd07.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-OriginatorOrg: edrnet.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2015 18:59:45.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5294837-2991-446b-82ba-9a6e606fbfae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1972
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272578>

Thanks.  Yes, I meant that "local code" is code pulled down to a person's PC, so we don't want them to leave the company with access to this code.  So we can only prevent this scenario by running GitLab in our environment instead of running GitHub in the cloud?  Would removing a GitHub account from the GitHub repository prevent them from accessing the code on their PC?

How do you prevent private GitHub repositories from being pulled down to unauthorized PCs?

Thanks,
Brian

-----Original Message-----
From: Konstantin Khomoutov [mailto:kostix+git@007spb.ru] 
Sent: Wednesday, June 24, 2015 2:31 PM
To: BGaudreault Brian
Cc: git@vger.kernel.org
Subject: Re: Repository Code Security (Plan Text)

On Wed, 24 Jun 2015 18:18:00 +0000
BGaudreault Brian <BGaudreault@edrnet.com> wrote:

> If someone downloads code to their notebook PC and leaves the company, 
> what protection do we have against them not being able to access the 
> local code copy anymore?

What do you mean by "local code"?
That one which is on the notebook?
Then you can do literally nothing except for not allowing cloning your Git repositories onto random computers in the first place.

If you instead mean the copy of code available in the repositories hosted in your enterprise then all you need to do is to somehow terminate the access of that employee who's left to those repositories.
(This assumes they're accessible from the outside; if they aren't, the problem simply do not exist.)
