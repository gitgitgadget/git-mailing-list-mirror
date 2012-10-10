From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout error
Date: Wed, 10 Oct 2012 00:40:59 -0700
Message-ID: <7vpq4qdbas.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9DUEL_J3MmH_4k7NC82m+crpCf1r3NS3gQBMZy+kvY3-A@mail.gmail.com>
 <m2lifg7zsj.fsf@igel.home>
 <CAB9Jk9CZ8d=8ugYs7XHXs84Kj9xJmTHZyZ2J0hU66OBS7YDZTg@mail.gmail.com>
 <7v626jdx8f.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9AFnauxX0dk8LfpBkpGDSWpWhqnzVew1Eo51K+qEA680A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 09:41:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLqup-0001Wd-MT
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 09:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab2JJHlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 03:41:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245Ab2JJHlD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 03:41:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F9226ABB;
	Wed, 10 Oct 2012 03:41:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XCYr1Zicwy3xKpNMcXPXS/tTJ4U=; b=q0F5Ne
	4xh8k39ISTFvs3NQlni6hfqQem2A0+ZdQM0cAcof39WYL3PCMK9EfWREFF0PTZB3
	aLsYSfm5Vp/GcFYUVV061dc+kLiq1RzPTbZ5Z9mVWs5OSfp/9npu21O4X8GimezH
	+WvnChCYJmhsWkSeLrXIjveoohyyY8TNHbm6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g1eKA5TPaSOlGfFkWQKqkbk5PUAFa+2J
	hj5J9+gFypLz/NMzsTbz+Hq6yMYdi5BSXDmY4yb8t48GmJp+Hns7EwG2nXlZZ4dU
	8reCvUxgT3BLXeEquNp6Lp2F0MnpF7IrcID0r+M7z0m742eow2rM+0pk3K+cgIFh
	1sVMok9UJ3E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F181D6AB0;
	Wed, 10 Oct 2012 03:41:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61E4B6AAF; Wed, 10 Oct 2012
 03:41:01 -0400 (EDT)
In-Reply-To: <CAB9Jk9AFnauxX0dk8LfpBkpGDSWpWhqnzVew1Eo51K+qEA680A@mail.gmail.com> (Angelo
 Borsotti's message of "Wed, 10 Oct 2012 09:02:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6A18C20-12AD-11E2-A07A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207371>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> Why it is so difficult to convince people to make documentation better?

It is not difficult.  The discussion on this list is usually done
via patches, and without one, constant talking is buried in other
noise and often go unnoticed.

There is however an issue about documentation consistency.  Do we
use elsewhere ( A | B | C ... ) to denote "You must write one (and
only one) among A, B, C, ..." consistently in the documentation?

An ancient discussion $gmane/72243 might be of interest to kickstart
such a documentation clean-up effort.
