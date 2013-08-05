From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git_mkstemps: improve test suite test
Date: Mon, 05 Aug 2013 09:21:49 -0700
Message-ID: <7vr4e8m7ky.fsf@alter.siamese.dyndns.org>
References: <201308030027.r730RNWS022924@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Mon Aug 05 18:22:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6NY1-0003px-8o
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 18:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab3HEQV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 12:21:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42139 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753506Ab3HEQV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 12:21:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D52DF3654B;
	Mon,  5 Aug 2013 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qdTnW3Qz4tw1EsrqUQO57zM0dvA=; b=MG7xiL
	fAh3HLUVTzUcE5X7jdsuBklnkVB3wszIFuq3So8wK/jHUb7rhpb9SiXPEawrjUYX
	TeYw9a/XqPbX3/ZVu9MkOTov2/LDfkINbQCmB4KswmRzco7G6vtSKBIE+4WCOg/B
	sdt3+z36tFn9c9ZC6UkfglU7nVC618bVmQ2GE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tm779CiKcVJmB5/6aRz4mkizOxkev8Ka
	yfjg9fupv9avm5JOWrjtjO5HTWhrEOD0Ju9k2/nbhKL3ogghBg9KUkL/4oOtsOym
	hALKNOeJ8PMNFkyh9VEnHbhC1RtSmEaN8jQ8HNcoc+kXEmdB7RsDz8A1jRn83OVb
	ysz1fleR2T0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7A853654A;
	Mon,  5 Aug 2013 16:21:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A71F36548;
	Mon,  5 Aug 2013 16:21:51 +0000 (UTC)
In-Reply-To: <201308030027.r730RNWS022924@freeze.ariadne.com> (Dale
	R. Worley's message of "Fri, 2 Aug 2013 20:27:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2275F3CE-FDEB-11E2-B397-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231671>

worley@alum.mit.edu (Dale R. Worley) writes:

> Commit 52749 fixes a bug regarding testing the return of an open()
> call for success/failure.  Improve the testsuite test for that fix by
> removing the helper program 'test-close-fd-0' and replacing it with
> the shell redirection '<&-'.  (The redirection is Posix, so it should
> be portable.)
>
> Signed-off-by: Dale Worley <worley@ariadne.com>
> ---

Sorry, but I have no idea what commit you are talking about, and as
far as I can see there is no such file test-close-fd-0.c in my tree.

Puzzled...

>  Makefile          |    1 -
>  test-close-fd-0.c |   14 --------------
>  2 files changed, 0 insertions(+), 15 deletions(-)
>  delete mode 100644 test-close-fd-0.c
