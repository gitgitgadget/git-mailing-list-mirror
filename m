From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 22:59:08 -0700
Message-ID: <7vppxj6thv.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<7va9ong9oa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
	<7v38ufer2x.fsf@alter.siamese.dyndns.org>
	<CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
	<7vvc7baahc.fsf@alter.siamese.dyndns.org>
	<CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
	<CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 07:59:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVFDB-0000Bc-8b
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 07:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002Ab3DYF7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 01:59:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab3DYF7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 01:59:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9195149AC;
	Thu, 25 Apr 2013 05:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xRFWZfD8LwlOZlPbwRr1uYVjTHw=; b=FUDpJT
	+CFUyf/TzT4dickdQVCyWQMxMefV59neJPDcwb4PHph4pWMnEQYqmRDHWgknziyP
	gy1WbWOVNDaXl8xt+v0Q9GFgGoaVW7eNeRFG8h4sy80Qj8T0FOMWwA7I/Q8dlGpR
	C7W2sE17cW+A1NTIjvQGlRFnZpLsI1v4EMHhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ofi7u/9Yanwq/PAhhnD9vrJP8N+IgJWg
	hGFhWTtUjfuCUEGdGiK8DTp0F0UP0LtMzHk/MAcVtC8Njp9NCcZXcrMiHLQIrNZN
	pIY3lIYdPXDAR1xISF1gXelXN1FZhditlSjUfsuqTudY6+NfTNns1OE9Oe1Co+Wj
	QItic2lGw0A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBB13149AB;
	Thu, 25 Apr 2013 05:59:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17395149A7;
	Thu, 25 Apr 2013 05:59:09 +0000 (UTC)
In-Reply-To: <CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 25 Apr 2013 04:47:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F638E84-AD6D-11E2-A36D-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222347>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>> Ofcourse, I now see that this is probably useless, and .. fits my bill.
>
> Would you find it potentially useful?

I dunno.  The description you gave was insufficient for me to answer
that question.

The part of your message that outlines the scenario you thought A~B
might help you was read by me like the following.

    >  pu is based on master~10.  rebase.autostash is based on
    >  master~5 and master~3 merges in pu.

    So which one is 'pu' based on?  master~10, or master~3?  You cannot
    have both.

    >  I merge pu into rebase.autostash while working.  

    So from pu the top two commit on 'master' are missing, but your
    branch was forked way before that from 'master', so these two do not
    concern you.

    >  Now, master..rebase.autostash will exclude commits reachable
    >  from master (and therefore pu),

    Whoa. Earlier you said 'pu' is based on master~10, but changed your
    mind to say master~3 is in 'pu', and now you mean the tip of
    'master' is also in 'pu'?  What is going on?

Can you draw a picture to illustrate the topology you are trying to
describe, like I did in a few message upthread?  E.g.

        ---o---*---a---a---a---a---A (master)
                \       \
                 b---Y---X---B (topic)
                    / 

shows a topic B that forked from master and merged from irrelevant
branch at Y and merged from master at X [*1*].

In the above sample topology, even if you pulled irrelevant (for the
purpose of completing your topic) commits at X from 'master',
neither "log A..B" or "log $(merge-base A B)..B" (aka "log A~B")
would exclude any of your commit that is not yet in the 'master', so
I do not think there is anything you gain by using A~B over A..B.

If you pulled something unrelated to your topic that is not in
'master', both "log A..B" and "log A~B" would show these unrelated
changes, so again I do not see how A~B would help you over A..B,
either.

Perhaps in a particular topology you have in mind, it might make a
difference, but I cannot read what that topology is from your
description.

[Footnote]

*1* I do not think this particular topology is what you have in
    mind. It is meant to demonstrate one way to illustrate the
    history to help other people understand the example you are
    trying to give.
