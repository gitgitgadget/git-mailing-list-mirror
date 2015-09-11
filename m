From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag, update-ref: improve description of option "create-reflog"
Date: Fri, 11 Sep 2015 09:47:39 -0700
Message-ID: <xmqq613g2990.fsf@gitster.mtv.corp.google.com>
References: <1441987453-22125-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, worldhello.net@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 18:47:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaRUN-0005oG-6B
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 18:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbbIKQrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 12:47:42 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33694 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbIKQrl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 12:47:41 -0400
Received: by pacex6 with SMTP id ex6so79747556pac.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=955HX4aA04I1WZq4jVy3hEbpfhWzDT6JLonblkJhmP4=;
        b=IowLHVmF1mDSC+IurzWqsmNw4/u9YocCFPjPwZ6SMkB9uMOq00AKqnM99ZUYDJbb6O
         jUWFTya/TU/Y/8vl9YsR7U9V8drrUbR072dmLeX11mpvHnQM47xFacKZm0DRWwPVsuX9
         chd6yYPr9qnt9vQM9KqoPAygiojf4T8epAuM27jnMs1d13nyzTG7ODirM7tm6PwgNQbN
         VixdoyIX9Vpe7sbaRIfTdYIdwAmHVnac39byCSVjOiQQtp6AXGxxtu0iWk2JoVTuNb93
         UrtXwSH+0levdP3bM682DzV7mSoSlMRdAmNtig7Ug8Z7uPBd4pGKTbTAM9bUH67RZbTa
         mEiA==
X-Received: by 10.68.226.134 with SMTP id rs6mr97983764pbc.11.1441990061057;
        Fri, 11 Sep 2015 09:47:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id bc1sm1294625pbb.66.2015.09.11.09.47.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 09:47:40 -0700 (PDT)
In-Reply-To: <1441987453-22125-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Fri, 11 Sep 2015 18:04:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277681>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> The description of option "create-reflog" is "create_reflog", which
> is neither a good description, nor a sensible string to translate.
> Change it to a more meaningful message.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---

This definitely is an improvement.  I will assume i18n team is OK
with a change like this this late in the cycle (I see you CC'ed
Jiang) and will merge before the next -rc.

Thanks.

>  builtin/tag.c        | 2 +-
>  builtin/update-ref.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index cccca99..cba0e22 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -606,7 +606,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
>  					N_("use another key to sign the tag")),
>  		OPT__FORCE(&force, N_("replace the tag if exists")),
> -		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create_reflog")),
> +		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create a reflog")),
>  
>  		OPT_GROUP(N_("Tag listing options")),
>  		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 04dd00f..7f30d3a 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -365,7 +365,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
>  					N_("update <refname> not the one it points to")),
>  		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
>  		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
> -		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create_reflog")),
> +		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
>  		OPT_END(),
>  	};
