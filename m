From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: update builtin usage
Date: Mon, 09 Apr 2012 15:06:32 -0700
Message-ID: <7vty0stv9z.fsf@alter.siamese.dyndns.org>
References: <4F804E70.2020106@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 00:06:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHMjQ-00046E-HZ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 00:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609Ab2DIWGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 18:06:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757515Ab2DIWGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 18:06:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E52A6973;
	Mon,  9 Apr 2012 18:06:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2LNeCs7ofWxvvTx+MXzNfuWR/8Q=; b=WZcXnf
	OCSraLbUQHVPoGpQUaksQ7myF/gyZpvr3qy5xFTK/+bUWw21wM/FDwKeH5keHPcJ
	CjgdJmnYaSuNKiGZEY8rsxmouGjKyJFW6MtHNq/Fonwj9sQnHD1bLgjdkKp2vv57
	YIpcqbjUqaXcCikXOV7DOvQL4tN8fRUm7d7Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qVweWHYJrmwqVOwdjO1e4JT1TZzaG3s0
	cQUxvLYBRZ5yw7I09vizbGiFeuPm/dMQM1xQduW8e7fIyxn3lqFOxe2cwKyPVNXn
	2az6bIrDiEViiQ7CrsrdZmiASoveTUx1+JjKuEJvwNXdvD2Ralfxd9djkRqc3FF0
	SEr5HwQ5A0w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 559566972;
	Mon,  9 Apr 2012 18:06:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B02B46971; Mon,  9 Apr 2012
 18:06:33 -0400 (EDT)
In-Reply-To: <4F804E70.2020106@elegosoft.com> (Michael Schubert's message of
 "Sat, 07 Apr 2012 16:25:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44B33A64-8290-11E1-8FC2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195043>

Michael Schubert <mschub@elegosoft.com> writes:

> Add missing options "--tags|--no-tags" and "--push".
>
> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
> ---
>  builtin/remote.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index fec92bc..b5645fe 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -9,7 +9,7 @@
>  
>  static const char * const builtin_remote_usage[] = {
>  	"git remote [-v | --verbose]",
> -	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror=<fetch|push>] <name> <url>",
> +	"git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>",
>  	"git remote rename <old> <new>",
>  	"git remote rm <name>",
>  	"git remote set-head <name> (-a | -d | <branch>)",
> @@ -17,7 +17,7 @@ static const char * const builtin_remote_usage[] = {
>  	"git remote prune [-n | --dry-run] <name>",
>  	"git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]",
>  	"git remote set-branches [--add] <name> <branch>...",
> -	"git remote set-url <name> <newurl> [<oldurl>]",
> +	"git remote set-url [--push] <name> <newurl> [<oldurl>]",
>  	"git remote set-url --add <name> <newurl>",
>  	"git remote set-url --delete <name> <url>",
>  	NULL


Hrm.  While this may not be _wrong_ per-se, it strikes me odd that
builtin_remote_usage[] is more or less a superset of the subcommand
specific usage text, e.g. builtin_remote_seturl_usage[], etc., but still
need to be manually defined like this.  That always leaves a risk that the
descriptions would drift apart between the two places.

For example, builtin_remote_setbranches_usage[] has these two:

static const char * const builtin_remote_setbranches_usage[] = {
        "git remote set-branches <name> <branch>...",
        "git remote set-branches --add <name> <branch>...",
	NULL
};

where the above has only one, with an optional "[--add]".

There must be a better way to do this.
