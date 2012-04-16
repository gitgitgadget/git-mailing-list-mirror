From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2012, #05; Thu, 12)
Date: Mon, 16 Apr 2012 10:36:55 -0700
Message-ID: <7v7gxfwpc8.fsf@alter.siamese.dyndns.org>
References: <20120416082641.5d239ef6@mkiedrowicz.ivo.pl>
 <CA+55aFwkf2bOLmUCU+_pSg0OzGyfQ1x-Cy_CiczpJN3zsThNWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:37:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJprN-0005W4-G1
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 19:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990Ab2DPRg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 13:36:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49816 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab2DPRg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 13:36:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 523FB6FF5;
	Mon, 16 Apr 2012 13:36:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U00wIJQy+FQFyp1t7uQ1VT/zXp4=; b=AdMd18
	AjCSF64iY7WzPOOGudKMlwT+vP1CDSNnaTSPhXNnSxX7+MFCijmKj7Ix96VeVrhS
	cgnTK11ZCBXPJBcqlorC8v6+21mR/hDwqQXW3n5OTDOYRsByfcmUMhkBxvJp4MzJ
	LiWvo1wWiBhcw2/Trjq2EW9ucg3KvnC73wrsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r09P2YzJJMkQQP21IQHDg5Lzbt+Nq1eO
	VCZAFQHv6mODYBHFksJ14o6yIT/dX3hKOfBNbig1jzgyCY0HI9QvvNCwDcVBJcAP
	E6dQlKtaHmqslfs0HLj8M3OsDLmUep9aV0fw9Me3m5h+8jFHEIL7eDbu6DmIpuVJ
	dgk9gXQCOxA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 361E26FF4;
	Mon, 16 Apr 2012 13:36:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4BAF6FF0; Mon, 16 Apr 2012
 13:36:56 -0400 (EDT)
In-Reply-To: <CA+55aFwkf2bOLmUCU+_pSg0OzGyfQ1x-Cy_CiczpJN3zsThNWg@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 16 Apr 2012 07:57:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C37A2CEA-87EA-11E1-930E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195670>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So  Ack on Michal's patch, but I think we also should do the appended
> equivalent thing for the fast-forward test on top of it (it's
> white-space damaged, sorry).
>
> Trivially tested with
>
>     git merge HEAD^ HEAD^^
>
> which did the wrong thing before, and now works.

And it seems to break 6028 ("merge -s ours" and "merge -s subtree"
up-to-date) X-<....
