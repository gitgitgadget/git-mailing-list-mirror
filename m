From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Fri, 11 Jan 2013 15:54:58 -0800
Message-ID: <7vmwwf9sx9.fsf@alter.siamese.dyndns.org>
References: <A0DB01D693D8EF439496BC8B037A0AEF322039A7@xmb-rcd-x15.cisco.com>
 <20130111212325.GA18193@sigill.intra.peff.net>
 <CALWbr2xasF1y9j3G=-fQ9Wwg41Ymv=MMsWoqyuhweDov9KpRvg@mail.gmail.com>
 <7vy5fz9xdl.fsf@alter.siamese.dyndns.org>
 <CALWbr2wtAzz7yWb_Z_V0LFt5ddZcRSs7_rea2w=ghdC847mEyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"Matt Seitz \(matseitz\)" <matseitz@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 00:55:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtoRZ-0001jG-Uo
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 00:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132Ab3AKXzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 18:55:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55699 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754255Ab3AKXzB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 18:55:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CAC3BD4C;
	Fri, 11 Jan 2013 18:55:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KconwfDXTplg/wNuCsuGPnfMd9Y=; b=i6sYOf
	FtwymvRwzKzuaWsNfqOQXimr1+s7pGC5D1fChz4FyyGBJWfZKpIra1KGO+yyVhRi
	t0cptosvSnYkGKTe5X7NgCqcUPRrX8BELMTnLL8LrLWDBjiQFkhiyDWTwhCz+ric
	18eaePI/IH3Hl44iQO348PFAvcKSXIo4qXFWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GukPMyVMtkTte2nWBwn0Mxal6RrUb+nu
	MjkMxaHUe1/Z1pgx/ikoEtpguu+3cMWPqkfzZgPNilXz+TO95p1kGtVCxRqQTCmD
	WpD1FnbBsFtMFtsdesWbGqYbsBZZhCqPDzWDslyoNf4wKsP5AgAXYByUoGyaa65F
	6HQbct0qfhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E131BD4A;
	Fri, 11 Jan 2013 18:55:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CB9FBD48; Fri, 11 Jan 2013
 18:54:59 -0500 (EST)
In-Reply-To: <CALWbr2wtAzz7yWb_Z_V0LFt5ddZcRSs7_rea2w=ghdC847mEyQ@mail.gmail.com> (Antoine
 Pelisse's message of "Fri, 11 Jan 2013 23:42:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F35398A-5C4A-11E2-A922-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213252>

Antoine Pelisse <apelisse@gmail.com> writes:

> I would simply go for:
>
>   What Message-ID are you replying to (if any)?
>
> If I don't know what to answer, I would definitely not say y/yes/n/no,
> but press enter directly.

Sounds sensible (even though technically you reply to a message
that has that message ID, and not to a message ID ;-)).

Any better phrasing from others?  If not, I'd say we adopt this
text.

Thanks.
