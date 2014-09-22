From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 10/35] cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
Date: Mon, 22 Sep 2014 17:25:18 +0200
Message-ID: <54203F5E.5090805@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-11-git-send-email-mhagger@alum.mit.edu> <20140916210538.GK29050@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 17:25:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW5UV-0008Os-El
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 17:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbaIVPZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 11:25:23 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:62409 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754089AbaIVPZV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Sep 2014 11:25:21 -0400
X-AuditID: 12074414-f79446d000001f1d-9f-54203f61bfaa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.27.07965.16F30245; Mon, 22 Sep 2014 11:25:21 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB23E6.dip0.t-ipconnect.de [93.219.35.230])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8MFPInI027134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 22 Sep 2014 11:25:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140916210538.GK29050@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsUixO6iqJtorxBi8GIlq0XXlW4mi4beK8wW
	T+beZbZ4e3MJo8WPlh5mi38Taiw6O74yOrB77Jx1l91jwaZSj4evutg9nvXuYfS4eEnZ4/Mm
	OY/bz7axBLBHcdskJZaUBWem5+nbJXBnnNu8g63gJk9F9+2zzA2M87i6GDk5JARMJFZO3s0M
	YYtJXLi3nq2LkYtDSOAyo8S1943MEM55JoldU6cygVTxCmhLHO5ZytLFyMHBIqAqcXq3KkiY
	TUBXYlFPM1iJqECAxIfOB4wQ5YISJ2c+YQGxRQQ0JJ5/+ga2gFngA6PE4luzWUHmCAuES6zc
	KAuxaxGjxONNr9lBGjgFDCS6fj0As5kF1CX+zLvEDGHLS2x/O4d5AqPALCQ7ZiEpm4WkbAEj
	8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkEgQ2cF45KTcIUYBDkYlHt4F
	TfIhQqyJZcWVuYcYJTmYlER575sqhAjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4Q2SBsrxpiRW
	VqUW5cOkpDlYlMR5vy1W9xMSSE8sSc1OTS1ILYLJynBwKEnwXrEFahQsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHxWp8MTBaQVI8QHv57UD2Fhck5gJFIVpPMepyrOv81s8kxJKX
	n5cqJc6rCVIkAFKUUZoHtwKW9l4xigN9LMxrAlLFA0yZcJNeAS1hAlpy/7g8yJKSRISUVAPj
	Wo6cE0cunuooTPGr32l84uc+Jse2zEq7qrpTP6+9K970wX6FHOfnixG84eKB5dOf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257365>

On 09/16/2014 11:05 PM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> There are a few places that use these values, so define constants for
>> them.
> 
> Seems like a symptom of the API leaving out a useful helper (e.g.,
> something that strips off the lock suffix and returns a memdupz'd
> filename).

I will add a function get_locked_file_path().

> [...]
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -570,6 +570,10 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
>>  #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
>>  extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
>>  
>> +/* String appended to a filename to derive the lockfile name: */
>> +#define LOCK_SUFFIX ".lock"
>> +#define LOCK_SUFFIX_LEN 5
> 
> My suspicion is that error handling would be better if fewer callers
> outside of lockfile.c did the '- LOCK_SUFFIX_LEN' dance, so this seems
> like a step in the wrong direction.
> 
> Adding constants in lockfile.c would make sense, though.

I agree that other call sites shouldn't be grubbing around in the
lock_file data structure. But with the addition of
get_locked_file_path(), the only remaining user of these constants is in
refs.c, in check_refname_component():

	if (cp - refname >= LOCK_SUFFIX_LEN &&
	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
		return -1; /* Refname ends with ".lock". */

I think it is forgivable there.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
