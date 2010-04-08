From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-remote: default to 'origin' when no remote specified
Date: Wed, 07 Apr 2010 23:44:08 -0700
Message-ID: <7vsk7678av.fsf@alter.siamese.dyndns.org>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
 <20100408044552.GA30473@coredump.intra.peff.net>
 <l2xbe6fef0d1004072307ma8dff5c2ic5dce170b28e5957@mail.gmail.com>
 <20100408063422.GD30473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 08:44:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzlTW-00071A-5l
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757004Ab0DHGoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 02:44:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab0DHGoT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 02:44:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2886A9C4E;
	Thu,  8 Apr 2010 02:44:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1aPDCjhl/+0Kqt//ZoXSiuWUcoM=; b=RrNiYe
	qMR5nIPel3LHI7dMVW9K5x/YD/X5kLp0gNjNGkTiIJ52FKA1ygeFjz9UcYxgeqtw
	drJWuF/rbJC9klRnxe30WvTkzwVfzXhmWfOBXjERm7D3tHOLIESKv4rKbQexD0HO
	42V14AoyQCDkqCqt+5u23p6jLDBqh6FheiViM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dYsfJDsHk4Pv3+vY9r5kn7CV2hr03/cR
	WUK2k+NYGQRG5srqus/f/xyN2NCyWG/RP7hIHcc80zm80pAFsHe/CXvbFjA6g6So
	JN41/4VdnZU54/1sVOdzkXCM564gk/y3mxGWgpzDUvdJ4zuXoDqJA0OLr/c+A3wM
	4dPpB1uJwXc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 40EEEA9C4C;
	Thu,  8 Apr 2010 02:44:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC57FA9C4B; Thu,  8 Apr
 2010 02:44:10 -0400 (EDT)
In-Reply-To: <20100408063422.GD30473@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 8 Apr 2010 02\:34\:22 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 25B843A4-42DA-11DF-8C1B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144327>

Jeff King <peff@peff.net> writes:

> Fetch's message is equally hard to trigger, I think, which is perhaps
> why nobody has complained about it yet.

See http://thread.gmane.org/gmane.comp.version-control.git/143229/focus=143404

;-)
