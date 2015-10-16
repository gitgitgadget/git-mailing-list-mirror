From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: add angle brackets to usage string
Date: Fri, 16 Oct 2015 10:46:10 -0700
Message-ID: <xmqqziziemfx.fsf@gitster.mtv.corp.google.com>
References: <1444962133-1266-1-git-send-email-alexhenrie24@gmail.com>
	<20151016172455.GA18751@ralf-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alex Henrie <alexhenrie24@gmail.com>, pyokagan@gmail.com,
	git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:46:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn957-0006Q0-7u
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 19:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbbJPRqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 13:46:12 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34614 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbbJPRqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 13:46:12 -0400
Received: by pacez2 with SMTP id ez2so10593601pac.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UuabRSVJbyTUPdXIyUt1I51aOTQt/LRbsBJQv3LqHQs=;
        b=EGC0d75Z2v7zEz+Q8doPTz4eigYpqe6lEOLwbyT9FovKrajb5oq8yomUAZ5YkMOBjg
         VNpV3zQL1WJ5mmCT8xCDww4hl8PcM8q892qZ0qnL5nhLH9HzZBtqC61mNrWqJadKQsE2
         B6GIs/wTYxDOT9xnQg8weM+3er+0C6OizYhlTpmwh3B4qssoZb+sBqtttM6XyZPRKi0c
         StN3MWnVTsqYuiqlJCyNgrdAhy0ldRuJuIfE8BVl9GhefiR5l8Vur8CHRW2DsKLe4GHy
         mHhU2LxuvwFMVEiGxKHm86VQxOIriTIBWiYf+hRVE9aVlstQiwR+4Q3bbA3/8ult9FKD
         tASg==
X-Received: by 10.68.65.13 with SMTP id t13mr18060723pbs.43.1445017571348;
        Fri, 16 Oct 2015 10:46:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id fx4sm22328285pbb.92.2015.10.16.10.46.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 10:46:10 -0700 (PDT)
In-Reply-To: <20151016172455.GA18751@ralf-ubuntu> (Ralf Thielow's message of
	"Fri, 16 Oct 2015 19:24:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279760>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> There seem to be three more places left missing these angle brances
> at the usage string.
> Junio, feel free to squash this or treat it as a separate patch
> on top, if suitable.

Thanks. Will queue.

>
> -- >8 --
> From: Ralf Thielow <ralf.thielow@gmail.com>
> Date: Fri, 16 Oct 2015 19:09:57 +0200
> Subject: [PATCH] am, credential-cache: add angle brackets to usage string
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  builtin/am.c       | 4 ++--
>  credential-cache.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 4f77e07..98992cd 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2218,8 +2218,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>  	int in_progress;
>  
>  	const char * const usage[] = {
> -		N_("git am [options] [(<mbox>|<Maildir>)...]"),
> -		N_("git am [options] (--continue | --skip | --abort)"),
> +		N_("git am [<options>] [(<mbox>|<Maildir>)...]"),
> +		N_("git am [<options>] (--continue | --skip | --abort)"),
>  		NULL
>  	};
>  
> diff --git a/credential-cache.c b/credential-cache.c
> index 8689a15..f4afdc6 100644
> --- a/credential-cache.c
> +++ b/credential-cache.c
> @@ -88,7 +88,7 @@ int main(int argc, const char **argv)
>  	int timeout = 900;
>  	const char *op;
>  	const char * const usage[] = {
> -		"git credential-cache [options] <action>",
> +		"git credential-cache [<options>] <action>",
>  		NULL
>  	};
>  	struct option options[] = {
