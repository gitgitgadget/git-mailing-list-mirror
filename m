From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 13:27:21 -0700
Message-ID: <7v4nrvadzq.fsf@alter.siamese.dyndns.org>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com>
 <201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com>
 <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
 <4FA2D8EA.7030809@palm.com>
 <CAMP44s2w9B0Jvcn44R5_-ptC=x+5=OgGF0n0SkH+t0JjomXsGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rich Pixley <rich.pixley@palm.com>,
	Michael Witten <mfwitten@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 22:27:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQP6A-0006Hr-BZ
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 22:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab2EDU1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 16:27:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58941 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334Ab2EDU1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 16:27:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A99067DD;
	Fri,  4 May 2012 16:27:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T9XlnMMe7Dstb7YVZYSPRNOOmxc=; b=mJwe+e
	qt7JThEPBN9Czu8Z4r3P0aHIftSabduvCnzRL/rqjaPo795QdY7jgqGeAZAKHkcX
	EeJwTbOI+VODRm2YTBEd3ohqStS5KIWzCxg5EU7ihk6ZcB7x5rhV4XeCmmzIG7aQ
	CVYLwoYHdyNqDWkIOeKpBl2jI8RfqAvn5porA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KCmMUfwkY0IUe3cNhuFC88Yws+qOMnME
	4jBY79rYHFchueXDXsc4tK7Fgh2sl508qmT8ruh94JJ/j9FWtgDjd20o7GcCl5rL
	HIIiGKDMl/tJdGAaUep+pecTybpWRVqiYTOoJB883klPcKWbAqy7AHSRP5pGaZJ8
	et7quXwmYyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8131367DC;
	Fri,  4 May 2012 16:27:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AA2F67DB; Fri,  4 May 2012
 16:27:22 -0400 (EDT)
In-Reply-To: <CAMP44s2w9B0Jvcn44R5_-ptC=x+5=OgGF0n0SkH+t0JjomXsGA@mail.gmail.com> (Felipe
 Contreras's message of "Fri, 4 May 2012 22:03:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E259FDE-9627-11E1-A68D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197073>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, May 3, 2012 at 9:13 PM, Rich Pixley <rich.pixley@palm.com> wrote:
> ...
>>  $ # ...do some work...
>>  $ hg push # assume this collides
>
> % git push
>
>>  pushing to $uri_for_cache_repo
>>  searching for changes
>>  abort: push creates new remote head 6d2eb0a6a278!
>>  (you should pull and merge or use push -f to force)
>>  $ hg push -f # the pull and merge case parallels git, so let's use push -f.
>
> This is stupid, why make everybody else's life difficult? Let's merge here.

Doing "hg push -f" _regularly_ is probably stupid, but you need to step
back a bit.  There is a valid situation where you may sometimes want to
publish unmerged work for others to see.

The person who is trying to push here may be quite junior, and may not be
yet familiar with the areas of the project outside what he has worked on.
In his attempt to "pull and then push", he can end up having to resolve a
merge conflict that he is not capable of handling correctly. Regardless of
the VCS used, you would want to give a way to this junior developer to ask
for help "here is my work; while I was working on it, the baseline has
been diverged greatly and I need help either merging it or rebasing it."

In that context, I can see that Hg's split head could be _one_ way to
implement it.  You just push and force split the head at the remote,
leaving others to sort out the resulting mess.

But that is not necessarily the _only_ way to implement it.  A Git user
would probably push his work to either his own public repository, or in an
environment like Rich illustrated, to refs/remotes/junior/need_help_xyzzy
of the central repository of the organization, and ask other people to
help him.  And when he does so, he needs to tell them where they can find
his work, either the url to his own repository (and its branch), or his
branch at the shared place, and that is where the naming of branch becomes
meaningful.  Instead of saying "There is 6d2eb0a6a278 in the repo that I
need somebody to help merging", the request-for-help message can say "I
placed my WIP on junior/need_help_xyzzy branch; please take a look and
help merging it."

Such a "push -f" to split heads (or pushing to need_help branch and ask
others to do the "pull/push" for him) shouldn't be a norm, and if a
project _relies_ on the ability to do so, there probably is a deeper
problem with the project (e.g. perhaps the codebase is not modularized
enough to allow isolated parallel development by junior people on narrow
subparts of it).
