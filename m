From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: add --author option
Date: Tue, 27 Mar 2012 13:52:40 -0700
Message-ID: <7vr4wdhilj.fsf@alter.siamese.dyndns.org>
References: <4F71E415.9030800@gmx.ch> <4F71F902.8090200@in.waw.pl>
 <4F7223D0.5000801@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, peff@peff.net
To: Mathias Weber <mweb@gmx.ch>
X-From: git-owner@vger.kernel.org Tue Mar 27 22:53:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCdOJ-00024u-07
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 22:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021Ab2C0Uwo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 16:52:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753879Ab2C0Uwn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 16:52:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7685D5DDE;
	Tue, 27 Mar 2012 16:52:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0zXU5hvExApZ
	FUE8+pzKms6PM8I=; b=wHDO6BW19NJKLktQvEnAaCIvM/e6xGlWMtbsl0rMLlQ0
	A1bxalnx8t4jPieemraWpgLcfsCW0hQknP8U+is3Fd8PzcCm7vQUiaMgB0bBthzx
	CEkY9tL1Z3gjeNnOstcaaXFT+QbguAvh82APvMOX8dmaBDRcz2zdFCDbMwHJawE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uBMrzc
	bQYJapVbA2uhuSB730jspI/YeynfjkTb67nwXjkVKBZOkHm7FkIzL6A7T8+NvMkR
	gCT4SSzCk/y4zS9U5B2d+kVF5Mk3NXkLFphrLE8VgNqwFHJ4AUgUff3A1ZzjFLuq
	obX60xmylA/0MmnV0CFXc8382ibYPN06vvvO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D3555DDD;
	Tue, 27 Mar 2012 16:52:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 006275DDC; Tue, 27 Mar 2012
 16:52:41 -0400 (EDT)
In-Reply-To: <4F7223D0.5000801@gmx.ch> (Mathias Weber's message of "Tue, 27
 Mar 2012 22:32:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBD20ADA-784E-11E1-9819-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194086>

Mathias Weber <mweb@gmx.ch> writes:

> On 27.03.2012 19:29, Zbigniew J=C4=99drzejewski-Szmek wrote:
>> On 03/27/2012 06:00 PM, Mathias Weber wrote:
>>>
>>> The tag command does not support the --author option as the
>>> commit command. This adds the --author option to create
>>> annotated tags with a different author.
>>=20
>> Consistency is good.
>
> It would be good but during the rework of the patch I realized that f=
or
> the tag the committer is and should be used and not the author.
> Therefore it is fine that this option isn't available. I'm sorry
> bothering you.

I would have thought that being able to lie about "tagger " would be
equivalent to lying about --author of the commit.  What am I missing?

Not that I am enthused by the idea of having to add another option.  I
would be perfectly happy if we did not add such a flag.  It is just I d=
o
not understand the reasoning behind the retraction.
