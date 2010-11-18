From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2010, #02; Wed, 17)
Date: Thu, 18 Nov 2010 09:54:27 -0800
Message-ID: <7v1v6icyb0.fsf@alter.siamese.dyndns.org>
References: <7v1v6je9g8.fsf@alter.siamese.dyndns.org>
 <m3mxp668cy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 18:54:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ8h2-0001lA-6p
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760005Ab0KRRyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 12:54:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203Ab0KRRyh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 12:54:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A45DA3C40;
	Thu, 18 Nov 2010 12:54:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P3EnnbgVq9O3MzDYrjeQ34TyODw=; b=lpoQMs
	CSg+OvLHx17L0WGnZ5CPRf3TH1r/6CnKv1EZwfJsXXjXXWmF5Od5eWliw/1YdgKQ
	BlfbyPSkYFrvjNuZg7mQhmQ3wr9uL/KkHCB9CZ55j2ahq075eB1Nj84Tdj+bqHLk
	a9eL57r6O0vydRvzP936s80J8oXp2joXXTU80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IIHH6ROB8PbmIZ5ettjnrOM37P77R6ln
	mlGyMwfZM43swdGfBotabVOSSvWs8++xkzdPk7x4gP3oIS2JI6I+NzyGkIGaWDV1
	YsY6d5/zeE0IBsGD2r5d6F+oPXEwYqpcusWiRKBsdnJBuFuBsddUT1Kdcj+H8LMs
	N6M/R/iD1fc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75C393C3D;
	Thu, 18 Nov 2010 12:54:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BA7713C3A; Thu, 18 Nov 2010
 12:54:39 -0500 (EST)
In-Reply-To: <m3mxp668cy.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu\, 18 Nov 2010 06\:00\:23 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED03C15A-F33C-11DF-9EAB-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161696>

Jakub Narebski <jnareb@gmail.com> writes:

> Sidenote: recently sent
>
>   gitweb: selectable configurations that change with each request
>
> practically reverts
>
>   gitweb: Move call to evaluate_git_version after evaluate_gitweb_config
>
> Just FYI.

Hmph, will have to look at it again.

>> * jn/gitweb-time-hires-comes-with-5.8 (2010-11-09) 1 commit
>>  - gitweb: Time::HiRes is in core for Perl 5.8
>> 
>> Looked reasonable.  Will merge to next.
>
> Thanks. With or without improvement to commit message?

I think what I pushed out has already been reworded.  Please check.

>> * jh/gitweb-caching (2010-11-01) 4 commits
>>  . gitweb: Minimal testing of gitweb caching
>>  . gitweb: File based caching layer (from git.kernel.org)
>>  . gitweb: add output buffering and associated functions
>>  . gitweb: Prepare for splitting gitweb
>> 
>> Temporarily ejected while I shuffled jn/gitweb-testing; will queue the
>> latest back in pu or perhaps in next.
>
> The advantage of 'gitweb: File based caching layer (from git.kernel.org)'
> is that it is tested in real-life on heavy load (assuming that 
> git.kernel.org uses the same version as is/would be in pu/next).
>
> The disadvantage is that it is seriously messy code.  Something that I
> wanted to improve in my rewrite.  This is only minimal fixup.

Which is exactly what we want at this point (I want to release 1.7.4 by
the end-of-year holidays, which means a feature-freeze will have to start
soon).  My understanding is that the serious messiness does not come from
the caching layer.

> I am thinking about splitting main 'gitweb: File based caching layer
> (from git.kernel.org)' patch in two, separating moving test for
> $caching_enabled out of cache_fetch to separate commit (largest change
> to original J.H. submission), but leaving hardening "do 'cache.pl';"
> and replacing 0/1 valued $cache_enable with boolean valued 
> $caching_enabled.
>
> Because currently new tests in t9501 and t9502 (examining status and
> output of gitweb with caching enabled) do not pass, I am thinking
> about adding new configuration know turning off "Generating..." page.
>
> BTW. should I forge J.H. signoffs, and add mine?

Just ping him beforehand ;-)
