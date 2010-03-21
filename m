From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .mailmap: Entries for Alex =?utf-8?Q?Benn=C3=A9e=2C?=
 Deskin Miller, Vitaly "_Vi" Shukela
Date: Sun, 21 Mar 2010 12:34:45 -0700
Message-ID: <7vk4t5qxii.fsf@alter.siamese.dyndns.org>
References: <cd13e44f33c1f6bc9ec11903c3041199c9c464ee.1268996321.git.git@drmicha.warpmail.net> <7vr5nfowgz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1003201405100.31128@xanadu.home> <4BA620CD.3060101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Mar 21 20:35:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtQvi-0007hP-G5
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 20:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab0CUTe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 15:34:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab0CUTe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 15:34:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B84CA4423;
	Sun, 21 Mar 2010 15:34:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=uBNysK5DhvfnPcxVzP/Li9P3hvs=; b=aHC2QQh62MfcovJtxvL9Dqm
	Hxx2l8W8KZWi055PVYvrxGBNSgzfM6PCOAdR4bCgRwyKhmOnN7d6/ZeW43t8N+G9
	qI2+go4LFzV1TyKMIXOKUVEy71ewxqzMkpILdrjcvbYoa+GdFl91ulcnIbKLh7u+
	JIVyHIcsdPx74RrkeWCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=f7tFYXZl35QSl0Ni3b3vR6QbIRJS7H4GQ5pa8fA3MbLy81JY2
	Ch0YXpuYSj/N2/bR1S3bLFYboBWxlr8kJBpG/rCjuAIRWxBlHhrUAmywB/ignVdM
	oTgpVuidM9nh353/UGHw0VXkaZqGEizR700pa+Feu5AJblLYwHaftl62Yg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03FC3A4422;
	Sun, 21 Mar 2010 15:34:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD3E9A4420; Sun, 21 Mar
 2010 15:34:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D12CF4FE-3520-11DF-8A45-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142851>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Maybe I should have cc'ed Vitaly, the others are straight typo fixes.
> (One may even argue that Vitaly's change is, too.) Smothering on the
> backburner for a while, is fine, though ;)

Nico is right; what I wrote sounded that the patch will be forever on hold
until I get all three acks, but that wasn't my intention.

> Also, if used without "-e", shortlog coalesces authors by full name. I
> reckon this is the most common way it is used, and it's the mode for
> which I provided cleanup.
>
> If you distinguish by e-mail (-e) then there are many obvious multiple
> entries, but it's not up to me to decide which is the main e-mail
> address. One could take the latest one used, but some people distinguish
> between work for hire (maybe for several employers) and private submissions.

True.

We might want to allow projects to use different mode of operation if they
so desire, though.  Linus Torvalds at OSDL and Linus Torvalds at L-F may
be one same person, and the person who is summarizing may want to
coallesce his commmits like this, even under "-e" option:

    Linus Torvalds <torvalds@evo.osdl.org>,<torvalds@g5.osdl.org>,<torvalds@linux-foundation.org> (1093):
      Initial revision of "git", the information manager from hell
      Add copyright notices.
      ... (many more commits) ...

while there may be more than one John Smiths that we can differenciate only
by email and they get their own separate group as different people (each
of them may have more than one email addresses).

If a grouping of set of name-mail pairs per individual is kept somewhere,
that can be used to enhance shortlog to support such a use case [*1*].
And the UUID thing could be one possible implementation (you make
name-mail pair to first map to some third identifier, and treat name-mail
pairs that map to the same identifier as "one person").  But I don't think
it would work well if you forced the maintenance burden of such a mapping
to individuals.


[Footnote]

*1* unless there is a situation where one person (say "Junio C Hamano")
stopped using one e-mail address (say "junkio@cox.net") s/he has been
using, and then a different person with the same name came and started
using the same address, that is.
