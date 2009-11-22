From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: new 'add-envelope' option
Date: Sat, 21 Nov 2009 18:58:11 -0800
Message-ID: <7v1vjrmfjw.fsf@alter.siamese.dyndns.org>
References: <1258825410-28592-1-git-send-email-felipe.contreras@gmail.com>
 <20091121193600.GA3296@coredump.intra.peff.net>
 <94a0d4530911211159l1fadad0ldb0d760439ceb57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 03:58:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NC2ei-0002nS-4j
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 03:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbZKVC6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 21:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbZKVC6Q
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 21:58:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbZKVC6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 21:58:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 843508104E;
	Sat, 21 Nov 2009 21:58:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m1GcikyalLplOnb/sbeHLmiojC0=; b=nOEvV+
	PYCrPF7sewIcBf2izWsojlQXy+OWiXzElOi6bheIXYPpbxmlMHN3mmyITw7YVOl7
	pB4IKBaArDbwuqBAWPuBdsStta62YXh883ToZYml+mRcqKsv7R3w71zJsPOBPGwr
	rYBaMeE3qfQFuMezPhGiHV3avZZA8spr7NweQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BKdzbhsmldZFNGWk1+oMn/gePTJp132o
	Y6qfbkYbQbolKQ0x/o4hI0RMfrYEOd2jUTKYe3eWJ8eBctEQ0nvB4JBCSs5TGYA9
	Ca7pPKSOwBzr6hmFspy7sZLEIqIBCS4nFXneevspB4Nai/gQn3VCL4Hr//PRHtKG
	AAWoGpTD7d8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52BA38104D;
	Sat, 21 Nov 2009 21:58:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96B518104B; Sat, 21 Nov
 2009 21:58:12 -0500 (EST)
In-Reply-To: <94a0d4530911211159l1fadad0ldb0d760439ceb57@mail.gmail.com>
 (Felipe Contreras's message of "Sat\, 21 Nov 2009 21\:59\:33 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1A8ABA0-D712-11DE-94AC-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133420>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There are no tests for 'envelope-sender', so I don't think it should
> be a requirement for this patch to do so....

The fact that the lack of test was pointed out as a problem makes it a
requirement.  Others' earlier mistakes are not an excuse for you to do a
poor job.

I do use --envelope-sender when sending patches out via msmtp.  What
wonderful things this patch adds am I missing in my current setup?
