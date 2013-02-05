From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Tue, 05 Feb 2013 08:18:10 -0800
Message-ID: <7vr4kuu43h.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vd2wf1yex.fsf@alter.siamese.dyndns.org>
 <87bobzslke.fsf@lifelogs.com> <7vy5f3zlzj.fsf@alter.siamese.dyndns.org>
 <87zjzjr5y4.fsf@lifelogs.com> <7vmwvjzkcs.fsf@alter.siamese.dyndns.org>
 <87sj5ariar.fsf@lifelogs.com> <7v7gmmvj5p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 17:18:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2lEE-00084x-OR
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 17:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274Ab3BEQSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 11:18:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49941 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab3BEQSN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 11:18:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08469B5FF;
	Tue,  5 Feb 2013 11:18:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+x/Hlzjm+ZfmWK1o0JeURfzKoSY=; b=DNOD+Z
	G/6SI998xmkENsBwHQFvlU0925s6vHaltggF7WpSz1ShotUU+PKF1SMFlFaLH4Kn
	mSd3nFzYTfaE71yyBTyeeOk0NNXYdpAHEFOmP/6gwme7iOgwVZiakBP+4BekUOOv
	q1RZhSnBs3SbLKn5lSMVbq9KBXpjT+0y1WWT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WgBb++Jq0iG63yU/kKIXKT6zb8H+b4PU
	YWWbDO8pdVmy7j+JnR1xr++PYZ6DF6MiVu5k+/N7TwjIw+7Vv9MgeMAinXVudV5u
	VQrwU9L5Wb6iDXwy0N6tocnDGarexFv8AKZ3DuQuhNeo9xc5qMAKkcKlCdMHZ8vG
	OVGCHIwM5Fw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF576B5FE;
	Tue,  5 Feb 2013 11:18:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71804B5FA; Tue,  5 Feb 2013
 11:18:12 -0500 (EST)
In-Reply-To: <7v7gmmvj5p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 05 Feb 2013 08:07:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3547530-6FAF-11E2-9294-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215514>

Junio C Hamano <gitster@pobox.com> writes:

> I thought I've given a more concrete outline than "I'll read
> Net::Netrc and do whatever I think it does" in a separate message.

And it turns out that the message was sitting in my outbox.  Sorry.

I just told the outbox to send it out.
