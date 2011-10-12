From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t1300: test mixed-case variable retrieval
Date: Wed, 12 Oct 2011 12:19:43 -0700
Message-ID: <7vpqi281bk.fsf@alter.siamese.dyndns.org>
References: <20111012182742.GA14543@sigill.intra.peff.net>
 <20111012183002.GB18948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:19:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE4LG-0000XU-O0
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 21:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab1JLTTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 15:19:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274Ab1JLTTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 15:19:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAB185131;
	Wed, 12 Oct 2011 15:19:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=vMNW6+qXFir/SqoIRGJWCQKRT7E=; b=LwNXc6lKZKFIYRahZQrB
	1Xx/eEMPUIlN1089KiyPGqcL2iYokM2S+fjvRGqVlwu9ivAQud14fJf9GzioBNcf
	rrjelfdqXeHeGlN18kO5XmtZIZdXYvscdp4NSLjFtjJjczC9mPZyzUW1b1njnI94
	KMarETr+SB5QyqpDpa/NCS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=rPShpSS8qCHYIbpHJ36xS5mJsif4DszQgB2/pobG7LrcKE
	1aZSQhqNxOis0YeCuDQUCXCPzpih7aBIdohOXbcubsWR9KHat2EoVohVwZPL9ei8
	9oMFdvSJW5hABwsBfCQI5ygk4sgR95u3fUKPMRraRpS++rS4WwVY0PISQYsfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A232C5130;
	Wed, 12 Oct 2011 15:19:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B798512F; Wed, 12 Oct 2011
 15:19:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24D3B12C-F507-11E0-92C3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183403>

Jeff King <peff@peff.net> writes:

> I was surprised this wasn't tested anywhere, but I couldn't find any
> such place. I think it makes sense to document the desired behavior in
> the form of a few tests.

Thanks. The patch looks good.

But oh boy the original test in the old style was ugly....
