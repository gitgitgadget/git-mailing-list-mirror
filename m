From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update git-multimail to version 1.0.2
Date: Tue, 28 Apr 2015 00:20:02 -0700
Message-ID: <xmqqfv7kvhwd.fsf@gitster.dls.corp.google.com>
References: <1430133445-21488-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq618hxxya.fsf@gitster.dls.corp.google.com>
	<vpq383ltoxi.fsf@anie.imag.fr>
	<xmqqoam9whs0.fsf@gitster.dls.corp.google.com>
	<vpqh9s1s9by.fsf@anie.imag.fr>
	<xmqqk2wxwgv1.fsf@gitster.dls.corp.google.com>
	<vpq618hqu5d.fsf@anie.imag.fr>
	<xmqqfv7lwfvx.fsf@gitster.dls.corp.google.com>
	<553E9671.3000902@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 28 09:20:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmzoT-0003QS-GP
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 09:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbbD1HUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 03:20:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752077AbbD1HUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 03:20:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EEB5E44470;
	Tue, 28 Apr 2015 03:20:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AGSdzaV08CX0N7jjRZUgu5JLnHQ=; b=qXSgxj
	i0Nu9sG7ewt6hpYT6LgItwsVyjfwV3YaQgljZCJROWEvcTzmFFc6qb82GJR3u065
	vRbtXNiovlyWQql0rXCNSSMNqTPqcuasCbX2vJkiukL7jGu4ZhjoTZkH08FIq6pv
	qOagq5JDJsXef5OwAX/8mjFVXO4+v4rgjGv2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lQcepKGt9hl3xg49C3Gaa6WGu+Aao6IU
	A8g09Pc4zHkfqfcMavwghzYJdhq3BdlJfsPW3h8sqPC8rocWy9PPjBgrkGz+NG/x
	AgWfiyroWPqph4BusVqVjDkPA7Im5dHQJSlBAO91qJaCMEWKaKNh+hBnzyORo6nF
	gEwQWU1Kv9k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E65684446D;
	Tue, 28 Apr 2015 03:20:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60FCE44465;
	Tue, 28 Apr 2015 03:20:04 -0400 (EDT)
In-Reply-To: <553E9671.3000902@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 27 Apr 2015 22:05:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FD925A3E-ED76-11E4-8638-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267907>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/27/2015 09:05 PM, Junio C Hamano wrote:
> ...
>> Hmm, that may be technically correct but it is grossly misleading to
>> update the existing "was obtained on 2014-04-07" to "was obtained on
>> 2015-04-27", especially if nothing was actually obtained, isn't it?
> ...
> It's true that only documentation changes are in the patch, but it still
> seemed like good practice to create a tag and all that. If nothing else,
> it will make it easier to figure out the baseline for future code drops.

Oh, there is no question about that ;-)

> There have been a couple of small software changes in git-multimail's
> master branch, but I didn't include those in the patch I submitted to
> you because I thought you wouldn't want to have code changes so close to
> the release. So 1.0.2 is on the newly-created "maint" branch.

OK.

>> I honestly am surprised that, after seeing the announcement about "a
>> new repository, co-maintainer and multiple contributors", no code
>> change is made over the past 12 months.
>
> I totally understand your disappointment. Mea culpa.

I am not *disappointed* at all.  No recent changes do not
automatically mean abandoned software---it may be a sign of
stability.  I was just *surprised*.

After all, 1.0.2 tag will hopefully soon become stale, and people
have to go to the upstream to see what the latest version is called
anyway, instead of looking at my tree.  So the primary value of
having a copy in my tree is (1) to have the URL for the true
upstream and (2) to have a working version that is not too stale.
So from that point of view, a patch without the update to the
version numbers or datestamps, i.e. just changes the URLs and
updates who to contact, would have been more truthful, unless it
also updated the code.

It was just that the update changed "the last obtained date" without
changing anything of substance that was "obtained" (because there
wasn't anything new to be obtained) and that looked unexpected and
surprised me.  That's all.
