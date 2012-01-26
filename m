From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: minor grammar fixes for v1.7.9 release notes
Date: Thu, 26 Jan 2012 11:15:08 -0800
Message-ID: <7vwr8e2s3n.fsf@alter.siamese.dyndns.org>
References: <20120125222002.GA6309@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 26 20:15:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqUn1-00021t-SP
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 20:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab2AZTPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 14:15:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37806 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410Ab2AZTPL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 14:15:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F3B84CF7;
	Thu, 26 Jan 2012 14:15:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E+5VF7hH+11V+XfZw/ri3LKSEgM=; b=f4x6HU
	M8c0LKypNJfSEuK6kM5B25WddCgVTxdmnz14xQ1gjDNNNErxPbLPI+1VOLkLMXCz
	OlFvaOeKcy9Rzc5VaJDUiLuQhp/p9dDFzUaqd3oWl4Li+aSCF7m3goxH3ndGpjsC
	5YwIG8nO3hSLbYz96L0wjhGKoOxmpqNubWKwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n6XH5hJgrB1xevfg3IzRMQDafEVqkqEO
	h5WEmVply8s+5qbx8K7X6rYukY02zxXyoiQKYKwj6ieBPzkMc4SRPMX9fu1m1DsO
	5mhXUWoaWLQsnEXZpPjScS3dMApwGgKwcog1gGGmlO581sbo8wJHzzoIHA0URaPG
	IUnIR2+AXgo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 376284CF6;
	Thu, 26 Jan 2012 14:15:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1E504CF5; Thu, 26 Jan 2012
 14:15:09 -0500 (EST)
In-Reply-To: <20120125222002.GA6309@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 25 Jan 2012 17:20:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 106EE9D8-4852-11E1-803F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189160>

Jeff King <peff@peff.net> writes:

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Easier to view with --color-words, of course.

Thanks ;-)

> ... (I notice you mostly include features and not bug-fixes, which I
> assume is to keep the list to a readable length).

Actually my intention regarding fixes are:

 - never mention follow-up fixes to new topics merged since v1.7.8 at all;

 - omit mentioning trivial fixes that not many people would be bitten by
   and actually be hurt in real life (i.e. typo in an error message); and

 - make sure as many fixes are covered in "Fixes since v1.7.8" section.

So "keep the list short" is only one-third of the motivation.
