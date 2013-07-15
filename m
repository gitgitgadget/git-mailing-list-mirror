From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] Documentation: Update manpage for pre-commit hook
Date: Mon, 15 Jul 2013 09:54:07 -0700
Message-ID: <7vhafvbw7k.fsf@alter.siamese.dyndns.org>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
	<1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
	<1373818879-1698-5-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 18:54:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uym2R-0005oz-TY
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 18:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167Ab3GOQyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 12:54:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757620Ab3GOQyK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 12:54:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C41D30010;
	Mon, 15 Jul 2013 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fybOMbL4ZozZ6DRWfwaLRp+VetU=; b=KJ2hhY
	Qt8q7IFJopJNYu9dtdUuUcYWXO+cXvOr66gX3SQ3LcMfldOcNkGvQqwrO0+rkiQ3
	qVuUwHdZYZMnvokDryRGYIIot/+4QjabuGJJwbZWI8zHdZ4L0Io1PF0fV0l9G2bH
	8ndmhIABETXLt21O64JP7mAWs2uNZDz56YHOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bcarbl9bLDNXSVIbj80jYqmXh49HBoai
	LzEYQ0xLJaU3paoQ3k3sdfMku3dg1zKz2vFqUb5KOCptZiLHA6BH1sIAw0x6TpGu
	C9kfE4YWwFFoIastaoxyjqqppTOHW/akV5x4vIEX8D13XQzIAQssAnsTs8F2wzoZ
	CaqMwR98g5g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 909EE3000F;
	Mon, 15 Jul 2013 16:54:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3DA93000C;
	Mon, 15 Jul 2013 16:54:08 +0000 (UTC)
In-Reply-To: <1373818879-1698-5-git-send-email-richih.mailinglist@gmail.com>
	(Richard Hartmann's message of "Sun, 14 Jul 2013 18:21:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2ABD8BFA-ED6F-11E2-AC31-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230489>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> Verbatim copy of 4b8234b2693af634a77ea059331d1658e070f6d7 in original
> patch series from 2013-06-10.

As Jonathan said, this is not a commit log message.

I've applied up to 3/6 with fixups, but will stop here for now.

>
> Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
> ---
>  Documentation/githooks.txt |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index b9003fe..1276730 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -80,7 +80,8 @@ causes the 'git commit' to abort.
>  
>  The default 'pre-commit' hook, when enabled, catches introduction
>  of lines with trailing whitespaces and aborts the commit when
> -such a line is found.
> +such a line is found. It will also prevent addition of non-ASCII
> +file names.
>  
>  All the 'git commit' hooks are invoked with the environment
>  variable `GIT_EDITOR=:` if the command will not bring up an editor
