From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] teach the user to be nice to git and let him say please sometimes
Date: Sun, 12 May 2013 14:19:34 -0700
Message-ID: <7vobcfvqu1.fsf@alter.siamese.dyndns.org>
References: <20130511201928.GA22938@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun May 12 23:19:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbdgH-0001HQ-E6
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 23:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590Ab3ELVTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 17:19:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53319 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab3ELVTj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 17:19:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 216101E3CF;
	Sun, 12 May 2013 21:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZpL5IVFnITKc8gnVKs1jZ7tVq/w=; b=wY4agB
	kUKSP/GvS/HIx8TydY1gJn9EoORht5a8QaOkjNw/ury0lCXCrbLmH0yoeyhZe2Bf
	BipjH56FVNw3LU+/SXPbpfiqwtD4hpx7xchdm7Ni7uVxE498/ZmdQ/22ND5AobYU
	b7pyulE1GcLfM3oO/GeSpv2+V3/il4KkoVjB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lk4vmXrHcAoVbn+9KFmxQ65LIdacaJ1O
	zcFKhOsiHa7hxyDKNmRhyK3hlvXFtDVrIha6dmEPIG0RGL/4Er6Q/atE0k5CkvPQ
	Obs9VXa2/NpkE2vzRU9JVaQPsV5mE9LRnYE+r1bvuxfR86jNLzRhQihYbCRsL7Kv
	HcRJuOb59es=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1600E1E3CE;
	Sun, 12 May 2013 21:19:37 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DA371E3CD;
	Sun, 12 May 2013 21:19:36 +0000 (UTC)
In-Reply-To: <20130511201928.GA22938@book.hvoigt.net> (Heiko Voigt's message
	of "Sat, 11 May 2013 22:20:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5E2A9A8-BB49-11E2-9BCE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224062>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Since ages we do not care about our program enough. Lets not treat them
> as slaves anymore and say please.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> Signed-off-by: Johan Herland <johan@herland.net>

So these were the ones present on the dev-day?

I actually would have expected, from the "please" title, the
opposite, us saying "please" to the user, either once in a while in
the advice messages we give to them, or perhaps in the en_POLITE
locale ;-)

>  .gitignore                       |  1 +
>  Makefile                         |  1 +
>  builtin.h                        |  1 +
>  builtin/config.c                 | 23 ++-----------------
>  builtin/please.c                 |  9 ++++++++
>  cache.h                          |  1 +
>  config.c                         | 23 +++++++++++++++++++
>  contrib/completion/git-prompt.sh |  5 +++-
>  git.c                            | 49 +++++++++++++++++++++++++++++++++++++++-

There is no test to protect this feature from future breakages?
