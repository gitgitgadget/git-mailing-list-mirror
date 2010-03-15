From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-filter-branch.txt: mention absolute path for scripts
 in --tree-filter
Date: Mon, 15 Mar 2010 10:14:19 -0700
Message-ID: <7viq8xse1g.fsf@alter.siamese.dyndns.org>
References: <87vdcy7zyu.fsf@jondo.cante.net> <4B9DFE36.3010707@viscovery.net>
 <87k4td95xm.fsf@jondo.cante.net> <4B9E20BD.3090705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 15 18:15:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrDsZ-00049n-Te
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965507Ab0CORO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 13:14:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965514Ab0CORO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 13:14:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E900A2620;
	Mon, 15 Mar 2010 13:14:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=c4amEeeEg/Q9ghEJKBhMwFNb7Z0=; b=B6fLHPCsUAlvyQXIWt7p+A3
	YqDpbpnoz09VnkF/X5qPT+26jl64wbTkgFGsqwCtYSsmgBlFVlHfmBLTa5PuyMnM
	h0HsFM9aitJRlrglyDuI2T6kXi1kZuaf9F3TB/2LnBTZ+9UcNfIFRPK9+7K51oUD
	8MkvRXZkCWylPisKDUoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mhyLtrv6xEjbSHR6OFGDPPGtXyeSBJmKC7p2Ar+lzvAw+5PXn
	j/8TcXTGmd7GKSOIR39++zGtWV1mDfq1QVTnkv3vqiSj3bf4KmFvUhNgNPMHH/kp
	2TS5P48FcSIqkoCy5j2NqEuOnRX0K+QGqllPyR277rrtdK8dTpt6u3s3A0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CEA3A2615;
	Mon, 15 Mar 2010 13:14:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95EAFA2613; Mon, 15 Mar
 2010 13:14:20 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 33FFFDBC-3056-11DF-9C03-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142226>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Jari Aalto schrieb:
>> J6t:
>>> But doesn't the recommendation to use absolute paths apply not only to
>>> --tree-filters, but
>>> ...
>> I don't know.
>
> It was a rethoric question. The hint about paths to files outside the
> working directory should go to the general description of filters.

It is a good point.

Do people involved in filter-branch feel the implementation/interface is
stable enough these days to allow us to add this to the first paragraph of
the "Filters" description in the documentation?  It currently talks about
the environment variables exported for the use of filter programs, and "In
which directory will my filter run? --- I need to know it when I want to
reference filesystem entities using relative paths in my filter." would
fit well.
