From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] CodingGuidelines:  make it clear which files in Documentation/ are the sources
Date: Wed, 08 May 2013 13:38:43 -0700
Message-ID: <7vy5bpdx64.fsf@alter.siamese.dyndns.org>
References: <201305082024.r48KOH55003964@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Wed May 08 22:38:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaB8X-0001MX-2v
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 22:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181Ab3EHUit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 16:38:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab3EHUis (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 16:38:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3973F1DA6A;
	Wed,  8 May 2013 20:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cd4grGDdsAajYuyVB929zLUJMZM=; b=kgq3oe
	FlLSkvmrGsxMNwdVar8/ZR/u3VMiBn3Rz6IX1vcCLASd4hurL67xDfJxCKRz7wDM
	dqjzSi08UnMvqiETV61N+Fxyhp0fuNsxaRpvF2mxxOhQuu22BRc3EhCe8k9GAnpE
	uPCGiLKBIYvfru9UCbRKkYaDRaWhNThCvuuIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kzm4cv+24VImZcjdH5dgDDLE5IMfasgW
	CHeA8nj8ktQsbzhu5wgrRm8lqXUwt9zcxySTxQo3Q90BNFzOD9m2rQq/LYBiF4Vf
	P+cnRyiMLDLILYaws1atNsjeTqW6MhhLDFWKBbpfLmS45a1qrhv2jUrd0A59EUa9
	z5kb+L42/EA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FE061DA69;
	Wed,  8 May 2013 20:38:45 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C8791DA68;
	Wed,  8 May 2013 20:38:44 +0000 (UTC)
In-Reply-To: <201305082024.r48KOH55003964@freeze.ariadne.com> (Dale
	R. Worley's message of "Wed, 8 May 2013 16:24:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46CC9442-B81F-11E2-B8DA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223684>

worley@alum.mit.edu (Dale R. Worley) writes:

> From e87227498ef3d50dc20584c24c53071cce63c555 Mon Sep 17 00:00:00 2001
> From: Dale Worley <worley@ariadne.com>
> Date: Tue, 7 May 2013 13:39:46 -0400
> Subject: [PATCH] CodingGuidelines:  make it clear which files in
>  Documentation/ are the sources

These five lines are present in the output of the format-patch only
to help you fill in the MUA's mail header (instead of typing the
subject, you can cut and paste from here, for example); after you
are done with the MUA headers, remove them and do not leave them in
the body of the message.

>
> Signed-off-by: Dale R. Worley <worley@ariadne.com>

The title looks a bit too long.  For a small and obviously correct
patch like this, I do not think you would need anything in the log
message, some of what you wrote below the three-dash line may
deserve to be said here.  Perhaps:

    Subject: [PATCH] CodingGuidelines: Documentation/*.txt are the sources

    People not familiar with AsciiDoc may not realize they are
    supposed to update *.txt files and not *.html/*.1 files when
    preparing patches to the project.

But it invites a question.  Why do people patching Git not to know *.txt
are the sources in the first place?  Generated *.html files are not
even tracked.

>  Documentation/CodingGuidelines |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 7e4d571..b8eef7c 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -238,7 +238,9 @@ For Python scripts:
>  Writing Documentation:
>  
>   Most (if not all) of the documentation pages are written in AsciiDoc
> - and processed into HTML output and manpages.
> + and processed into HTML output and manpages.  This means that the *.txt
> + files in this directory are usually the sources from which the
> + corresponding *.html, *.1, and *.xml files are generated.

Whenever you see somebody writing "This means that" or "In other
words", it is a good habit to ask if the existing text can be
improved so that it does not need such a follow-up clarification.

    Most (if not all) of the documentation pages are written in the
    AsciiDoc format in *.txt files (e.g. Documentation/git.txt), and
    processed into HTML and manpages (e.g. git.html and git.1 in the
    same directory).

>  
>   Every user-visible change should be reflected in the documentation.
>   The same general rule as for code applies -- imitate the existing
