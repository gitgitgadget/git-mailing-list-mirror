From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2011, #03; Thu, 11)
Date: Tue, 16 Aug 2011 09:45:13 -0700
Message-ID: <7vwredi9uu.fsf@alter.siamese.dyndns.org>
References: <7vr54rpogf.fsf@alter.siamese.dyndns.org>
 <CALkWK0mxHT8by86-P=Msopgib1ToeHcfwsSXBYBgvN_dm75GnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 18:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtMlX-0000tV-Sq
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 18:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669Ab1HPQpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 12:45:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34528 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580Ab1HPQpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 12:45:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C6524DEE;
	Tue, 16 Aug 2011 12:45:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XzQVC9CGF4hJq0j3nJI0SwFeIbo=; b=vhhm+H
	+XZSiC2M/U68dbMpV1vtSRqMyfUNn4JK/ux84Qx0QkzBvknKMN92Hu6T0l9RQ/7u
	vy53ddqXS5jTIaNLldKD6XXyD/pMcQar4Gh9Z2HopRPrvFwUA6N3MdGzWxZS/niI
	DBQkceWv/jgdoctwBkPUlQ7nyQN1jBtJzIJtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s13op5iDii/UAnfEpXOMzJvD3A2b8QAp
	niqrO/yuztnu2lpXhmP83rSgPZeGTx1xrBe/7Zi1OCWkm84bCEZfbejt3CtMGYLz
	eShHRO/wykhub9OCAsgbRBRhBsjT55J1FrrUx3MfH6jYhzcyh6NGtHJuz34L+SJY
	qlwT9BMtK4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73FFC4DED;
	Tue, 16 Aug 2011 12:45:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06A694DEC; Tue, 16 Aug 2011
 12:45:15 -0400 (EDT)
In-Reply-To: <CALkWK0mxHT8by86-P=Msopgib1ToeHcfwsSXBYBgvN_dm75GnA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sun, 14 Aug 2011 14:14:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E65AD7A-C827-11E0-B49A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179458>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> * rr/revert-cherry-pick-continue (2011-08-08) 18 commits
>> [...]
>> Will merge to "next".
>
> If this won't graduate to 'next' before the 24th, I have plenty of
> time to re-roll fixing all the issues that I've addressed in the
> beginning of the new series.

I take it that you mean by "the new series" the 6-patch "Towards a
generalized sequencer" topic?

It is ultimately up-to-you. If you feel the fix-up is against glaring
errors in the earlier round that you would prefer not to see in the
history cast-in-stone, I am perfectly Ok to wait for a re-roll. On the
other hand, if they are mostly cosmetic fixes without major semantic
changes, it may be easier for everybody to see them fixed in-tree.

Your call.
