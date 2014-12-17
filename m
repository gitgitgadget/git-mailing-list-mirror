From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] builtin/remote.c: add missing space to user-facing message
Date: Wed, 17 Dec 2014 04:44:30 -0500
Message-ID: <CAPig+cQeLLyHTsaD=9xsN9AQxXcnZkMBaz+cyaop6zp48wJE5Q@mail.gmail.com>
References: <20141217022034.5259c7879ecedd905f9ba633@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 10:44:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1B9p-0005R8-RP
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 10:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbaLQJoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 04:44:32 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:41528 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaLQJob (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 04:44:31 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so7477756yhl.9
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 01:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=G/ljUORvvSqvJPS3YQ62vXRNF+zuG5mqXgaMHJg9wQc=;
        b=WsfMPWgfpp2EZUBJC/EY2awRUXME9HFGj2SitUVuqaDfjWmS020to3zsOl5lITc3TJ
         /PZY6hzcWlFTsAIQuQSf5RlqpoPMr5y2hiTy1W77HwwHUezMwLCE8YI97C3UO2+8QjsE
         +hfUESP7os3RfOkMYy012dHhfROfnow+s/r1JEhhSq/2fTGVEqt0PXrw52yZmx0xCOYU
         JViGEvsIHZ2OYjHB53EJ8TxnkMBYtyhAr50aKJMaeBAURQ1NRow3bYbwKzD8gV9TZbqT
         Dq5ZusHHlPHa8WfIeqeGOPRw7eygA5GXuyEhiBpFmqsEtS9LSBLKPgGnpcU/vXZeEgMx
         N7Gw==
X-Received: by 10.236.8.100 with SMTP id 64mr30159119yhq.112.1418809470855;
 Wed, 17 Dec 2014 01:44:30 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Wed, 17 Dec 2014 01:44:30 -0800 (PST)
In-Reply-To: <20141217022034.5259c7879ecedd905f9ba633@gmail.com>
X-Google-Sender-Auth: auOww-VdyMcN1cNTj-ovcsnUmes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261477>

On Wed, Dec 17, 2014 at 4:20 AM, Alex Henrie <alexhenrie24@gmail.com> wrote:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 7f28f92..c55c7ce 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -13,7 +13,7 @@ static const char * const builtin_remote_usage[] = {
>         N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>"),

This line also has a couple instance of missing spaces.

>         N_("git remote rename <old> <new>"),
>         N_("git remote remove <name>"),
> -       N_("git remote set-head <name> (-a | --auto | -d | --delete |<branch>)"),
> +       N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch>)"),
>         N_("git remote [-v | --verbose] show [-n] <name>"),
>         N_("git remote prune [-n | --dry-run] <name>"),
>         N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
> --
> 2.1.3
