From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 02/38] rename_ref_available(): add docstring
Date: Thu, 9 Jun 2016 15:09:18 +0200
Message-ID: <57596A7E.9020407@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <5eb96cc20c0f76aff39d1556803ebd4f9f422cea.1464983301.git.mhagger@alum.mit.edu>
 <xmqq7fe0rhts.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 15:09:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAziM-0001yy-DB
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 15:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbcFINJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 09:09:28 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45311 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751926AbcFINJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 09:09:25 -0400
X-AuditID: 12074412-52fff700000009f7-6e-57596a824cd3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 59.72.02551.28A69575; Thu,  9 Jun 2016 09:09:22 -0400 (EDT)
Received: from [192.168.69.130] (p508EAACA.dip0.t-ipconnect.de [80.142.170.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u59D9IsL001721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jun 2016 09:09:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqq7fe0rhts.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsUixO6iqNuUFRlucOujjsX8TScYLbqudDNZ
	NPReYbbonvKW0eJHSw+zxcyr1hZn3jQyOrB77Jx1l93jWe8eRo+Ll5Q99i/dxuax+IGXx4Ln
	99k9Pm+SC2CP4rZJSiwpC85Mz9O3S+DO6L17nbXgt3TFlVMtjA2Mi8W6GDk5JARMJB6vvMzc
	xcjFISSwlVHi7dV9bBDOeSaJrmnz2EGqhAUcJL5eOcgCYosIqElMbDsEZgsJ7GSUaPmmDNLA
	LDCLSaJj60VGkASbgK7Eop5mJhCbV0BbYsHu+0ANHBwsAioSp57XgoRFBUIkzq/bygpRIihx
	cuYTsJmcAtYSP1q+gsWZBfQkdlz/BWXLS2x/O4d5AiP/LCQts5CUzUJStoCReRWjXGJOaa5u
	bmJmTnFqsm5xcmJeXmqRrplebmaJXmpK6SZGSMAL7WBcf1LuEKMAB6MSD69GSkS4EGtiWXFl
	7iFGSQ4mJVHeJ9aR4UJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeLvSgHK8KYmVValF+TApaQ4W
	JXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8rzOBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPz
	UlKLEktLMuJBMRlfDIxKkBQP0F55kHbe4oLEXKAoROspRl2OI/vvrWUSYsnLz0uVEuftASkS
	ACnKKM2DWwFLb68YxYE+FuYtAaniAaZGuEmvgJYwAS1ZfiQcZElJIkJKqoFxfrFL1atGHY2v
	tvOzK33t9kzc9n/HlTuxvRYXn9o5XH6r4vecI0TOqsWy683+1+/1ZLw+6nIwHzLK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296886>

On 06/07/2016 08:10 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> From: David Turner <dturner@twopensource.com>
>>
>> Signed-off-by: David Turner <dturner@twopensource.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs/refs-internal.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index efe5847..d8a2606 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -240,6 +240,11 @@ const char *find_descendant_ref(const char *dirname,
>>  				const struct string_list *extras,
>>  				const struct string_list *skip);
>>  
>> +/*
>> + * Check if the new name does not conflict with any existing refs
>> + * (other than possibly the old ref).  Return 0 if the ref can be
>> + * renamed to the new name.
>> + */
>>  int rename_ref_available(const char *oldname, const char *newname);
> 
> I do not quite understand the comment.  Partly because it is unclear
> what "conflict" means here, but I guess it means a D/F conflict that
> is explained near verify_refname_available()?

Yes.

> A new name can conflict with an existing, possibly old ref?  Are you
> referring to this condition?
> 
>     You are trying to rename "refs/a/b" to "refs/a", which would
>     conflict, but as long as there is no other ref that share the
>     prefix "refs/a/", e.g. "refs/a/c", the new name "refs/a" is
>     available.

That is correct.

> I wonder if it is necessary to document that this function is not
> meant to protect us from others racing with us.  That is, when you
> are renaming something to "refs/a", you call this function and it
> finds, by calling verify_refname_available(), that the repository
> has nothing that conflicts with the name and says "OK", but before
> you actually do the rename, somebody may push from sideways to
> create "refs/a/b", making the result of an earlier check with this
> function invalid.
> 
> Or is this to be called only under a lock that protects us from such
> a race?

It would be really awkward (maybe impossible?) to guard against all such
races even using locks. One problem is that the lockfiles for the old
and new refnames would themselves, in some cases, not be able to coexist
due to D/F conflicts. Also, there is no way to prevent the creation of
"any reference in `refs/a/*`" except by creating the reference `refs/a`
(the presence of `refs/a.lock` is not enough), but by that time it is
too late.

In the end, this function mostly exists as a pre-check that
`rename_ref()` is *likely* to succeed, so that the latter function is
less likely to detect a problem after it has started moving things
around. But `rename_ref()` is the final arbiter and is a bit more robust
than this check.

I also noticed that the docstring in this patch got the polarity of the
return value backwards.

I propose to change the parameter names to `old_refname` and
`new_refname` and to change the docstring to

/*
 * Check whether an attempt to rename old_refname to new_refname would
 * cause a D/F conflict with any existing reference (other than
 * possibly old_refname). If there would be a conflict, emit an error
 * message and return false; otherwise, return true.
 *
 * Note that this function is not safe against all races with other
 * processes (though rename_ref() catches some races that might get by
 * this check).
 */

Does that sound good?

Michael
