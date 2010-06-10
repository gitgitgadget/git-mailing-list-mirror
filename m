From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Misterious warning about file system boundaries [It's a bug, not
 a mystery.]
Date: Thu, 10 Jun 2010 07:53:47 -0700
Message-ID: <7v39wvndl0.fsf@alter.siamese.dyndns.org>
References: <4C0FF7B9.8040007@drmicha.warpmail.net> <4C109C4F.1030809@op5.se>
 <4C10AAC4.90405@drmicha.warpmail.net>
 <AANLkTimwhDGNTMiOaW8_AGGd4PvFtyILEikePdC4zGDo@mail.gmail.com>
 <4C10C02E.50502@drmicha.warpmail.net>
 <AANLkTikle0gxLvKkhr-APkt_6QCB0hVu7bIGm0sRcjVK@mail.gmail.com>
 <20100610110258.GA17290@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	kusmabite@gmail.com, Erik Faye-Lund <kusmabite@googlemail.com>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 16:54:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMj91-0007mN-TO
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 16:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab0FJOyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 10:54:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab0FJOyF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 10:54:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AAC24BB7DD;
	Thu, 10 Jun 2010 10:54:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ykEGnug8Yd6w9Z7TKepsdT1hKa0=; b=kEa4VD
	O6GCIe+Nba4FOC4rCTe4Ip7m0w1impz0ZJW2jKxLKntcX95t4K9vRNVKAbVncKbf
	AtTotA8zkez/ihMwAnPpya0NBLXeCK/CBDCLTxyB/1w8CBHo/FbdSUVnt8pXo8NP
	4XTQ/aNsuEb1U6HOMPXsAHUl/zpg6ZG1cztKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ySSuHsl6CPX+ftd0o8dqbsVJM3K1L9gB
	RBHh21PNp55Wt/YTxUBNcbRt1RDS78Yn36qh4PBZgw1jOe0M9jSt8jN+qMfPd6Rv
	YL+8heDsO2WUq5tMUhU1bn/m/uY0yanlJ6Uql2TAM7/KTG1TIHVskOkG69a//SKD
	b7uja6MhSEA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35616BB7DA;
	Thu, 10 Jun 2010 10:53:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F3C7BB7D9; Thu, 10 Jun
 2010 10:53:48 -0400 (EDT)
In-Reply-To: <20100610110258.GA17290@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 10 Jun 2010 07\:02\:58 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FF0A4EF8-749F-11DF-B74B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148880>

Jeff King <peff@peff.net> writes:

> Since the early-warning suggestion is generating false positives, and I
> don't think there is a portable and reliable way around it, dropping it
> makes sense to me.

Makes sense.  Let's make it so (I won't have time to do that myself until
late this evening, though).

Thanks.
