From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] ls-remote: document --refs option
Date: Mon, 18 Jan 2016 12:01:11 -0800
Message-ID: <xmqqsi1ud5dk.fsf@gitster.mtv.corp.google.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
	<1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
	<1453136238-19448-3-git-send-email-t.gummerer@gmail.com>
	<20160118193140.GB1009@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	bturner@atlassian.com, pedrorijo91@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 21:01:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLFzK-0002BK-2F
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 21:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756268AbcARUBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 15:01:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754270AbcARUBN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 15:01:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 362E23B448;
	Mon, 18 Jan 2016 15:01:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nCO1ZJYa7F20+aYDBEGJcshksD0=; b=oO0yMO
	/EHrIKCn5ia76iLg/TCMU9abQteuxC2T9dZlYkVpWr9vo1cPp8gvYz/xHtKHQDwb
	56tDEP2vFog7nNjf+yGILpT8rTK8HxMGJF6Vc8txEnYOhN3sr0oVuW9B2GMESWqS
	8wzbS01z85N2j6X5AcGsTxXVk9lNJ8wMONTQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SP+z3xo8lx8Vv9N9HYjgHweSm5V7DFf/
	qwG7a+dgikS17GSzwCojt6lCDJEndZqQPvny4bMpLy2ekZtqXD5qkMO1P3Xgu5Ee
	Ubz/EtwXg9jZqoyDVD2dd/z2NI7JyN1qencRD4kGoBCjwh8oVycWze9uS7lN2smo
	/FeIN/zr82M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D0293B446;
	Mon, 18 Jan 2016 15:01:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 91F413B443;
	Mon, 18 Jan 2016 15:01:12 -0500 (EST)
In-Reply-To: <20160118193140.GB1009@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 18 Jan 2016 14:31:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3968B0E4-BE1E-11E5-8F15-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284312>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 18, 2016 at 05:57:15PM +0100, Thomas Gummerer wrote:
>
>> +--refs::
>> +	Do not show peeled tags or pseudo-refs like HEAD or MERGE_HEAD
>> +	in the output.
>> +
>
> Minor nit: we show whatever the other side sends us, which is the refs,
> HEAD, and peeled tags. So mentioning MERGE_HEAD isn't wrong (if the
> server _did_ send it to us, we would omit it), but it is a bit
> misleading.
>
> I think saying "pseudo-refs like HEAD" is OK; even though we know it is
> only HEAD in the current server implementation, it better describes what
> the client side is doing.

Good point, I think.  We probably would want to fix the glossary
entry of the word that is not spelled with a dash in between the
two word components (or update the above to spell it as a single
word).
