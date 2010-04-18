From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git documentation writing guidelines
Date: Sat, 17 Apr 2010 17:28:27 -0700
Message-ID: <7vtyr9y578.fsf@alter.siamese.dyndns.org>
References: <20100407210010.GB27012@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com>
 <k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com>
 <k2x32541b131004071511i9bbe883az504547d6133aef@mail.gmail.com>
 <20100408043059.GA28768@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A075390@FL01EXMB01.trad.tradestation.com>
 <7vwrwh6fz8.fsf@alter.siamese.dyndns.org>
 <20100408194908.GB4222@sigill.intra.peff.net>
 <7vbpdt65ie.fsf@alter.siamese.dyndns.org>
 <20100417115111.GB28623@coredump.intra.peff.net>
 <7v8w8m3uqj.fsf@alter.siamese.dyndns.org>
 <m3mxx2dnlu.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 02:29:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3INi-0002kR-6Y
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 02:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab0DRA2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 20:28:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab0DRA2n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 20:28:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CDFBABB04;
	Sat, 17 Apr 2010 20:28:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U1C4ISKpuCkHrZHP3I5UXFgc4tc=; b=Eplc1e
	XiPSUBWr1Z1NY2N9eRcG2aQwkeJ1SAiozw5uQuuf+eNrOEoTSUL7rPTKEibgWcR7
	+wR+wDRGp+8OQJabehZa5pYfp/f2t3gokQXDXV1FjDaWks/gRt4uJCq9PscrLQWI
	eqhb8usinO49OO1TYe9libKCdKNLA96Ti3Mfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c8ZL6kmrWY+xOVVeuMe296BYFoaPjbJn
	5cZTZ+zYVlokKU3nwIG0h2ivXWKfl65CDMcBWZ/8aXSSODLmi5GCSWmWfk7jb+iR
	spfsH5blRVL60dWY+3flp1BHE8K/01smQ2eqyeLZIoR3180tbmK6eBVN0/x0wrlh
	YNDBqkbu0zY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F2C6ABB03;
	Sat, 17 Apr 2010 20:28:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3260BABB00; Sat, 17 Apr
 2010 20:28:29 -0400 (EDT)
In-Reply-To: <m3mxx2dnlu.fsf_-_@localhost.localdomain> (Jakub Narebski's
 message of "Sat\, 17 Apr 2010 09\:57\:40 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 53D7E236-4A81-11DF-956E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145192>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>
>> > git-config (or perhaps even gitconfig(7)) should have a list of all
>> > variables and where they are described, like:
>> >
>> >   apply.ignorewhitespace        git-apply(1)
>> >   apply.whitespace              git-apply(1)
>> >   branch.autosetupmerge         git-branch(1)
>> >   [etc]
>> >
>> > There is not much point in having full descriptions in one giant list.
>> > Instead, you can peruse the whole list, and then go to the configuration
>> > section of the relevant manpage to see a bunch of related options. Such
>> > a list should be pretty easy to generate automatically from the other
>> > documentation.
>> 
>> Yes, I like it.
>
> Well, there are some variables, like advice.*, or core.*, or alias.*, or
> color.*, or browser.<tool>.path, or i18n.*, or interactive.singlekey,
> or notes.*, or user.* that do not really belong to single git command
> (well, perhaps they could be put in git(1) manpage), or belong to more
> than one command.

So?

Naturally they will be listed like:

    alias.*		git(1)
    color.diff.*	git-diff(1)
    browser.*.path      git(1)
    ...

and I don't see a problem in the general structure Jeff suggested.

    
