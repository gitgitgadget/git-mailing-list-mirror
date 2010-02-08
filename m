From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: git-add: correct first example
Date: Mon, 08 Feb 2010 11:22:34 -0800
Message-ID: <7vsk9bmt1h.fsf@alter.siamese.dyndns.org>
References: <1265650551-32664-1-git-send-email-gbacon@dbresearch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Bacon <gbacon@dbresearch.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 20:22:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeZC3-0004WG-Or
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 20:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337Ab0BHTWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 14:22:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287Ab0BHTWl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 14:22:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0C3C98B53;
	Mon,  8 Feb 2010 14:22:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OpwA0nGV3/9dFwa97+o4rV331gw=; b=BXqfyG
	wMu5REouJ9r8kkm/gLVgy2RRY9v4yCtaxK1EbIrLL+Brb79q8BfQ1b2/gvyAPFHi
	jQOo/eaYVzuYjxou9v53X1cN1M5dwXFr80BG2oK6j93QwLU3dewdyRQmK3H38Fqu
	HKikU6bjOAnUNObCuPxd/Zv66y/YtFfCCSDNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KKeCry06DrdfFqid7lZyW0IrhNuOHTjG
	3OwwbkcsQ5cIWrS2vssKK9nA3OagUn5/YBb0cfCXMJMvJvyAi/tMm1bGp3XbLPIL
	RJ45u/SHeb4qPmfvLevROga3qh3rKeJDG4dDwb3N7QU/uaVv0iAXy93BHDpPMduy
	vNuoTe5dw8c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 852C698B52;
	Mon,  8 Feb 2010 14:22:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C914998B4F; Mon,  8 Feb
 2010 14:22:35 -0500 (EST)
In-Reply-To: <1265650551-32664-1-git-send-email-gbacon@dbresearch.net> (Greg
 Bacon's message of "Mon\,  8 Feb 2010 11\:35\:51 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 51B3E678-14E7-11DF-90E9-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139306>

Greg Bacon <gbacon@dbresearch.net> writes:

> The first example for git-add covers recursive adding of patterns but
> contains an extra backslash.

Correct.  

> Signed-off-by: Greg Bacon <gbacon@dbresearch.net>
> ---
>  Documentation/git-add.txt |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index f74fcf3..93e8f57 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -149,11 +149,12 @@ those in info/exclude.  See linkgit:gitrepository-layout[5].
>  EXAMPLES
>  --------
>  
> -* Adds content from all `\*.txt` files under `Documentation` directory
> +* Adds content from all `*.txt` files under `Documentation` directory

For this, both

    http://www.kernel.org/pub/software/scm/git/docs/git-add.html

and output from

    git help add

in my local build seem to be rendered correctly by AsciiDoc.

>  and its subdirectories:
>  +
>  ------------
> -$ git add Documentation/\\*.txt

This indeed results in double-backslash in the output.

> +$ git add Documentation/\*.txt

and this seems to fix it.

Thanks.
