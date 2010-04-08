From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ghost refs
Date: Thu, 08 Apr 2010 09:55:55 -0700
Message-ID: <7vwrwh6fz8.fsf@alter.siamese.dyndns.org>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
 <20100407210010.GB27012@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com>
 <k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com>
 <89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com>
 <k2x32541b131004071511i9bbe883az504547d6133aef@mail.gmail.com>
 <20100408043059.GA28768@coredump.intra.peff.net>
 <89030B4A18ECCD45978A3A6B639D1F24032A075390@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 18:56:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzv1b-0000s3-Gh
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 18:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758744Ab0DHQ4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 12:56:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758510Ab0DHQ4G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 12:56:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9D46A9F7A;
	Thu,  8 Apr 2010 12:56:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=JPX95pa5aUijdUaPmlZHJJ4ewUk=; b=LLWINfG5YvX85mhoOGY86m0
	I8XA5IsbNacWUmqVrF+NZfku9Qqnn99tooavysP2lc2MK/wETGNRvL975sIN+CSA
	8KBs1+X0kHFZahO3qks3VeFzjJ0hTY27HZd5EGbo2TmQJyYA5qjlRHCxA1c3Zs3E
	Y6lgAQeqsPokvOAsO63s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gtdaVAHj6+4KbhmRFJdjpBu/32pzEPJ16+GmZs5Gk7CZO4x8W
	mhzqJRGOARqlgqesxCHBgwSLHXtjSwfxfWPdgaL0InQDk9S2EGWCjxM+0lsNMA5J
	uJDmCFEdfYGxrvp2GbPYkftAdX2C+Je6gCYfN1Xbpv39X2EwlK0OZ4J8uc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A7193A9F79;
	Thu,  8 Apr 2010 12:56:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6B31A9F77; Thu,  8 Apr
 2010 12:55:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9CBCFDFA-432F-11DF-A47F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144363>

John Dlugosz <JDlugosz@TradeStation.com> writes:

> In git-branch,
>
> 	-l
>
> 	    Create the branch's reflog. This activates recording of all
> 	    changes made to the branch ref, enabling use of date based
> 	    sha1 expressions such as "<branchname>@{yesterday}".

That is how you selectively enable reflog for that particular branch when
you have explicitly disabled "reflog by default" with the configuration.
