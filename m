From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Separate default push/pull?
Date: Thu, 11 Feb 2010 21:57:54 -0800
Message-ID: <7vvde3dmhp.fsf@alter.siamese.dyndns.org>
References: <m2zl3fg26j.fsf@boostpro.com>
 <a038bef51002111057l382ed55fy6b4042d1115a830c@mail.gmail.com>
 <20100212001417.GC21930@coredump.intra.peff.net>
 <7veikrl1m1.fsf@alter.siamese.dyndns.org>
 <20100212010549.GA23303@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 12 07:00:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfoZe-00014s-Hl
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 07:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394Ab0BLF6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 00:58:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab0BLF6J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 00:58:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD58B99C33;
	Fri, 12 Feb 2010 00:58:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4r7OxNsbToHKmk60E6Sv/ozYqeU=; b=qu0wgW
	y5Ss5bEF4Y7CzNRhOAJoaQC8EAFyKrQ4Zp7RgiBixmPsDCGbAJWkBjvJPq5ZcK9K
	auTBicpCGc8zG+Z2orWImHGLijEBLtDxlH0a6tlw1BrpTUivI5ifdnG7qpohbaEh
	8r/azh7MvwEjntoFBjz4WEH2z3si9duTb4q9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MOpL7lJjYIUOqx07QDApn0a3DDrYHVKf
	mEHirdMmytIu8Kvt0hSarm9ody6Y610rhkZXqBwaFAh5SYRGyVDh2smkxpzVcvPu
	iZQqIj5VcG1+EQA0sctj0cvI8CTlCPt0kv7jDSLna8OL7YmLgyylKOIH28oishoc
	CJW/Wtf7p/U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BFC599C2F;
	Fri, 12 Feb 2010 00:58:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A866399C2E; Fri, 12 Feb
 2010 00:57:56 -0500 (EST)
In-Reply-To: <20100212010549.GA23303@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 11 Feb 2010 20\:05\:49 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9409E692-179B-11DF-A3C3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139658>

Jeff King <peff@peff.net> writes:

> In a distributed setup, I don't think it is that uncommon to not want to
> push to the place you pull from. You are generally pulling and building
> on somebody else's work, so if there is no central repo, you will be
> pushing to somewhere that is not where you pulled it.

You are probably right.

It still feels funny to see "git pull" and "git push" goes to different
places, but as long as that is what the user explicitly configures, that's
fine.
