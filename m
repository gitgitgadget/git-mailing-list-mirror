From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Wed, 15 Aug 2012 12:22:28 -0700
Message-ID: <7va9xw55aj.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch>
 <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
 <7v628lbdcw.fsf@alter.siamese.dyndns.org>
 <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
 <87lihh8c7s.fsf@thomas.inf.ethz.ch> <7vr4r98ah5.fsf@alter.siamese.dyndns.org>
 <87sjbo63pl.fsf@thomas.inf.ethz.ch> <7vfw7o6p1g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 15 21:22:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1jAu-0001wP-4k
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 21:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab2HOTWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 15:22:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753390Ab2HOTWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 15:22:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AAC98826;
	Wed, 15 Aug 2012 15:22:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9iaOKyG7XhlwWpZ6wulDtDfBCHg=; b=aqhUMo
	MVCS6wJVp/Z1KZQCDFW3ky3MhNfHlaTrU3Nc+fO82Nd4ipQ6cEEl0NDzfu4fn8Fv
	pOUlcVHpvhlPHco2hxQ+mAgmuluQguvrqSOLYN05J3uezxP4/KKeoDwKjHjDAOdB
	b4lGefWBZ4q9wlfQRPlLXxrOx4iNoLvVSyXns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EUzEQh0hIVPzsyFnwyI/30ZbpM66KP9P
	7xoGE+h2LczvC1yQ9F6qZp4uS1XrlU0HHFHByiN8IBEKeKa8ZTrD/roEwMjjj/qu
	0XlLqI8OWGcM7E7hhncX46Bikb1PB5WA3OwdFCztaBx+xFPLK0oEyPdkpIsJrwnS
	1DDKGHjk/EY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07C938825;
	Wed, 15 Aug 2012 15:22:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58C138821; Wed, 15 Aug 2012
 15:22:31 -0400 (EDT)
In-Reply-To: <7vfw7o6p1g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 15 Aug 2012 10:30:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F1259A4-E70E-11E1-8022-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Updating Documentation/pull-fetch-param.txt would be a bear, though.
> The documentation is stale in that it was written in the days back
> when .git/remotes/ was the primary way to configure remotes, and was
> not adjusted to use the termilology used in the [remote "where"]
> section of the .git/config file (notice a mention of "'Pull: '
> lines" there), so it needs cosmetic adjustment anyway, but the
> semantics it spells is still up to date.  The current rule is very
> simple and understandable.  You either say from the command line
> exactly what should happen (refspec without colon is the same as the
> refspec with colon at the end, meaning "do not track"; if you want
> to track, you write what to update with the fetch), or we use the
> configured refspec (which again spells what should happen).
>
> The updated rule would be more complex.  If a remote nickname is
> used, and a refspec given from the command line is without colon, a
> new special rule overrides the current behaviour and tries to match
> with a configured refspec.  You would need to desribe what happens
> in that case.

It would be something like this.

When you tell "git fetch" to fetch one or more refs from a
configured remote by explicitly listing them on the command line,
e.g.

    git fetch <remote> <name>...

each <name>... goes through the following process:

    - The <name> is turned into the full ref at the remote that
      starts from refs/ form by applying the usual fetch dwimmery
      (if <name> is a name of a branch, "refs/heads/<name>" would
      likely to be the one that is fetched).

    - Then, configured fetch refspecs for <remote> is looked up from
      remote.<remote>.fetch configuration variable(s), or "Pull: "
      line(s) of .git/remotes/<remote> file.

    - If the LHS of a refspec found in the previous step matches the
      full ref we computed in the first step, then the ref at the
      RHS of the refspec (i.e. remote tracking branch), if any, is
      updated.

If there is no configured refspecs that match the name given from
the command line, no remote tracking ref is updated.
