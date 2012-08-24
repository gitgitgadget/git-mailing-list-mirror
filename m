From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/17] Name local variables more consistently
Date: Fri, 24 Aug 2012 09:05:12 +0200
Message-ID: <503727A8.3040600@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu> <1345709442-16046-5-git-send-email-mhagger@alum.mit.edu> <20120823083918.GB6963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 24 09:12:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4o49-00048M-Rl
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 09:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203Ab2HXHMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 03:12:20 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:46616 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755100Ab2HXHMS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2012 03:12:18 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2012 03:12:18 EDT
X-AuditID: 12074414-b7f846d0000008b8-05-503727abe18b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 9E.2E.02232.BA727305; Fri, 24 Aug 2012 03:05:15 -0400 (EDT)
Received: from [192.168.69.140] (p57A25109.dip.t-dialin.net [87.162.81.9])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7O75DrN020737
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 24 Aug 2012 03:05:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <20120823083918.GB6963@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqLta3TzAYMpTMYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Bk7l71hL/jIU3G4i7OBcRZX
	FyMHh4SAicSmFRZdjJxAppjEhXvr2boYuTiEBC4zSpzYf5oZwjnFJLH0HEiGk4NXQFui78dP
	dhCbRUBV4sqCbrA4m4CuxKKeZiYQW1QgRGLNtymMEPWCEidnPmEBsUUEZCW+H94IFmcWsJZY
	8fowWL2wgKPEtQUNjBDLVjNK/Fq1hRUkwSlgJTFjZQ87yKXMAuoS6+cJQfTKS2x/O4d5AqPA
	LCQrZiFUzUJStYCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGSNiK7GA8
	clLuEKMAB6MSD2/BBLMAIdbEsuLK3EOMkhxMSqK8M9XMA4T4kvJTKjMSizPii0pzUosPMUpw
	MCuJ8M5/DFTOm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBKweMTyHB
	otT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UJTGFwPjFCTFA7R3GshNvMUFiblAUYjW
	U4y6HJ+fnrzLKMSSl5+XKiXOewOkSACkKKM0D24FLEm9YhQH+liYlwHkEh5ggoOb9ApoCRPQ
	ErWrxiBLShIRUlINjJ7x3t9WKjk4mD86a1CkvOWU1+2lr/N9pyn8PLhvxcLXiSqJwt8uTtug
	EdrBED29R/e7mbTojrJKJ+9mTa6suvrz/9yV/xxeejjpX8REe4F1/rmLb11jUdjE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204188>

On 08/23/2012 10:39 AM, Jeff King wrote:
> On Thu, Aug 23, 2012 at 10:10:29AM +0200, mhagger@alum.mit.edu wrote:
> 
>> From: Michael Haggerty <mhagger@alum.mit.edu>
>>
>> Use the names (nr_heads, heads) consistently across functions, instead
>> of sometimes naming the same values (nr_match, match).
> 
> I think this is fine, although:
> 
>> --- a/builtin/fetch-pack.c
>> +++ b/builtin/fetch-pack.c
>> @@ -521,7 +521,7 @@ static void mark_recent_complete_commits(unsigned long cutoff)
>>  	}
>>  }
>>  
>> -static void filter_refs(struct ref **refs, int nr_match, char **match)
>> +static void filter_refs(struct ref **refs, int nr_heads, char **heads)
>>  {
>>  	struct ref **return_refs;
>>  	struct ref *newlist = NULL;
>> @@ -530,12 +530,12 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
>>  	struct ref *fastarray[32];
>>  	int match_pos;
> 
> This match_pos is an index into the "match" array, which becomes "head".
> Should it become head_pos?
> 
> And then bits like this:
> 
>> -			while (match_pos < nr_match) {
>> -				cmp = strcmp(ref->name, match[match_pos]);
>> +			while (match_pos < nr_heads) {
>> +				cmp = strcmp(ref->name, heads[match_pos]);
> 
> Would be:
> 
>   while (head_pos < nr_heads)
> 
> which makes more sense to me.

I was up in the air about this, because match_pos *is* the position at
which a match is attempted.  But since the name also strikes you as
wrong, I will change it in the next version.

Thanks for this and all of your other comments!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
