From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default documented in "man git-push"?
Date: Mon, 08 Oct 2012 10:12:02 -0700
Message-ID: <7v8vbgnb19.fsf@alter.siamese.dyndns.org>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
 <7v7gr75s40.fsf@alter.siamese.dyndns.org>
 <20121003214051.GD4484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 08 19:12:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLGsa-00051s-De
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 19:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274Ab2JHRMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 13:12:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754169Ab2JHRMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 13:12:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD5089FAB;
	Mon,  8 Oct 2012 13:12:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m1nhtwsPLr2jmuAu7LWfe2YGdRY=; b=TZZhGB
	r5Mlt/dxt+EsiLYGPEr2vyl7acPt6VgJd6SrpdZrZhNd/Iz+sgh9RqMN9BiSuz17
	7y33v2wu2F1gUToqu7mDLanNNsunSwZ2oMD9HjhJeQ4JQL7qw2FfIs1GBVbSoKWd
	j9I3itbj7+5ULXtdC5kYVhaKILfkvYBrpi8TU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ixYC35pDaHVHaUbrfm0LsaC2yi+Snlhg
	9woSgSUkPHVpuxbsTw4HEph/DF7uCH1ASBkn17JeyoqWIaJCw0JdZJsN9BlaSnLo
	aE4Sopj5qTq5E29rkGqIguT+MFfCNK4aRBXXiqNTVi/U8YnePR9Cp74OgLq4BO/4
	8YXWT/DkSZg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A97B09FAA;
	Mon,  8 Oct 2012 13:12:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC02D9FA8; Mon,  8 Oct 2012
 13:12:04 -0400 (EDT)
In-Reply-To: <20121003214051.GD4484@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 3 Oct 2012 17:40:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 487B4FA0-116B-11E2-850E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207243>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 03, 2012 at 11:26:55AM -0700, Junio C Hamano wrote:
>
>> Please do not label the list as "These variables affect this
>> command" to give a false impression that it is the complete list if
>> it isn't.
>> 
>> Unless somebody promises to keep an up-to-date complete list there
>> (or even better, come up with a mechanism to help us keep that
>> promise automatically, perhaps by annotating pieces with structured
>> comments in config.txt and automatically appending such a section to
>> manual pages of relevant commands), that is.
>>
>> With a weaker phrase, e.g. "These configuration variables may be of
>> interest", such a list may not hurt readers, but personally I do not
>> think it adds much value to have a list of variables without even a
>> single line description of what each is used for.
>
> We talked a while ago about actually moving the config options into the
> individual manpages, and generating config.txt to simply contain an
> index of keys and where their definitions may be found. That also has
> the "list without description" characteristic. But presumably you would
> be looking for keys in the manual of the command you want to affect, and
> the master list would mostly be for redirecting you to the right
> manpage.

That cuts both ways for configuration variables that affects or are
affected by multiple commands, and that would range from the trivial
example of configuration variables for fetch and merge that appear
to take effect in "git pull" from the end users' perspective, to the
more complex ones like remotes.*.merge and remotes.*.url that are
set to make the @{upstream} notation work.

> It does break down a little when you have keys that could go in multiple
> pages. In many cases, this can be solved by a canonical location that
> describes the shared concepts. For example, `diff.*` should probably go
> into a `gitdiff(7)` that talks about the various diff options and
> formats.
>
> Of course, that only works if you think pulling out the shared diff bits
> from git-diff*, git-log, etc into a separate manpage is a good idea. I
> do, because I think it makes it more clear to the reader how the
> concepts connect (as opposed to simply including shared bits inline in
> the manpages, as we do now, with no indication that the same content is
> going to apply in many places). But it does have a downside that
> individual manpages are not as easily searchable via the pager, as you
> may have to follow a cross-reference to find what you want.

I suspect that approach would make individual manual pages less
approacheable by new people, as they will have more required
reading.

git(1) currently guides people to user manual, and then points at
individual pages, assuming that these shared concepts (e.g. the one
for "diff" you discuss in the above paragraph) are fully mastered
once the user manual is read.  Perhaps we would need to replace it
with a "concepts" manual, or enhance it with more "concepts"
material?
