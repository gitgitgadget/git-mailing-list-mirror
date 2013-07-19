From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Delete current branch
Date: Fri, 19 Jul 2013 12:15:08 -0700
Message-ID: <7vy592uzsz.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com>
	<7vr4euy4c6.fsf@alter.siamese.dyndns.org>
	<CALkWK0m-q=Aoof62zhXnUYsJ7PQZwTLbQ50BUEmufVO4gtWNUA@mail.gmail.com>
	<7vppuewl6h.fsf@alter.siamese.dyndns.org>
	<20130719170830.GD5999@euporie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Taylor Hedberg <tmhedberg@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 21:15:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0G9H-0001f2-KH
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 21:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761210Ab3GSTPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 15:15:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299Ab3GSTPU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 15:15:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C49B31BF4;
	Fri, 19 Jul 2013 19:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vhobgMpccOsRKk09bXtgDamB/24=; b=pCPAQ9
	ZBifOJDNMPuKRbOsJ20CrVtPyK8xCVDNrJeGkobMIrsXPtr62ivDSX5RFxGmjWI3
	nvJJbzs4cwyGRPy+QehiKACwkzoFJBuV7xf473IEbK1n/416z3fnNQreE7sIy2+J
	TMHnwQGfYsGKOQLhQmx62SaJ/uuR7QoPdVlgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g1qLQBX5k+8HzX6ux00HQdnDux+kSMlt
	hskQcbo/MxenEDnigChryseS96CXfJaqbPJ6mzN0KEVJ/GFuZ3YqXV4QzNGxgT8A
	UoxYj5szGC/8nhj3tcwt+vCXyATSXm1SPAIGnbRX5vNeDQGihOPfNDFbSLo96GLD
	CwPLE7gJdzg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80D6F31BF2;
	Fri, 19 Jul 2013 19:15:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEA4C31BEF;
	Fri, 19 Jul 2013 19:15:18 +0000 (UTC)
In-Reply-To: <20130719170830.GD5999@euporie> (Taylor Hedberg's message of
	"Fri, 19 Jul 2013 13:08:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CEF26C2-F0A7-11E2-B5CF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230840>

Taylor Hedberg <tmhedberg@gmail.com> writes:

> Junio C Hamano, Fri 2013-07-19 @ 09:48:06-0700:
>> But there is a very commonly accepted long tradition for "-" to mean
>> "read from the standard input", so we cannot reuse it to mean "the
>> branch I was previously on" for every command without first making
>> sure the command will never want to use "-" for the other common
>> purpose.
> ...
> What would it mean to check out the standard input, anyway?

That is my point exactly, isn't it?

You have to ask that question "What would it mean to do X on the
standard input?" for every operation X you might want to use the
short-cut "-" for.
