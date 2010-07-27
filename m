From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Tue, 27 Jul 2010 14:14:40 -0700
Message-ID: <7v39v47hkv.fsf@alter.siamese.dyndns.org>
References: <4C4778DE.9090905@web.de>
 <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com>
 <m31vavn8la.fsf@localhost.localdomain>
 <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
 <4C49B31F.8000102@xiplink.com>
 <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com>
 <AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com>
 <AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com>
 <4C4DB9AC.9000306@xiplink.com>
 <AANLkTimQywtn-0Fcr-ceLeHGeSBNROt+T=K+TowF_u5h@mail.gmail.com>
 <20100727182841.GA25124@worldvisions.ca>
 <7vaapc7jv8.fsf@alter.siamese.dyndns.org>
 <AANLkTim0A0MAmpgAiaYSgYO=YbZ2gc4Upx3MQQopx6DG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Branchaud <marcnarc@xiplink.com>, skillzero@gmail.com,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 23:15:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrUc-000898-11
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317Ab0G0VPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:15:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab0G0VPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:15:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E562CC8EF9;
	Tue, 27 Jul 2010 17:15:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8ZncS1CdBv3CY5flydcATHKXFIU=; b=X6QOs/
	4OfFwGGEfLH50ij9sv5FCCGGygwPkKvRpNgIXMPs7+nLezioMKUezVXvGyjK4sIa
	MUdlWxYVHRH3wrKpPgsqNMdwiJZblERwAxcGjSrbgpcrwrkJNUIM5hF7yf+Q4AdQ
	t+DOV6xsXrG0/sOdVxi1DBjlAVqJ4QrqshCqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ccYp/V1lbvi3PXORZdcYzQ+fp47G/8IL
	I/jVUP42PywdyqXPZnn9P3mpgqDJGtL9GqscKOB5SSoxoRa6wB/cT3M4dCskehmW
	tRgIfcpTmRrcbZXgRSZv+OAwafpEzO9YzoZHzkE41heJ+3djPorpkJlkD3rUQQ78
	WaphKtIRtQU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E28EAC8EF3;
	Tue, 27 Jul 2010 17:14:53 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E280C8EE8; Tue, 27 Jul
 2010 17:14:42 -0400 (EDT)
In-Reply-To: <AANLkTim0A0MAmpgAiaYSgYO=YbZ2gc4Upx3MQQopx6DG@mail.gmail.com>
 (Avery Pennarun's message of "Tue\, 27 Jul 2010 16\:57\:24 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 001DC4E8-99C4-11DF-84F1-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151997>

Avery Pennarun <apenwarr@gmail.com> writes:

> ...  There is one problem I don't know how to
> solve with this idea, though: what happens when commit A adds a
> submodule in modules/mod1, commit B removes it, and then commit C
> re-adds the same submodules in modules/mod1-again?  Will it reuse the
> same submodule .git directory or a new one?  Share objects or not?
> Share branch names or not?  Share .git/config or not?
>
> Unless you have some kind of "unique id" scheme for submodules, this
> gets impossible to handle correctly.  And the git objects themselves
> (trees that link to commits) have nowhere to put such things.

I vaguely recall that we already had discussed and more or less resolved
it at the design level at some point.  Looking for "three-level thing" in
the gmane archive might be beneficial, although all I recall these three
words as search keywords and do not have a detailed recollection of actual
discussion ;-)
