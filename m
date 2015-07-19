From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/6] worktree: consistently use term "linked working tree"
 in manpages
Date: Sat, 18 Jul 2015 22:54:29 -0400
Message-ID: <CAPig+cSYO5FOXpbbA6sTSTFX0TB9mXaNu+1K7nvYHDncoOwJ6g@mail.gmail.com>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
	<097393a343401706ac8041eb01a9e61949a31d2d.1437271363.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 19 04:54:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGekO-0007LA-Sw
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 04:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbbGSCya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 22:54:30 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:32947 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbbGSCya (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 22:54:30 -0400
Received: by ykfw194 with SMTP id w194so36826130ykf.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 19:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jVD/dBRHbHtRO0oMroaXR17rWvEXLf27eUIzf2RcalU=;
        b=s9zHgVpeVX07QFqccbejbHLmPLiGoTdzVpG2Wkw+zAPXH7yeo2YcYGSxbnF4HUAb2g
         3nDOVvQAPstfWbS5eTBWTNkAom5Pd3yvblZDpKHAMtUq8J4cDIDv5kloSVK9Mq40AVKj
         zXmJV68SQd9wwz8jbgemDD4S/slPKBVIswoDQHy9hZQTWh4QZBk/KFI0ighbACd8VxS+
         jmSPMdWrxcmTHiXgp+F8P04ea29mARHjv02PBo1NOnwjNju2cdSo8kFBCSvHkDTQ1ySb
         ZCp1G67YktymJYvFqJyLbQb75APuh5pYzFeAfY711GffHrRdm54+AxL+n+FEY5isq3n/
         kO5A==
X-Received: by 10.170.97.9 with SMTP id o9mr22263966yka.84.1437274469696; Sat,
 18 Jul 2015 19:54:29 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 18 Jul 2015 19:54:29 -0700 (PDT)
In-Reply-To: <097393a343401706ac8041eb01a9e61949a31d2d.1437271363.git.mhagger@alum.mit.edu>
X-Google-Sender-Auth: 0YX-8SN-PlyGjL36u2_OilcJaRM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274193>

On Sat, Jul 18, 2015 at 10:10 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Sometimes linked working trees were called "linked working
> directories" or "linked worktrees". Always refer to them as "linked
> working trees" for consistency.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index da71f50..c8dd0e5 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -141,7 +141,7 @@ demands that you fix something immediately. You might typically use
>  linkgit:git-stash[1] to store your changes away temporarily, however, your
>  worktree is in such a state of disarray (with new, moved, and removed files,

Was your intention to replace all instances of "worktree" with
"working tree" or just some? If only some, what is the criteria by
which you decide? I ask because several instances of "worktree" (such
as the one above) remain even after this patch.

>  and other bits and pieces strewn around) that you don't want to risk
> -disturbing any of it. Instead, you create a temporary linked worktree to
> +disturbing any of it. Instead, you create a temporary linked working tree to
>  make the emergency fix, remove it when done, and then resume your earlier
>  refactoring session.
