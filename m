From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Add js=1 before an URI fragment to fix line
 number links
Date: Tue, 27 Sep 2011 10:40:03 -0700
Message-ID: <7vy5x9x4ss.fsf@alter.siamese.dyndns.org>
References: <1317060642-25488-1-git-send-email-peter@stuge.se>
 <7v62kf2jf4.fsf@alter.siamese.dyndns.org>
 <20110926194639.25339.qmail@stuge.se>
 <7vipof0zx0.fsf@alter.siamese.dyndns.org>
 <20110926222801.14985.qmail@stuge.se> <4E8170B3.8040205@viscovery.net>
 <20110927094947.10955.qmail@stuge.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Peter Stuge <peter@stuge.se>
X-From: git-owner@vger.kernel.org Tue Sep 27 19:40:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8bde-0006Ks-R3
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 19:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708Ab1I0RkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 13:40:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52688 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab1I0RkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 13:40:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B963E535F;
	Tue, 27 Sep 2011 13:40:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MTPdx9fSl2kXvivU/Ydp1KW7yXY=; b=EhtrIR
	FlV6L5RQGRl7Nm3eke0iyXv4MWcphZpOz0rBFCD9X7fIG77BCM3GmIphd9MxutLK
	0HuVL25PJLG3KbLrnCpes0Ua5LgVwAMtBoohXw9uFpmpspto+GFeH5c7PtOOIx7k
	dkZyaV8nDrGSOiiMkPWrDJYHNeZw2o7GFTbbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WFr/Kom4cCZj4h71JgOWZbUuAS4XaotI
	x7nPPo7TrsMrUYT1mYBt8BZpeWDAtz8lBEtWJo/etyCpWbfNUzixG6gCIxGYq+VN
	yNvlcA2IdkijO2c1KMqkX71u4znuGhO7f3aRazcvOq3alkDv8Ra6je+I8n0Y0naT
	6fm2rTehTw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B11F2535E;
	Tue, 27 Sep 2011 13:40:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42A50535A; Tue, 27 Sep 2011
 13:40:05 -0400 (EDT)
In-Reply-To: <20110927094947.10955.qmail@stuge.se> (Peter Stuge's message of
 "Tue, 27 Sep 2011 11:49:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC4A669C-E92F-11E0-A480-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182256>

Peter Stuge <peter@stuge.se> writes:

> I disagree, but I agree with you if we qualify that a little. The
> right balance is a matter of subjective review, so the only way it
> can be practiced with relevance is by actually working with the same
> reviewers for a while, to learn what they consider right.
>
> It can absolutely not be practiced out of context,...

You are right that you need to practice in the context of working in the
Git project to explain your change with the right amount of details when
preparing a change for the Git project, and the same goes for the openocd
project.

We aim to write our commit log messages primarily for future developers
who want to read "git log -p" output and understand why these changes had
to be made, to help them avoid intentionally breaking what the old commit
wanted to achieve when they want to modify the existing code 6 months down
the road. Your reviewers aim to make sure that your log message gives
sufficient information to such future developers, as opposed to themselves
while reviewing the patch and the issue is still fresh in their head.

I suspect that the target audience of log message may even be different
depending on the project, and openocd may not work that way, and that is
perfectly fine.
