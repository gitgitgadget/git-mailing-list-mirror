From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 6/6] Document some functions defined in object.c
Date: Mon, 24 Feb 2014 09:47:57 +0100
Message-ID: <530B073D.5010702@alum.mit.edu>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu> <1393000327-11402-7-git-send-email-mhagger@alum.mit.edu> <alpine.LFD.2.11.1402211222270.17677@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 09:48:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHrCr-0000r9-Bx
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 09:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbaBXIsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 03:48:03 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46821 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752433AbaBXIsB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Feb 2014 03:48:01 -0500
X-AuditID: 12074414-f79d96d000002d2b-5c-530b0740fd8f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 6C.58.11563.0470B035; Mon, 24 Feb 2014 03:48:00 -0500 (EST)
Received: from [192.168.69.148] (p57A25CCF.dip0.t-ipconnect.de [87.162.92.207])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1O8lvTq020201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 24 Feb 2014 03:47:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <alpine.LFD.2.11.1402211222270.17677@knanqh.ubzr>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqOvAzh1ssPuznEXXlW4mi4beK8wW
	8168YLP40dLD7MDi8exEO5vHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdsW/TOfaC
	HqGKNev2MzYwbuDrYuTkkBAwkbj17yk7hC0mceHeerYuRi4OIYHLjBLP3p1lhXDOM0lMuHWU
	FaSKV0Bb4vn/WywgNouAqsSJ1qOMIDabgK7Eop5mJhBbVCBYYvXlBywQ9YISJ2c+AbNFBFQk
	ns94zAxiMwvES2yaPAHMFhZwkbjU/IgdYtl6Rol3H1rBhnIK2Ek83/UXaDEH0HniEj2NQRC9
	OhLv+h5AzZGX2P52DvMERsFZSNbNQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6
	Fnq5mSV6qSmlmxghgS6yg/HISblDjAIcjEo8vAcquIKFWBPLiitzDzFKcjApifKuZOUOFuJL
	yk+pzEgszogvKs1JLT7EKMHBrCTC++M+UDlvSmJlVWpRPkxKmoNFSZz322J1PyGB9MSS1OzU
	1ILUIpisDAeHkgRvDhvQUMGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQDMcXA6MY
	JMUDtDcBpJ23uCAxFygK0XqKUZfjdtuvT4xCLHn5ealS4rxFIEUCIEUZpXlwK2Bp7RWjONDH
	wrw2IFU8wJQIN+kV0BImoCWFFhwgS0oSEVJSDYzLC21q+79e+nx2Y/xOJv7l7PodlrO3v+2Y
	HHPyz3xuS+bVuZM6Jol93h9gvvZKybt/OxxZ9+q1yUpvcFn7uurkKTvXBs0zrLvn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242579>

Nicolas, thanks for the very fast feedback!

On 02/21/2014 06:33 PM, Nicolas Pitre wrote:
> On Fri, 21 Feb 2014, Michael Haggerty wrote:
> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> 
> Minor nits below.
> 
> 
>> ---
>>  object.c | 23 ++++++++++++++++++++++-
>>  object.h |  7 +++++++
>>  2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/object.c b/object.c
>> index 584f7ac..c34e225 100644
>> --- a/object.c
>> +++ b/object.c
>> @@ -43,14 +43,26 @@ int type_from_string(const char *str)
>>  	die("invalid object type \"%s\"", str);
>>  }
>>  
>> +/*
>> + * Return a numerical hash value between 0 and n-1 for the object with
>> + * the specified sha1.  n must be a power of 2.
>> + *
>> + * Since the sha1 is essentially random, we just take the required
>> + * bits from the first sizeof(unsigned int) bytes of sha1.
> 
> This might be improved a little.  The only reason for the sizeof() is 
> actually to copy those bits into a properly aligned integer.  Some 
> architectures have alignment restrictions that incure a significant cost 
> when integer operations are performed on unaligned data whereas sha1 
> pointers don't have any particular alignment requirements.  Once upon a 
> time this used to simply be:
> 
> 	return *(unsigned int *)sha1 & (n - 1);
> 
> The memcpy is there only to avoid unaligned accesses.

I understand all that; it's clear that the old code is not correct C,
isn't it?  And ISTM that the use of memcpy() is an implementation detail
that is not relevant to callers and so not needed in the docstring.  So
I suggest that your note be added as comments within the function; what
do you think?

Contrariwise, I thought about it again and believe that it *is*
important for the docstring to mention explicitly that the return value
is architecture-dependent (it depends on endianness and possibly
sizeof(unsigned int)).  Presumably the function is only used within one
Git invocation, so this isn't a problem, but we should warn callers.
Alternatively, we could stick a call to ntohl() in the function to make
the return value consistent, but this would cost a little bit on
little-endian computers.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
