From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: merge into unborn by fast-forwarding from empty tree
Date: Thu, 20 Jun 2013 14:45:04 -0700
Message-ID: <7v7ghoqwwv.fsf@alter.siamese.dyndns.org>
References: <20130620124758.GA2376@sigill.intra.peff.net>
	<aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
	<7v8v24vd0m.fsf@alter.siamese.dyndns.org>
	<20130620201957.GC31364@sigill.intra.peff.net>
	<7vmwqkqzhy.fsf@alter.siamese.dyndns.org>
	<20130620205533.GA8074@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 20 23:45:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpmfL-0005J6-Ds
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 23:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033Ab3FTVpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 17:45:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757417Ab3FTVpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 17:45:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4731929979;
	Thu, 20 Jun 2013 21:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dCU/xY3xXUymti0tbk8DrvbD+x8=; b=D8+QRB
	l0vRbHhFoDeb5keQ+l7KLoRJpLo7938DarZv+TWeZPM+Ak6+z+pxiD5cUmIaN5tZ
	P8n03ryrBOt39xsHHBuPXOuPlpiCPgul3RpmYPju1ipRy/UrI2UqDuCOPGt3+KQ9
	5uufBJalWOtGzlAlpeavVAq0p90H75FL/w6nY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gRlFbWx2Is6pvsbbmImKOgAJ2tWbmdxK
	RBCDZrKUY6Z2yTpECQQ7xN26StedFCHx2rWtKX1kVpp9dR38LaDDUAePzY7ad7U3
	1LOmd2CyRcNeBFXrCt+YLk1A7bqQKnpahtCjCasFDXc4vIKCo4R/BD0CfOd5wj+j
	F38tf7mG44Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BC7229976;
	Thu, 20 Jun 2013 21:45:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6B9C29974;
	Thu, 20 Jun 2013 21:45:05 +0000 (UTC)
In-Reply-To: <20130620205533.GA8074@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 20 Jun 2013 16:55:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC1F4D7C-D9F2-11E2-82F4-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228544>

Jeff King <peff@peff.net> writes:

> I think I got us off-track with my expectation of ending the one case
> with a conflicted index. But caring about that is even more unlikely.  I
> think Thomas's original patch is probably a happy medium.

OK, so should I consider it Reviewed-by: peff?

> As an orthogonal matter, we probably should reverse the order of
> updating HEAD and the index/working tree, as it does not make much sense
> to me to do the former if the latter is not possible (and that is the
> case even with the current code).

Yes.
