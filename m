From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/21] replacement for dt/refs-backend-lmdb v7 patch 04/33
Date: Wed, 30 Mar 2016 08:37:48 +0200
Message-ID: <56FB743C.3020902@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
 <1458802034.28595.8.camel@twopensource.com> <56F76E2C.5030700@alum.mit.edu>
 <1459282370.2976.7.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 08:38:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al9lf-0005af-P0
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 08:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbcC3GiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 02:38:10 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52736 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751926AbcC3GiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2016 02:38:09 -0400
X-AuditID: 1207440c-c3fff70000000b85-58-56fb7440f67c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C9.C0.02949.0447BF65; Wed, 30 Mar 2016 02:37:52 -0400 (EDT)
Received: from [192.168.69.130] (p508EAFF9.dip0.t-ipconnect.de [80.142.175.249])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2U6bmUv028773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 30 Mar 2016 02:37:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1459282370.2976.7.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsUixO6iqOtQ8jvMYNtHE4v5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrR3YPHbOusvu8ax3D6PHxUvKHvuXbmPzWPD8PrvH501yAWxR
	3DZJiSVlwZnpefp2CdwZTztWMRdME6h43bmavYHxB08XIweHhICJxJ+v+l2MXBxCAlsZJX5N
	38cC4Vxgkvi5som1i5GTQ1jAT+L5++fMILaIQITEksn7WCGKNjFK3J27ng0kwSyQJ/Fp6WKw
	IjYBXYlFPc1MIBt4BbQlrp+KAgmzCKhKPJp9lBHEFhUIkdi27hvYfF4BQYmTM5+wgNicAuYS
	jT+3MkOMVJf4M+8SlC0vsf3tHOYJjPyzkLTMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJ
	iXl5qUW6hnq5mSV6qSmlmxghwc2zg/HbOplDjAIcjEo8vBGSv8OEWBPLiitzDzFKcjApifIe
	KAQK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuF9lgeU401JrKxKLcqHSUlzsCiJ86ouUfcTEkhP
	LEnNTk0tSC2CycpwcChJ8HoVAzUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgyIy
	vhgYkyApHqC9aSDtvMUFiblAUYjWU4y6HEf231vLJMSSl5+XKiXOW1oEVCQAUpRRmge3ApbK
	XjGKA30szKsIMooHmAbhJr0CWsIEtGSrxi+QJSWJCCmpBsY+Dc+cFDWedx/PO6+d/3X3xScm
	7I8MahMCb+XkvJf+c7lvxwGmH81Hn8nHPZT8zCWy2tnoXKpWrk7hTU69SP8/fb8m 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290274>

On 03/29/2016 10:12 PM, David Turner wrote:
> On Sun, 2016-03-27 at 07:22 +0200, Michael Haggerty wrote:
>> On 03/24/2016 07:47 AM, David Turner wrote:
>>> [...]
>>> I incorporated your changes into the lmdb backend.  To make merging
>>> later more convenient, I rebased on top of pu -- I think this
>>> mainly
>>> depends on jk/check-repository-format, but I also included some
>>> fixes
>>> for a couple of tests that had been changed by other patches.
>>
>> I think rebasing changes on top of pu is counterproductive. I believe
>> that Junio had extra work rebasing your earlier series onto a merge
>> of
>> the minimum number of topics that it really depended on. There is no
>> way
>> that he could merge the branch in this form because it would imply
>> merging all of pu.
>>
>> See the zeroth section of SubmittingPatches [1] for the guidelines.
> 
> I'm a bit confused because 
> [PATCH 18/21] get_default_remote(): remove unneeded flag variable
> 
> doesn't do anything on master -- it depends on some patch in pu.  And
> we definitely want to pick up jk/check-repository-format (which doesn't
> include whatever 18/21 depends on).
> 
> So what do you think our base should be?

I think the preference is to base a patch series on the merge of master
plus the minimum number of topics in pu (ideally, none) that are
"essential" prerequisites of the changes in the patch series. For
example, the version of this patch series that Junio has in his tree was
based on master + sb/submodule-parallel-update. Even if there are minor
conflicts with another in-flight topic, it is easier for Junio to
resolve the conflicts when merging the topics together than to rebase
the patch series over and over as the other patch series evolves. The
goal of this practice is of course to allow patch series to evolve
independently of each other as much as possible.

Of course if you have insights into nontrivial conflicts between your
patch series and others, it would be helpful to discuss these in your
cover letter.

Michael
