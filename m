From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 09/13] refs: introduce an iterator interface
Date: Tue, 31 May 2016 03:16:49 +0200
Message-ID: <574CE601.3010701@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
 <89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
 <574C5AB0.4090005@ramsayjones.plus.com>
 <574C70EF.5070705@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 31 03:17:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7YIr-0003b8-K0
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 03:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162290AbcEaBRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 21:17:00 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45075 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161883AbcEaBQ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 21:16:59 -0400
X-AuditID: 12074414-63fff700000008e6-c7-574ce60503de
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id CB.D4.02278.506EC475; Mon, 30 May 2016 21:16:53 -0400 (EDT)
Received: from [192.168.69.130] (p508EABD0.dip0.t-ipconnect.de [80.142.171.208])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4V1GoKU016066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2016 21:16:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <574C70EF.5070705@ramsayjones.plus.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsUixO6iqMv6zCfc4HSLssX8TScYLbqudDNZ
	NPReYbbonvKW0eJHSw+zxcyr1g5sHjtn3WX3eNa7h9Hj4iVlj/1Lt7F5LHh+n93j8ya5ALYo
	bpukxJKy4Mz0PH27BO6M201TWApeslX8vvGRqYFxI2sXIyeHhICJxKvrh9m7GLk4hAS2Mkrc
	aV3PBOFcYJI4sHsnWJWwgIPE3c9NLCAJEYFeRonmpgksEFV3gJzfe8H6mQWmMUo82XaNGaSF
	TUBXYlFPMxOIzSugLbHk8m4WEJtFQFVi0/kusLioQIjE+XVbWSFqBCVOznwCVsMJdNTk/7fY
	QGxmAXWJP/MuMUPY8hLb385hnsDIPwtJyywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyY
	l5dapGuhl5tZopeaUrqJERLkIjsYj5yUO8QowMGoxMPL0OkTLsSaWFZcmXuIUZKDSUmUd8E9
	oBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3ocPgXK8KYmVValF+TApaQ4WJXHeb4vV/YQE0hNL
	UrNTUwtSi2CyMhwcShK8EU+BGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBkRlf
	DIxNkBQP0N7UJyB7iwsSc4GiEK2nGI05Fvy4vZaJ48j+e2uZhFjy8vNSpcR5XzwGKhUAKc0o
	zYNbBEtvrxjFgf4W5u0GuYcHmBrh5r0CWsUEtCo+A2xVSSJCSqqBcQonywbpB594l5stFDP/
	H/NV6vLsvc0zHv7kTsjcz50/6XlahsWGjKPqnXeKrsxWnxgTLOYbqd+5+1Lmk6uR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295944>

On 05/30/2016 06:57 PM, Ramsay Jones wrote:
> 
> 
> On 30/05/16 16:22, Ramsay Jones wrote:
>>
>>
>> On 30/05/16 08:55, Michael Haggerty wrote:
>> [snip]
>>
>>>  /* Reference is a symbolic reference. */
>>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>>> index 8ab4d5f..dbf1587 100644
>>> --- a/refs/files-backend.c
>>> +++ b/refs/files-backend.c
>>> [...]
>>> +			sort_ref_dir(dir);
>>
>> do you need to sort here ...
>>> [...]
>>> +			sort_ref_dir(level->dir);
>>
>> ... given that you sort here?
> 
> I had intended to say 'or vice versa' here. When I wrote this, I had not
> finished reading this patch (let alone the series). Now, I suspect that
> you can simply drop this 'sort_ref_dir()' call site. Unless I've misread
> the code, of course! ;-)

Yes, you are right. Thanks for catching this! I'll fix it in v2.

Michael
