From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 26/27] struct ref_update: Add type field
Date: Wed, 02 Apr 2014 12:13:25 +0200
Message-ID: <533BE2C5.7050700@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>	<1395683820-17304-27-git-send-email-mhagger@alum.mit.edu> <xmqq8urozuk0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:37:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeLy-0000xS-EW
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758488AbaDBKNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 06:13:31 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:62367 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758486AbaDBKN3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 06:13:29 -0400
X-AuditID: 1207440d-f79d86d0000043db-3b-533be2c9c8b4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.F4.17371.9C2EB335; Wed,  2 Apr 2014 06:13:29 -0400 (EDT)
Received: from [192.168.69.148] (p57A25BD8.dip0.t-ipconnect.de [87.162.91.216])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s32ADPnJ013447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 2 Apr 2014 06:13:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqq8urozuk0.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqHvykXWwwbNDnBY710lYdF3pZrJo
	6L3CbDHv7i4mix8tPcwWHzsXMDuweeycdZfd49LL72weH58tZ/d41ruH0ePiJWWPz5vkAtii
	uG2SEkvKgjPT8/TtErgzXk/2LTjEXfHr0zGmBsZlnF2MnBwSAiYSez9NZIOwxSQu3FsPZHNx
	CAlcZpSYNX0RE4Rzjkni9aM2dpAqXgFtiaY5y8A6WARUJdYuvcQEYrMJ6Eos6mkGs0UFgiQO
	bzjFClEvKHFy5hMWEFtEQE1iYtshFpChzAKrGSWWTpkBNkhYwF7i880uZohtaxklzr35y9jF
	yMHBKWAt8e51FogpISAu0dMYBFLOLKAj8a7vATOELS+x/e0c5gmMgrOQrJuFpGwWkrIFjMyr
	GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3MUKigXcH4/91MocYBTgYlXh4D563
	ChZiTSwrrsw9xCjJwaQkyvvxoXWwEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHepyA53pTEyqrU
	onyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE72WQRsGi1PTUirTMnBKENBMHJ8hw
	LimR4tS8lNSixNKSjHhQBMcXA2MYJMUDtNcEbG9xQWIuUBSi9RSjLseGbWsamYRY8vLzUqXE
	eU+BFAmAFGWU5sGtgKW+V4ziQB8L8x4EqeIBpk24Sa+AljABLeFeZwWypCQRISXVwJgivqB+
	V4dU2yRbPd/3peY3Xz3bFCE0UyyJa+mtiQ9FbAM+cbw+5VTaGW68xHDhroR819o9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245687>

On 04/01/2014 10:03 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This is temporary space for ref_transaction_commit().
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
> 
> I was about to complain to "*Add* type" that does not say what it is
> used for at all, with "Please do not add something for unknown purpose
> only to utilise it in a later patch".
> 
> But that was before I noticed that these are already used and
> realized that the change is about "moving what is recorded in the
> type array, which is used to receive the existing reftype discovered
> by calling resolve_ref_unsafe() in ref_transaction_commit() and not
> used anywhere else, to a field of individual ref_update structure".
> 
> So it was somewhat of a "Huh?", but perhaps it is OK.

I will expand the comment in v3.

> I wonder if ref-transaction-commit can shrink its parameter list by
> accepting a single pointer to one ref_update?

I don't understand this last point.  ref_transaction_commit() has the
following signature:

int ref_transaction_commit(struct ref_transaction *transaction,
			   const char *msg, enum action_on_err onerr)

What change are you proposing?

By the way, longer-term, I wonder if msg and maybe action_on_err should
be set for each ref_update, rather than for a whole transaction.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
