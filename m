From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 01/11] refs: make is_branch public
Date: Tue, 10 Nov 2015 08:37:35 +0100
Message-ID: <56419EBF.5020404@alum.mit.edu>
References: <cover.1447085798.git.mhagger@alum.mit.edu> <39e0a2a708fb1a42b69e45bc5c0b17d565d3662e.1447085798.git.mhagger@alum.mit.edu> <5640EBD3.8040505@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 08:37:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw3V5-0005gq-FJ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 08:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbbKJHhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 02:37:51 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59434 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462AbbKJHhu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 02:37:50 -0500
X-AuditID: 1207440f-f79df6d000007c0f-80-56419ec34588
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 96.C3.31759.3CE91465; Tue, 10 Nov 2015 02:37:40 -0500 (EST)
Received: from [192.168.69.130] (p4FC97D33.dip0.t-ipconnect.de [79.201.125.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAA7bZ4P004856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 10 Nov 2015 02:37:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <5640EBD3.8040505@ramsayjones.plus.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsUixO6iqHtknmOYwa2DjBbzN51gtOi60s1k
	0dB7hdli0pSbTBY/WnqYLWZetbbo7fvEavFvQo0Dh8fOWXfZPRZsKvU4ezDT41nvHkaPi5eU
	PfYv3cbmseD5fXaPz5vkAjiiuG2SEkvKgjPT8/TtErgzeleUFTxkq9j5r425gXETaxcjJ4eE
	gInE86WfmSBsMYkL99azgdhCApcZJc5sUO1i5AKyzzNJvPz9hREkwSugLTFh1Q5mEJtFQFWi
	58FkdhCbTUBXYlFPM9ggUYEgiRXLX0DVC0qcnPmEBcQWEYiW+H9tLxvIUGaB94wS+489ArtC
	WMBSYsXUv4wQ29YxSiz/dAxsKifQeQ9n7wQ7iVlAT2LH9V+sELa8xPa3c5gnMArMQrJkFpKy
	WUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQIiQz+HYxd62UOMQpw
	MCrx8E745hAmxJpYVlyZe4hRkoNJSZSXf5pjmBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXvsX
	QOW8KYmVValF+TApaQ4WJXFe9SXqfkIC6YklqdmpqQWpRTBZGQ4OJQnexLlAQwWLUtNTK9Iy
	c0oQ0kwcnCDDuaREilPzUlKLEktLMuJBsRpfDIxWkBQP0N44kHbe4oLEXKAoROspRl2OBT9u
	r2USYsnLz0uVAroApEgApCijNA9uBSwNvmIUB/pYmHcHSBUPMIXCTXoFtIQJaMlSf5DniksS
	EVJSDYym11RC5hz1e5fSm6HiNcVt4RfFd0dqF/yRlOn0D7c9OmOzZna6yZuzzTKb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281102>

On 11/09/2015 07:54 PM, Ramsay Jones wrote:
> On 09/11/15 17:03, Michael Haggerty wrote:
>> [...]
>> diff --git a/refs.h b/refs.h
>> index 6d30c98..39b8edc 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -217,6 +217,8 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
>>   */
>>  int pack_refs(unsigned int flags);
>>  
>> +int is_branch(const char *refname);
>> +
>>  /*
>>   * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
>>   * REF_NODEREF: act on the ref directly, instead of dereferencing
>>
> 
> I don't understand, is_branch() is already declared in refs.h, see line 67.
> 
> This is true in master, next and pu now appears to have two declarations.

Thanks for noticing! I'll drop that patch from the next round.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
