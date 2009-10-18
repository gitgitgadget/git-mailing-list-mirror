From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unapplied patches reminder
Date: Sun, 18 Oct 2009 16:31:49 -0700
Message-ID: <7vbpk4i8ii.fsf@alter.siamese.dyndns.org>
References: <20091019052030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 01:32:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzfEL-0005n3-Am
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 01:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbZJRXbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 19:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755084AbZJRXby
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 19:31:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774AbZJRXby (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 19:31:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38A765EC4C;
	Sun, 18 Oct 2009 19:31:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=n12Fu1FmdeimNXpB5mWJrQzUums=; b=eH5QoAtaYOhSU8B1BfAdHnc
	owc+W+4tg+S9ajkwDyIl4KfSZ7NgYjGDZzch5wHO0L1Lz1RL8g34DiTMq8p1hOFF
	6l817AWOXQvdj8YFGfKYWcSfdWrzyL6suSz/VSz/J0zypzf5TZL2xhKYsDHx4jTw
	EbFFAI1ECsv2qEk7vpeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=XHFihO7i1unQ/l/7JzUU5EhqlAUNVOPFO/K2MQgbRMsnRS+7q
	QHTz551phoWHNXe+SdLc2emWgtuwLutIK2egEFGXdFzbkHASE++8tS9tojnYUVbg
	c2w5YbyV8cLL49M6vg+ag1msc/e09y+dhK3bOOqmxyT9jySGIYy88+fFqM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 087515EC4B;
	Sun, 18 Oct 2009 19:31:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6520C5EC47; Sun, 18 Oct
 2009 19:31:50 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B30A55C-BC3E-11DE-9F3D-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130621>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, I saw these patches and thought what they try to do were 
> sensible, but I don't them in your tree. I didn't see much discussion 
> on most of them, either.
>
> Because I don't read C very well, I may have listed some patches 
> here that you may have discarded because the code was no good, and 
> if so I apologize for wasting your time, but I thought at least 
> some of them should be salvaged.
> ...
> From:	Heiko Voigt <hvoigt@hvoigt.net>
> Subject: [PATCH] fix testsuite to not use any hooks possibly provided by source
> Date:	Wed, 23 Sep 2009 20:30:28 +0200
> Message-ID: <20090923183023.GA85456@book.hvoigt.net>
>
>     This is useful if you are using the testsuite with local changes that
>     include activated default hooks suitable for your teams installation.

This may be useful when Heiko or somebody actually has changes that needs
this fix, but otherwise was an unnecessary code churn during pre-release 
code freeze.  I am reasonably sure that Heiko will include it in a series
that requires this one.

In other words, I am not against it per-se, but I would prefer to see
patches that actually depends on this change at the same time.  Otherwise
this "is supposed to be no-op, and promises it will help in the future",
and needs extra mental effort to validate the latter claim.
