From: BGaudreault Brian <BGaudreault@edrnet.com>
Subject: RE: Repository Code Security (Plan Text)
Date: Wed, 24 Jun 2015 19:53:23 +0000
Message-ID: <BLUPR0701MB1969E8CB9B348504F02231F3D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
References: <BLUPR0701MB19693B73E05DF433C6B70182D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
 <20150624213111.61ce6933040bbb7220d5903c@domain007.com>
 <BLUPR0701MB196947C0396E91F8CCE39200D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
 <alpine.DEB.2.02.1506241217010.4148@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Wed Jun 24 21:53:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qjj-0007PU-II
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbbFXTx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:53:28 -0400
Received: from mail-bl2on0064.outbound.protection.outlook.com ([65.55.169.64]:22891
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753189AbbFXTx0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2015 15:53:26 -0400
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com (10.163.121.20) by
 BLUPR0701MB1969.namprd07.prod.outlook.com (10.163.121.20) with Microsoft SMTP
 Server (TLS) id 15.1.195.15; Wed, 24 Jun 2015 19:53:23 +0000
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com ([10.163.121.20]) by
 BLUPR0701MB1969.namprd07.prod.outlook.com ([10.163.121.20]) with mapi id
 15.01.0195.005; Wed, 24 Jun 2015 19:53:23 +0000
Thread-Topic: Repository Code Security (Plan Text)
Thread-Index: AdCuqem2MqHLznfSRzO/+eUOqJToogAAgfmAAABNYKAAAWr1AAAA8xfA
In-Reply-To: <alpine.DEB.2.02.1506241217010.4148@nftneq.ynat.uz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lang.hm; dkim=none (message not signed) header.d=none;
x-originating-ip: [12.188.185.200]
x-microsoft-exchange-diagnostics: 1;BLUPR0701MB1969;5:Qgo7kdfzxoHfTpvyYW5JqdQNMkczT5HfjobzzsGmsi2/4EnEpv6ct2bW4n8QdofUqn5r1L7sT+1hvKPiRCbzzvgcXa5OoKCa9JKLwHrI0jxkYjVxeR+VF9Jr0nb5th3iWk7vOhseV9A1XnAAGJExlA==;24:Cq/VNA6yVtGeyC7CczRd+S94sLNAPMIDjNWfgBSvEENcgTvKmiUQlZGvFkea1XL3jwadNjGX61G+9HVkAWeP4wTmG3FTE5RriRrLiaqEOyY=;20:v6s+uqm28btScNPKAWWGYokwJ/ZJ/rI3d6ocl1P1D1tjRmx43m+d152TYofOHKVfdK0+GbzNYLMv6FcvAAKjFw==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(42134001)(42139001);SRVR:BLUPR0701MB1969;
x-microsoft-antispam-prvs: <BLUPR0701MB1969B2360510FC0A6C6D2CC1D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BLUPR0701MB1969;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1969;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(164054003)(13464003)(377454003)(51704005)(24454002)(76576001)(66066001)(40100003)(2950100001)(80792005)(122556002)(77156002)(93886004)(50986999)(74316001)(2420400003)(62966003)(99286002)(76176999)(5002640100001)(54356999)(2900100001)(7110500001)(86362001)(19580405001)(110136002)(19580395003)(5003600100002)(15975445007)(77096005)(102836002)(2656002)(189998001)(33656002)(92566002)(46102003)(87936001)(5001960100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1969;H:BLUPR0701MB1969.namprd07.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-OriginatorOrg: edrnet.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2015 19:53:23.4693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5294837-2991-446b-82ba-9a6e606fbfae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1969
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272591>

Hi David Lang,

I'm sorry, but I'm confused by your first two responses.  Am I not contacting Git when I e-mail this e-mail address?  You sound like you don't know exactly how GitHub works.  Should I be contacting someone else for GitHub support?

Thanks,
Brian

-----Original Message-----
From: David Lang [mailto:david@lang.hm] 
Sent: Wednesday, June 24, 2015 3:20 PM
To: BGaudreault Brian
Cc: Konstantin Khomoutov; git@vger.kernel.org
Subject: RE: Repository Code Security (Plan Text)

On Wed, 24 Jun 2015, BGaudreault Brian wrote:

> Thanks.  Yes, I meant that "local code" is code pulled down to a person's PC, so we don't want them to leave the company with access to this code.  So we can only prevent this scenario by running GitLab in our environment instead of running GitHub in the cloud?  Would removing a GitHub account from the GitHub repository prevent them from accessing the code on their PC?
>
> How do you prevent private GitHub repositories from being pulled down to unauthorized PCs?

policy, you say that it's against policy for someone to put company info on a personal machine.

You probably run your own repository that's only available within your network (or over your VPN) rather than using a cloud service like github (you may want to check with github to see if they can lock down a private repo to only be accessed from specific IP addresses)

you will also need to make sure that people don't plug personal laptops into your corporate network, and that they don't use personal phones to access company e-mail.

The bottom line is that it's no different from preventing them from having access to any other sensitive data in your company. What measures do you have in place to keep them from taking sensitive Word Docs or spreadsheets when they leave? do the same thing to deal with their access to code.

David Lang

> Thanks,
> Brian
>
> -----Original Message-----
>
> On Wed, 24 Jun 2015 18:18:00 +0000
> BGaudreault Brian <BGaudreault@edrnet.com> wrote:
>
>> If someone downloads code to their notebook PC and leaves the 
>> company, what protection do we have against them not being able to 
>> access the local code copy anymore?
>
> What do you mean by "local code"?
> That one which is on the notebook?
> Then you can do literally nothing except for not allowing cloning your Git repositories onto random computers in the first place.
>
> If you instead mean the copy of code available in the repositories hosted in your enterprise then all you need to do is to somehow terminate the access of that employee who's left to those repositories.
> (This assumes they're accessible from the outside; if they aren't, the 
> problem simply do not exist.)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in the 
> body of a message to majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
>
