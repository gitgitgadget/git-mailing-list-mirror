From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Wed, 15 Aug 2012 10:30:35 -0700
Message-ID: <7vfw7o6p1g.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch>
 <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
 <7v628lbdcw.fsf@alter.siamese.dyndns.org>
 <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
 <87lihh8c7s.fsf@thomas.inf.ethz.ch> <7vr4r98ah5.fsf@alter.siamese.dyndns.org>
 <87sjbo63pl.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 15 19:31:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1hQp-0005Sn-0G
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 19:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999Ab2HORav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 13:30:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42958 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755960Ab2HORai (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 13:30:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4D4486D6;
	Wed, 15 Aug 2012 13:30:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1ZIsumwDqUHxbxKr9Hql3mT+FjQ=; b=rrrfVo
	ymxLRJezpYq0vIZRyPqq3dUOdnTfuFGPR1/nBg0yzwtMjKdRwaVJPBx2AgNUAnp+
	epf7l746trpo9Sd0WXASbkwXXbcBSicC/di267pfMelFvl/GUau8WpKTJCW/HiTY
	y2NCLdSbblAinHwldnB6HlMjfd0b91hASoNXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kyKBQlT80i5+1lkv44dYRsFUxgAuiRpS
	07DlmbTSJ6tzd1Th1ZYbwmLNHVlb9yTMQsP2HEV9a482lZppwY5+m9RaaQ8sdhMx
	L93klJ4/xrWmIMzgNJrl7J3jJ8dc+apxwQ5M5ceJXR5Y0rcsEMm48RNv55cjZKR8
	0B1RZk8GtcI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFAFE86D5;
	Wed, 15 Aug 2012 13:30:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3128C86D3; Wed, 15 Aug 2012
 13:30:37 -0400 (EDT)
In-Reply-To: <87sjbo63pl.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Wed, 15 Aug 2012 08:59:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED1E62BE-E6FE-11E1-B936-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203475>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> In some sense this is a really bad case of wrong UI design, because we
>>> (this happens on #git a lot) have to teach users not to use the command
>>> so they won't trip over this problem.  It would be better to fix the
>>> real issue instead.  IIRC it was even on the 1.8.0 wishlist...
>>
>> Is it?
>>
>> There already is a way to ask it to update the single tracking
>> branch while fetching; "git fetch origin master" that
>> unconditionally updates refs/remotes/origin/master without a way to
>> tell it not to do so will be a grave usability regression.
>
> Grave?  Do you have any data/use-cases to back that up with?

When I get a pull request from say Eric, I would:

	git fetch git-svn master
        git show-branch remotes/git-svn/master FETCH_HEAD

to see what happened since the last pull request on the other side.
He may have rebased (which is not necessarily a crime), or I may see
more commits in the output than what he lists in the request message
(which may indicate I may have missed an earlier pull request from
him).

Such a sanity check will stop working if the first "fetch" updated
my remotes/git-svn/master.  I would have to enable reflog for
tracking branch and do something like this:

	git show-branch remotes/git-svn/master@{1} remotes/git-svn/master

So I was correct in saying that without an easy escape hatch, such a
change would be a regression.

But I think I (and others) could just train fingers to do

	git fetch git-svn master:

as a workaround.

Updating Documentation/pull-fetch-param.txt would be a bear, though.
The documentation is stale in that it was written in the days back
when .git/remotes/ was the primary way to configure remotes, and was
not adjusted to use the termilology used in the [remote "where"]
section of the .git/config file (notice a mention of "'Pull: '
lines" there), so it needs cosmetic adjustment anyway, but the
semantics it spells is still up to date.  The current rule is very
simple and understandable.  You either say from the command line
exactly what should happen (refspec without colon is the same as the
refspec with colon at the end, meaning "do not track"; if you want
to track, you write what to update with the fetch), or we use the
configured refspec (which again spells what should happen).

The updated rule would be more complex.  If a remote nickname is
used, and a refspec given from the command line is without colon, a
new special rule overrides the current behaviour and tries to match
with a configured refspec.  You would need to desribe what happens
in that case.
