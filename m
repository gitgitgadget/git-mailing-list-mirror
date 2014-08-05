From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] doc: format-patch: don't use origin as a branch name
Date: Tue, 05 Aug 2014 11:19:13 -0700
Message-ID: <xmqqlhr2pzoe.fsf@gitster.dls.corp.google.com>
References: <1406994383-5076-1-git-send-email-philipoakley@iee.org>
	<1406994383-5076-2-git-send-email-philipoakley@iee.org>
	<xmqq38dctcmz.fsf@gitster.dls.corp.google.com>
	<F97E9146985F4449A937B9C5CCA1D7F5@PhilipOakley>
	<xmqqa97jrjk2.fsf@gitster.dls.corp.google.com>
	<C4E435A5EF324ABCBCC0930A9EB56141@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "GitList" <git@vger.kernel.org>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 20:19:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEjKd-0006rg-Uu
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 20:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbaHEST0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 14:19:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61465 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755421AbaHESTX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 14:19:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 700532E7DB;
	Tue,  5 Aug 2014 14:19:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrX3+Cg7pE4q37tT7t/4eTZvTnU=; b=Rx7Z2S
	1UVJ1AG2yU0Fq+takHU+WNlE6+Sza0PUKrlKPwJ++mMO7dqFbJLs0Z+KTgJn6XNW
	MCRVQZK87rGGeSvQiFClxtCLNAUjYMOsAP0VSKOqwj4QlIRLhSFLwo+mJV0ADMp6
	G4oGPtnalRIMYxGTWLWqtLz91Ufke0zgd/cKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ugJH/rdJV6vgmu3OLYVPyRmP3rw8xqm9
	Z40ZbA7TD+MQuamFMQEGS34tC/YwYmEvfcecblgXR6R7NWu9+/OxS3oUJWhvSbBX
	lMsep9tCfAfz/J2kQbbgV/i5sOA8OAZwIL4Pl/LeJ1XEURksxMx5dec8JJVxMZuM
	LoeoT7sANJg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6694F2E7DA;
	Tue,  5 Aug 2014 14:19:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 04ABA2E7CD;
	Tue,  5 Aug 2014 14:19:14 -0400 (EDT)
In-Reply-To: <C4E435A5EF324ABCBCC0930A9EB56141@PhilipOakley> (Philip Oakley's
	message of "Tue, 5 Aug 2014 00:19:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 01B402B4-1CCD-11E4-9CCC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254816>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
> ...
>> Nowhere I am assuming that "the reader is creating paches based on
>> wherever someone else had got to".  Sorry, but I have no idea what
>> you are complaining about.
>
> I think we are talking at cross purposes. My starting point is that
> (the examples says that) the reader wants to create a patch series for
> a local branch, relative to their <some name> branch which they
> branched from...

Perhaps what you are missing is that the 'origin' in that example is
not "their" <some name> branch.  It is how we used to spell what we
call 'refs/remotes/origin/HEAD' these days, a copy of their upstream
repository's primary branch.

> (e.g. the example, relative to Git, could have been from
> branched from (e.g. the example, relative to Git, could have been from
> a 'pu' picked up a couple of days earlier, when they'd have said 'git
> format-patch pu' ;-).

Again, if that were a "'pu' picked up a few days earlier, it would
not be 'pu', but be 'origin/pu'".

>> The primary reason why 'origin' in the example should be replaced
>> with 'origin/master' is because that is the literal adjustment from
>> the pre-separate-remote world order to today's world order.
>
> I was trying to avoid a literal adjustment to what I'd perceived as a
> presumed workflow.

These are "examples", showing uses of commands in some hopefully
common scenarios.  I am not exactly sure what you are aiming at, but
if you are trying to strip context and/or background from them and
trying to limit them purely to "If you do X, Y happens", the
resulting description would lack clues that readers rely on in order
to choose the usage pattern of the command that is suitable for
their situation, which I do not think is a good change to make.  The
readers would be helped more with "You are in state A and want to
achieve B. If you do X starting from state A, Y happens, which helps
you achieve B.", and that is what examples are about.

Now, these "where you are and what you want to do" may not be
explicitly spelled out to avoid redundancy, and it may be an
improvement to enhance the scenario without making them too narrow.
But that would be a separate change, and renaming 'origin' (whose
modern equivalent is 'origin/master' in the context of these
examples) to 'master' alone would not do any such enhancement.

>> The
>> local branch 'origin' (more specifically, 'refs/heads/origin') used
>> to be what we used to keep track of 'master' of the upstream, which
>> we use 'refs/remotes/origin/master' these days.
>>
>> Side note: DWIMming origin to remotes/origin/HEAD to
>> remotes/origin/master was invented to keep supporting this
>> "'origin' keeps track of the default upstream" convention
>> when we transitioned from the old world order to
>> separate-remote layout.
>>
>> And the reason why 'origin' should not be replaced with 'master' is
>> because your 'master' may already have patches from the topic you
>> are working on, i.e. in your current branch, that the upstream does
>> not yet have.
>
> So this a 'develop on master' view, rather than a 'develop on feature
> branches' approach? Which could explain the misunderstanding.

The new work on the feature branches may be merged in 'master'
without ever intending to push 'master' out.  The development is
still done on the topic branches that are merged to your local
'master', perhaps for testing purposes and most likely to personally
use it before the upstream picks them up.

I suspect your misunderstanding is primarily coming from that you
may have forgotten, or you may be too new to know, that 'origin' in
the example, 'refs/heads/origin', used to be how we tracked the
primary branch of the other side back in the era when these examples
were written, and refs/remotes/origin/master is used for the same
tracking these days.
