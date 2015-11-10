From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 07/11] refs/refs-internal.h: new header file
Date: Tue, 10 Nov 2015 08:40:02 +0100
Message-ID: <56419F52.9050806@alum.mit.edu>
References: <cover.1447085798.git.mhagger@alum.mit.edu> <5f62351689318a4ef9feeb3639e6a7a00b354a02.1447085798.git.mhagger@alum.mit.edu> <5640F823.5010902@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 08:40:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw3XL-0008AS-Pe
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 08:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbbKJHkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 02:40:09 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61959 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751162AbbKJHkI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 02:40:08 -0500
X-AuditID: 12074413-f79bd6d000007ac2-7e-56419f54811a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 4A.36.31426.45F91465; Tue, 10 Nov 2015 02:40:04 -0500 (EST)
Received: from [192.168.69.130] (p4FC97D33.dip0.t-ipconnect.de [79.201.125.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAA7e2Gd004959
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 10 Nov 2015 02:40:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <5640F823.5010902@ramsayjones.plus.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqBsy3zHMYN45U4v5m04wWnRd6Way
	aOi9wmwxacpNJosfLT3MFjOvWlv09n1idWD32DnrLrvH2YOZHs969zB6XLyk7LF/6TY2jwXP
	77N7fN4kF8AexW2TlFhSFpyZnqdvl8Cd0Xm5gbHgM1vF05vTGBsY97F2MXJySAiYSHz69pcN
	whaTuHBvPZDNxSEkcJlRorf1AyOEc55J4tznrYwgVbwC2hK7OxuZQGwWAVWJF5PmMIPYbAK6
	Eot6msHiogJBEiuWv4CqF5Q4OfMJC4gtIhAt8f/aXrANzAL7GSW+T90C1iAs4CzxoeMpE8S2
	dYwSy3dfB5rKwcEJdN/XOdYgNcwCehI7rv9ihbDlJba/ncM8gVFgFpIds5CUzUJStoCReRWj
	XGJOaa5ubmJmTnFqsm5xcmJeXmqRrrlebmaJXmpK6SZGSCwI72DcdVLuEKMAB6MSD++Ebw5h
	QqyJZcWVuYcYJTmYlER5+ac5hgnxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4bV/AVTOm5JYWZVa
	lA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLglZgHNFSwKDU9tSItM6cEIc3EwQky
	nEtKpDg1LyW1KLG0JCMeFK3xxcB4BUnxAO2dOReonbe4IDEXKArReopRl2PBj9trmYRY8vLz
	UqXEeeeDFAmAFGWU5sGtgCW+V4ziQB8L834DqeIBJk24Sa+AljABLVnqD/JccUkiQkqqgZFh
	A7/j44+LTxosvvWrzfljMGdi76pfW2ta7Zp+2SlaJr88F1RhxBN+yO3Bmd2yYtdT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281103>

On 11/09/2015 08:46 PM, Ramsay Jones wrote:
> On 09/11/15 17:03, Michael Haggerty wrote:
>> [...]
>> diff --git a/refs.c b/refs.c
>> index f48c58a..9aff0c8 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1,6 +1,6 @@
>>  #include "cache.h"
>> +#include "refs/refs-internal.h"
>>  #include "lockfile.h"
>> -#include "refs.h"
> 
> This looked wrong to me, until I had read the remainder of the
> patch and noticed that the 'internal' header #included the
> 'public' interface header.
> 
> Unfortunately, this still feels wrong to me! I would rather that
> the internal header _not_ include the public header (so, include
> them _both_ when necessary). Just my opinion, which you can simply
> ignore. :-D

Yeah, I was of two minds about this. I will change this in the next
round. Thanks for your review!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
