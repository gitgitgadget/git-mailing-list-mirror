From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 15/21] init: allow alternate ref strorage to be set for
 new repos
Date: Thu, 18 Feb 2016 15:12:38 +0100
Message-ID: <56C5D156.1020800@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-16-git-send-email-dturner@twopensource.com>
 <56BDF9B1.5050302@alum.mit.edu> <1455742036.7528.18.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 15:13:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWPKP-0005t3-Kp
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 15:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620AbcBROMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 09:12:55 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43172 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751308AbcBROMx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2016 09:12:53 -0500
X-AuditID: 12074412-af3ff70000006da4-6c-56c5d1593676
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id BF.85.28068.951D5C65; Thu, 18 Feb 2016 09:12:41 -0500 (EST)
Received: from [192.168.69.130] (p548D6911.dip0.t-ipconnect.de [84.141.105.17])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1IECcd4003236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 18 Feb 2016 09:12:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1455742036.7528.18.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1I28eDTMYNFeEYv5m04wWnRd6Way
	2N2a5cDs8e5UA6vHguf32T0+b5ILYI7itklKLCkLzkzP07dL4M74vKC44BRrxd99i9gaGLez
	dDFyckgImEi8vtPK3sXIxSEksJVR4viPI+wgCSGB80wSTU/iuhg5OIQFoiS+z+MHCYsIOEhc
	3nWUGaL+CqPEk87JYIOYBUwlZq3ZC2azCehKLOppZgKxeQW0JXZvXQ4WZxFQlZj++iAbiC0q
	ECLx/utzVogaQYmTM5+A1XAKWEjcPj+VHWKmusSfeZeYIWx5ie1v5zBPYOSfhaRlFpKyWUjK
	FjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdPLzSzRS00p3cQICVChHYzrT8odYhTgYFTi
	4d3w4kiYEGtiWXFl7iFGSQ4mJVFezZ1Hw4T4kvJTKjMSizPii0pzUosPMUpwMCuJ8O7eC5Tj
	TUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHgUJLgZbwA1ChYlJqeWpGWmVOC
	kGbi4AQZziUlUpyal5JalFhakhEPisf4YmBEgqR4gPbqgLTzFhck5gJFIVpPMepyLPhxey2T
	EEtefl6qlDjvu/NARQIgRRmleXArYOnoFaM40MfCvPYgo3iAqQxu0iugJUxAS3IuHQJZUpKI
	kJJqYEyefF51R3T70sBrU7WcYqfqOX1QVnysqx+1ZeOc1FjrzSXzBL5XfMn5tWnFy4gpi9zF
	GVTnR+9tDXCr2PjQJ2Ll0ZhQe4kZ2rlWDtnmRlpLtNdvnJFcuiss/Ze1andFcs/y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286607>

On 02/17/2016 09:47 PM, David Turner wrote:
> On Fri, 2016-02-12 at 16:26 +0100, Michael Haggerty wrote:
>> [...]
>> Is it worth testing re-initializing with the same --ref-storage?
>> Perhaps
>> not.
> 
> Would be nice, but since we cannot guarantee that any alternate backend
> exists, we have no way to test this.  We'd have to add an entire "test"
> ref backend just for tests, which seems a bit overboard.

I meant re-initializing a repository that is using the "files" backend
with `--ref-storage=files` to make sure that it is a NOP. But I think
this functionality is unlikely to be broken so it wouldn't be a very
high-value test.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
