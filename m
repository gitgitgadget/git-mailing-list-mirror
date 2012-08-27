From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/17] Name local variables more consistently
Date: Mon, 27 Aug 2012 11:22:36 +0200
Message-ID: <503B3C5C.1020109@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu> <1345709442-16046-5-git-send-email-mhagger@alum.mit.edu> <20120823083918.GB6963@sigill.intra.peff.net> <7vvcg5v9hh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 11:22:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5vWz-0007mp-1q
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 11:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab2H0JWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 05:22:42 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:47063 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753007Ab2H0JWl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 05:22:41 -0400
X-AuditID: 1207440e-b7f036d0000008b5-8b-503b3c60e365
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B0.0C.02229.16C3B305; Mon, 27 Aug 2012 05:22:41 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7R9MclI021528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 27 Aug 2012 05:22:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vvcg5v9hh.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqJtoYx1gsHMas0XXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7oz5zxvYCi6IVpz+3M7ewDhX
	sIuRk0NCwETiyoZ+ZghbTOLCvfVsXYxcHEIClxklfk/cxAjhHGeSaO06wg5SxSugLfFqVw9Y
	B4uAqsSv1kksIDabgK7Eop5mJhBbVCBEYs23KYwQ9YISJ2c+AasREVCTmNh2CMjm4GAWMJKY
	d7oeJCws4ChxbUED1K6rjBIPWxeA7eIUMJNY0X8WbCazgI7Eu74HzBC2vMT2t3OYJzAKzEKy
	YhaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXWy80s0UtNKd3ECAlevh2M7etl
	DjEKcDAq8fCuum0VIMSaWFZcmXuIUZKDSUmUd5OVdYAQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
	Ed7v+y0DhHhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzPrIGGChal
	pqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxINiNb4YGK0gKR6gvT0g7bzFBYm5QFGI1lOM
	xhz/T568y8jx+SmQFGLJy89LlRLnPQlSKgBSmlGaB7cIlrZeMYoD/S3M+xKkigeY8uDmvQJa
	xQS0ar8i2KqSRISUVAOjzJZ5Eh/ctZhmnSl8vNPD5kib4+apYjNO/WXXf1cX3a4V4u+2sjqt
	6UHNjskvTzYxbo+Ufmm9QrZvj/OGiQfk1ec0X55WvUmWJaKrOvwm/6Tm+tKT5YaR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204329>

On 08/26/2012 07:39 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Thu, Aug 23, 2012 at 10:10:29AM +0200, mhagger@alum.mit.edu wrote:
>>
>>> From: Michael Haggerty <mhagger@alum.mit.edu>
>>>
>>> Use the names (nr_heads, heads) consistently across functions, instead
>>> of sometimes naming the same values (nr_match, match).
>>
>> I think this is fine, although:
>>
>>> --- a/builtin/fetch-pack.c
>>> +++ b/builtin/fetch-pack.c
>>> @@ -521,7 +521,7 @@ static void mark_recent_complete_commits(unsigned long cutoff)
>>>  	}
>>>  }
>>>  
>>> -static void filter_refs(struct ref **refs, int nr_match, char **match)
>>> +static void filter_refs(struct ref **refs, int nr_heads, char **heads)
>>>  {
>>>  	struct ref **return_refs;
>>>  	struct ref *newlist = NULL;
>>> @@ -530,12 +530,12 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
>>>  	struct ref *fastarray[32];
>>>  	int match_pos;
>>
>> This match_pos is an index into the "match" array, which becomes "head".
>> Should it become head_pos?
>>
>> And then bits like this:
>>
>>> -			while (match_pos < nr_match) {
>>> -				cmp = strcmp(ref->name, match[match_pos]);
>>> +			while (match_pos < nr_heads) {
>>> +				cmp = strcmp(ref->name, heads[match_pos]);
>>
>> Would be:
>>
>>   while (head_pos < nr_heads)
>>
>> which makes more sense to me.
> 
> Using one name is better, but I wonder "heads" is the better one
> between the two.
> 
> After all, this codepath is not limited to branches these days as
> the word "head" implies.  Rather, <nr_thing, thing> has what we
> asked for, and <refs> has what the other sides have, and we are
> trying to make sure we haven't asked what they do not have in this
> function.
> 
> And the way we do so is to match the "thing"s with what are in
> "refs" to find unmatched ones.
> 
> So between the two, I would have chosen "match" instead of "heads"
> to call the "thing".

When I decided between "heads" and "match", my main consideration was
that "match" sounds like something that has already been matched, not
something that is being matched against.  The word "match" also implies
to me that some nontrivial matching process is going on, like glob
expansion.

But I agree with you that "heads" also has disadvantages.

What about a third option: "refnames"?  This name makes it clear that we
are talking about simple names as opposed to "struct ref" or some kind
of refname glob patterns and also makes it clear that they are not
necessarily all branches.  It would also be distinct from the "refs"
linked list that is often used in the same functions.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
