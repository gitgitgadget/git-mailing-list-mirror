From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] standardize usage strings that were missed the first time
Date: Thu, 02 Apr 2015 14:56:59 -0700
Message-ID: <xmqqego2i47o.fsf@gitster.dls.corp.google.com>
References: <1428010016-12968-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, artagnon@gmail.com, git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 23:57:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydn6q-00054H-Hj
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 23:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbbDBV5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 17:57:04 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752357AbbDBV5C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 17:57:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 735CC43F04;
	Thu,  2 Apr 2015 17:57:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wW7EI8dHLqIzEMJqiGmgt4T6YPA=; b=AuVXwb
	u5FT5xN4wKyLcNN8QH3WQJhrWhAf/ClESB7Np/kxPZMEkdvZfmkAxUCqND7DXf+V
	9Gxzt7Ms1JRHfwQxsgzWsLut4QEUVhtFhPXyAGttgQM0swsoy+rAhMiRKvimdRma
	OCDGa+minFSqByEoSWW1mkEK+g/7ZvHXlzg50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ats2C1tggSk5AQiJ4rVwoxfoRJZQh3Y7
	Kk4bgFunV3OCHuOM6rQ2YOHX1HI6G/2RF863lF4xTEEKBlbY2oaZux7fp13/wyk2
	VOo3VDtAgS8af6Djb8Hymv6iHW8XPoWINrgkpJN9BcEtNgcto+SmmrJUavG4cmfl
	+2M/EU7yRZI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BFF143F03;
	Thu,  2 Apr 2015 17:57:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CFF8143F00;
	Thu,  2 Apr 2015 17:57:00 -0400 (EDT)
In-Reply-To: <1428010016-12968-1-git-send-email-alexhenrie24@gmail.com> (Alex
	Henrie's message of "Thu, 2 Apr 2015 15:26:56 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 30AF2B7A-D983-11E4-A330-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266683>

Alex Henrie <alexhenrie24@gmail.com> writes:

> This is a follow-up to commit 9c9b4f2f8b7f27f3984e80d053106d5d41cbb03b.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---

Thanks, but please no more _("string") changes for the rest of the
cycle, as that would impact i18n folks who will be starting from
tagged -rc releases.

Please hold them off, and resend them after 2.4.0 final.

Thanks.

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
