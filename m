From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Host refs to push are chosen (documentation error)?
Date: Wed, 17 Feb 2010 21:13:01 -0800
Message-ID: <7vfx4zrusi.fsf@alter.siamese.dyndns.org>
References: <201002171627.57599.arvidjaar@mail.ru>
 <be6fef0d1002170539v4384b355lb6be3e2f19b7b87b@mail.gmail.com>
 <32541b131002170939l261f396cpbee45f652fd96c77@mail.gmail.com>
 <20100218011620.GA15870@coredump.intra.peff.net>
 <32541b131002171751n454081a9w90f2957d7a40d87@mail.gmail.com>
 <7vaav7wb8v.fsf@alter.siamese.dyndns.org>
 <20100218021010.GA21693@coredump.intra.peff.net>
 <7vocjnuqzy.fsf@alter.siamese.dyndns.org>
 <20100218044337.GA10970@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 06:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhyiQ-0003T3-07
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 06:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687Ab0BRFNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 00:13:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab0BRFNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 00:13:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BB5F9B573;
	Thu, 18 Feb 2010 00:13:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WYmu8bmul41fGujTtsvnuUELRxY=; b=TLdRs0
	9edLwO91Rw3S+Fmp3VMFFo5xxNYf53pi8MVk8bULYOZQKfisJ9IlUkmI/cMnjc9Z
	gI1wWVmiGfkSG/vvwOJ2t0OMOLgFfhanopQF81TDLfdI73SYPLY+qf0QEotFZK27
	q5LUzjciGc33m12OC44KJOHMz1ltmlHKPPpm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CIsixmf45JLzSC3GP4ARxI2i3N8dPrv6
	pweNr6Hpp+UQs4vlLzTvFybZoLT2wXy6yVMR/b7+wLh0U7/Tsx0tupUBUWYLi1v7
	iwFPAbH9NJ3WXdnO2VBjBpjbr+Ixb7UXVIXh6tqmV2SQn684UmlnwoeJd+EzJmIE
	5GaXmG5spoM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CCE2D9B570;
	Thu, 18 Feb 2010 00:13:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCCC49B56F; Thu, 18 Feb
 2010 00:13:19 -0500 (EST)
In-Reply-To: <20100218044337.GA10970@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 17 Feb 2010 23\:43\:37 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5D0450F0-1C4C-11DF-9FE5-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140298>

Jeff King <peff@peff.net> writes:

>> This makes it much more clear.  Thanks.
>
> Do you want a repost with the squashed text?

I think I have both; thanks for the offer, though.
