From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] test-lib: filesystem prerequisites
Date: Fri, 27 Jul 2012 10:29:15 -0700
Message-ID: <7vboj115as.fsf@alter.siamese.dyndns.org>
References: <5001B82B.1060201@web.de>
 <cover.1343309173.git.git@drmicha.warpmail.net>
 <7vtxwu75gy.fsf@alter.siamese.dyndns.org>
 <20120726184337.GB16037@sigill.intra.peff.net>
 <7vzk6m5ln9.fsf@alter.siamese.dyndns.org>
 <50126005.7060202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, tboegi@web.de
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 27 19:29:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuoLs-0003oD-AY
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 19:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247Ab2G0R3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 13:29:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237Ab2G0R3R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 13:29:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7037E8E88;
	Fri, 27 Jul 2012 13:29:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a+cyP71AP1LpNMQwgp7T3xtfapI=; b=PV7u0T
	ASHDCCput7LHnWVmQ5lyQ9v5pCa1gQl5hIWmgM5N+NSLvMr9AVdhIeWPzJqy+Zb3
	wHgGfPsVl9nGt+BZivXXQ+eqGZ5cb/DHO/p+gZBKZIAXabr3U8GGEHVnjIsZ+mY+
	YUvPi/p3C7sToKmpiwk0mF1Kb+0jRbNvhDMFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f9mR/zfMbHbRb1j7KivPi3bFgWlHRA8D
	v4kqZzARp0XgsaPxiFzLpEdG4FYE3gl+KF314Oe/A2xXXwWL6dCYdXKzepYbdUob
	g6jXnIJoIdx5uNthP1th8HYdRZ25p47eOuZTIyZOtrfmakgrNsPf4bYiXNwzyQCc
	mfnTxNvhaQE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EDFD8E87;
	Fri, 27 Jul 2012 13:29:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D010D8E86; Fri, 27 Jul 2012
 13:29:16 -0400 (EDT)
In-Reply-To: <50126005.7060202@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 27 Jul 2012 11:31:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9760C2EC-D810-11E1-B6FE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202364>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> 5/5 needs a fix in the subject line, sorry. It should be:
>
> t3910: use the UTF8_NFD_TO_NFC test prereq
>
> (5/5 hasn't hit next)

That is because I thought that you would like the lazy-probe and
that you would be capable of rerolling it on your own ;-)
