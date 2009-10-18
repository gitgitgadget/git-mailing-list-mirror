From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unapplied patches reminder
Date: Sun, 18 Oct 2009 16:32:14 -0700
Message-ID: <7voco4gtxd.fsf@alter.siamese.dyndns.org>
References: <20091019052030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Geoffrey Thomas <geofft@mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 19 01:32:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzfEl-0005uX-8v
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 01:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbZJRXcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 19:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755611AbZJRXcU
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 19:32:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602AbZJRXcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 19:32:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BDA55EC5C;
	Sun, 18 Oct 2009 19:32:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=sjDpqGuQ0oLtaERoZEBZjlcb6nY=; b=ZFIvo+et6zrZUxrOeB5kG3d
	Kijy7vTuKgEm4E9DGdUBang9rIoJZdkAQ0NTc9OKqJoG700LpG6B2PJmZe5v0+yM
	Fbz1NgDJ9zl+JjYjTElWC/HePaCK+1T6HI/XgOYvzIhYIAW7W2+vELHa4719YY7S
	NliWtE611lFlrWh2wtjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=qC2ziBKC33tTB5IyVgX5sd+L7Cpw7DAbZU6Nrsckjn8aJjA5j
	6GXdJhrt/Wo2+iSQhkM/E1tDwHgV8FkTOtKLg7DL7NtWhf/nI1nk08Ah0ZVnm+hj
	5xk0bGa48evYp+Wd/cS46QiJsqVJvDEMfxMJR848VxywXSxeMzcYKGtsj4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F37B05EC5A;
	Sun, 18 Oct 2009 19:32:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E3F95EC59; Sun, 18 Oct
 2009 19:32:15 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A123310-BC3E-11DE-8063-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130626>

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
> From: Geoffrey Thomas <geofft@mit.edu>
> Subject: [PATCH] diffcore-order: Default the order file to .git/info/order.
> Date: Sat, 12 Sep 2009 19:49:48 -0400
> Message-ID: <1252799388-16295-1-git-send-email-geofft@mit.edu>
>
>     Since order files tend to be useful for all operations in the
>     project/repository, add a default location for the order file, so that
>     you don't have to specify -O<orderfile> on every diff or similar
>     operation.

Except that "$GIT_DIR/info/order" is a bit too generic a name ("eh,
'order'?  Order of what?"), I do not think this will hurt, as no existing
repositories would have such a file that would cause any behaviour change
to existing users.  The reason I did not queue it was because there wasn't
any discussion on it (not even the filename being too generic) which was
an indication that not many people are interested in such a feature.

That of course can be remedied by interested people speaking out.
