From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Provide some linguistic guidance for the documentation.
Date: Thu, 01 Aug 2013 11:21:06 -0700
Message-ID: <7vfvuts25p.fsf@alter.siamese.dyndns.org>
References: <1375197114-10742-1-git-send-email-marcnarc@xiplink.com>
	<1375369825-28636-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 20:21:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4xUx-0007La-3C
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 20:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab3HASVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 14:21:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab3HASVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 14:21:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DC7F350D2;
	Thu,  1 Aug 2013 18:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lzRNQ/OW5OfWPLQXIiO6lEqWKqk=; b=CcIC1A
	3ZTA3ZPvotioGiu6xGMIrhDx666uc+xVQ9XmDvfWEiNvF0KHaRBGG8UnNF5T83IW
	vwwy99yGJx24igdE1REIGsnf9zXnctZBkSu91AK1z3F1oQKO10SsbcHPr4vFuodU
	FfzzG4914b17JpS9iWyLyQASJE/9KiymKDlJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MCJAEVCUHC3ixqYyaF27bwZPE+mEA2lb
	E0Xq5R4/IC3RJjQMQYpz2sNu3fZWMwQNwoytEDj5iLDAWlPvgLzrACpuKZRbcKqz
	wzE+rHHmKKeg+kWOnfSh7ZWKVzuly7FqBl05M35Ivdgz3SB3ER+eRxgLSbzG3EfF
	2P9r7HH3MaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 619A3350D1;
	Thu,  1 Aug 2013 18:21:08 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4B08350CF;
	Thu,  1 Aug 2013 18:21:07 +0000 (UTC)
In-Reply-To: <1375369825-28636-1-git-send-email-marcnarc@xiplink.com> (Marc
	Branchaud's message of "Thu, 1 Aug 2013 11:10:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 226A66B0-FAD7-11E2-AC9A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231497>

Marc Branchaud <marcnarc@xiplink.com> writes:

> + The documentation generally follows US English (en_US) norms for spelling
> + and grammar, although most spelling variations are tolerated.  Just avoid
> + mixing styles when updating existing text.  If you wish to correct the
> + English of some of the existing documentation, please see the documentation-
> + related advice in the Documentation/SubmittingPatches file.

Is that accurate?  My impression has been:

    The documentation liberally mixes US and UK English (en_US/UK)
    norms for spelling and grammar, which is somewhat unfortunate.
    In an ideal world, it would have been better if it consistently
    used only one and not the other, and we would have picked en_US.

    A huge patch that touches the files all over the place only to
    correct the inconsistency is not welcome, though.  Potential
    clashes with other changes that can result from such a patch is
    simply not worth it.  What we would want is to gradually convert
    them, with small and easily digestable patches, as a side effect
    of doing some other _real_ work in the vicinity (e.g. rewriting
    a paragraph to clarify, while turning en_UK spelling to en_US).
