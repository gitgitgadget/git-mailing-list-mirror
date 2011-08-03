From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitattributes: Clarify discussion of attribute
 macros
Date: Wed, 03 Aug 2011 14:40:19 -0700
Message-ID: <7v1ux2b2d8.fsf@alter.siamese.dyndns.org>
References: <1312378890-31703-1-git-send-email-mhagger@alum.mit.edu>
 <1312378890-31703-2-git-send-email-mhagger@alum.mit.edu>
 <20110803194632.GB23848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 03 23:40:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojAx-0007S6-DU
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab1HCVkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 17:40:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926Ab1HCVkW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 17:40:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73FD04298;
	Wed,  3 Aug 2011 17:40:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7/2fQbB0Zn2l11DicHdgvWDl0yc=; b=JRwVRe
	O891RY9qoa6RyYwymTATF5mdp+5Ajwh7Q+7PczNuOqizWzHnGFm/3LRZlpAwYBt/
	ORUnLHFDVOUy/2s54AvCqMqfpLViyy9eJOb/h9xvQPxV3Yq7jMAFaWgI4MfgVBc9
	QBj6ICVFZOhK9nrHS0EcWV+FmvFhGoUj3TyJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dg4iLQSlhfArcaBgVVJLnpGYKCQDUdDV
	OXmID8VsBqd76MIAdo9MbsCtaGeYFCTgECNXoX3RQm4MhEzLXxD8MwGOnGlkEIV2
	HeUyO6Li6d7HXr+jYZJOWK7CxX61e1Ikfre/XcukC39plmPdYt/jhCngE3xr4gM2
	0JjxNycE3v0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ACDC4297;
	Wed,  3 Aug 2011 17:40:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F39B44296; Wed,  3 Aug 2011
 17:40:20 -0400 (EDT)
In-Reply-To: <20110803194632.GB23848@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 3 Aug 2011 13:46:32 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30031328-BE19-11E0-AC29-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178625>

Jeff King <peff@peff.net> writes:

> I don't know if that was intentional, or if the behavior is simply
> accidental and the original code was simply never meant to have
> "-binary" called at all.

The latter. You were never expected to say -macro at all.
