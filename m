From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Thu, 21 Nov 2013 11:44:48 -0800
Message-ID: <xmqqhab54k0f.fsf@gitster.dls.corp.google.com>
References: <20131120203350.GA31139@kitenet.net>
	<20131120213348.GA29004@sigill.intra.peff.net>
	<20131120222805.GC26468@kitenet.net>
	<20131121114157.GA7171@sigill.intra.peff.net>
	<20131121114837.GB7171@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 21 20:45:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjaBS-0005u4-Et
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 20:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214Ab3KUTo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 14:44:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49323 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406Ab3KUTo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 14:44:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B737544EA;
	Thu, 21 Nov 2013 14:44:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RMmMoHlNVvBlXKLnjD5BuMYqAVc=; b=dvqw7L
	plRJQi76o9cL4LIOu7qsU4hd8u8igyVksCdS3bG9L0cg0YNIzMyJue1fe5aWSmqV
	S6vQPUhnwLcj6TB8eamSuPwnMrQl2bf1IhB2AiC35cYr1gkB2aGaI0wAB2Te4NTX
	eCXyF3NLYEaRy69Fvt0OthKyLHJUIfgMW4Z1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NcMy8wuD7xinsm6fbSTqQMWutSf+ASdL
	3DIvrLLVBwE3cROvd2CAtuuI1PuTCxirZY7ThxCEEN+iZqXHiKXcWMLzaMkU8zX/
	CtNYVpRPB+N2WyObl2m1cVsx0tF49AGh5bQ30B+dxklBes9yIag1srYdz+p8nIXw
	JBIwwdQxmiU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64CC1544E9;
	Thu, 21 Nov 2013 14:44:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 417CB544E0;
	Thu, 21 Nov 2013 14:44:51 -0500 (EST)
In-Reply-To: <20131121114837.GB7171@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 21 Nov 2013 06:48:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 62FA1F8E-52E5-11E3-AE6B-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238136>

Jeff King <peff@peff.net> writes:

> We could try to improve the heuristic to err on the side of
> normal objects in the face of corruption, but there is
> really little point. The experimental format is long-dead,
> and was never enabled by default to begin with. We can
> instead simply remove it. The only affected repository would
> be one that explicitly set core.legacyheaders in 2007, and
> then never repacked in the intervening 6 years.

Sounds sensible.  Thanks.
