From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: brush up obsolete bits of git-fsck manpage
Date: Fri, 16 Dec 2011 22:10:26 -0800
Message-ID: <7vbor7g23x.fsf@alter.siamese.dyndns.org>
References: <20111216113310.GA16601@sigill.intra.peff.net>
 <7vy5ucgsic.fsf@alter.siamese.dyndns.org>
 <20111217012811.GC20225@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 17 07:10:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbnU2-0000tA-Ha
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 07:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126Ab1LQGKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 01:10:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab1LQGKe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 01:10:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 817363FAC;
	Sat, 17 Dec 2011 01:10:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FOM2wp3O83zhaQgS8C+mTOYPWSM=; b=pBE5NP
	uXvs/Zh+IUgK8SQCwyymPL+qpkCppT9BT0K4nozqACzd3NQN793qWrXl3wQWrH9x
	TaPRVTa8T5iLeFWSHwJwnQWJwkzl9fpcYGbc1KcG85RXbmdYLPTB7YYmzfrwInVg
	N0J1QhCYZRB+JLnCBbvhjrZPQZGt3DdpP1lbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MSd1/sqU1h3bXhrCzwnCW3hq869JVkYx
	iw5btMCXKsGT6Wslp8xnMbGpntSzg1RmNRbjAtOSlyXLFkGPPLLtDAqSl7SCoNIA
	tRZC8uL49RUsmcNuWXhs8cGUwKaNgeWF6p+l5mc4dAYZMaqo3vU/bYeBFYBUaOy7
	tSRRt7mgHvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E02A3FAA;
	Sat, 17 Dec 2011 01:10:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CF803FA4; Sat, 17 Dec 2011
 01:10:31 -0500 (EST)
In-Reply-To: <20111217012811.GC20225@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 16 Dec 2011 20:28:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D325195E-2875-11E1-93E9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187350>

Jeff King <peff@peff.net> writes:

> Using "--patience", on the other hand, does find it as a common line,

Ahh, that must be it.  Thanks, and sorry for the noise.
