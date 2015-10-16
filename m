From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] pull: add angle brackets to usage string
Date: Fri, 16 Oct 2015 19:24:55 +0200
Message-ID: <20151016172455.GA18751@ralf-ubuntu>
References: <1444962133-1266-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pyokagan@gmail.com, git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 16 19:25:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn8kd-0006lj-LK
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 19:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbbJPRZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 13:25:00 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36852 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbbJPRZA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 13:25:00 -0400
Received: by wicgb1 with SMTP id gb1so18077823wic.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xes60MTs7aHCCM6qs7a/WybZ3fDIvqAHisnCkpTWvDM=;
        b=OWvtKn/YVO7W8j2SgerK24Y9PDHLrjUuFW0MVXmfxSDIbj8Q/tlVk87z8mE+BcPr39
         m6hZKue7MPhkLhkV0O2yFcx6e1dWcrFdEVjCsUNJV2acKsLkBI6/jQj6oX39FuG2wEnQ
         ZMD671MYqs8PDlc/y+arlRo2DxQxW7eNz5MQJzoSckvpvtIIPyEEYvJTN9QyMu/YoU5P
         vHmZDiqSxVds6q9EFI3BEUzn33vek5KbvMhkG7ZPTZQGOlrqT1j9IjmQRuoJ6aF8IZ/o
         pfpa1e9oXYCzMZurNEF0TFn8y/jMpkFVuedQn8yQQjSvD4rMtEIzLvDMxIhZKvIqlHZb
         8JMQ==
X-Received: by 10.194.171.3 with SMTP id aq3mr18561515wjc.54.1445016298291;
        Fri, 16 Oct 2015 10:24:58 -0700 (PDT)
Received: from localhost (cable-94-139-9-57.cust.telecolumbus.net. [94.139.9.57])
        by smtp.gmail.com with ESMTPSA id bf8sm23650636wjc.22.2015.10.16.10.24.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Oct 2015 10:24:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444962133-1266-1-git-send-email-alexhenrie24@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279755>

Alex Henrie <alexhenrie24@gmail.com> wrote:
> ---
>  builtin/pull.c               | 2 +-
>  contrib/examples/git-pull.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/pull.c b/builtin/pull.c
> index a39bb0a..bf3fd3f 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -66,7 +66,7 @@ static int parse_opt_rebase(const struct option *opt, const char *arg, int unset
>  }
>  
>  static const char * const pull_usage[] = {
> -	N_("git pull [options] [<repository> [<refspec>...]]"),
> +	N_("git pull [<options>] [<repository> [<refspec>...]]"),
>  	NULL
>  };


There seem to be three more places left missing these angle brances
at the usage string.
Junio, feel free to squash this or treat it as a separate patch
on top, if suitable.

-- >8 --
From: Ralf Thielow <ralf.thielow@gmail.com>
Date: Fri, 16 Oct 2015 19:09:57 +0200
Subject: [PATCH] am, credential-cache: add angle brackets to usage string

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/am.c       | 4 ++--
 credential-cache.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4f77e07..98992cd 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2218,8 +2218,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	int in_progress;
 
 	const char * const usage[] = {
-		N_("git am [options] [(<mbox>|<Maildir>)...]"),
-		N_("git am [options] (--continue | --skip | --abort)"),
+		N_("git am [<options>] [(<mbox>|<Maildir>)...]"),
+		N_("git am [<options>] (--continue | --skip | --abort)"),
 		NULL
 	};
 
diff --git a/credential-cache.c b/credential-cache.c
index 8689a15..f4afdc6 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -88,7 +88,7 @@ int main(int argc, const char **argv)
 	int timeout = 900;
 	const char *op;
 	const char * const usage[] = {
-		"git credential-cache [options] <action>",
+		"git credential-cache [<options>] <action>",
 		NULL
 	};
 	struct option options[] = {
-- 
2.6.1.339.g81d1034
