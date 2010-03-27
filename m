From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Fri, 26 Mar 2010 18:09:32 -0700
Message-ID: <7v39zm7epf.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
 <20100326124650.GA12215@coredump.intra.peff.net>
 <7vwrwykhee.fsf@alter.siamese.dyndns.org> <m239zmdcz5.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 02:09:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvKXF-000467-Pe
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 02:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab0C0BJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 21:09:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab0C0BJo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 21:09:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DB23A5599;
	Fri, 26 Mar 2010 21:09:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MtDs0a2XMk6Q1TeR/arr1lQnD84=; b=Uw9z0V
	umf3B9/A6pq+Feii9uj/Knk7KyFP9uo3/huxCmElrGzzL6KBFbB3zs2e26m/bid/
	2WugFWx+DHYaG2F240xMXiI2GQa6ylW+0LbbczjaipWn6l2JFxlKoI0fE2ymKZC+
	lP0w+iwkLDA0s+jliGvkFyQmtPyBhbmz2maDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r3/5LHWkwBRNlt70d6Uppk0tzGBFVwKx
	DVfnJFIY4syCqh5UpXnEKUUiRzrNwIGzoo4tAsIUoGH1efj9qoLacNtEPGeKaUgK
	lZW2rvyu3jBrc3hdYFBaLrV23Y+HCGl82JNrwEwPvryoQnH+iLxjgo03EQ4n+17J
	3UIGLpk5brk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 17F9DA5594;
	Fri, 26 Mar 2010 21:09:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEF45A558F; Fri, 26 Mar
 2010 21:09:33 -0400 (EDT)
In-Reply-To: <m239zmdcz5.fsf@gmail.com> (Francis Moreau's message of "Fri\,
 26 Mar 2010 21\:50\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6AB8BF7A-393D-11DF-8500-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143307>

Francis Moreau <francis.moro@gmail.com> writes:

>> and I often run "git grep -n" in that mode..
>
> I always need to pass the '--no-pager' switch: "git --no-pager grep -n"
> since git doesn't detect that its output is sent to a 'dumb' terminal.

Sorry, but as any self-respecting Emacs user would have PAGER set to cat
(and EDITOR set to emacsclient), I thought nobody would need --no-pager
;-)
