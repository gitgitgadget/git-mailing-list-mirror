From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug?] "am --abort" broken?
Date: Wed, 12 Jun 2013 21:17:10 -0700
Message-ID: <7v7ghyy795.fsf@alter.siamese.dyndns.org>
References: <7vsj0nymyd.fsf@alter.siamese.dyndns.org>
	<CALkWK0ksCupC183X-XDwCcscHkQXq9whxxYeWLjR2FpH50ycHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 06:17:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmyyM-0001Vs-RM
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 06:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab3FMERO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 00:17:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782Ab3FMERO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 00:17:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAACF1F9C7;
	Thu, 13 Jun 2013 04:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3yFXgV8jH9fWJRmw+phM1pY1Ujw=; b=Fsrgen
	gx+m1PGowlexVApPc3g9oPeodKeeP3cf7xUQEyq1QgCdhUjM03/qRI9iKtEuyfou
	BRtBpe+o9ptiSybFs8VYRWxjSuqgEEQcZ4nc29MiAnxtrbiCmtTLRGeO1tearTIj
	IqTwfh+s4pRZig9f09DrzZSF5qobPWcd5l54I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ci7eQwvbMak/NHXCRAJMalXq+uDXig1c
	B5eTrheAu8giK0VCVy6cUYRHivpg7Ec7h2XrQuFSayR6//aTJZmTgzSKP1lx9lp+
	VOyRVSHOZ8OF2Y7NuQSb6cpPqul7GoM+hvVVw7aLsXegZSZz2wFrpEUucwL2zcoF
	rhmcF8bvLuw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE3FF1F9C6;
	Thu, 13 Jun 2013 04:17:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 490851F9C3;
	Thu, 13 Jun 2013 04:17:12 +0000 (UTC)
In-Reply-To: <CALkWK0ksCupC183X-XDwCcscHkQXq9whxxYeWLjR2FpH50ycHA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 13 Jun 2013 09:30:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F239C2E-D3E0-11E2-A631-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227696>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> I think this is a recent breakage after merging the topic to add
>> "rebase --autostash", but I haven't looked into it yet.
>
> Yes, I can confirm that my topic introduced this bug, and I apologize
> for not having caught it.  I'm looking into the problem.

No need to apologize; nobody caught it during the review.

And thanks for volunteering.
