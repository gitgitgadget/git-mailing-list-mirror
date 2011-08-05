From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: quote paths in output
Date: Fri, 05 Aug 2011 15:55:19 -0700
Message-ID: <7v4o1v31uw.fsf@alter.siamese.dyndns.org>
References: <20110805105526.GA22480@sigill.intra.peff.net>
 <4E3BD006.6010005@viscovery.net>
 <20110805223622.GA5808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	James Gregory <j.gregory@epigenesys.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 06 00:55:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpTIe-00006Y-1T
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 00:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab1HEWzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 18:55:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755650Ab1HEWzW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 18:55:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFBC84DC9;
	Fri,  5 Aug 2011 18:55:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a6Sema0q7U0lyX6c7iEnJOMvUSs=; b=YxLEZO
	ZGefS7hwhXQWwTBsyeOdfFs5xHmT4htEHf6S09tPD8wAqb720rV61E4sRrXc/r2/
	Dm5bBMzXxpqtqHG4EiqweyjET63qgcL/VaPnlJjnwAWCwqkP9oHCENb1tWLwEEBL
	uTYhszFD8ykKwcXP7kEquHhjpS4dngJSa5HuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KYO7ZG6w7+nxVfcI+WeTgfICk/c5pm6A
	JxxOz1QPL2Jf9b8zcAzevr0fHq1a9XP6CgqtLz84zgbgJhn+9n/jgme8rfTGHkAp
	y5Lhssw3PVtTgrAlYbp3h5YYwep0biFSXFkbUL+IP1zAlqZrZKDlMPnjusRYzuGw
	fUBoq/GOeac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D621A4DC8;
	Fri,  5 Aug 2011 18:55:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AAE14DC7; Fri,  5 Aug 2011
 18:55:21 -0400 (EDT)
In-Reply-To: <20110805223622.GA5808@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 5 Aug 2011 16:36:22 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF4F52A2-BFB5-11E0-84E4-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178817>

Jeff King <peff@peff.net> writes:

> +	 git read-tree --empty &&

Hmmmm, this adds more work to the backporting of this fix.
