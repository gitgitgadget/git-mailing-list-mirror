From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/pretty-{formats,options}: better reference
 for "format:<string>"
Date: Tue, 01 Jun 2010 21:40:16 -0700
Message-ID: <7vljayoxn3.fsf@alter.siamese.dyndns.org>
References: <1275414886-942-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 06:40:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJfkk-0002Qc-Be
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 06:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab0FBEkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 00:40:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab0FBEkX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 00:40:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1F41B6F0D;
	Wed,  2 Jun 2010 00:40:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=rC/Dmzru/cYHR/glW2WQEXjR3z8=; b=tSuyErbpuAZSeG2kyvwo59Z
	DwTQKRXiMXDgPOzttIlcqOTfbiWZl5TLR3sHHFSg2wg9i11a/wwY1bi27zOmCcP+
	oIJuSaedHbRjh1a8J0ItkxsB9R0Qb3ol9MGoTk1ihQyuWV/li0rzgVbE2KvL5Yc5
	8SBzDkJHX6US/BfX9FJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=hrpmC7H1MFmOwjovsPeWzRX0L21+62FcXtNCYwkavgRcVj2Mu
	8K4pWZzPoZW+Bnpflb4wq13arkGEc81MpjcvcHWuSHcFElLvUAg29xzxi0L/4xur
	4ShRfTRxF5+mVF6J7A4s0eJFS5JJcNNTxEiLAc6D0HcJH/e6JTMyHtnnX4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E35EB6F0B;
	Wed,  2 Jun 2010 00:40:20 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98DF6B6F09; Wed,  2 Jun
 2010 00:40:17 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F34F7CE6-6E00-11DF-B381-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148198>

Nazri Ramliy <ayiehere@gmail.com> writes:

> In "git help log" (and friends) it's not easy to find the possible
> placeholder for <string> for the "--pretty=format:<string>" option
> to git log.
>
> This patch makes the placeholder easier to find by adding a reference
> to the "PRETTY FORMATS" section and repeating the "format:<string>"
> phrase.
>
> Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>

Makes sense; thanks.

>  Documentation/pretty-formats.txt |    4 ++--
>  Documentation/pretty-options.txt |    5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 1686a54..c85a52c 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -76,9 +76,9 @@ displayed in full, regardless of whether --abbrev or
>  true parent commits, without taking grafts nor history
>  simplification into account.
>  
> -* 'format:'
> +* 'format:<string>'
>  +
> -The 'format:' format allows you to specify which information
> +The 'format:<string>' format allows you to specify which information
>  you want to show. It works a little bit like printf format,
>  with the notable exception that you get a newline with '%n'
>  instead of '\n'.
> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
> index af6d2b9..d78e121 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -3,8 +3,9 @@
>  
>  	Pretty-print the contents of the commit logs in a given format,
>  	where '<format>' can be one of 'oneline', 'short', 'medium',
> -	'full', 'fuller', 'email', 'raw' and 'format:<string>'.
> -	When omitted, the format defaults to 'medium'.
> +	'full', 'fuller', 'email', 'raw' and 'format:<string>'.  See
> +	the "PRETTY FORMATS" section for some additional details for each
> +	format.  When omitted, the format defaults to 'medium'.
>  +
>  Note: you can specify the default pretty format in the repository
>  configuration (see linkgit:git-config[1]).
> -- 
> 1.7.1.226.g770c5
