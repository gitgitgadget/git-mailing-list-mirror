From: Junio C Hamano <gitster@pobox.com>
Subject: Re: requesting info page (and pdf) doc releases
Date: Fri, 23 Oct 2009 11:57:30 -0700
Message-ID: <7vtyxqaqg5.fsf@alter.siamese.dyndns.org>
References: <4AE0C362.3030900@gentoo.org>
 <f46c52560910221513w1cb19949lfa05ef964987d809@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Pipping <sping@gentoo.org>, git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 20:57:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1PKd-0008SN-VA
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 20:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbZJWS5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 14:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbZJWS5h
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 14:57:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbZJWS5g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 14:57:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C9EE7831F0;
	Fri, 23 Oct 2009 14:57:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=nmDZiS4CAeGVPuBTLsRnrfInmAE=; b=f12qN+Zt9BzygwZnWL/xxsV
	u0WHliIYBmuFFnnOmXKgGyKxdPbWlh2taK4vdBa8nVlM71+aodjFcJ+bHLcs23UR
	bUbBEE5cwPvKVQKzF6Bf+Ah2I/JP+kYg5GjldQt50ZjFWAtvj1Z8tlu0Ti/UHO5o
	tjEZdckXBxMpFIX3LRoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xtow7pzKm+TWkwPP/ecqWqDwNFUrPnGc97nHVAIyQvoclAxe6
	+lvaAsuwnjtOoSLwNP3l7d42x79Qu+/K/aqereNoh5dRBN1m7ziZ60SO8UkjOVgG
	b1Exxu2c4flduh+AGTK56AKQVnwEfpoAZvJ3ezG6DR8nR4gCFYoj7Bc5JU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B6C4831EF;
	Fri, 23 Oct 2009 14:57:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E2173831EC; Fri, 23 Oct 2009
 14:57:31 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE78A264-C005-11DE-8C77-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131116>

Rustom Mody <rustompmody@gmail.com> writes:

> On Fri, Oct 23, 2009 at 2:11 AM, Sebastian Pipping <sping@gentoo.org> wrote:
>>
>> would be nice to get info pages (and pdf) doc releases in addition to
>> html and man pages.  i imagine such a change to the release machine
>> should not be too hard to integrate.  we could use it in gentoo.
>
> +1
> Why only gentoo? I would use it on ubuntu or windows as well

As I understand it, Gentoo is supposed to build everything from the source
anyway, you would not want to use pregenerated info nor pdf, no?  You
shouldn't be using pregenerated html nor man for that matter...

FWIW, you can already say "make info" and "make pdf" yourselves if you
have necessary toolchains installed.  Integration is not an issue.

Neither my primary development box (Debian, which I would test before
pushing things out) nor the machine at k.org I use for the final sanity
check (FC11, on which the documents are automatically generated) has
dblatex nor docbook2x installed.  I am not particularly enthused about
installing a lot of dependencies for these packages on my machine.  I do
not want to bother k.org admins who are already overloaded to install
these on their machines either.
