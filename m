From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-add.txt: Explain --patch option in
 layman terms
Date: Sun, 30 Aug 2009 16:20:23 -0700
Message-ID: <7vbplw28js.fsf@alter.siamese.dyndns.org>
References: <87ocpxb46g.fsf@jondo.cante.net>
 <7vab1hdppb.fsf@alter.siamese.dyndns.org> <87tyzp9da4.fsf@jondo.cante.net>
 <7vskf954sr.fsf@alter.siamese.dyndns.org> <87ab1gaol2.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 01:21:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhthk-00088Q-JE
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 01:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbZH3XUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 19:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbZH3XUd
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 19:20:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbZH3XUd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 19:20:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25CF83DE6D;
	Sun, 30 Aug 2009 19:20:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=poanV3yqCiVeSdRe0/Ba7OsTLF0=; b=TUuPuw
	3oxV1NGdhLeZ4r1J+ANbNKs3BmYwWAWIetLUgle9o6BzE9iblcroENCfu+APXarV
	NH+3NFhg/3psSKPaciY6J2L03gFXc96D4bKaFR+tkubEEyYjTo+6mVGUB/T+Jq2q
	MnSVFlkeNe319xpN55xwIqEVtgLUQY7pTyYB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQq1KQp+SLk5utCzt4H5O30FGRGi4RoI
	7JSSg7L8gYqb+Bl97byG12Qkf9csIrc6E7WCRNn0wHXS6bVbkLKsxqZ6hxgCihic
	dhtLK1tUSB5uXHoC3MJ7VUUKofwkGA6Oyxph5yvpIqf5wQwZH+A/jNCNwX8/pUhD
	Aev15qV5rcI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 080933DE6C;
	Sun, 30 Aug 2009 19:20:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 721753DE6B; Sun, 30 Aug 2009
 19:20:25 -0400 (EDT)
In-Reply-To: <87ab1gaol2.fsf@jondo.cante.net> (Jari Aalto's message of "Mon\,
 31 Aug 2009 02\:06\:49 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B7071BAE-95BB-11DE-9C32-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127445>

Jari Aalto <jari.aalto@cante.net> writes:

> Your proposal that starts:
>
>     ...but bypass the initial command menu

No, it doesn't..

Go re-read the message you are responding to, paying extra attention to
the parts you snipped from your quote, which was the important part you
should have read before you responded.

    If you want to start the description with "What it does/what it is used
    for", I think it is a good idea.  I already made a suggestion for such an
    improvement in my message you are responding to.

Now, what was that suggestion?

It is in the message your first response was a follow-up to.  Again you
didn't quote the relevant part in that response, and perhaps that was
because you did not even read it before responding.

    If you assume that the reader is not familiar with "add -i", then the
    above is not descriptive enough, but "Run interactive patch command" is
    not an improvement either.  We would need a description of "what it is
    used for" before "how it would look to you" (i.e.. my rewrite shown
    above).

    "What it is used for" would perhaps read like this.

            Review the difference between the index and the work tree, and add
            modified contents to the index interactively by choosing which
            patch hunks to use.

This time I re-quoted things for you because your responses obviously were
written without reading or understanding them, but please be careful not
to make me do this.  I do not have infinite time.
