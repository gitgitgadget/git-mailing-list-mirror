From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] worktree: Correct typo in documentation
Date: Thu, 30 Jul 2015 01:36:24 -0400
Message-ID: <CAPig+cSy7qVBwBznJDhzmx=YrPVd=GhTJkcG4Q5mh+3T5DgJGA@mail.gmail.com>
References: <1438211028-22403-1-git-send-email-j@1616.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Johan Sageryd <j@1616.se>
X-From: git-owner@vger.kernel.org Thu Jul 30 07:36:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKgW5-000823-GR
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 07:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbbG3FgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 01:36:25 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34973 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbbG3FgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 01:36:24 -0400
Received: by ykdu72 with SMTP id u72so26271078ykd.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 22:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9oxKmRYxTGEJXPynTVSb0FY3SH49No7JAqLTxmY1aAk=;
        b=zCOnFxpS/jvK8oA1sYBZMtBrUjjFbEIEAhq/70m4hlWr+wWfLwrEk5y6pl5oektIzz
         nIZpY9rZoKngFoBYyqrjS8jZD9S5vKRmxnHlwU7a52q8HrPV7gOy2wR+T2mwZ+wOpNwa
         R7rb/4PI9Lx7nHF16zbXIAv/0oYb7DvkhEs5q3/uwmTDLEueoV6oJoT/pXnS4i2UD9Pq
         DWVSTgqQFH8bwU0payRWGuWIHfvIJJGasEnvQTb+chpCpBx04B6W3t7SQdt75eXrJngC
         DvX264CBYyy5LwjctCWEcIiHHxlEynzC5wL+bstyKeBgUHmM2puBw4C/dgog8w0cbqW7
         ZsgQ==
X-Received: by 10.170.97.9 with SMTP id o9mr49153209yka.84.1438234584237; Wed,
 29 Jul 2015 22:36:24 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 29 Jul 2015 22:36:24 -0700 (PDT)
In-Reply-To: <1438211028-22403-1-git-send-email-j@1616.se>
X-Google-Sender-Auth: GJflVGkahtcN1fxrCeisBaFaja8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274969>

On Wed, Jul 29, 2015 at 7:03 PM, Johan Sageryd <j@1616.se> wrote:
> Signed-off-by: Johan Sageryd <j@1616.se>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 3387e2f..d9d90b5 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -39,7 +39,7 @@ repository so that they do not get automatically pruned.
>
>  If a linked working tree is stored on a portable device or network share
>  which is not always mounted, you can prevent its administrative files from
> -being pruned by creating a file named 'lock' alongside the other
> +being pruned by creating a file named 'locked' alongside the other
>  administrative files, optionally containing a plain text reason that
>  pruning should be suppressed. See section "DETAILS" for more information.

Thanks for the patch. This is already fixed in the 'next' branch by
2e73ab6 (Documentation/git-worktree: fix incorrect reference to file
"locked", 2015-07-20).
