From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Prebuilt man pages on Google code
Date: Tue, 18 Dec 2012 15:03:07 -0800
Message-ID: <7vhanjdkus.fsf@alter.siamese.dyndns.org>
References: <20121216162827.GA22351@river.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Dec 19 00:03:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl6C8-0003lE-N4
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 00:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab2LRXDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 18:03:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63316 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab2LRXDK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 18:03:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD6F2A96D;
	Tue, 18 Dec 2012 18:03:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MZm94acITcJDtu7OirjVja5m9Gc=; b=CQzgDG
	q4HWvDh5q3kQ6PJrHxNGMYIWhxoIqCtNavPzeNsyKFTYahPtdk+zAv+UGGrABKK2
	soEPzLhOh7vIbxkYmpT/8ypLaqG6kWQAq2yBkHpKjNKPIgiN2abOD5mpxQZs1iDT
	5dBkhK1z4KoeRHGU7bwV74quU4rJhKbz7V7yY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yi4yPsz3+By3JtLiehTMEcJsqHqzuu0+
	434OAG1JE1GKHGv8QDNn8bSl5zhMnRu1i3zUos6h0QW1dPT/gu2lCe2y0cVdgCEo
	ZS+7jfZLKc7IzS/nvMQb2C5NGzfsCjsBjq4t80DiOEJVek14hYjrGqAkrtrn6dvS
	PKXcKbEIX4E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C3A1A96C;
	Tue, 18 Dec 2012 18:03:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19AFAA96B; Tue, 18 Dec 2012
 18:03:09 -0500 (EST)
In-Reply-To: <20121216162827.GA22351@river.lan> (John Keeping's message of
 "Sun, 16 Dec 2012 16:28:27 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1703E912-4967-11E2-BFCF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211794>

John Keeping <john@keeping.me.uk> writes:

> While investigating Asciidoc's quoting in this thread [1], I noticed
> that my system man pages don't display Asciidoc double quoted text
> correctly.
> ...
> I can't see any configuration option that could cause this difference,
> so I assume it must be caused by some particular tool version on the
> machine used to generate these man pages.

Yeah, Debian ships with a tad older one, and I've been using
asciidoc 8.5.2 on my primary box.

I'm experimenting a newer one from the latest tarball (asciidoc
8.6.8) and the result looks promising.  If everything goes smoothly,
I'll probably do another -rc before the final 1.8.1 release goes out
with the new asciidoc, but no promises (yet).

Thanks.
