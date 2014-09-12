From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 10/32] cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
Date: Fri, 12 Sep 2014 19:13:28 +0200
Message-ID: <541329B8.1050200@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>	<1409989846-22401-11-git-send-email-mhagger@alum.mit.edu> <CAL=YDWmgwwQsCSpVsQ5U+c=4RcLdzo-j_hmxDk-AJWdRUk_SsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 19:20:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSUWU-00043m-90
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 19:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbaILRUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 13:20:34 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52708 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751489AbaILRUd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 13:20:33 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Sep 2014 13:20:33 EDT
X-AuditID: 12074412-f792e6d000005517-87-541329bbdf2f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id EC.9D.21783.BB923145; Fri, 12 Sep 2014 13:13:31 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1EE6.dip0.t-ipconnect.de [93.219.30.230])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8CHDTFu013163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Sep 2014 13:13:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <CAL=YDWmgwwQsCSpVsQ5U+c=4RcLdzo-j_hmxDk-AJWdRUk_SsQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsUixO6iqLtbUzjEoKfV1KLrSjeTRUPvFWaL
	J3PvMlv8aOlhtvg3ocais+MrowObx4JNpR4PX3Wxezzr3cPocfGSssfnTXIet59tYwlgi+K2
	SUosKQvOTM/Tt0vgzph76wprwWveil2Hz7E2MF7h6mLk4JAQMJHYMTG1i5ETyBSTuHBvPVsX
	IxeHkMBlRonp605DOeeZJBp3nWIHqeIV0JZ4/+otC4jNIqAq8bnzGjOIzSagK7Gop5kJxBYV
	CJD40PmAEaJeUOLkzCdg9SICmhI3+08zgQxlFrjBKLH0Rg8jyBXCAuESn67FQSw7zCixYsV1
	sEGcAoESz9ZdAmtmFlCX+DPvEjOELS/RvHU28wRGgVlIdsxCUjYLSdkCRuZVjHKJOaW5urmJ
	mTnFqcm6xcmJeXmpRbpmermZJXqpKaWbGCFBL7SDcf1JuUOMAhyMSjy8FSyCIUKsiWXFlbmH
	GCU5mJREeT+rCIcI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFl1gDK8aYkVlalFuXDpKQ5WJTE
	eX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8L4HaRQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0kt
	SiwtyYgHxWp8MTBaQVI8QHuFNUH2Fhck5gJFIVpPMepyrOv81s8kxJKXn5cqJc77GmSHAEhR
	Rmke3ApYinvFKA70sTDvRpAqHmB6hJv0CmgJE9CSd3OEQJaUJCKkpBoYZ5W92vniyPtbr9an
	sEy/9bXGp311ZPPXnbenfOjY/q/Nd9P9tPN/z+R0eexOebUoJZfN/1Gi9JWE+NlZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256928>

On 09/12/2014 12:42 AM, Ronnie Sahlberg wrote:
> Maybe we should not have a public constant defined for the length :
> +#define LOCK_SUFFIX_LEN 5
> 
> since it encourages unsafe code like :  (this was unsafe long before
> your patch so not a regression)
> +       i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
>         result_file[i] = 0;
> 
> 
> 
> What about removing LOCK_SUFFIX_LEN from the public API and introduce
> a helper function something like :
> 
> 
> /* pointer to the character where the lock suffix starts */
> char *lock_suffix_ptr_safe(const char *filename)
> {
>     size_t len = strlen(filename);
>     if (len < 5)
>        die("BUG:...
>     if (strcmp(filename + len - 5, LOCK_SUFFIX)
>        die("BUG:...
>     return filename + len - 5;
> }
> 
> and use it instead?

At the end of this patch series, LOCK_SUFFIX_LEN is only used in two
places outside of lockfile.c:

* In check_refname_component(), to ensure that no component of a
reference name ends with ".lock". This only indirectly has anything to
do with lockfiles.

* In delete_ref_loose(), to derive the name of the loose reference file
from the name of the lockfile. It immediately xmemdupz()s the part of
the filename that it needs, so it is kosher.

I will add a function get_locked_file_path() for the use of the second
caller.

I like being able to use the symbolic constant at the first caller, and
it is not dangerous. I don't think it is so important to make the
constant private, because I think somebody programming sloppily wouldn't
be deterred for long by not seeing a symbolic constant for the suffix
length. So if it's OK with you I'll leave the constant.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
