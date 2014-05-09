From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 19/25] contrib: remove 'diff-highlight'
Date: Fri, 09 May 2014 11:06:56 -0700
Message-ID: <xmqq61lezv0f.fsf@gitster.dls.corp.google.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
	<1399597116-1851-20-git-send-email-felipe.contreras@gmail.com>
	<20140509015107.GA9787@sigill.intra.peff.net>
	<xmqqa9aq28a4.fsf@gitster.dls.corp.google.com>
	<536d142c3524_693d7fd30c9d@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 20:07:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WipCQ-0004V7-CP
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 20:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765AbaEISHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 14:07:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60734 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756533AbaEISHC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 14:07:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83CFC15FCD;
	Fri,  9 May 2014 14:07:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CqW26AorX3cDf0i7yKWDf7hdmno=; b=rEM5k8
	Kluhk3aQMo4I2c1UY/+brKHbDgL7xKfx4bvx1OvYuh33iSmckyLxJeIU9AQv1L5T
	wxGnbXW6eL6mQglI/0UgJ41KTAdVZzwSJ7nt4WYt7j2PQi6mTx5mq9rqUqR662Ge
	iB2aCfisKQMsWyo8iUg8epizUnwbFO/m+HcLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GbqfhE8vpqUoGBb6HDqJFYZMfEThaQ0d
	P2M/oEwne0e+yQ+ayGucgunaByCajakuxBEMNDNbAkjnOdED2WFMEC+NTyv9+Lmi
	+hs75mXXvzECDA0/uYzVY8OaQ8quNP4yuFj50NU7zw86WpmCUdVJocPjf9nmC8L7
	2HPHgDxuopw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5400B15FCB;
	Fri,  9 May 2014 14:07:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7D3A915FC5;
	Fri,  9 May 2014 14:06:58 -0400 (EDT)
In-Reply-To: <536d142c3524_693d7fd30c9d@nysa.notmuch> (Felipe Contreras's
	message of "Fri, 09 May 2014 12:45:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B65AB9A6-D7A4-11E3-BC90-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248602>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> *You* said this[1]:

If you read the context you omitted from the quote, and realize that
it was a counter-suggestion to give a middle ground to a more
draconian "let's divide them into two", neither which I said I want
to see go forward immediately, you see that this message does not
deserve any response.
