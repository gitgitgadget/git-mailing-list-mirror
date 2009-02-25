From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git config: improve documentation
Date: Wed, 25 Feb 2009 00:03:31 -0800
Message-ID: <7vab8baqp8.fsf@gitster.siamese.dyndns.org>
References: <1235512745-26814-1-git-send-email-felipe.contreras@gmail.com>
 <1235512745-26814-2-git-send-email-felipe.contreras@gmail.com>
 <1235512745-26814-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 09:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcEmD-0008Aq-Je
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760754AbZBYIDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760736AbZBYIDl
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:03:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61025 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760712AbZBYIDk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:03:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DC63C12FB;
	Thu, 26 Feb 2009 03:03:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 31A8B12FA; Thu,
 26 Feb 2009 03:03:32 -0500 (EST)
In-Reply-To: <1235512745-26814-3-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 24 Feb 2009 23:59:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F8768E5C-03DB-11DE-8E9F-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111388>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-config.txt |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 19a8917..b284611 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -68,7 +68,8 @@ OPTIONS
>  
>  --add::
>  	Adds a new line to the option without altering any existing
> -	values.  This is the same as providing '^$' as the value_regex.
> +	values.  This is the same as providing '^$' as the value_regex
> +	in `--replace-all`.
>  
>  --get::
>  	Get the value for a given key (optionally filtered by a regex
> @@ -150,7 +151,7 @@ See also <<FILES>>.
>  	When the color setting for `name` is undefined, the command uses
>  	`color.ui` as fallback.
>  
> ---get-color name default::
> +--get-color name [default]::
>  
>  	Find the color configured for `name` (e.g. `color.diff.new`) and
>  	output it as the ANSI color escape sequence to the standard

Looks sane.  Dscho, can I borrow your sanity?
