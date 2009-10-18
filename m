From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unapplied patches reminder
Date: Sun, 18 Oct 2009 16:32:19 -0700
Message-ID: <7viqecgtx8.fsf@alter.siamese.dyndns.org>
References: <20091019052030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Mon Oct 19 01:32:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzfEl-0005uX-QT
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 01:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbZJRXcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 19:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755623AbZJRXcY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 19:32:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619AbZJRXcX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 19:32:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0CB9B7CC63;
	Sun, 18 Oct 2009 19:32:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=J+s44+wSEoM75/O1ns5kCQBv+ro=; b=mK96/gGnVjVCJMFftPklvAT
	/0kM3t9zwghJ9WYPH0O5G/DkEpeBg2jwMkIip/agQLMrqUXLErLcJOmJ6yRPkYOQ
	I83szfUmJ2mVsQV6peKANHCdDVct30Xm0ax128NGVaeyxOEk/vj7eCBqkAu2QCPX
	IWkIkYyCzd3fZy4UgLF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uPkeh0o4lhR9YKsOPeblhT28blPaSrNkacaIilTvl3pKBPlXa
	k4pMjEXJNWHj09BYo7P4vixt/mn3uVXPfrMEhvH4mTWyOP/K/XBIpU4Emw4Qz8vd
	ne1RU96V5aWXiGEibr0+38lNEpd/4sSIO9JZJqZ8HeTWuf2w0CVUxC9lZ4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D7FD57CC61;
	Sun, 18 Oct 2009 19:32:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 820DD7CC5D; Sun, 18 Oct 2009
 19:32:20 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7D89C706-BC3E-11DE-9D92-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130627>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, I saw these patches and thought what they try to do were 
> sensible, but I don't them in your tree. I didn't see much discussion 
> on most of them, either.
>
> Because I don't read C very well, I may have listed some patches 
> here that you may have discarded because the code was no good, and 
> if so I apologize for wasting your time, but I thought at least 
> some of them should be salvaged.
> ...
> From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
> Subject: [PATCH] NO_PERL_MAKEMAKER should behave more like ExtUtils::MakeMaker
> Date: Tue, 13 Oct 2009 13:14:31 +0200
> Message-ID: <1255432471-14168-1-git-send-email-tgc@statsbiblioteket.dk>
>
>     This change makes NO_PERL_MAKEMAKER behave more as ExtUtils::MakeMaker
>     by installing the modules into the perl libdir and not $(prefix)/lib.
>     It will default to sitelib but will allow the user to choose by setting
>     the INSTALLDIRS variable which is also honored by ExtUtils::MakeMaker.

I still have this in my inbox, but I tend to wait for Acks to patches that
touch perl/ area before acting on them, which hasn't happened.

P.S. Originally I somehow mistook this from tchrist (aka thoth) and
blindly applied, but then realized it is a different Tom with slightly
different family name and recategorized the patch to go through the usual
review cycle.
