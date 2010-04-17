From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ghost refs
Date: Sat, 17 Apr 2010 09:32:36 -0700
Message-ID: <7v8w8m3uqj.fsf@alter.siamese.dyndns.org>
References: <20100407210010.GB27012@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com>
 <k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com>
 <k2x32541b131004071511i9bbe883az504547d6133aef@mail.gmail.com>
 <20100408043059.GA28768@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A075390@FL01EXMB01.trad.tradestation.com>
 <7vwrwh6fz8.fsf@alter.siamese.dyndns.org>
 <20100408194908.GB4222@sigill.intra.peff.net>
 <7vbpdt65ie.fsf@alter.siamese.dyndns.org>
 <20100417115111.GB28623@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 17 18:33:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3AxB-0000QN-FF
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 18:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030Ab0DQQcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 12:32:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab0DQQcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 12:32:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8E63AAB90;
	Sat, 17 Apr 2010 12:32:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KvF08ldr8JFU6EELls5REL9+Evo=; b=xKkv7e
	4kQ5dWdv9QedgjHHzjX6UFIhsE1qYzigtL2M0f3zicMqPCfL335E2do51TynnpIP
	5uK0sdRn0ytCr+Z3R6UXwbiSsIhwaniAw5QVkXdJGX34KddTab/ynY0OI2LuEuyx
	d14wUZTqa/ZNWtK/yv0C4erKxygSE/zKNsoxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jJrxJNphTiZvSN5tYOCx/nLmll2UYxOl
	VYlJ8aWcglzu7l2F/GYrG1eX6LQOs3ySTZHSX+ilyNP8jqgTiRV9Mkj5ymn/qnUl
	9TP4xy7+voKky4jT5N3KNHhLis4lhNAwhEvNwE+FOsgna4SQSlkNkyMs2ePdQjfe
	G4twSUHeAbY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44708AAB8A;
	Sat, 17 Apr 2010 12:32:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34FA2AAB88; Sat, 17 Apr
 2010 12:32:39 -0400 (EDT)
In-Reply-To: <20100417115111.GB28623@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 17 Apr 2010 07\:51\:11 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D989531C-4A3E-11DF-80EC-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145153>

Jeff King <peff@peff.net> writes:

> I would also like to have consensus on this, too. But it seems like it
> gets bikeshedded to death every time it comes up.  But hey, why not try
> it one more time? :)
>
>> I'll list my preference off the top of my head as a firestarter.
>> 
>> NAME::
>> 
>> The name followed by what it is used for
>
> Yep, makes sense.
>
>> SYNOPSIS::
> ...
> As another example, for git-branch, I would suggest:
>
>   git branch [<options>]
>   git branch [<options>] <branchname> <start-point>
>   git branch -m [<oldbranch>] <newbranch>
>   git branch -d [<options>] <branchname>
>
> From that I can quickly see that there are four major modes: listing,
> creating a new branch, moving a branch, and deleting a branch. I would
> also be happy if each mode was explicitly described. Some of my favorite
> synopses are those of perl modules, which tend to give you a very short
> and readable code snippet of how you might use the module, along with
> comments showing anything non-obvious.

Yes, that makes a lot more sense than "list every possible option".

>> Detailed discussion of concepts::
>> 
>> Some manual pages need to have discussion of basic concepts that would not
>> be a good fit for the DESCRIPTION section (e.g. "Detached HEAD" section in
>> "checkout" manual).  I am not sure if this kind of material is better
>> given in OPTIONS section close to the functional group (e.g. "History
>> Siimplification" heading in "log" manual).
>
> I would really prefer most of this material to be pushed out into its
> own manual pages, and referred to by name (e.g., say "see
> githistory(7) for a discussion of history simplification" or "history
> is simplified as described in githistory(7)").
>
> Here's my reasoning.  [jc: good summary of possible solutions skipped] 
> ...
>   3. factor it into githistory(7), and reference it by name
>
>      Obviously this is my favorite. :) It does have one downside,
>      though. If we convert pretty-formats.txt into gitpretty(7), then
>      searching for "oneline" in git-log may not turn up what you want.
>      I wonder if we can summarize with something like:
>
>        --format=:
>        --pretty=<oneline|full|raw>:
>        --oneline:
>          Format the output. See gitpretty(7).
>
>     in git-log(1).

I like the suggested outcome.

One way of doing this is to strip the description from pretty-format.txt
and move the description to gitpretty.txt (and anything that supports
pretty format will continue to include pretty-format.txt).

But we will need to list _all_ the options twice if we go this route;
pretty-format.txt for the heading, and the descriptions in gitpretty.txt.
Perhaps pretty-format.txt can be autogenerated from gitpretty.txt to keep
them in sync.

> You didn't mention configuration variables.

Yeah, I forgot.

> git-config (or perhaps even gitconfig(7)) should have a list of all
> variables and where they are described, like:
>
>   apply.ignorewhitespace        git-apply(1)
>   apply.whitespace              git-apply(1)
>   branch.autosetupmerge         git-branch(1)
>   [etc]
>
> There is not much point in having full descriptions in one giant list.
> Instead, you can peruse the whole list, and then go to the configuration
> section of the relevant manpage to see a bunch of related options. Such
> a list should be pretty easy to generate automatically from the other
> documentation.

Yes, I like it.
