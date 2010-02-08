From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Mon, 08 Feb 2010 15:11:48 -0800
Message-ID: <7vmxzj726j.fsf@alter.siamese.dyndns.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org> <7vtytrih7b.fsf@alter.siamese.dyndns.org> <7vvde7h1mn.fsf@alter.siamese.dyndns.org> <20100208213256.GA470@coredump.intra.peff.net> <7viqa7cqs9.fsf@alter.siamese.dyndns.org> <20100208223107.GB21718@cthulhu> <7vpr4f9wey.fsf@alter.siamese.dyndns.org> <20100208231002.GA25729@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 00:12:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Necly-00063w-Rv
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 00:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764Ab0BHXL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 18:11:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab0BHXL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 18:11:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DE9E9835A;
	Mon,  8 Feb 2010 18:11:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3pO4tGLcXwRUkfbXFZK5PSgVqbU=; b=ohkLdt
	r4Yws2vpRlesstaICM4BZQjz2BTXGXg788PhCy4j6CBpJYrlo2ok+11wT4EgBLIa
	wvuJAJ2tCKZGimBZGj1qm7TKLSrNRnCtHC9XMJPiUame6q3Ree5YUwn+W2+ez7c0
	Oabs7k8MRWE1MHEBC00oJfzRS9jB7VixLdNe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UoYIsQ9VGIo/f73CBk8St6RvQKRXXzE+
	dGkWdg0ZHZNdFmi2EOTyHbMj5SPG/wdastaYjZq8KZUwEKgvxg+6u0i50ylGEplj
	DlJ7rwD36A98iQvouEB9ZxQSym/QBeTiTwyaEltyXZldbpA3sWZAxguhL5UJBhWY
	IjU5rHF/4Vs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BC4E98359;
	Mon,  8 Feb 2010 18:11:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B09C98355; Mon,  8 Feb
 2010 18:11:50 -0500 (EST)
In-Reply-To: <20100208231002.GA25729@cthulhu> (Larry D'Anna's message of
 "Mon\, 8 Feb 2010 18\:10\:02 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 594BBBB6-1507-11DF-967C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139335>

Larry D'Anna <larry@elder-gods.org> writes:

>> Is this documented anywhere?
>
> aparnetly not.  patch to follow.

Thanks.
