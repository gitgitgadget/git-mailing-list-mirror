From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 10/15] fetch --tags: fetch tags *in addition to* other
 stuff
Date: Sat, 26 Oct 2013 07:10:15 +0200
Message-ID: <526B4EB7.7020004@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>	<1382543448-2586-11-git-send-email-mhagger@alum.mit.edu> <xmqqob6emlxu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 07:17:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZwFb-00055G-90
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 07:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047Ab3JZFRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 01:17:23 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54693 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020Ab3JZFRW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Oct 2013 01:17:22 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Oct 2013 01:17:22 EDT
X-AuditID: 1207440d-b7f4c6d000004a16-59-526b4ebc01c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 36.6C.18966.CBE4B625; Sat, 26 Oct 2013 01:10:20 -0400 (EDT)
Received: from [192.168.69.9] (p57A2580B.dip0.t-ipconnect.de [87.162.88.11])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9Q5AFnS001276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 26 Oct 2013 01:10:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <xmqqob6emlxu.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsUixO6iqLvHLzvIYP0EXovpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFo8bSz0mLeixdsFj9aepgdOD0urXvJ5HHozxR2j2cn2tk8
	Lr38zubxrHcPo8fFS8oeM1pes3h83iTnceDyY7YAzihum6TEkrLgzPQ8fbsE7owp2+cwFVzh
	rXj+7SFbA2MLdxcjJ4eEgInEweO3WSBsMYkL99azdTFycQgJXGaU2HxzHSOEc4ZJounrY7Aq
	XgFtievL+1hBbBYBVYnlP+4wgthsAroSi3qamUBsUYEQiYWrjrND1AtKnJz5BKxXREBNYmLb
	IRaQocwC95kkfve8BisSFgiSeN8+H2yokMBqRon/7WwgNqeAtcT0X2fAbGYBHYl3fQ+YIWx5
	ie1v5zBPYBSYhWTHLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6SXm1mil5pS
	uokREjW8Oxj/r5M5xCjAwajEw1vQnhUkxJpYVlyZe4hRkoNJSZT3i292kBBfUn5KZUZicUZ8
	UWlOavEhRgkOZiUR3tU/gMp5UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwc
	ShK8J0GGChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIOiNb4YGK8gKR6gvY9A2nmL
	CxJzgaIQracYdTnmffnwjVGIJS8/L1VKnPcaSJEASFFGaR7cCliKfMUoDvSxMO96kCoeYHqF
	m/QKaAkT0JK/V0CeKy5JREhJNTC6vHoWXs1tY+1459s3FrMfe77PcZgBjFDlVGOW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236734>

On 10/24/2013 10:51 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
>> index ba1fe49..0e6d2ac 100644
>> --- a/Documentation/fetch-options.txt
>> +++ b/Documentation/fetch-options.txt
>> @@ -61,11 +61,9 @@ endif::git-pull[]
>>  ifndef::git-pull[]
>>  -t::
>>  --tags::
>> -	This is a short-hand for giving `refs/tags/*:refs/tags/*`
>> -	refspec from the command line, to ask all tags to be fetched
>> -	and stored locally.  Because this acts as an explicit
>> -	refspec, the default refspecs (configured with the
>> -	remote.$name.fetch variable) are overridden and not used.
>> +	This is a short-hand requesting that all tags be fetched from
>> +	the remote in addition to whatever else is being fetched.  It
>> +	is similar to using the refspec `refs/tags/*:refs/tags/*`.
> 
> This is no longer a short-hand, is it?  There is no other way to ask
> "fetch the usual stuff, and then refs/tags/*:refs/tags/* as well".
> 
> It should be sufficient for me to locally do:
> 
>     s/This is a short-hand requesting/Request/;
> 
> I think.

Yes, that's better.

>> diff --git a/git-pull.sh b/git-pull.sh
>> index b946fd9..dac7e1c 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -172,7 +172,7 @@ error_on_no_merge_candidates () {
>>  	do
>>  		case "$opt" in
>>  		-t|--t|--ta|--tag|--tags)
>> -			echo "Fetching tags only, you probably meant:"
>> +			echo "It doesn't make sense to pull tags; you probably meant:"
> 
> s/pull tags/pull all tags/; perhaps?

Yes, that's also an improvement.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
