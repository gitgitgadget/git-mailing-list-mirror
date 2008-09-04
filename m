From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix thinko in Release Notes
Date: Thu, 04 Sep 2008 00:37:55 -0700
Message-ID: <7vzlmo5pkc.fsf@gitster.siamese.dyndns.org>
References: <e51f4f550809040030h25b7913dn85269d135d1a28e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Kris Shannon" <kris@shannon.id.au>
X-From: git-owner@vger.kernel.org Thu Sep 04 09:39:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb9Qu-0000mn-F9
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 09:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbYIDHiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 03:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbYIDHiE
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 03:38:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbYIDHiE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 03:38:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5412E5C25C;
	Thu,  4 Sep 2008 03:38:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9C8415C25B; Thu,  4 Sep 2008 03:37:57 -0400 (EDT)
In-Reply-To: <e51f4f550809040030h25b7913dn85269d135d1a28e0@mail.gmail.com>
 (Kris Shannon's message of "Thu, 4 Sep 2008 17:30:26 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 66E835FA-7A54-11DD-BC13-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94902>

"Kris Shannon" <kris@shannon.id.au> writes:

> Signed-off-by: Kris Shannon <kris@shannon.id.au>
> ---
>  Documentation/RelNotes-1.6.0.2.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/RelNotes-1.6.0.2.txt
> b/Documentation/RelNotes-1.6.0.2.txt
> index 686e607..a862305 100644
> --- a/Documentation/RelNotes-1.6.0.2.txt
> +++ b/Documentation/RelNotes-1.6.0.2.txt
> @@ -30,7 +30,7 @@ Fixes since v1.6.0.1
>
>  * "git for-each-ref refs/heads/" did not work as expected.
>
> -* "git log --grep=pattern -i" did not ignore case.
> +* "git log -i --grep=pattern" did not ignore case.

Hmm, that's right.  We evaluate from left to right ;-)
