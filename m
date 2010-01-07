From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #02 draft; Wed, 06)
Date: Wed, 06 Jan 2010 19:43:57 -0800
Message-ID: <7vvdfeeg02.fsf@alter.siamese.dyndns.org>
References: <7vvdfenaar.fsf@alter.siamese.dyndns.org>
 <20100107122334.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 04:44:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSjIC-0005dF-RU
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 04:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727Ab0AGDoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 22:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756603Ab0AGDoH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 22:44:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227Ab0AGDoE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 22:44:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 578458E2C1;
	Wed,  6 Jan 2010 22:44:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sVHDYQnpn1u+s2X47eurFKKrUuo=; b=AY9qX4
	mboHTW/9eRXcnxvwX/z9NwSQGGECTwDrj1tonKVWjNYt70Ivcdi4sLHrDMYqbaeA
	6Iu3Y4iVM76IVa4gIhn9KeAXDJ9XxZYnw+EyT0tlYE+9cg0NZQaXcoIe/TfLqJty
	FOEs64uQ8yRiuf+PEP9Hl1JKE0fas2YH7G8AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gVAV7f8+o8B+i1ptpechyKki83Nb+VLC
	gfy/cCcDZdED1hHiG1+K/8Xtu+dLkBlvYyq36RlEvbeqY9lDWtNRgtInQz+0zXIs
	mKjtCVWeBC9Ezp2SXKcLpIy0e0Jl0mNA4wvXjR7n6hbiVQ4RiiOOaTt8M+FbJ1Rc
	RGiyvHe/XUc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32E758E2BF;
	Wed,  6 Jan 2010 22:44:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B4C18E2B8; Wed,  6 Jan
 2010 22:43:58 -0500 (EST)
In-Reply-To: <20100107122334.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu\, 07 Jan 2010 12\:23\:34 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E4BAF1CC-FB3E-11DE-8E2E-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136321>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> I am experimenting with ideas to better manage the periodic "What's
>> cooking" messages, and here is one of such attempt based on the current
>> draft of the upcoming "2010 Jan, issue #02".
>> ...
>> Moved from [New Topics] to [Cooking]
>>
>>  * da/difftool (2009-12-22) 2 commits
>> - - git-difftool: Add '--gui' for selecting a GUI tool
>> - - t7800-difftool: Set a bogus tool for use by tests
>> +  (merged to 'next' on 2010-01-06 at e957395)
>> + + git-difftool: Add '--gui' for selecting a GUI tool
>> + + t7800-difftool: Set a bogus tool for use by tests
>>
>>  * jh/gitweb-cached (2010-01-03) 4 commits
>>   - gitweb: Makefile improvements
>>   - gitweb: Optionally add "git" links in project list page
>>   - gitweb: Add option to force version match
>>   - gitweb: Load checking
>> +
>> +Will merge to 'next', unless I hear objections within a few days.
>
> For what it's worth, I think this new format very easy to spot the
> differences and much nicer.

This is _not_ a "new format" per-se, but is primarily a demonstration of
the external diff feature (all in 'todo' branch).

While I think it is easier to view when I am interested in the differences
since the previous issue (and that was why I wrote it) than the full list,
its "incremental" nature cuts both ways.

The primary reason I send out "What's cooking" is to make sure people are
aware of topics that are _not_ going forward, to encourage them to be
involved by helping such topics.  When some topics are moved from Cooking
to Stalled category, they will show up in the incremental report, but
after that, until they start moving again, they won't be shown in the
incremental report.  That defeats the whole point of sending the "What's
cooking" messages.

Topics that are in motion are watched actively by testers, developers and
documenters.  They don't need as much exposure as stalled ones.
