From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
Date: Tue, 07 May 2013 07:51:22 -0700
Message-ID: <7vy5bqlu6t.fsf@alter.siamese.dyndns.org>
References: <15tsj20cizd.fsf@tux.uio.no>
	<7vtxmgruhc.fsf@alter.siamese.dyndns.org>
	<vpq1u9kunba.fsf@grenoble-inp.fr>
	<7vwqrbmh4d.fsf@alter.siamese.dyndns.org>
	<vpq7gjbrzzz.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 07 16:51:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZjEp-0005cb-7t
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 16:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038Ab3EGOvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 10:51:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48195 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756141Ab3EGOvY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 10:51:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 375CE1C04A;
	Tue,  7 May 2013 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fMHgO86NoC3oUZKpPZ98tsap6/g=; b=uZ7BM+
	F4ncyL6oDeuQhfMuwA4XoYSGArlJzY8+/4F5XazHqKgEE6CsiBIHh9JNa+OtUnBk
	xO5S7FTOnvFJ1bWMSZeEwNQfOYSSz8EzRFBPGYYKqqYsJJwj38yVX/ObSfqRSldn
	tFy01ESMudm6eldco1nqOkT0Y4qBxWymYeFx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V6XqSUwgm2i9lmytPdZ+63D+chL+3I0y
	5BcyyTNNS75JvHK6INXhK3gILhbOkBywnyYQ9WbvWLHcrsbIFgkbZx/LoBqc1TyO
	gZUoRqGPDNPmD4Lh0tVW0INVQoSf3Q7jwowiDHBUhFzIT1Bi3SuMv2vxL2i+KGG1
	9SlSyXN8L4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B5561C049;
	Tue,  7 May 2013 14:51:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A61CC1C048;
	Tue,  7 May 2013 14:51:23 +0000 (UTC)
In-Reply-To: <vpq7gjbrzzz.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Tue, 07 May 2013 09:49:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 963E899A-B725-11E2-B64A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223575>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> OTOH, it's not urgent, people can already use git-multimail by taking it
> from GitHub.

Yes.  There are less and less reason to rush things into contrib/
these days, which is a very good thing from ecosystem's point of
view.  It is a sign that Git has matured that my tree no longer has
to be the promotion place for third-party add-ons.
