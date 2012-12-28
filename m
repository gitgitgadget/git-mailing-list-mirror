From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove the suggestion to use parsecvs, which is
 currently broken.
Date: Fri, 28 Dec 2012 11:28:34 -0800
Message-ID: <7vobheht7h.fsf@alter.siamese.dyndns.org>
References: <20121228162025.8565E4413A@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com (Eric S. Raymond)
X-From: git-owner@vger.kernel.org Fri Dec 28 20:29:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tofc5-0006vT-JV
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 20:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913Ab2L1T2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 14:28:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56801 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902Ab2L1T2i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 14:28:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B382A1F0;
	Fri, 28 Dec 2012 14:28:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2X+GArMejbq95hrQnxdSnYgTTqU=; b=nmiFhM
	KAT1HWPiVhVFxMAdE6RstHknpGEnKh9aebfAnMgUObw5/1l+eqqkmPSFGc5VlQK7
	VgeCQ+HDLuEAmKcylSABPlMR3SVTlcMEU5PQndwFDtNF+PS1+KA/mA8ZX4xiXuhP
	wDZe05k0XwNx1SPv755vlgjHLJ7aU4homBQr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PHUtSTA3QASAJ+yohjvScilc0/4VfNv1
	f1sbouLUOkLXsPMbTh55x8N+kU/PpEcENPsmPnsYKqrULg5YjABHbIY5QzhQHDE7
	7xTB22FQt0NILFzDZ2LDw3HXmXEzOfs57ri0I+V7WsiJl8S2nXlJaD6UNB97S0Vn
	NYdJdj2JsLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AD9AA1E8;
	Fri, 28 Dec 2012 14:28:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AF4FA1E7; Fri, 28 Dec 2012
 14:28:36 -0500 (EST)
In-Reply-To: <20121228162025.8565E4413A@snark.thyrsus.com> (Eric S. Raymond's
 message of "Fri, 28 Dec 2012 11:20:25 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6843012-5124-11E2-BE16-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212251>

esr@thyrsus.com (Eric S. Raymond) writes:

> The parsecvs code has been neglected for a long time, and the only
> public version does not even build correctly.  I have been handed
> control of the project and intend to fix this, but until I do it
> cannot be recommended.
>
> Also, the project URL given for Subversion needed to be updated
> to follow their site move.
> ---
>  Documentation/git-cvsimport.txt | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> ...
> -- 
> 		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
>
> A ``decay in the social contract'' is detectable; there is a growing
> feeling, particularly among middle-income taxpayers, that they are not
> getting back, from society and government, their money's worth for
> taxes paid. The tendency is for taxpayers to try to take more control
> of their finances...	-- IRS Strategic Plan, (May 1984)

It is funny that you keep forgetting to sign-off your patches and
even send a message with no subject, but still manage to add a
pointer to your homepage and stuff at the end.

Perhaps you would need to form a habit to do "commit -s"?
