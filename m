From: BGaudreault Brian <BGaudreault@edrnet.com>
Subject: RE: Repository Code Scope (Plan Text)
Date: Wed, 24 Jun 2015 19:09:32 +0000
Message-ID: <BLUPR0701MB1969F731E6A6D18C575CBFA1D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
References: <BLUPR0701MB1969F347A7CA0ABBEE901242D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
 <20150624215246.55e60abab6afb139589c2765@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Wed Jun 24 21:09:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7q3H-0003tI-UY
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577AbbFXTJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:09:36 -0400
Received: from mail-bn1bon0092.outbound.protection.outlook.com ([157.56.111.92]:43712
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752813AbbFXTJf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2015 15:09:35 -0400
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com (10.163.121.20) by
 BLUPR0701MB1969.namprd07.prod.outlook.com (10.163.121.20) with Microsoft SMTP
 Server (TLS) id 15.1.195.15; Wed, 24 Jun 2015 19:09:33 +0000
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com ([10.163.121.20]) by
 BLUPR0701MB1969.namprd07.prod.outlook.com ([10.163.121.20]) with mapi id
 15.01.0195.005; Wed, 24 Jun 2015 19:09:33 +0000
Thread-Topic: Repository Code Scope (Plan Text)
Thread-Index: AdCuqiWXW3q4b8KeRjqM4Al8UTgx2AABM/kAAABbWsA=
In-Reply-To: <20150624215246.55e60abab6afb139589c2765@domain007.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: 007spb.ru; dkim=none (message not signed)
 header.d=none;
x-originating-ip: [12.188.185.200]
x-microsoft-exchange-diagnostics: 1;BLUPR0701MB1969;5:tJ9gqXqsRXSd/leKSV59EDMDw2CR0QAtK8ipP00q3H7DuJ9IBHLh6UwyfLEGDwFXyGwW+TlZu6vcwIllYIPyqn+Ixz54IiL7JcUhfIPs/uY/6YTHJ7bkOI3jlk4Yx6flJch2Bc3OO6bACcuOZwHCNg==;24:c0jVtDz07Drjv86hisDYXWW/njeGj1fJU1uXHClHWGWqCqsGnWPINEq3/OHg7bxjb5Sr/wqmqdZIqKSKhKJ1RF4WRQl0xsyX0bU1TKgljBI=;20:SrfK0kfoDLmP2U9XbB+wwFgnR/B+wpr3mTAJFWILUWkUWuGdaG58EFQgkRzM7X84oTMYCbT5uP4HxHBsX1sugQ==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1969;
x-microsoft-antispam-prvs: <BLUPR0701MB19695E5F4CE84884ED235BEFD7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BLUPR0701MB1969;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1969;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(377454003)(13464003)(164054003)(19580395003)(110136002)(86362001)(19580405001)(5003600100002)(77096005)(5002640100001)(2900100001)(54356999)(76176999)(46102003)(92566002)(87936001)(5001960100002)(2656002)(102836002)(33656002)(189998001)(80792005)(122556002)(66066001)(76576001)(2950100001)(40100003)(50986999)(99286002)(62966003)(74316001)(77156002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1969;H:BLUPR0701MB1969.namprd07.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-OriginatorOrg: edrnet.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2015 19:09:33.0356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5294837-2991-446b-82ba-9a6e606fbfae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1969
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272579>

Thanks.  So are you saying there are tools that will let us start a repo for a project with multiple submodules and then pull out the coding history for a specific submodule so we can create a separate repository just for that submodule?

I've actually been doing a lot of research about Git for many things that Git doesn't have basic documentation for, but I wasn't sure how to search for an answer to this type of question.  Plus, we're trying to adopt Git quickly, and since I'm not a developer I have a lot of research that has to be done to understand what developers understand and how we can manage GIt, which is slowing down our adoption of Git.

Thanks,
Brian

-----Original Message-----
From: Konstantin Khomoutov [mailto:kostix+git@007spb.ru] 
Sent: Wednesday, June 24, 2015 2:53 PM
To: BGaudreault Brian
Cc: git@vger.kernel.org
Subject: Re: Repository Code Scope (Plan Text)

On Wed, 24 Jun 2015 18:19:42 +0000
BGaudreault Brian <BGaudreault@edrnet.com> wrote:

> What type of code scope should a repository contain?  Can it be one 
> large program with many elements or should it just be part of a 
> program or can it be a project with multiple programs?  What are the 
> recommendations?

There are no recommendations because the structure of a repositories depends on the use case.

If you're developing a library which might be used by more than a single other project, host it in a separate repository, and in the projects which use that library, refer to it using submodules.

If you have a project which contains internal submodules (say, for .NET projects, it's common to have many so-called assemblies in a single project to provide modularity), there's little point in messing with separate repositories and it's simpler to keep everything in one place.

Note that there are tools which allow you to split from a repository the history touching only the contents of a particular directory, and then glue such history back into some other repository.  Using these are not exactly a walk in the park but at least this sort of things is doable.
This means you might start with a simple solution and then shape it into a more appropriate form when you'll see the need for this.

I should also warn you that your question appear to be a bit too broad which, IMO, suggests that you did not do much research on what's offerred by Git and its ecosystem, what's in a Git repo, how is it hosted, what are the best practices of managing complicated Git projects etc.  And all this information is abundant in the internets...
