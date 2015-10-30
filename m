From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] checkout: added two options to control progress output
Date: Fri, 30 Oct 2015 09:52:20 -0700
Message-ID: <xmqqa8r0mh8b.fsf@gitster.mtv.corp.google.com>
References: <1445698768-22614-1-git-send-email-eantoranz@gmail.com>
	<20151029220519.GA466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Edmundo Carmona <eantoranz@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 17:52:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsCux-0006mD-IY
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 17:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758897AbbJ3Qwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 12:52:39 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759484AbbJ3Qw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 12:52:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6FAF24E2D;
	Fri, 30 Oct 2015 12:52:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sfYRCHM1xGSqbNED13SXIe/EFLQ=; b=qFIorW
	uryFftf2s7kekzbOEGYld+o7DpwrCP7Jig18JUyja1cAFnmg1DqMLXviM1K9rsTA
	HbUmVvtLLQc0XJK6ai7NXqNzXDDsmM+e9UIq42QrZpmz2wjqPLi/kqBGwywATEz5
	7gDZ/6cR+JQexE6A9o5ZoALm+el+sAqqKqhWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O8h6jy8g5vU4rRSwtnOpnLeK0tIqq5Xe
	oOPM72LGc35Jp5garG8PVyEK0jUDYT2nxjSwg5udKAXVlN4yHRiu7KmQ5aX/mCDG
	GkWo4WL81pY9LrcWuRreC8fn2jcBWiHJPdiOpIQuS3Lb6p7sLblq/N0qTCIrdQjj
	nHW+cpKZWbs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DED9624E2B;
	Fri, 30 Oct 2015 12:52:26 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 67B9024E2A;
	Fri, 30 Oct 2015 12:52:26 -0400 (EDT)
In-Reply-To: <20151029220519.GA466@sigill.intra.peff.net> (Jeff King's message
	of "Thu, 29 Oct 2015 18:05:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 996F83A0-7F26-11E5-990D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280494>

Jeff King <peff@peff.net> writes:

>> --progress-lf: print progress information using LFs instead of CRs
>
> I notice this is part of your patch 1, but it really seems orthogonal to
> checkout's --progress option. It should probably be a separate patch,
> and it probably needs some justification in the commit message (i.e.,
> explain not just _what_ you are doing in the patch, but _why_ it is
> useful).

Yes, and as I doubted its validity, I would really have preferred to
see it done as a later step.  The "we want to say --[no-]progress"
one on the other hand looked a very sensible change, and it was sad
to see it taken hostage by that -lf thing.

Thanks.
