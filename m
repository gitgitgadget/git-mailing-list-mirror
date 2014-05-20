From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RelNotes/2.0.0.txt: Fix several grammar issues, notably a lack of hyphens, double quotes, or articles
Date: Mon, 19 May 2014 21:27:55 -0700
Message-ID: <xmqq8upx2hx0.fsf@gitster.dls.corp.google.com>
References: <1400297434-30254-1-git-send-email-jstjohn@purdue.edu>
	<xmqq1tvpuyas.fsf@gitster.dls.corp.google.com>
	<537AD699.8070503@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jason St. John" <jstjohn@purdue.edu>, git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue May 20 10:00:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmbeq-000775-In
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 06:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbaETE2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 00:28:02 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56594 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbaETE2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 00:28:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21EC213547;
	Tue, 20 May 2014 00:28:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CiP5nqRcscjdui4nndSHwXXdNes=; b=CBWfGq
	N6wuiwQhEUnhcwpOfu7KKc2sgY1UgSZYb1qZTrycrx8ivU/x4cicGwQ2oEGMF7Dl
	OhcjNeIK6tdls5nsApooVZvN2WD/7L6U2gGcCbaIiJ5m+BA2j8AfMc6UfPCLdz6r
	HIB92QhJwysJwRjgRv8rQbqyXiGAFHuWDt9UA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rwsm+zla+ql5S4/4fU1T8/dE5dXuS4rQ
	udX2n4v3+uehsnZzJkDEKde778cFVqcQhW69Tcg1n91AuDZmy6Z9pHxRRPNtrfCK
	SjKtJ9ZkRTG3ss310pZc7fM8PLnrM6r9wrFM7PQdEJxHJxXFbWRyZZ8xBQPYUpam
	Ejjdxirhkwc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 169C713545;
	Tue, 20 May 2014 00:28:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2A95013541;
	Tue, 20 May 2014 00:27:57 -0400 (EDT)
In-Reply-To: <537AD699.8070503@bbn.com> (Richard Hansen's message of "Tue, 20
	May 2014 00:14:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1E608E60-DFD7-11E3-8493-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249641>

Richard Hansen <rhansen@bbn.com> writes:

> On 2014-05-19 19:46, Junio C Hamano wrote:
>> "Jason St. John" <jstjohn@purdue.edu> writes:
>>> @@ -53,7 +53,7 @@ Updates since v1.9 series
>>>  UI, Workflows & Features
>>>  
>>>   * The "multi-mail" post-receive hook (in contrib/) has been updated
>>> -   to a more recent version from the upstream.
>>> +   to a more recent version from upstream.
>> 
>> Hmph, I have only one multi-mail upstream; shouldn't I call it "the"
>> upstream from my point of view?
>
> Plain "upstream" (without "the") is correct because it's an adverb, not
> a noun.  (Alternatively, this could be written "from the upstream
> repository" or "from the upstream project".)

OK; I was trying to use "upstream" as a noun.

>
>>> @@ -217,7 +218,7 @@ notes for details).
>>>   * "git diff --no-index -Mq a b" fell into an infinite loop.
>>>     (merge ad1c3fb jc/fix-diff-no-index-diff-opt-parse later to maint).
>>>  
>>> - * "git fetch --prune", when the right-hand-side of multiple fetch
>>> + * "git fetch --prune", when the right-hand side of multiple fetch
>>>     refspecs overlap (e.g. storing "refs/heads/*" to
>> 
>> Hmph, I read this as a "right-hand", a multi-word adjective, is used
>> to describe one "side" (the other side being the "left-hand side").
>> Otherwise, you would be writing command-line-option, no?
>
> Are you reading the diff backwards?  (The second hyphen is being
> removed, not added.)

Yes.  Thanks.
