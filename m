From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] better document 'interactive.singlekey' and
 '--patch'
Date: Thu, 05 May 2011 12:16:00 -0700
Message-ID: <7vbozh6jrj.fsf@alter.siamese.dyndns.org>
References: <7vbozjipmp.fsf@alter.siamese.dyndns.org>
 <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git-List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Valentin Haenel <valentin.haenel@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 05 21:16:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI428-0004Wb-1V
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab1EETQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 15:16:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab1EETQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 15:16:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B114E46C1;
	Thu,  5 May 2011 15:18:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y9jOL+UIIuhQPzS+FmGBacUxHXA=; b=pTkKAS
	RQrND0vD3SzFOIIS/VK+O5veT09KtTKziG+VSEv7AiKzVEXqQM8OVaFUsXSaP+Xo
	6kt3AHf9G71Yeds7arBAU3VALsq8KWttDvTS4YRXzsBLc626KQOo/x3Aoy0eeA/R
	kJtMQSp/fe2WmbD3T0DPME6Tc22EI3hCm0td0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sRVJmBl5g60mmFKIdM31HWU+guAJlqAd
	I6dW06bKzvCd671WCJgcVk9A4YWisH3IRqJya6bgUglkyBkiwCMZrB0t3fuwwebJ
	zM3E+W5U+H3vy5umOxiU28jCh06bLuDXJoeuKP3EpS7c5wNzcNlzW6xb5K3qlnJa
	CdHkbsJKhjw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 695C446B5;
	Thu,  5 May 2011 15:18:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 07A4C46B4; Thu,  5 May 2011
 15:18:05 -0400 (EDT)
In-Reply-To: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
 (Valentin Haenel's message of "Thu, 5 May 2011 20:47:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AC2AE4C-774C-11E0-849C-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172885>

Valentin Haenel <valentin.haenel@gmx.de> writes:

> Note that the first patch is already included in pu (93556471), but I
> included it here again since its part of the series. Is that the right
> thing to do, or could I have dropped it?

To me it does not make much of a difference either way.

I usually try to apply a rerolled series at the same fork point as the
previous round, and discard the earlier ones after verifying if they are
identical between the two rounds (both trees and log message wording).  It
becomes irritating when the changes I find in this process only reverts
what I fixed-up when I queued the previous round, but on the other hand,
a complete re-send will give the patch a new chance to be reviewed by
different people, so...
