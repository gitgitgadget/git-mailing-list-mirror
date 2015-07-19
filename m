From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/6] config.txt: refer to "git worktree prune", not "prune --worktree"
Date: Sat, 18 Jul 2015 23:08:50 -0400
Message-ID: <CAPig+cQGT1=97uN1EiAWqw4yaxQJJE-UsvxOQCjLkO2wXCu4xQ@mail.gmail.com>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
	<47bb6cfeed994694bf333facb5956583da9b934b.1437271363.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 19 05:08:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGeyG-0003x5-2b
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 05:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbbGSDIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 23:08:51 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36378 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbbGSDIv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 23:08:51 -0400
Received: by ykay190 with SMTP id y190so117066977yka.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 20:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HAYEZzMjhk9CpdTtRjtf1NvtFWCN5pwPqO0FCXjLvoQ=;
        b=nk4nJnnnoGC4H5MCBPEGBlPv0iOaHaOwiFn+8o0Dmb3ZANNT/jtiXQLw1mbZDpCDt3
         ARTTQMGdmZEauf0TccDP0vcOvJoEjGA+vaX4f/rdrzlXCn9m7+W4MJ8mSv822fZpMrs5
         qck7M3yAtiKPtPCggq++/AAoAT4AXnxZry/hhRUp6KSkUZOo0PqcUwNqWjNCLZuhjWFQ
         oPrvQjWM0MwI8UeNg8DvguR2GAmVxh7eVjWovxlxOptHVnCo7Z7uYK/LWM2WZlZY3mZt
         zxb+WOYL3O+lopaDUlchgNb3e9VzJ6LV9Jq8jiJR+iOcy4ioA77JBQkjYix1+OBGKw4T
         7TZA==
X-Received: by 10.13.192.132 with SMTP id b126mr22003078ywd.163.1437275330456;
 Sat, 18 Jul 2015 20:08:50 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 18 Jul 2015 20:08:50 -0700 (PDT)
In-Reply-To: <47bb6cfeed994694bf333facb5956583da9b934b.1437271363.git.mhagger@alum.mit.edu>
X-Google-Sender-Auth: jjtSx29YxJb3QbK4iXDcJllFVfk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274197>

On Sat, Jul 18, 2015 at 10:10 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> The latter doesn't exist.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Documentation/config.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 3e37b93..7f65dbb 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1293,7 +1293,7 @@ gc.pruneExpire::
>
>  gc.pruneWorktreesExpire::
>         When 'git gc' is run, it will call
> -       'prune --worktrees --expire 3.months.ago'.
> +       'git worktree prune --expire 3.months.ago'.

Looks good. This appears to be the last reference to "prune --worktrees".

>         Override the grace period with this config variable. The value
>         "now" may be used to disable the grace period and prune
>         $GIT_DIR/worktrees immediately.
