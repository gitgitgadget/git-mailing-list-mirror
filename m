From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 05/15] get_ref_map(): rename local variables
Date: Thu, 24 Oct 2013 09:24:50 +0200
Message-ID: <5268CB42.4080709@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>	<1382543448-2586-6-git-send-email-mhagger@alum.mit.edu> <xmqqwql3q11q.fsf@gitster.dls.corp.google.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 24 09:24:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZFHv-00036w-0P
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 09:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab3JXHYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 03:24:55 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62635 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751427Ab3JXHYy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Oct 2013 03:24:54 -0400
X-AuditID: 1207440c-b7f566d000004272-32-5268cb45f6fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FF.DC.17010.54BC8625; Thu, 24 Oct 2013 03:24:53 -0400 (EDT)
Received: from [192.168.69.9] (p57A24971.dip0.t-ipconnect.de [87.162.73.113])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9O7OodO016696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 Oct 2013 03:24:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <xmqqwql3q11q.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsUixO6iqOt6OiPI4O5Xc4vpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFo8bSz0mLeixdsFj9aepgdOD0urXvJ5HHozxR2j2cn2tk8
	Lr38zubxrHcPo8fFS8oeM1pes3h83iTnceDyY7YAzihum6TEkrLgzPQ8fbsE7oz1R/+xFizm
	qbiyuYW9gfEpZxcjJ4eEgInEx/tXGSFsMYkL99azdTFycQgJXGaUmNPyhwXCOcskseHaCTaQ
	Kl4BbYmJk+Yzg9gsAqoSC+a2M4HYbAK6Eot6msFsUYEQiYWrjrND1AtKnJz5hAXEFhFQk5jY
	dghsKLPAfSaJ3z2vwYqEBRwk7r+fzwixbRWjxKPzr8Fu4hSwlphwvAmsiFlAR+Jd3wNmCFte
	YvvbOcwTGAVmIVkyC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaU
	bmKExA3PDsZv62QOMQpwMCrx8Gp8SA8SYk0sK67MPcQoycGkJMp770RGkBBfUn5KZUZicUZ8
	UWlOavEhRgkOZiURXs8KoBxvSmJlVWpRPkxKmoNFSZxXdYm6n5BAemJJanZqakFqEUxWhoND
	SYI3+hRQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoXuOLgRELkuIB2qt7EmRv
	cUFiLlAUovUUoy7HvC8fvjEKseTl56VKifOmg+wQACnKKM2DWwFLkq8YxYE+FuaNB6niASZY
	uEmvgJYwAS2ZsiQNZElJIkJKqoGR4wijhty9M2/u3LtrI+Q658GJ1V8PXf7rYf/Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236569>

On 10/23/2013 08:45 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Rename "refs" -> "refspecs" and "ref_count" -> "refspec_count" to
>> reduce confusion, because they describe an array of "struct refspec",
>> as opposed to the "struct ref" objects that are also used in this
>> function.
> 
> Good.  In general, we'd prefer to name an array of things that are
> primarily walked in the index order "thing[]", so that "thing number
> 3" can be spelled thing[3] (not things[3]) in the code, though.

Since I didn't change singular -> plural or vice versa in this patch,
it's a bit off topic, but in case you are curious I prefer plural to
distinguish which pointers point at lists or arrays as opposed to single
objects.  This convention conveniently leaves the singular available to
name a variable that is used for a single object; for example, in a loop

    struct thing thing = things[i];

(The convention in SQL is different: tables are usually named using
singular nouns.  But that makes sense in SQL because there is not really
a way to reference a single row in a table as an aggregate, so there is
no need to reserve the singular noun for that purpose.  In fact, in
SELECT statements the table name often appears in a context that makes
it look like it does refer to a single row:

    SELECT employee.name, employee.salary FROM ...

So I think it makes sense to use different conventions in C vs. SQL.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
