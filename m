From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff should not fire up $PAGER, period!
Date: Wed, 17 Dec 2008 18:26:09 -0800
Message-ID: <7vy6yei5ha.fsf@gitster.siamese.dyndns.org>
References: <3c6c07c20812171818k6b6e3555ja991e20d74d8291b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mike Coleman" <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 03:28:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD8cK-0008D0-L4
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 03:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbYLRC0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 21:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYLRC0T
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 21:26:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYLRC0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 21:26:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 89A9987D25;
	Wed, 17 Dec 2008 21:26:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D409187D20; Wed,
 17 Dec 2008 21:26:14 -0500 (EST)
In-Reply-To: <3c6c07c20812171818k6b6e3555ja991e20d74d8291b@mail.gmail.com>
 (Mike Coleman's message of "Wed, 17 Dec 2008 20:18:38 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3FF5911E-CCAB-11DD-8E5C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103421>

"Mike Coleman" <tutufan@gmail.com> writes:

> To me, the most important nugget from the original complaint was that
> git-diff sends its error messages to stdout.  I understand why it
> might be done, but I'd worry about losing the stderr diagnostic for a
> command that matters.  [I've been playing around with this for a few
> minutes trying to see errors going to stdout and I can't reproduce
> it--I wonder if they really do.]

They indeed did but it has hopefully been fixed.  See a833502 (pager: do
not dup2 stderr if it is already redirected, 2008-12-15).

> ...  Like Junio, I also eschew doing terminal emulation
> inside of emacs.

Come to think of it, it may have been from you that I picked up the trick
of setting PAGER to cat inside an Emacs environment.

> Good evening from the icy midwest,

Good evening from rainy and chilly SoCal.
