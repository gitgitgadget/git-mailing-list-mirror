From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 30 Jan 2013 07:57:29 -0800
Message-ID: <7v7gmumzo6.fsf@alter.siamese.dyndns.org>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 16:57:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0a2s-0007o3-Di
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 16:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab3A3P5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 10:57:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42197 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733Ab3A3P5b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 10:57:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 860C6B66A;
	Wed, 30 Jan 2013 10:57:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IRkicqg3xwq024BYbKWEnnHK+rs=; b=Gccb+N
	SouO6lSx6fy/8EDs/4wfQQS5+PjJwLFUI960jvC/6GIsrMkF/NzU5y/G5u5gKnx/
	oqk6MtXBleQ3HRV3Za5rz66Vl9xO5RsTAizSdivGfuVNqGSoT3es+2kvE5ayWcoq
	fLEigURwUo2za32uwORTs5XRfMUljsCJVgyME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GtYDZBuGOlCYjjROnoAv4ok2sbq/6XDx
	0F+i3ksssH61WARXlcfnVdrZCun6BMO9mFQL2AlIoHY2aOWzyQNwLM/1XGk58UZQ
	B15s473c2Z6QOrixRDv8s7GcOxomfQc5GHLYoUHWR2g1ne3D7ZwP/tm14TlMjmze
	dkDxsQUBA14=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79383B669;
	Wed, 30 Jan 2013 10:57:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F19ACB663; Wed, 30 Jan 2013
 10:57:30 -0500 (EST)
In-Reply-To: <20130130074306.GA17868@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 Jan 2013 02:43:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0E02554-6AF5-11E2-A12A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215027>

Jeff King <peff@peff.net> writes:

> But it would probably make sense for send-email to support the existing
> git-credential subsystem, so that it can take advantage of secure
> system-specific storage. And that is where we should be pointing new
> users. I think contrib/mw-to-git even has credential support written in
> perl, so it would just need to be factored out to Git.pm.

Yeah, that sounds like a neat idea.
