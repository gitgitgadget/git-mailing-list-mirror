From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v13 05/12] ref-filter: add option to filter out tags,
 branches and remotes
Date: Thu, 27 Aug 2015 17:24:17 +0200
Message-ID: <55DF2BA1.2020107@alum.mit.edu>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com> <1440214788-1309-6-git-send-email-Karthik.188@gmail.com> <55DDE4DB.2070504@alum.mit.edu> <CAOLa=ZQh0MNwjAOLameh1f22LB=JyD7=FeROzDRikpoRXse7cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 17:24:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUz2q-0006o7-MY
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 17:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbbH0PYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 11:24:46 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50389 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753483AbbH0PYU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2015 11:24:20 -0400
X-AuditID: 1207440c-f79e16d000002a6e-9e-55df2ba3c346
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E5.1E.10862.3AB2FD55; Thu, 27 Aug 2015 11:24:19 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3ABF.dip0.t-ipconnect.de [93.219.58.191])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7RFOHCx025619
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Aug 2015 11:24:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <CAOLa=ZQh0MNwjAOLameh1f22LB=JyD7=FeROzDRikpoRXse7cw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqLtY+36owYln5ha3Z7YwW3Rd6Way
	aOi9wmwxe8sGNotLn9ezOrB67Jx1l91j4pfjrB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8Cd
	8e52C3vBFZmKw1/WMzcwbhXtYuTkkBAwkfjU380GYYtJXLi3Hsjm4hASuMwo8XVZC5Rznkli
	1evv7CBVvALaEqsmHAeyOThYBFQlmm/agITZBHQlFvU0M4HYogJBEiuWv2CEKBeUODnzCQuI
	LSKgKXGgdSIryExmgfWMEh96zjCDzBEWSJA4fCgJYtcjRolruy+DDeIUCJTYvGcfM4jNLKAu
	8WfeJShbXqJ562zmCYwCs5DsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31
	cjNL9FJTSjcxQkKbZwfjt3UyhxgFOBiVeHgFEu+FCrEmlhVX5h5ilORgUhLljRK5HyrEl5Sf
	UpmRWJwRX1Sak1p8iFGCg1lJhDddDCjHm5JYWZValA+TkuZgURLnVV2i7ickkJ5YkpqdmlqQ
	WgSTleHgUJLgva8J1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitX4YmC0gqR4
	gPa+AGnnLS5IzAWKQrSeYlSUEudl0gJKCIAkMkrz4MbCEtYrRnGgL4V5BUGqeIDJDq77FdBg
	JqDBL+PvggwuSURISTUwmpS7LLL1+8bO8qrnCnNz6/Ie96tvnKUtl05Qt192wJQh8I5CzpLj
	+Q3Pnz/dH/jKditf3N+cCrXK3g6zujB//TfmnQ+3bBYIFkvlTDppEtjcGWRWmnj1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276676>

On 08/27/2015 02:42 PM, Karthik Nayak wrote:
> On Wed, Aug 26, 2015 at 9:40 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 08/22/2015 05:39 AM, Karthik Nayak wrote:
>>> [...]
>>> +     if (type == FILTER_REFS_BRANCHES)
>>> +             ret = for_each_reftype_fullpath(ref_filter_handler, "refs/heads/", broken, &ref_cbdata);
>>> +     else if (type == FILTER_REFS_REMOTES)
>>> +             ret = for_each_reftype_fullpath(ref_filter_handler, "refs/remotes/", broken, &ref_cbdata);
>>> +     else if (type == FILTER_REFS_TAGS)
>>> +             ret = for_each_reftype_fullpath(ref_filter_handler, "refs/tags/", broken, &ref_cbdata);
>>> +     else if (type & FILTER_REFS_ALL) {
>>> +             ret = for_each_reftype_fullpath(ref_filter_handler, "", broken, &ref_cbdata);
>>> +             if (type & FILTER_REFS_DETACHED_HEAD)
>>> +                     head_ref(ref_filter_handler, &ref_cbdata);
>>
>> The usual promise of the for_each_ref functions is that they stop
>> iterating if the function ever returns a nonzero value. So the above
>> should be
>>
>>                 if (! ret && (type & FILTER_REFS_DETACHED_HEAD))
>>                         ret = head_ref(ref_filter_handler, &ref_cbdata);
>>
>> Also, these functions usually iterate in lexicographic order, so I think
>> you should process HEAD before the others.
> 
> This is done on purpose, cause we need to print the HEAD ref separately
> so we print the last ref_array_item in the ref_array, free that memory and
> sort and print the rest, hence HEAD ref is attached to the last.

Without having looked at the other patches, this makes me wonder whether
it makes sense to store HEAD in the ref_array at all or whether it
should be handled separately.

>> But there's another problem here. It seems like
>> FILTER_REFS_DETACHED_HEAD is only processed if (type & FILTER_REFS_ALL)
>> is nonzero. But shouldn't it be allowed to process *only* HEAD?
>>
>> So, finally, I think this code should look like
>>
>>         else if (!filter->kind)
>>                 die("filter_refs: invalid type");
>>         else {
>>                 if (filter->kind & FILTER_REFS_DETACHED_HEAD)
>>                         ret = head_ref(ref_filter_handler, &ref_cbdata);
>>                 if (! ret && (filter->kind & FILTER_REFS_ALL))
>>                         ret =
>> for_each_reftype_fullpath(ref_filter_handler, "", broken, &ref_cbdata);
>>         }
>>
> 
> So finally something like this perhaps
> 
>     if (!filter->kind)
>         die("filter_refs: invalid type");
>     else {
>         if (filter->kind == FILTER_REFS_BRANCHES)
>             ret = for_each_reftype_fullpath(ref_filter_handler,
> "refs/heads/", broken, &ref_cbdata);
>         else if (filter->kind == FILTER_REFS_REMOTES)
>             ret = for_each_reftype_fullpath(ref_filter_handler,
> "refs/remotes/", broken, &ref_cbdata);
>         else if (filter->kind == FILTER_REFS_TAGS)
>             ret = for_each_reftype_fullpath(ref_filter_handler,
> "refs/tags/", broken, &ref_cbdata);
>         else if (filter->kind & FILTER_REFS_ALL)
>             ret = for_each_reftype_fullpath(ref_filter_handler, "",
> broken, &ref_cbdata);
>         if (filter->kind & FILTER_REFS_DETACHED_HEAD)
>             head_ref(ref_filter_handler, &ref_cbdata);
>     }

Yes, but the last test should be

        if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))

unless you have a reason not to follow the usual convention that a
nonzero return value from fn means that the iteration should be aborted.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
