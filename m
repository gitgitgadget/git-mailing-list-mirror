From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Revert "rev-parse: remove restrictions on some options"
Date: Mon, 29 Feb 2016 09:32:22 -0800
Message-ID: <xmqqy4a3cti1.fsf@gitster.mtv.corp.google.com>
References: <20160226232507.GA9404@sigill.intra.peff.net>
	<20160226232957.GB9552@sigill.intra.peff.net>
	<20160226233449.GA9622@sigill.intra.peff.net>
	<20160229110156.GA29697@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 18:32:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaRgL-0000NU-Oe
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 18:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbcB2RcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 12:32:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751350AbcB2RcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 12:32:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDB9D47F25;
	Mon, 29 Feb 2016 12:32:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nep8DsGeM1kmuTFju+fOnygJUnc=; b=Duix7o
	fVqkzNNto2lS3FUg3gzpW1btZ187oYqLExkDq4NtINUgM4wTLQayiwCW5iFYTDYK
	8X2GSQ2MYfzQepv3hyxzvTiLmTH3oTIV/EL7pgTFvwvKb27mLXHlS95RufhYSsXf
	ZOl/PLD91F4xnnmf+GUA2LsqjEa1FKqTtW1wg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jeeYnbZHrbCDJ0ET4gXtIp+nHYfGT76R
	gWzWZAe7qVqsDSNmYxZDOF/QW9K/t6nKHwZSnMgE+9ZdJ7Lu7MMctlcnEd2wEpRo
	U3U/3JGebkJ0Akrc915RvOx+LDu7fPxbwTWcGBoOehKY9jgRLDOW1ZLQcVQB9XsN
	aIuXEymwqC0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C567347F24;
	Mon, 29 Feb 2016 12:32:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 47A4E47F22;
	Mon, 29 Feb 2016 12:32:23 -0500 (EST)
In-Reply-To: <20160229110156.GA29697@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 29 Feb 2016 06:01:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 647A7742-DF0A-11E5-A1F6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287851>

Jeff King <peff@peff.net> writes:

> IOW, I think my 2/2 should be replaced with this:

This looks sensible.

Don't we still want the documentation updates from the previous 2/2?
