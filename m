From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 4/7] struct ref_lock: delete the force_write member
Date: Tue, 03 Mar 2015 11:50:58 +0100
Message-ID: <54F59212.5040105@alum.mit.edu>
References: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>	<1425288597-20547-5-git-send-email-mhagger@alum.mit.edu> <xmqqk2yz9ir9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 11:51:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSkPz-0005lq-4W
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 11:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbbCCKvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 05:51:10 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57354 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751369AbbCCKvJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 05:51:09 -0500
X-AuditID: 12074412-f79e46d0000036b4-ad-54f592167543
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 04.E6.14004.61295F45; Tue,  3 Mar 2015 05:51:02 -0500 (EST)
Received: from [192.168.69.130] (p5DDB193E.dip0.t-ipconnect.de [93.219.25.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t23AowX0014723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 3 Mar 2015 05:50:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqqk2yz9ir9.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsUixO6iqCs26WuIQd9RTouuK91MFg29V5gt
	3t5cwmjRPeUto8WPlh5mi96+T6wWmze3s1icedPI6MDhsXPWXXaPBZtKPZ717mH0uHhJ2WPx
	Ay+Pz5vkAtiiuG2SEkvKgjPT8/TtErgzvrYvZit4KVix9XgDcwPjZ94uRk4OCQETibafb1kh
	bDGJC/fWs3UxcnEICVxmlHi9egorhHOWSWLm55nMIFW8AtoSy5bcZgexWQRUJf5/mATWzSag
	K7Gop5kJxBYVCJI4dPoxC0S9oMTJmU/AbBEBNYmJbYdYQIYyC1xmknj78zdYQljAS+Lxqodg
	zUICaxglLvy1B7E5Bawl2v5cY+xi5ABqUJdYP08IJMwsIC/RvHU28wRGgVlIVsxCqJqFpGoB
	I/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJA4ENrBuP6k3CFGAQ5GJR7e
	CexfQ4RYE8uKK3MPMUpyMCmJ8nZMAArxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4e1vBMrxpiRW
	VqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1ILYLJynBwKEnwloAMFSxKTU+tSMvMKUFIM3Fw
	ggznkhIpTs1LSS1KLC3JiAdFanwxMFZBUjxAe3tB2nmLCxJzgaIQracYFaXEeatBEgIgiYzS
	PLixsOT2ilEc6EthXpWJQFU8wMQI1/0KaDAT0OBbil9ABpckIqSkGhhNhXJ+nE0vNL6pcX2C
	Pmv87CcvJJbe3CbOxNMhWf4rvWz/USeF1xfTfN/esrNNXjDp39K90368E9jt48k1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264647>

On 03/02/2015 10:44 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Instead, compute the value when it is needed.
> 
>> @@ -2318,8 +2317,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>>  	lock->ref_name = xstrdup(refname);
>>  	lock->orig_ref_name = xstrdup(orig_refname);
>>  	ref_file = git_path("%s", refname);
>> -	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
>> -		lock->force_write = 1;
>>  
>>   retry:
>>  	switch (safe_create_leading_directories(ref_file)) {
>> @@ -3787,8 +3784,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>  		struct ref_update *update = updates[i];
>>  
>>  		if (!is_null_sha1(update->new_sha1)) {
>> -			if (!update->lock->force_write &&
>> -			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
>> +			if (!((update->type & REF_ISSYMREF)
>> +			      && (update->flags & REF_NODEREF))
>> +			    && !hashcmp(update->lock->old_sha1, update->new_sha1)) {
>> +				/*
>> +				 * The reference already has the desired
>> +				 * value, so we don't need to write it.
>> +				 */
>>  				unlock_ref(update->lock);
>>  				update->lock = NULL;
>>  			} else if (write_ref_sha1(update->lock, update->new_sha1,
> 
> The code before and after the change are equivalent.
> 
> It shouldn't be the case, but somehow I find the original slightly
> easier to understand. [...]

I had the same feeling; thanks for confirming it. How about I introduce
a temporary variable `overwriting_symref` as an aid to the reader? I
think this makes it pretty clear:

>  		if (!is_null_sha1(update->new_sha1)) {
> -			if (!update->lock->force_write &&
> -			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
> +			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
> +						  (update->flags & REF_NODEREF));
> +
> +			if (!overwriting_symref
> +			    && !hashcmp(update->lock->old_sha1, update->new_sha1)) {
> +				/*
> +				 * The reference already has the desired
> +				 * value, so we don't need to write it.
> +				 */
>  				unlock_ref(update->lock);
>  				update->lock = NULL;
>  			} else if (write_ref_sha1(update->lock, update->new_sha1,

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
