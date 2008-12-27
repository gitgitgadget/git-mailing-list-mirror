From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/diff-options.txt: unify options
Date: Sat, 27 Dec 2008 14:01:11 -0800
Message-ID: <7vfxk9cm6w.fsf@gitster.siamese.dyndns.org>
References: <E1LGfY3-0001pM-S9@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Sat Dec 27 23:02:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGhF1-0002oR-RL
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 23:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbYL0WBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 17:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbYL0WBS
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 17:01:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbYL0WBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 17:01:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 12D431B312;
	Sat, 27 Dec 2008 17:01:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E3D6E1B311; Sat,
 27 Dec 2008 17:01:12 -0500 (EST)
In-Reply-To: <E1LGfY3-0001pM-S9@jidanni.org> (jidanni@jidanni.org's message
 of "Sun, 28 Dec 2008 04:12:50 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E210C14A-D461-11DD-92A4-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104024>

jidanni@jidanni.org writes:

> Signed-off-by: jidanni <jidanni@jidanni.org>
>
> diff --git a/diff-options.txt b/diff-options.txt
> index 5721548..b05503a 100644
> --- a/diff-options.txt
> +++ b/diff-options.txt
> @@ -21,0 +22 @@ ifndef::git-format-patch[]
> +-u::
> @@ -26,3 +26,0 @@ endif::git-format-patch[]
> --u::
> -	Synonym for "-p".
> -

Sorry, but this patch is very unusual in that it lacks any context lines,
which makes it impossible to review.
