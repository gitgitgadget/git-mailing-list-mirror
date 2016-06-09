From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs: mark the file-local vtable symbols as static
Date: Thu, 9 Jun 2016 14:40:29 +0200
Message-ID: <575963BD.6050302@alum.mit.edu>
References: <57583022.2030205@ramsayjones.plus.com>
 <xmqqfusnldc4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 14:40:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAzGI-0005tA-Qv
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 14:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbcFIMke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 08:40:34 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51231 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750964AbcFIMkd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 08:40:33 -0400
X-AuditID: 12074411-e2bff70000000955-c2-575963bfa88d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id B2.5C.02389.FB369575; Thu,  9 Jun 2016 08:40:32 -0400 (EDT)
Received: from [192.168.69.130] (p508EAACA.dip0.t-ipconnect.de [80.142.170.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u59CeTnv032637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jun 2016 08:40:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqqfusnldc4.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1D2QHBlu8Ogiq0XXlW4mi4beK8wW
	M69aOzB7XLyk7LF/6TY2j8+b5AKYo7htkhJLyoIz0/P07RK4M17+O8ZacJKnYuGpO4wNjLO5
	uhg5OSQETCQeX+hiAbGFBLYySnQfk+li5AKyzzNJXOubCpYQFnCXOPdxNROILSIQLXF/zxRG
	iIYUibcfDgDVcHAwC2hJvPxdBxJmE9CVWNTTDFbOK6AtsehCN1g5i4CKxITHr8FsUYEQifPr
	trJC1AhKnJz5BGwVp4C1xPtLN8DizAJ6Ejuu/4Ky5SW2v53DPIGRfxaSlllIymYhKVvAyLyK
	US4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQTIyQ8BXcwzjgpd4hRgINRiYdXIyUi
	XIg1say4MvcQoyQHk5Io7xPryHAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwPE4ByvCmJlVWp
	RfkwKWkOFiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJ3nVJQI2CRanpqRVpmTklCGkmDk6Q
	4VxSIsWpeSmpRYmlJRnxoHiMLwZGJEiKB2jvEZB23uKCxFygKETrKUZdjiP7761lEmLJy89L
	lRLn3QBSJABSlFGaB7cCloxeMYoDfSzMKwZMTUI8wEQGN+kV0BImoCXLj4SDLClJREhJNTCK
	vTPTl0iJUNlfc6K9uyx+5x9OL7517xuqBDsMti/xev7uzxJWy4p3mlu/PJt4O3HbLqfjPEwb
	dIo1XX5u9DN19tGQaH9skCn4/Zas4JYvvt/nzcj4peMyddmhB1ZqqWvWS2/NWvh9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296885>

On 06/08/2016 08:55 PM, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Michael, Junio,
>>
>> I would normally ask you to squash this into the relevant patch when
>> you next re-roll your 'mh/ref-iterators' branch, but this has already
>> been merged into next. (I normally have a bit more time ... sorry!).
>>
>> Perhaps, after the release, when the next branch is re-wound/re-built,
>> this could be squashed into your branch then.
> 
> Yup, sounds like a plan.
> 
>>
>> Anyway, after applying this patch, the following symbols are still
>> 'public but unused':
>>
>> 	> refs/files-backend.o	- files_reflog_iterator_begin
>> 	> refs/iterator.o	- is_empty_ref_iterator
>> 	> refs/iterator.o	- merge_ref_iterator_begin
>>
>> These all look (potentially) useful for the implementation of
>> additional 'ref-iter' types and look to be part of the _internal_
>> iterator API - so they should not be marked static. Can you just
>> confirm my interpretation.
> 
> I am not Michael, but FWIW I think that is sensible.

I *am* Michael, and I think your changes look good. Thanks for your review.

I've incorporated your changes with some other changes in a re-roll [1]
in case Junio wants to use it in that form. Please note that two of the
hunks that you are suggesting apply to "refs: introduce an iterator
interface" and the third to "for_each_reflog(): reimplement using
iterators".

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/296883
