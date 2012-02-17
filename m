From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] api-config documentation leftovers
Date: Fri, 17 Feb 2012 09:04:25 -0800
Message-ID: <7v1uptv1ba.fsf@alter.siamese.dyndns.org>
References: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
 <20120214214729.GA24711@sigill.intra.peff.net>
 <7vmx8l5aw3.fsf@alter.siamese.dyndns.org>
 <20120214220953.GC24802@sigill.intra.peff.net>
 <20120216080102.GA11793@sigill.intra.peff.net>
 <7v1upuzgfr.fsf@alter.siamese.dyndns.org>
 <20120217001438.GD4756@sigill.intra.peff.net>
 <7vty2quq9r.fsf@alter.siamese.dyndns.org>
 <20120217031723.GA5738@sigill.intra.peff.net>
 <20120217032325.GB5738@sigill.intra.peff.net>
 <20120217081743.GA11389@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 17 18:04:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyREW-0002YR-1G
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 18:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608Ab2BQRE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 12:04:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab2BQRE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 12:04:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C44D078D5;
	Fri, 17 Feb 2012 12:04:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oZ+phr/Mch3Csp6cT+Gpq2Sxf8A=; b=wf1YiP
	HY7W6F/B1dndl0l5fOX5DATDRd4kJ1An9HA40HWa5pNtUagah2gsEbwisbFJNklZ
	kmqsXS40++H3hiXms7GlD+zMjNBn2vcA5sbL+p+uc6vYAa8CfBMFhHoUwGVdWsB4
	weKbL+2kLE5amVmBLSBzijPI6aEBuMezDB5b8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xd2jHSG/kto9UUWMOkq9mzmf57+ZfKD3
	RcwIYHoTPh3uzKvcfS56TGtRCHncRw2c1b/8grAAqCHsJIBqnMrd0X4QGOkFQMn4
	MmyGsD7Bg+GyUlQ//8fZ8qvO0tA8UCQVbUVqJuXlgBQikixPvlynIyJVweCV+cMq
	FPNWlI/EyRc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB48278D4;
	Fri, 17 Feb 2012 12:04:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50C7F78D3; Fri, 17 Feb 2012
 12:04:26 -0500 (EST)
In-Reply-To: <20120217081743.GA11389@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 17 Feb 2012 03:17:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7273D5CE-5989-11E1-A849-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190964>

Jeff King <peff@peff.net> writes:

> Here they are, on top of what you have in jk/config-include. Squashing
> would involve breaking apart the second one into the "introduce
> git_config_with_options" part and the "and now it learns
> respect_includes" part. So it's probably not worth the effort.
>
>   [1/2]: docs/api-config: minor clarifications
>   [2/2]: docs/api-config: describe git_config_with_options

Thanks.
