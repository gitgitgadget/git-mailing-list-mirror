From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] remote: Remove -v/--verbose option from git remote
 show synopsis
Date: Thu, 08 Jan 2015 20:17:23 +0100
Message-ID: <54AED7C3.8010604@web.de>
References: <1420739863-11602-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 20:18:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9Iae-0003MH-0U
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 20:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbbAHTRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 14:17:47 -0500
Received: from mout.web.de ([212.227.15.3]:60790 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbbAHTRq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 14:17:46 -0500
Received: from [192.168.178.27] ([79.253.173.145]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M5wkL-1XtxSZ0BqL-00xtSm; Thu, 08 Jan 2015 20:17:42
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1420739863-11602-1-git-send-email-kuleshovmail@gmail.com>
X-Provags-ID: V03:K0:mBY2yiMyhK7MOJ8PPmH2P7rJyRUEZX+xATxrEqRaV25Yr6LFMMN
 cYFrYgzneYxGI4i/Lk0j+eUzDGTyOJLe8/cGIMGc77ZnblNcTvLeE0Qx9DyE7WGYuseXNHK
 Va2E4Wyop1CANiXfD6/awRI53Y4rK7VZu2pbIvoiNIeZNrtIv2Cc390j9peyZ/hzJR52FsS
 sSEqZlYuDPCmcyRrVwCuA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262209>

Am 08.01.2015 um 18:57 schrieb Alexander Kuleshov:
> git remote show doesn't use -v/--verbose option

Hmm, but it does?

	$ git version
	git version 2.2.1
	$ git remote show
	origin
	$ git remote -v show
	origin  git://git.kernel.org/pub/scm/git/git.git (fetch)
	origin  git://git.kernel.org/pub/scm/git/git.git (push)

Perhaps you meant the following variant?  The changed line documents the 
one above, though (-v before show).

	$ git remote show -v
	error: unknown switch `v'
	usage: git remote show [<options>] <name>

	    -n                    do not query remotes

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>   builtin/remote.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 46ecfd9..978c645 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -14,7 +14,7 @@ static const char * const builtin_remote_usage[] = {
>   	N_("git remote rename <old> <new>"),
>   	N_("git remote remove <name>"),
>   	N_("git remote set-head <name> (-a | --auto | -d | --delete |<branch>)"),
> -	N_("git remote [-v | --verbose] show [-n] <name>"),
> +	N_("git remote show [-n] <name>"),
>   	N_("git remote prune [-n | --dry-run] <name>"),
>   	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
>   	N_("git remote set-branches [--add] <name> <branch>..."),
>
