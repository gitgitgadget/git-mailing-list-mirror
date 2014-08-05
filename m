From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] Documentation: git-init: template directory: reword
Date: Tue, 05 Aug 2014 15:10:30 -0700
Message-ID: <xmqqmwbioaeh.fsf@gitster.dls.corp.google.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
	<1407002817-29221-4-git-send-email-linusarver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Arver <linusarver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 00:10:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEmwP-0003CH-1U
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 00:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbaHEWKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 18:10:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50203 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbaHEWKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 18:10:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44FC32ED77;
	Tue,  5 Aug 2014 18:10:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UeA415kVNPAqZLW+5m+c7SZlgT0=; b=Zbt0WH
	fy25syED592xmujtOhogTCItn5B942Ap5Sz3sUsy8R0IKKsXks/n9jQ18Mq4U7Ae
	jkE1ZJH97bykC2mv09cDbZfQkho/fe9MXx84aFOqWCXSCJKOnmlPFaH3DEOg9/9j
	DaxanVbKkKNu/ePx6i6sbYgp7ti9t8WtqAsDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hOEfsYwBJW/2wVVjIzHldFDwbn2RxmIy
	WtlRmrubIF7G3vQOkyUF2Ps8IPr0shkuRjtTaz5ibUWjfRcoqtxaXEcF9dmc/qZe
	crf3o7XY9Di/1Ye3ydvKJF/h6IT80pv4oDhKBDXUZhHLf3K0c2a2Q1x9c31Jzt6o
	qZjQWNalk9I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B0152ED74;
	Tue,  5 Aug 2014 18:10:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A5C712ED70;
	Tue,  5 Aug 2014 18:10:32 -0400 (EDT)
In-Reply-To: <1407002817-29221-4-git-send-email-linusarver@gmail.com> (Linus
	Arver's message of "Sat, 2 Aug 2014 11:06:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 516CEBB6-1CED-11E4-9D6F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254833>

Linus Arver <linusarver@gmail.com> writes:

> Signed-off-by: Linus Arver <linusarver@gmail.com>
> ---

This seems to reword and also reformat at the same time, but was the
latter change (i.e. to unindent the bulletted items and to remove
blank lines between items) necessary?

>  Documentation/git-init.txt | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 45501d0..f21b85b 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -113,22 +113,18 @@ line, the command is run inside the directory (possibly after creating it).
>  
>  --
>  
> -
>  TEMPLATE DIRECTORY
>  ------------------
>  
>  The template directory contains files and directories that will be copied to
>  the `$GIT_DIR` after it is created.
>  
> -The template directory used will be (in order):
> -
> - - The argument given with the `--template` option.
> -
> - - The contents of the `$GIT_TEMPLATE_DIR` environment variable.
> -
> - - The `init.templatedir` configuration variable.
> +The template directory will be one of the following (in order):
>  
> - - The default template directory: `/usr/share/git-core/templates`.
> +- the argument given with the `--template` option;
> +- the contents of the `$GIT_TEMPLATE_DIR` environment variable;
> +- the `init.templatedir` configuration variable; or
> +- the default template directory: `/usr/share/git-core/templates`.
>  
>  The default template directory includes some directory structure, some
>  suggested "exclude patterns", and copies of sample "hook" files.
