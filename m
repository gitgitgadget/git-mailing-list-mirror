From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] test output: respect $TEST_OUTPUT_DIRECTORY
Date: Mon, 29 Apr 2013 11:27:22 -0700
Message-ID: <7vsj29i451.fsf@alter.siamese.dyndns.org>
References: <7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
	<7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
	<47c9ba4200a22e865040208628357d9bc4bcf3f4.1367002553.git.john@keeping.me.uk>
	<87fvy9dxok.fsf@hexa.v.cablecom.net>
	<7vwqrli4mb.fsf@alter.siamese.dyndns.org>
	<20130429181950.GM472@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:27:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWsnS-00083F-99
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab3D2S1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:27:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757302Ab3D2S1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:27:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EBD31AA52;
	Mon, 29 Apr 2013 18:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bw2C95u6Dr/Jvbh3GWn5gnRlgI0=; b=RIKwqb
	L0bRuNuBNlwCCV9RiOqFC/mFQhxx9IoFQiRnMa9yAm1aj+ryp4AFuq6/AFGeloLP
	2Lur6RKw4WSaWjKQOweEZw8OrMY7aHTqYXaQK6FCVzCZDV5nn+WXt+FXl4xL87EI
	pv+DoRMBrHIWrQ5p//wLAI7+mbb9sWntTZ/iI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NrOpN4RsoMy62z2ahOO8MfomGK4Y3r+2
	lj9x9SoDVdOYBT++m405dAZHrUnmnK/f9eqxrrOvhrSMVHnRVkN/Qj+fEBITdtTf
	A957lHOXOVKVm1G6b46yaU2HPF9a7XpxVpKmPKtigLzqSsg6HqTmz6YwftCiAkQs
	vYhCFJT7iCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92C511AA50;
	Mon, 29 Apr 2013 18:27:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1493B1AA4E;
	Mon, 29 Apr 2013 18:27:24 +0000 (UTC)
In-Reply-To: <20130429181950.GM472@serenity.lan> (John Keeping's message of
	"Mon, 29 Apr 2013 19:19:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FFD9EAA-B0FA-11E2-9D9A-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222841>

John Keeping <john@keeping.me.uk> writes:

> This is identical to the interdiff of what I posted at the same time, so
> it obviously looks good to me.

Thanks.  I've replaced the old tip with your version.
