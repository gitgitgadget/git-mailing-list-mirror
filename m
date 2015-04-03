From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] improve documentation for some commands that use pathspecs
Date: Fri, 3 Apr 2015 20:57:45 +0700
Message-ID: <CACsJy8AW0vj2SWpzocJpXkrgJB93x8Zb1p9YVQZE1SVh4G7COg@mail.gmail.com>
References: <20150331152224.GA16617@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Joey Hess <joeyh@joeyh.name>
X-From: git-owner@vger.kernel.org Fri Apr 03 15:58:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye27C-0008Mh-H0
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 15:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbbDCN6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 09:58:24 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33646 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbbDCN6P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 09:58:15 -0400
Received: by iebmp1 with SMTP id mp1so84348256ieb.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qW4nbLHXe5pn/FnDHlzavr/ztx4uKMQW292xkdqk0A4=;
        b=I8Sh7iP7mI7NLKvlXqklCrelchKElsOm28ZhX0Flb6EKKGgw2dnCcQ1Q0wyXJaLaEx
         m+HylNtKX499gI8yOxSBzd7rSCTNtu57pMf/oTNiaXc7HJ/smMYqnjURUZBaPJq1CvOy
         zWiHPAWn24qUhD+6tx/OqgG1QhotdFWoKxIB53YCtOU4YPoQS7bAzRx62O3Am6w71vI0
         Z9v0V71RhHKPjyxK5Ze0EFWI/oV4BcqmsclBoUN5p3g9Ak+iaRmcig3p1WgQZQbX3UpD
         T8qg89if/60uIlaBgSEOwLZWrKHYSmkzrBYWJLTPKLKZ1YAujJ1tr9DNRTgyVmI5juhq
         sYoQ==
X-Received: by 10.42.82.199 with SMTP id e7mr4066962icl.18.1428069495232; Fri,
 03 Apr 2015 06:58:15 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Fri, 3 Apr 2015 06:57:45 -0700 (PDT)
In-Reply-To: <20150331152224.GA16617@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266707>

On Tue, Mar 31, 2015 at 10:22 PM, Joey Hess <joeyh@joeyh.name> wrote:
> After being surprised that git-ls-files expands pathspecs, here's a patch
> that would have saved me.
> ---
>  Documentation/git-ls-files.txt | 9 +++++----
>  Documentation/git-ls-tree.txt  | 8 ++++----
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index e26f01f..f7a3039 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -17,7 +17,7 @@ SYNOPSIS
>                 [--exclude-per-directory=<file>]
>                 [--exclude-standard]
>                 [--error-unmatch] [--with-tree=<tree-ish>]
> -               [--full-name] [--abbrev] [--] [<file>...]
> +               [--full-name] [--abbrev] [--] [<pathspec>...]

Just a note that "git ls-files -h" still says "<file>", from
ls_files_usage in builtin/ls-files.c
-- 
Duy
