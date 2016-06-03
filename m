From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/13] Reference iterators
Date: Fri, 03 Jun 2016 16:40:03 -0700
Message-ID: <xmqq4m99265o.fsf@gitster.mtv.corp.google.com>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
	<xmqqporyneik.fsf@gitster.mtv.corp.google.com>
	<5751FCBF.3070507@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:40:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8yhJ-0005KN-Q9
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 01:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbcFCXkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 19:40:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750740AbcFCXkH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 19:40:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B387D2221A;
	Fri,  3 Jun 2016 19:40:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ouRH4a4j1CjYBppxfe82K68yi9k=; b=SdhAuD
	p6glE1Qg6YGQHtCkUZEVCss0Z3ZEQyC8kUjjFlUKMwLZBiZlD2dHlAf/s0UjzAQ3
	YmmDZEMLTZMmcBDz07CKaPMwqdWoMuNphidFbH9KQ2r2cmBLwNKqy4wUQ2ClVlTE
	1IQ5jloCbWpRiNhRNAF7C2hE4ArgMz3c2Emu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hXiy4NYeBjIZbj4QxaiuRow4aPwpWvsB
	SvwTXzco/erUFFH9ruJagL2o9P5rE5sFq+iScoo7ZI3k4nNASlFQ2NIX7uWdeYzi
	n0LEooRzeZpRrQwk+oDdIUUEStKR0G/tklCLZ+WSMlVPXFY7PEzNOrwvdT/LQH5g
	YoN4a/AoIWw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB68D22218;
	Fri,  3 Jun 2016 19:40:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33C2322217;
	Fri,  3 Jun 2016 19:40:05 -0400 (EDT)
In-Reply-To: <5751FCBF.3070507@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 3 Jun 2016 23:55:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7FAF7628-29E4-11E6-B752-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296429>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 06/03/2016 11:33 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> This patch series applies on top of mh/split-under-lock. It can also
>>> be obtained from my GitHub repo [2] as branch "ref-iterators".
>> 
>> Ah, that reminds me.  What's the doneness of the dependent topic?
>
> If you mean the vtable implementation, check your inbox :-) I already
> submitted it (38 patches, but most of them are straightforward). I've
> been iterating on that patch series for quite a while so I'm pretty
> confident that it's solid.

What I meant was the doneness of mh/split-under-lock actually.

>> The patches in this series looked all good to me.
>
> Thanks for the review (and your patience), both David and Junio!

Will take a look at the updated vtable series. Thanks.
