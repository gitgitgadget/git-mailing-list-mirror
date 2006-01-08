From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH] Stgit - gitmergeonefile.py: handle removal vs. changes
Date: Sat, 07 Jan 2006 20:50:49 -0500
Organization: Network Appliance, Inc.
Message-ID: <43C06FF9.4070908@citi.umich.edu>
References: <20051113194225.20447.57910.stgit@zion.home.lan> <b0943d9e0511150154y2d2af24ck@mail.gmail.com> <200512301859.51000.blaisorblade@yahoo.it> <43BFA499.3020202@gmail.com>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020909010109070505080502"
Cc: Blaisorblade <blaisorblade@yahoo.it>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 02:51:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvPiS-0000UG-9t
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 02:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbWAHBuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 20:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbWAHBuw
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 20:50:52 -0500
Received: from mx1.netapp.com ([216.240.18.38]:15538 "EHLO mx1.netapp.com")
	by vger.kernel.org with ESMTP id S1161133AbWAHBuv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 20:50:51 -0500
Received: from smtp1.corp.netapp.com ([10.57.156.124])
  by mx1.netapp.com with ESMTP; 07 Jan 2006 17:50:51 -0800
X-IronPort-AV: i="3.99,342,1131350400"; 
   d="vcf'?scan'208"; a="281791867:sNHT23447472"
Received: from svlexc02.hq.netapp.com (svlexc02.corp.netapp.com [10.57.157.136])
	by smtp1.corp.netapp.com (8.13.1/8.13.1/NTAP-1.6) with ESMTP id k081ooiX019966;
	Sat, 7 Jan 2006 17:50:50 -0800 (PST)
Received: from exsvl02.hq.netapp.com ([10.56.8.60]) by svlexc02.hq.netapp.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 7 Jan 2006 17:50:50 -0800
Received: from [10.58.48.180] ([10.58.48.180]) by exsvl02.hq.netapp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 7 Jan 2006 17:50:50 -0800
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <43BFA499.3020202@gmail.com>
X-OriginalArrivalTime: 08 Jan 2006 01:50:50.0430 (UTC) FILETIME=[F3C495E0:01C613F5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14302>

This is a multi-part message in MIME format.
--------------020909010109070505080502
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
>>Also, another note: I just found Bruce Eckel mentioning pychecker, which is a 
>>static code checker for Python (to perform the checks a compiler would 
>>normally do). I've not the time to investigate more myself, but I hope it can 
>>be useful to you.
>> 
>>
> 
> Thanks. I'll give it a try.

i already ran pychecker against everything but gitmergeonefile.py... it
found a few things that you have already integrated (like that weird
behavior around using empty lists as the default value for function
arguments).  fyi...

--------------020909010109070505080502
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cel.vcf"

YmVnaW46dmNhcmQNCmZuOkNodWNrIExldmVyDQpuOkxldmVyO0NoYXJsZXMNCm9yZzpOZXR3
b3JrIEFwcGxpYW5jZSwgSW5jb3Jwb3JhdGVkO09wZW4gU291cmNlIE5GUyBDbGllbnQgRGV2
ZWxvcG1lbnQNCmFkcjo1MzUgV2VzdCBXaWxsaWFtIFN0cmVldCwgU3VpdGUgMzEwMDs7Q2Vu
dGVyIGZvciBJbmZvcm1hdGlvbiBUZWNobm9sb2d5IEludGVncmF0aW9uO0FubiBBcmJvcjtN
STs0ODEwMy00OTQzO1VTQQ0KZW1haWw7aW50ZXJuZXQ6Y2VsQGNpdGkudW1pY2guZWR1DQp0
aXRsZTpNZW1iZXIgb2YgVGVjaG5pY2FsIFN0YWZmDQp0ZWw7d29yazorMSA3MzQgNzYzLTQ0
MTUNCnRlbDtmYXg6KzEgNzM0IDc2MyA0NDM0DQp0ZWw7aG9tZTorMSA3MzQgNjY4LTEwODkN
CngtbW96aWxsYS1odG1sOkZBTFNFDQp1cmw6aHR0cDovL3Ryb3kuY2l0aS51bWljaC5lZHUv
dS9jZWwvDQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------020909010109070505080502--
