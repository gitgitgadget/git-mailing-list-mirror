From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Itches with the current rev spec
Date: Mon, 29 Apr 2013 09:05:25 -0700
Message-ID: <7vobcxl3ui.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
	<20130426101946.433f2d12@chalon.bertin.fr>
	<517A3E47.6010606@viscovery.net>
	<7v7gjpxjw0.fsf@alter.siamese.dyndns.org>
	<CAMP44s0-C_TRC_eD_ZbN3WFe4NKWVPQVhh+ME-F5yBBwKs2NdA@mail.gmail.com>
	<7v8v45vvuy.fsf@alter.siamese.dyndns.org>
	<CALkWK0=W_FxDwc3Tby=h90yc5i8UEuT7maERahFRDQU=hQ633g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yann Dirson <dirson@bertin.fr>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 18:05:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWqa5-0007VP-HE
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 18:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757250Ab3D2QF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 12:05:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43716 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756863Ab3D2QF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 12:05:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3755C1A9A6;
	Mon, 29 Apr 2013 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rdEpW8fDf7v1OUgvSGitJXwrMdA=; b=bNntTr
	v2USTGMvebv+602nD/j5wJ5gYBDYPij0NqbAV5418o//iUlpyME5xymY1bRnGzaF
	xe3/jDTCqDgpGyuUD7Y0QRDxMmbrlLXaCfUCQiGsM2Vag6NF2TbVkOmd6FeC3PiR
	28esMb3z/o1X3WFNd+OtdDRIWaN19sb+atDW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T/35ufgdqw6gty5Swacvq/NlaxLlyoOn
	O3jWy1hFMt9AmnoxLFaDOZ2T/umTGWfDMk/qqQulanxnUH0cUHKiHoo0cb+47AMd
	DE1+cw1HesrE/bwysIcLACFvub/UfhkAhWA9LaSGwH6RwoqHLLLUHKk+dklmolW9
	xWdHwiXRuDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D3AD1A9A5;
	Mon, 29 Apr 2013 16:05:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 764C21A9A3;
	Mon, 29 Apr 2013 16:05:26 +0000 (UTC)
In-Reply-To: <CALkWK0=W_FxDwc3Tby=h90yc5i8UEuT7maERahFRDQU=hQ633g@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 29 Apr 2013 20:38:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B1B43C6-B0E6-11E2-ABB7-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222804>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>  - If the UI language for "rebase" were designed following the
>>    "composition using common elements like ranges and revisions"
>>    school, it would have started from "rebase --onto=X A..B".
>
> I think you're looking at the whole issue backwards from the way I
> look at it.

I am not "looking at" anything.  I was giving the historical
background to explain how the current UI language came to be, but
that was not to argue for keeping it to be the way it is, or even to
justify that it is the right UI.

> Let's try to lay out some fundamental principles and

Very interesting.

> 3. "Range" is not an inherent property of A..B or A...B.  There are no
> "revision ranges".
>
> 4. Every command is free to interpret positive and negative commits as
> it sees fit.  Since there is no ordering, it must never treat one
> negative commit differently from another negative commit, or one
> positive commit differently from another positive commit.

That world view is broken, isn't it?  Perhaps you forgot to consider
symmetric differences, where left positives and right positives have
to be treated differently.  "diff A B" and "diff B A" mean very
different things, for that matter.  A line of thought that begins
with "there is no ordering" may be a "brave proposal", perhaps, but
it is not "fundamental principles".

If you do not like the word "range", read it as a DAG.

"rebase requires three: onto, list and a ref" (by the way, it is not
refspec, which has a specific meaning) is trapped by the limitation
of its current UI language that came from the "workflow" school and
missing what the operation really means.

rebase takes a DAG with one negative commit, and replays it to form
an isomorphic DAG on top of another commit.  At the essential level,
it takes two pieces of information, such a DAG and an "onto" commit.

But in the current UI, the way to specify these two things are by
giving three commits, i.e. --onto=ONTO ONE_NEGATIVE ONE_POSITIVE.
The positive is used to specify which ref to update.

It is not far-fetched to allow rebase to handle a history with two
branches A and B that share the common initial part (i.e. ^X A B)
and replay that history on top of an unrelated point in history Y to
transform:

             o---o---Y
            /
    ---o---X---C---C---A---A---A (tip of branch A)
                    \
                     B---B---B (tip of branch B)

into

             o---o---Y---C'--C'--A'--A'--A' (updated tip of branch A)
            /         \
    ---o---X           B'--B'--B' (updated tip of branch B)

But the "rebase one branch on a new base" UI that came from the
"workflow" school is unable to express such an operation.  The
pieces of information we are using in the above are:

 * Where the bottom of the DAG being replayed is (i.e. X);
 * What refs are the top of the DAG (i.e. A and B);
 * Where the new bottom of the replayed DAG (i.e. Y).

So if we are refining the rebase UI, while making sure we can later
extend it, we shouldn't start from "onto, list and a ref".  We
should start from "a single onto, a single bottom, and one or more
refs that define tops".

> constraint remains: rebase _cannot_ make this --onto= parameter part
> of the normal rev spec

So what?  Why do you even _need_ to mix up all positive revisions,
some of which mean different things from others, into a single bag,
only to later differenciate some as special (i.e. used as the onto
commit) from the others (i.e. the tips in the DAG)?  If something is
special, you can say not just it is special and can say what it
means by saying "this is where I want to replay the DAG on top".

A much larger issue is that the current setup_revisions()
infrastructure does not let us express an operation that involves
two or more DAGs.  People sometimes wish to say an equivalent of

    git show $(git rev-list A..B) $(git rev-list C..D)

but obviously

    git show A..B C..D

is not the way to say it, and this limitation comes from it.
