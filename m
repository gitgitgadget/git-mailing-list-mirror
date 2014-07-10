From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: State coding guideline for error message punctuation
Date: Thu, 10 Jul 2014 13:36:05 -0700
Message-ID: <xmqqwqbl6jey.fsf@gitster.dls.corp.google.com>
References: <1402923357-3788-1-git-send-email-philipoakley@iee.org>
	<1402923357-3788-2-git-send-email-philipoakley@iee.org>
	<20140617093759.GA6267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:36:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5L4k-0004CZ-4M
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbaGJUgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:36:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58176 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbaGJUgN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:36:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F26127D26;
	Thu, 10 Jul 2014 16:35:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SA250NkwypBVJusm/6Zc6V5f2Xw=; b=QZ5SFx
	UGmAEc/yf/3rhB+eFONNMQfNlIBBcqoStJszdo0A2akCciWMlYB9iaBV9TDoMkHB
	/m3LHiuMZSskRpy86Vw8CHalX2GVqNqbzDXlopPXhxRlhpWHKx2Hrmp71C57NcCf
	6iHixRo8/yli0djCIFhg8NefXT7ytVsrxppXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FzkPLl2UwAA/kiC9brNljBgjkxVdTMWI
	1OdcKF5pVNgndbxD+bFbGAvaLw3amgK50M/AwP/y8lx+6xztGdjpJPjQCf6i6otN
	swy4IxKIHSI/S0Vm1tgfg0kamuCmiz9cJtrDhQeEo2CpiEF3SqRG8cTIESNUAMFj
	nVgKoF2RAMg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55EDF27D24;
	Thu, 10 Jul 2014 16:35:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 07D8C27D1C;
	Thu, 10 Jul 2014 16:35:51 -0400 (EDT)
In-Reply-To: <20140617093759.GA6267@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 17 Jun 2014 05:37:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C8C1DA04-0871-11E4-B2C2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253209>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 16, 2014 at 01:55:57PM +0100, Philip Oakley wrote:
>
>> +Error Messages
>> +
>> + - We typically do not end error messages with a full stop. While
>> +   we've been rather inconsistent in the past, these days we mostly
>> +   settle on no punctuation.
>
> Unlike Junio, I do not mind spelling out guidance for error messages.
> However, I do not think the second sentence is adding anything here
> (everything in CodingGuidelines is subject to "we did not always do it
> this way, but this is the preferred way now"). So I'd drop it.
>
> And then add in more guidance. Besides "no full stop", probably:
>
>   1. do not capitalize ("unable to open %s", not "Unable to open %s"
>
>   2. maybe something on sentence structure / ordering? We tend to prefer
>      "cannot open 'foo': No such file or directory" to "foo: cannot
>      open: No such file or directory".
>
> Perhaps there are others (we do not have to be exhaustive, but it makes
> sense to think for a moment while we are here).

I do not want to forever be waiting for a reroll, so let's queue
this and advance it to 'next' soonish, and refine the guidelines by
further building on top of it as needed.

Thanks.

-- >8 --
From: Philip Oakley <philipoakley@iee.org>
Date: Mon, 16 Jun 2014 13:55:57 +0100
Subject: [PATCH] doc: give some guidelines for error messages

Clarify error message puntuation to reduce review workload.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index f424dbd..f4137c6 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -264,6 +264,15 @@ For Python scripts:
    documentation for version 2.6 does not mention this prefix, it has
    been supported since version 2.6.0.
 
+Error Messages
+
+ - Do not end error messages with a full stop.
+
+ - Do not capitalize ("unable to open %s", not "Unable to open %s")
+
+ - Say what the error is first ("cannot open %s", not "%s: cannot open")
+
+
 Writing Documentation:
 
  Most (if not all) of the documentation pages are written in the
-- 
2.0.1-751-ge540734
