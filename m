From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 02/39] api-lockfile: revise and expand the documentation
Date: Wed, 01 Oct 2014 10:11:36 +0200
Message-ID: <542BB738.9080100@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>	<1411726119-31598-3-git-send-email-mhagger@alum.mit.edu>	<xmqq8ul6869o.fsf@gitster.dls.corp.google.com>	<542AB323.4080402@alum.mit.edu> <20140930161543.GA10581@peff.net> <xmqqoatxrodx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershaus?= =?windows-1252?Q?en?= 
	<tboegi@web.de>, Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 01 10:12:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZF10-0005ne-QO
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 10:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbaJAIL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 04:11:58 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:65069 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944AbaJAILz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 04:11:55 -0400
X-AuditID: 12074413-f79ed6d000002501-56-542bb73b9584
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id D9.7B.09473.B37BB245; Wed,  1 Oct 2014 04:11:39 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s918BavI021601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 04:11:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <xmqqoatxrodx.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsUixO6iqGu9XTvE4NEPC4uuK91MFg29V5gt
	nsy9y2zx9uYSRosfLT3MFv8m1Fh0dnxldGD32DnrLrvHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DO+HbgGHNBF3fFjA/dTA2Mdzm6GDk5JARMJN6sP8wO
	YYtJXLi3nq2LkYtDSOAyo8SVeQvYIZxzTBI7N61hA6niFdCW+PN9JwuIzSKgKjFvwX9mEJtN
	QFdiUU8zE4gtKhAg8aHzASNEvaDEyZlPwOpFBBwlTjy4zgoylFngHaPE0j0TwVYLC/hLnFqx
	D6xBSGAuk8SdJXxdjBwcnALWEj8u6IGEmQX0JHZc/8UKYctLNG+dzTyBUWAWkhWzkJTNQlK2
	gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZIJAjvYNx1Uu4QowAHoxIP
	r0KCdogQa2JZcWXuIUZJDiYlUV6urUAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwTK4ByvCmJ
	lVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJXo5tQI2CRanpqRVpmTklCGkm
	Dk6Q4VxSIsWpeSmpRYmlJRnxoFiNLwZGK0iKB2ivGEg7b3FBYi5QFKL1FKMux7rOb/1MQix5
	+XmpUuK8jCBFAiBFGaV5cCtgae8VozjQx8K8miBVPMCUCTfpFdASJqAlyWvAlpQkIqSkGhjl
	hJ8uvaSeG/343qw3L07EeSS1pt2/znMs9MjtI0+VI2WXPhd2T/ryRKDjL7OlZ8wW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257693>

On 09/30/2014 07:47 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Tue, Sep 30, 2014 at 03:41:55PM +0200, Michael Haggerty wrote:
>>
>>> I didn't fix it because IMO the correct fix is to add a stdio-oriented
>>> entry point to the lockfile API, and teach the lockfile code to handle
>>> closing the FILE correctly when necessary.
>>
>> I think so, too, after our discussion[1] surrounding 9540ce5 (refs: write
>> packed_refs file using stdio, 2014-09-10).
> 
> Yeah, but we already write packed-refs via stdio, so the stdio
> oriented lockfile API entry points can no longer be just on the
> mythical todo list but needs to become reality before we can merge
> this topic sanely.

That's not the fault of this topic, which just moves the text of the
"rule" to a different place in the file. And neither is it the fault of
Peff's change to write packed-refs via stdio. It is the fault of

  60b9004 Use atomic updates to the fast-import mark file (2007-03-08)

which also fdopen()ed then fclose()d a lock_file::fd, and of

  0c0478c Document lockfile API (2008-01-16)

which documented the "rule" that had already been broken.

>>> But I didn't want to add even more changes to this patch series, so I am
>>> working on this as a separate patch series. I hope to submit it soon.
>>
>> Yay.
> 
> Yay.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
