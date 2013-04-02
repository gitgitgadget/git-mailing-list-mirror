From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Tue, 02 Apr 2013 12:55:23 -0700
Message-ID: <7vip44d7x0.fsf@alter.siamese.dyndns.org>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:56:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7JI-0008TW-2W
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933080Ab3DBTz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:55:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932700Ab3DBTz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:55:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4816E12F84;
	Tue,  2 Apr 2013 19:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pDzhWSlc2a5kLUfvzfto+5ifC90=; b=ABBDTs
	vYHnx+Dsc48Lkf1DTYmvfAKnzF/Bqbnep98CUuZv3d5zhUhD+uUI8+VuKk0NuwZ6
	aZQmRJ8503jZTqHPWFQm9Fa4+EY9PgVC2KzJKHun8u8cR6c9TXHADwrKoYqXUklz
	gDfKXvmAvP152p0Ee+/F1slb6Ns9tb4G4EfhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J4cJWC79DeSHczQHnDart59Fyag2dP+U
	tAmOFAI4Y04cWl9h2idQUSaveL78ilRIbMkMDcUIdc6Pf26qyBneEppLeiFZpPCz
	TYfmJltCfr6nyAZtxRNQgeoMBdvAthJBda9JkH73rnxftkrQHkafYxnwifqVNRj4
	1MZy3M/l7rQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C02B12F83;
	Tue,  2 Apr 2013 19:55:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D57712F81; Tue,  2 Apr
 2013 19:55:24 +0000 (UTC)
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 2 Apr 2013 13:02:49 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 423565E2-9BCF-11E2-BD26-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219870>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Here is the next round of patches for remote-hg, some which have been
> contributed through github.

Thanks.

> Fortunately it seems to be working for the most part, but there are some
> considerable issues while pushing branches and tags.

Do you have a plan in mind what to do about "some considerable
issues"?

I could push these out to 'master' and let the interested parties
sort it out---having early access to the code everybody bases his
effort on would help.

I could queue these on 'pu' and do the same, and wait until you say
"now it is ready, let's go to 'next'" (and same for 'master').

Or are they meant as "There are issues, but here is a snapshot of
what I have at this moment.  Hopefully others can help me update it
by trying it out and discussing, which may lead me to post a reroll
for application"?

I'll queue them on 'pu' in the meantime.

>
> Dusty Phillips (1):
>   remote-hg: add missing config variable in doc
>
> Felipe Contreras (11):
>   remote-hg: trivial cleanups
>   remote-hg: properly report errors on bookmark pushes
>   remote-hg: make sure fake bookmarks are updated
>   remote-hg: trivial test cleanups
>   remote-hg: redirect buggy mercurial output
>   remote-hg: split bookmark handling
>   remote-hg: refactor export
>   remote-hg: update remote bookmarks
>   remote-hg: force remote push
>   remote-hg: don't update bookmarks unnecessarily
>   remote-hg: update tags globally
>
> Peter van Zetten (1):
>   remote-hg: fix for files with spaces
>
>  contrib/remote-helpers/git-remote-hg     | 73 ++++++++++++++++++++++++--------
>  contrib/remote-helpers/test-hg-bidi.sh   |  6 +--
>  contrib/remote-helpers/test-hg-hg-git.sh |  4 +-
>  3 files changed, 61 insertions(+), 22 deletions(-)
