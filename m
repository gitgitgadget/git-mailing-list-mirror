From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] standardize usage strings that were missed the first time
Date: Sun, 03 May 2015 10:18:07 -0700
Message-ID: <xmqq383dwpf4.fsf@gitster.dls.corp.google.com>
References: <1430536341-21847-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, artagnon@gmail.com, git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 19:18:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoxWx-0002oh-Ow
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 19:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbbECRSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 13:18:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750918AbbECRSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 13:18:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D08924D6EC;
	Sun,  3 May 2015 13:18:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RABdR3iBnQlKcStYytNzaRmMviY=; b=iQydlT
	tz3qtJReRdHniRZe8ucomWEVdZC8kixGblKnILz8cVlz6mvncrOpDjhW94QCMY9I
	hv7sdTtD7FuLPlCHPB/hH1NRSzwpeNBIfIoCHRoAlvDsDFzTWC8GVWKW28zVbBAb
	nqcNpuesSikz92EBpyVwsfRXbWWxSc2uLWxTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o/+paDydAMS5u9qySf0HhYen3tve1PaX
	Y9pol8oX+kkapzM+JQnvo2lxZbBHAtjeTVEKxtAliquTAVVjFyXrLNJf3P6ftp7x
	/xNgoy09xfq48aHgVZN60XX6+CKv88zFSqN6J5NrxU0s2bmho7cyJ4GEdKOKzSPf
	JACwxtQR9WI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C997B4D6EB;
	Sun,  3 May 2015 13:18:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 408EF4D6EA;
	Sun,  3 May 2015 13:18:08 -0400 (EDT)
In-Reply-To: <1430536341-21847-1-git-send-email-alexhenrie24@gmail.com> (Alex
	Henrie's message of "Fri, 1 May 2015 21:12:21 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E1661B2-F1B8-11E4-BA08-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268275>

Alex Henrie <alexhenrie24@gmail.com> writes:

> This is a follow-up to commit 9c9b4f2f8b7f27f3984e80d053106d5d41cbb03b.

Please do not force the reader to type "git show 9c9b4f2".

>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/blame.c | 2 +-
>  builtin/log.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 06484c2..0b2f4ed 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -27,7 +27,7 @@
>  #include "line-range.h"
>  #include "line-log.h"
>  
> -static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] file");
> +static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
>  
>  static const char *blame_opt_usage[] = {
>  	blame_usage,
> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..4c4e6be 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -38,7 +38,7 @@ static const char *fmt_patch_subject_prefix = "PATCH";
>  static const char *fmt_pretty;
>  
>  static const char * const builtin_log_usage[] = {
> -	N_("git log [<options>] [<revision range>] [[--] <path>...]"),
> +	N_("git log [<options>] [<revision-range>] [[--] <path>...]"),
>  	N_("git show [<options>] <object>..."),
>  	NULL
>  };
