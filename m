From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-bisect.txt: clarify that reset finishes bisect
Date: Sat, 09 Feb 2013 13:53:04 -0800
Message-ID: <7v8v6xw3wf.fsf@alter.siamese.dyndns.org>
References: <5e23d4c420f150b700dd5100bffb38d32f874200.1360439176.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Mohr <andi@lisas.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Feb 09 22:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4IMb-0002lF-Q7
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 22:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584Ab3BIVxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 16:53:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34301 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932574Ab3BIVxI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 16:53:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7078EC6EC;
	Sat,  9 Feb 2013 16:53:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6o2l26NqERb3uP4SYrZLjY9i8Fw=; b=OLlK60
	W064qnqkLKWDFS/MiKf+Pwd6bV8oU0dZVb4R5ULzEkIzkS54EOdmZVlpJhxhKzbW
	sm0xu9VndlM6bfcK7yi27xxUOesGhR5t8+Sd4a34NTRf+ju1HEWvRsHju4n0NHFP
	mpeDEVpi4/kNTbw87hxu5QFn99Kl9sFTL9GSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vkmg8H9RlFuMHLRbID2whuhPJ+IH8qsb
	TxYx3G4MsytrIXw2ZN0sPWAIpDs4fadU5KhtvB/PNiJ1EzZ4W7+HHYBSBB5o6A2i
	9ZTee9TGmVq6ZN7KUfdZmJkbRpHTwHPo0jgtrrispdbaVSYPl6v/dSLMhMbIxytY
	yVZGoyicR6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63906C6EB;
	Sat,  9 Feb 2013 16:53:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D47A0C6EA; Sat,  9 Feb 2013
 16:53:06 -0500 (EST)
In-Reply-To: <5e23d4c420f150b700dd5100bffb38d32f874200.1360439176.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Sat, 9 Feb 2013 20:47:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 162E8AF4-7303-11E2-8459-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215877>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> "reset" can be easily misunderstood as resetting a bisect session to its
> start without finishing it. Clarify that it actually finishes the bisect
> session.
>
> Reported-by: Andreas Mohr <andi@lisas.de>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-bisect.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index b4831bb..d50bd89 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -83,7 +83,7 @@ Bisect reset
>  ~~~~~~~~~~~~
>  
>  After a bisect session, to clean up the bisection state and return to
> -the original HEAD, issue the following command:
> +the original HEAD (i.e., to finish bisect), issue the following command:

Makes sense.
