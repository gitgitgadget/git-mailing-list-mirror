From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Thu, 17 Oct 2013 12:51:13 -0700
Message-ID: <xmqqppr3znf1.fsf@gitster.dls.corp.google.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<20130924045325.GD2766@sigill.intra.peff.net>
	<xmqqy55ub1ud.fsf@gitster.dls.corp.google.com>
	<525e0b6e25aeb_81a151de7495@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 21:51:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWtbN-0001Zn-U0
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 21:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762493Ab3JQTvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 15:51:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50592 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759409Ab3JQTvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 15:51:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4858A4AE8D;
	Thu, 17 Oct 2013 19:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=qUwHYc/FUv1EMADP/qPxgs8F5J8=; b=MR8IIAny0Is82ZVjpxoG
	4Xu/pGUKCr9vUPhsZXB0+H4Z+wuK8PcBXpMNWaZ09EMm7pvyofFBzRc9S1QTkdcY
	hKBKp/GYjiF/yQsA2ru9vzJYtW+pPjF+DxKlSwo+RkJGNRpZ0/yvuhQ+TVNKReb+
	o1ffBVMPP0h5NdoWgfU75DE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Vek4tFa2nFCtBCyO0ezQR79jzyhXoS4SfeMQMG802609rC
	UeMlZI3/6B+I9w9xy8HJeOjxe9yL3Zj5aTTHpk1UakhnnuML9u2LW6yz0h/1sHkC
	zxzbapxtLQGNk7BcP7wRS5rQGAusXMW1hIpGpEKVLF0MJoiKmT6ePdOcQZSuw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AC974AE8C;
	Thu, 17 Oct 2013 19:51:16 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 937A44AE89;
	Thu, 17 Oct 2013 19:51:15 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7B99BD2E-3765-11E3-B4EB-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236311>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > It seems[1] that some
>> > people define "ci" as "commit -a", and some people define "st" as
>> > "status -s" or even "status -sb".
>> 
>> These option variants aside.
>> 
>> Just like thinking that committing must be the same as publishing,
>> it is a cvs/svn induced braindamage to think that "checking in" must
>> be the same as "committing".  The former is a sign of not
>> understanding the "distributed", the latter "the index".
>> 
>> In a world with both check-in and commit as two words usable to
>> denote possibly different concepts, it may make sense to say "you
>> check-in the current status of the working tree files into the
>> index, in order to make commits out of it later".
>
> Yet a wide amount of users do use 'ci' to mean 'commit', so basically they are
> just wrong. So you are saying they are just ignorant.

I am sick of seeing my word twisted, especially when they were not
even addressed to you (see the message's primary recipients list).
Those who want to type "git ci" due to their familiarity with "svn
ci" are not wrong; they can do so if they choose.

Let's try again (see below).

> Now, if you are commenting on the aliases, that would mean you are not against
> the idea of aliaes per se, but more about values of those aliases. So if we
> agreed on the right values, you would welcome this patch.
>
> Is that correct?

No.

I agree with the issue the message I was replying to raised. The
alias mechanism is a way to help users to define their own
convenient short-cut. If you want to say "git ci" to mean "git
commit" (and not "git commit -a" or something else), define it for
your own use, and stop there, without getting in the way of other
people. That is why I see an attempt to add hard-coded set of
aliases as a move in the wrong direction.

A set of hard-coded alias that _officially_ declares that "checkin"
is an equivalent to "commit" has another issue.  It will close the
door for us to later add "git checkin" that may mean something
different from "git commit", and that is another reason why I do not
agree with the patch under discussion in this thread. A "checkin"
that is an operation that checks-in the current contents to the
index is one example of an action other than committing that the
word may make sense for, because "git checkout README.txt" is about
checking out of the index, its logical opposite "checkin" could be
about checking into the index.
