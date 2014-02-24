From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/6] Add docstrings for lookup_replace_object() and do_lookup_replace_object()
Date: Mon, 24 Feb 2014 09:25:02 +0100
Message-ID: <530B01DE.7050002@alum.mit.edu>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu> <1393000327-11402-2-git-send-email-mhagger@alum.mit.edu> <xmqqios8499b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 09:25:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHqr8-0007mV-S9
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 09:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbaBXIZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 03:25:12 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:64394 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761AbaBXIZJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Feb 2014 03:25:09 -0500
X-AuditID: 1207440f-f79326d000003c9f-5b-530b01e421d6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 26.E5.15519.4E10B035; Mon, 24 Feb 2014 03:25:08 -0500 (EST)
Received: from [192.168.69.148] (p57A25CCF.dip0.t-ipconnect.de [87.162.92.207])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1O8P39S019284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 24 Feb 2014 03:25:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqios8499b.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqPuEkTvYYN4fQYuuK91MFg29V5gt
	5r14wWbxo6WH2YHF49mJdjaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE748z1CawF
	N0QqDr3lbWB8I9DFyMkhIWAiMXHHIhYIW0ziwr31bF2MXBxCApcZJZ5vXsYO4Zxnkji5bw87
	SBWvgLbEqs9/GUFsFgFVif79S8G62QR0JRb1NDOB2KICwRKrLz9ggagXlDg58wmYLSKgJjGx
	7RCYzSwQK/F9TRPYTGGBJIlrnY+hNq9hlOg/fp8ZJMEpYC1xbu59oGUcQOeJS/Q0BkH06ki8
	63vADGHLS2x/O4d5AqPgLCTrZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO9
	3MwSvdSU0k2MkDDn38HYtV7mEKMAB6MSD69ENVewEGtiWXFl7iFGSQ4mJVHem/+AQnxJ+SmV
	GYnFGfFFpTmpxYcYJTiYlUR4f9wHyvGmJFZWpRblw6SkOViUxHnVl6j7CQmkJ5akZqemFqQW
	wWRlODiUJHgT/gM1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIMiOL4YGMMgKR6g
	vTsYuIH2Fhck5gJFIVpPMepy3G779YlRiCUvPy9VShyiSACkKKM0D24FLKm9YhQH+liYNxvk
	Eh5gQoSb9ApoCRPQkkILDpAlJYkIKakGxu3yFz3KVM4k8iyqYRe6ejJPdrWT+T5HH6/Pa1JP
	8U/Z0nHrbrLlvG2b/t26rPXnxAO22xvDlyTe2xooH2Zh/GLh9cCSm98W95+e8C9+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242576>

On 02/21/2014 07:21 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  cache.h | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/cache.h b/cache.h
>> index dc040fb..0ecd1c8 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -788,13 +788,29 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
>>  {
>>  	return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJECT);
>>  }
>> +
>> +/*
>> + * If a replacement for object sha1 has been set up, return the
>> + * replacement object's name (replaced recursively, if necessary).
>> + * The return value is either sha1 or a pointer to a
>> + * permanently-allocated value.  This function always respects replace
>> + * references, regardless of the value of check_replace_refs.
>> + */
>>  extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
>> +
>> +/*
>> + * If object sha1 should be replaced, return the replacement object's
>> + * name.  This function is similar to do_lookup_replace_object(),
>> + * except that it when object replacement is suppressed, it always
>> + * returns its argument unchanged.
>> + */
>>  static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
>>  {
>>  	if (!read_replace_refs)
>>  		return sha1;
>>  	return do_lookup_replace_object(sha1);
>>  }
>> +
>>  static inline const unsigned char *lookup_replace_object_extended(const unsigned char *sha1, unsigned flag)
>>  {
>>  	if (!(flag & LOOKUP_REPLACE_OBJECT))
> 
> The above description is good, but after reading e1111cef (inline
> lookup_replace_object() calls, 2011-05-15) that introduced this
> ugliness, I have to wonder if do_lookup_replace(), which nobody
> except lookup_replace_object() ever calls, is better removed from
> the public API, making lookup_replace_object() an extern definition.
> 
> We do name functions that are purely helpers that are internal
> implementation detals of the API as "do_blah", but exporting that
> kind of name as if that is part of the API people are expected to
> call feels very wrong.

I assume that the current design was to avoid the overhead of a function
call in the case that no replace references exist.  If we're willing to
eat that cost, then sure, we should bury do_lookup_replace_object() in
the implementation file.

Unless you say otherwise, I will work that change into my patch series.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
