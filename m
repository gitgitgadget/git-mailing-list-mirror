From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-tag(1): Refer to git-check-ref-format(1) for <name>
Date: Tue, 25 Aug 2009 13:37:14 -0700
Message-ID: <7vd46jocjp.fsf@alter.siamese.dyndns.org>
References: <87ab2gsqst.fsf@jondo.cante.net>
 <7veirs6qxn.fsf@alter.siamese.dyndns.org>
 <20090822094518.6117@nanako3.lavabit.com>
 <20090825172100.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 22:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg2mb-0006uY-QZ
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 22:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693AbZHYUhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 16:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755550AbZHYUhY
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 16:37:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbZHYUhX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 16:37:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 633A218F45;
	Tue, 25 Aug 2009 16:37:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=NhwUiGCF9Ovo4vtuwmHohoPtTX0=; b=UIIW6gSkHoOuawQAS/LrhN9
	HdFia8I9nVSLRLdB1qIN/MZbqWyGH9Qmd8Qt2R6eI4ZEeTKIS2ZiNgj0gO2Kb9t5
	TO0+RyYhr8JhpNoRPaWokkcKIaAty57PcF6lTozewa/TSoIWLWOhH+4RqV/EAnop
	kCHxiOMIC4LBneyqrYq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=qIiXJfq9SB0Qj5qMi6B+nrpodYbI/klxQC4XFbrU4sRpWFvSm
	64xJydPqZszVv4CtWoR9PqvDKGd2y2/52P9LwtowXdqewQsPEzeux+Y+vSE9Y5V2
	NbfuW1Hd+8qg5YLO6nN+xCYccaR/vzJzVfLFbXWbN/kNlX8SI4TH8oPM9I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 363ED18F43;
	Tue, 25 Aug 2009 16:37:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C23B18F3F; Tue, 25 Aug
 2009 16:37:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1601E5AC-91B7-11DE-B73E-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127048>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting myself...
>
>> Subject: Documentation: consistently refer to check-ref-format
>>
>> Change the <name> placeholder to <tagname> in the SYNOPSIS section of
>> git-tag documentation, and describe it in the OPTIONS section in a way
>> similar to how documentation for git-branch does.
>>
>> Add SEE ALSO section to list the other documentation pages these two pages
>> refer to.
>>
>> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
>
> Should I further polish this patch?

No, it just fell through the cracks of my mailbox.  I tend to agree that
it is better to mention only the presense of rules, and refer to the rules
described in the definitive document.

Safe names are designed to be what most sane people would naturally choose
to use anyway and they would not need to see the clutter that describes
only the half of the rules there.  And more importantly, the people who do
get errors by choosing illegal names by accident would _want_ to see the
full set of rules before choosing another name to avoid getting the same
error again.

Spelling only the half of the rules in the tag/branch manual page would
not help neither audience.
