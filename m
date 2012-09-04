From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Tue, 04 Sep 2012 13:44:17 -0700
Message-ID: <7vobll8qn2.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CACsJy8C36eghwEOYqbnd2z5C5KnynWsvwMDa4e2hns3uW243EQ@mail.gmail.com>
 <CAB9Jk9CNYr6LfWvyVqXvHjh7dzhUAuzkufqO9YMeOXg08D2cJw@mail.gmail.com>
 <CACsJy8AUYigHVKjzE-0NT0hnOrQWdufN+COmkk=2Q8L1Rimytw@mail.gmail.com>
 <CAB9Jk9D0DHBJEpVq=Z=12TV=+Av0oFVZ0yO1svLh1wyuP+9r1Q@mail.gmail.com>
 <7v4nndd98g.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9DVcG14mS3HaGE4JEY0AwExvjqrnQqzTEZxHLjEQ6UObg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 22:44:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8zz4-0006x1-Ax
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 22:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444Ab2IDUoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 16:44:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33825 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab2IDUoW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 16:44:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80B389990;
	Tue,  4 Sep 2012 16:44:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PswFZX5uP7UXVusHnjVna1JFs+M=; b=QpCbZl
	UI2nS+GPtgIg8gwWsW+O4MPHm6mHFxZX1wzgjFFEpTHj1RS9Jgin+qPjycf0o1XJ
	M0q6hir6rjdaYdyZm0BAfr5kGBFZu+700LpzngYsap3uJSS9QmIZrmz4vcEc2j4J
	7TFiX39xUEBKEoU427CEMPWtZ5Y1hPZD2Wxzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a9WWw/pLpsjjqmGrb50jTfN+aI/gCyqP
	2Fs43/LfZww8Ta0GLJsLFAWK8TbAV9d8jWcr/bui7rMt34zHW7Z11XqWFu53msWn
	ztV7dBcDSIXlNB6iOacmZd8FwQnzBBOQbZ684f5+GEf3YWy+EzZAZe93pyJ66bUm
	f4tjO6zsPUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DC2D998F;
	Tue,  4 Sep 2012 16:44:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7893998E; Tue,  4 Sep 2012
 16:44:18 -0400 (EDT)
In-Reply-To: <CAB9Jk9DVcG14mS3HaGE4JEY0AwExvjqrnQqzTEZxHLjEQ6UObg@mail.gmail.com> (Angelo
 Borsotti's message of "Tue, 4 Sep 2012 21:29:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C673B24-F6D1-11E1-B2B7-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204784>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> The issue here is that the paths must denote filenames that are
> present in the index
> or tree-ish, so, wildcards are misleading since they would instead be
> interpreted
> with respect to the working directory.

When you are talking to a shell (and you almost never directly talk
to Git), wildcards are always interpreted with respect to the
working directory by the shell.  And that is not specific to Git.

> A possible way to make this clear is to warn the user to quote paths
> that contain
> wildcards. Something like, e.g.:
>
>   "Note that <paths> that contain wildcards must be quoted in order to
> denote files that
>    belong to the index or <tree-ish>. Otherwise, they are interpreted
> by the shell with
>    respect to the current directory, with a result that may depend on
> the shell."

Perhaps, if you drop ", with a result..." from that sentence.

Even though that description is a bit too much on the side of "shell
primer" than "git documentation" for my taste, I could see it may
help some people, so I wouldn't reject such a phrasing out of hand.

Let's see what others feel.
