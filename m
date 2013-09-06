From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t2024: Fix inconsequential typos
Date: Fri, 06 Sep 2013 10:32:31 -0700
Message-ID: <xmqqwqmtyhxs.fsf@gitster.dls.corp.google.com>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
	<1378464042-17476-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Sep 06 19:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHztg-0004DX-OR
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761Ab3IFRch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:32:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723Ab3IFRcg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:32:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F2693E96C;
	Fri,  6 Sep 2013 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N4qynqfR33NxktJOx9ZAzGdrPKU=; b=uLTChN
	oh8v9M90yptNeXq0/oHdepvDoJffhfJD8Ah5mDWRXnY+aaPxoJYUBpfhCOsFTFiT
	9RZUOM26dYfpxvycuNNhjIntRlbZPDcbZdVyqed4Srb8aEkQKiFfLfB93ujQv6Eb
	PAhDfLOvmOhWOOSupw/WFNZsbQzioxJgwkzp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZCMoidu55R+UoPwsLapow9ohaYttzlAN
	Ov6BLFjSYaB2VL0CM98H8XW02cS6daquVq92Uxiup6Ng5t/uPnpn9qdmyj7q8ZB0
	J8qAWyGIzazndCaQX1lYn8J4X7L4EuenjsbE1R3uOlphAvWq7Oxs50pRLQA5Vr9t
	nTCxzGuvUns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29BA43E969;
	Fri,  6 Sep 2013 17:32:35 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA17C3E966;
	Fri,  6 Sep 2013 17:32:33 +0000 (UTC)
In-Reply-To: <1378464042-17476-2-git-send-email-johan@herland.net> (Johan
	Herland's message of "Fri, 6 Sep 2013 12:40:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5076592E-171A-11E3-B540-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234069>

Johan Herland <johan@herland.net> writes:

> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  t/t2024-checkout-dwim.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
> index dee55e4..6c78fba 100755
> --- a/t/t2024-checkout-dwim.sh
> +++ b/t/t2024-checkout-dwim.sh
> @@ -113,9 +113,9 @@ test_expect_success 'setup more remotes with unconventional refspecs' '
>  		cd repo_d &&
>  		test_commit d_master &&
>  		git checkout -b baz &&
> -		test_commit f_baz
> +		test_commit d_baz

Not limited to this hunk but there seems to be a breakage in the &&
chain here.

>  		git checkout -b eggs &&
> -		test_commit c_eggs
> +		test_commit d_eggs
>  	) &&
>  	git remote add repo_c repo_c &&
>  	git config remote.repo_c.fetch \
