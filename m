From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add Minix configuration options.
Date: Tue, 19 Jul 2011 14:39:14 -0700
Message-ID: <7vaaca7xx9.fsf@alter.siamese.dyndns.org>
References: <20110719162659.81020d7c.tcort@minix3.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Cort <tcort@minix3.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 23:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjI0t-00008G-2o
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 23:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712Ab1GSVj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 17:39:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58631 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab1GSVjR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 17:39:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 562B24199;
	Tue, 19 Jul 2011 17:39:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FsB3kc7wBagirKP3pm63ZUv8Mm4=; b=MoHhM6
	zBdwTUTLYRM/vZQTqYUdVc17QKIq+DgZ1d0DmauNfCqKGOqVkfF/3UwasgE2hM3I
	uFJduzgc70yStaR5H2QTwBazJOEzc8KFRFx50349fLciAwCG0jYNQeP+6s6CHVWL
	4cVQ+KhsY8NO5d+cRyrAd1uV8qPT86OAnmUQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i2qmFuJKiwd5MosdrUzZ20Ab/CaGWFQg
	oA6n/xqmvThON967OoKPL5+I70VhIBUhbVwHDNJe88OP6WZ8rC40gxLhOzn1AdiG
	6VP1mziscL+cKSijVukOvoWCkgVA7C/AzN7loQk1h3Uc9zSBtEgwi8iqTxTKhkhC
	SMJJxAoZFO0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E1354198;
	Tue, 19 Jul 2011 17:39:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8BF64197; Tue, 19 Jul 2011
 17:39:15 -0400 (EDT)
In-Reply-To: <20110719162659.81020d7c.tcort@minix3.org> (Thomas Cort's
 message of "Tue, 19 Jul 2011 16:26:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D01D17A-B24F-11E0-9EF9-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177509>

Thomas Cort <tcort@minix3.org> writes:

>  * Adds a $(uname_S) case for Minix with the correct options.

Ok, but lose the asterisk and speak as if you are giving an order to the
codebase or the person who maintains it, i.e. "Add $(uname_S) case...".

>  * Adds NEEDS_SSL_WITH_CURL and NEEDS_CRYPTO_WITH_SSL to the
>    libcurl section. On Minix both -lssl and -lcrypto are
>    needed when using -lcurl.

These...

> +	NEEDS_IDN_WITH_CURL = YesPlease
> +	NEEDS_SSL_WITH_CURL = YesPlease

... are not described in the beginning of Makefile; add them.

>  * Changes OPENSSL_LINK to OPENSSL_LIBSSL in the
>    NEEDS_CRYPTO_WITH_SSL conditional in the libopenssl section.

Why is this change necessary?

>    The -lcrypto needs to be in OPENSSL_LIBSSL.

Ditto.

Thanks.
