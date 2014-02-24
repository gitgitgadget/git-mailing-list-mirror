From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/6] Add docstrings for lookup_replace_object() and do_lookup_replace_object()
Date: Mon, 24 Feb 2014 11:17:03 +0100
Message-ID: <530B1C1F.9090304@alum.mit.edu>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu> <1393000327-11402-2-git-send-email-mhagger@alum.mit.edu> <CAP8UFD1Fz_cPSBPAZ2DwoiXKAXxEvoBAj6fiBRz3FH0nfi+OvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 11:17:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHsbC-0006dW-Fo
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 11:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbaBXKRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 05:17:12 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42887 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752997AbaBXKRJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Feb 2014 05:17:09 -0500
X-AuditID: 12074413-f79076d000002d17-7a-530b1c23386c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.25.11543.32C1B035; Mon, 24 Feb 2014 05:17:07 -0500 (EST)
Received: from [192.168.69.148] (p57A25CCF.dip0.t-ipconnect.de [87.162.92.207])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1OAH4Vt023811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 24 Feb 2014 05:17:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CAP8UFD1Fz_cPSBPAZ2DwoiXKAXxEvoBAj6fiBRz3FH0nfi+OvA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsUixO6iqKsswx1s8HCbvsXtmS3MFl1Xupks
	GnqvMFvMe/GCzeJHSw+zA6vHsxPtbB47Z91l93jWu4fR4+IlZY/Pm+QCWKO4bZISS8qCM9Pz
	9O0SuDN6dl9gK/gjUPFktl8D41neLkYODgkBE4mpuzO7GDmBTDGJC/fWs3UxcnEICVxmlLh8
	/R4rhHOeSWJL+wd2kCpeAW2Jpp832UBsFgFViRtr7rKC2GwCuhKLepqZQGxRgWCJ1ZcfsEDU
	C0qcnPkEzBYRMJSY83sJO8hQZoF2Rok9s/aADRIWSJK41vkYavUhRol9Hx4xgZzHKRAo8fdf
	IcSl4hI9jUEg5cwCOhLv+h4wQ9jyEtvfzmGewCg4C8m6WUjKZiEpW8DIvIpRLjGnNFc3NzEz
	pzg1Wbc4OTEvL7VI11wvN7NELzWldBMjJPCFdzDuOil3iFGAg1GJh1eimitYiDWxrLgy9xCj
	JAeTkihvpih3sBBfUn5KZUZicUZ8UWlOajHQ8RzMSiK8ZrxAOd6UxMqq1KJ8mJQ0B4uSOK/a
	EnU/IYH0xJLU7NTUgtQimKwMB4eSBO9SKaBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE
	0pKMeFD8xhcDIxgkxQO09zJIO29xQWIuUBSi9RSjLsfttl+fGIVY8vLzUqXEeVlBigRAijJK
	8+BWwNLcK0ZxoI+FeW1BqniAKRJu0iugJUxASwotOECWlCQipKQaGHdMkK0UF3wolsNyniXC
	pjRsufTkWcIb7+qJTogsU1zq/+RrUNl2RTF5ta0PHqxUrVp8ftPlv3OCOF0juWI6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242585>

On 02/24/2014 10:24 AM, Christian Couder wrote:
> On Fri, Feb 21, 2014 at 5:32 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
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
>>         return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJECT);
>>  }
>> +
>> +/*
>> + * If a replacement for object sha1 has been set up, return the
>> + * replacement object's name (replaced recursively, if necessary).
>> + * The return value is either sha1 or a pointer to a
>> + * permanently-allocated value.  This function always respects replace
>> + * references, regardless of the value of check_replace_refs.
> 
> Here you talk about "check_replace_refs" ...
> 
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
>>         if (!read_replace_refs)
> 
> ... but here "read_replace_refs" is used.
> 
>>                 return sha1;
>>         return do_lookup_replace_object(sha1);
>>  }

You're right; thanks for noticing.  I originally implemented this patch
on top of mh/replace-refs-variable-rename but then separated them after
all, in the hopes that the latter would be straightforward enough to be
merged quickly, before conflicting patch series appear.

Junio, what would be easiest for you?  I suggest that I rebase this
patch series back on top of mh/replace-refs-variable-rename when re-rolling.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
