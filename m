From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/6] worktree: the "locked" mechanism is already implemented
Date: Sat, 18 Jul 2015 23:06:49 -0400
Message-ID: <CAPig+cRSWWnWyV2HJVjS9MkAxv_gLk=KauSbNvw_3k2N_rkuVg@mail.gmail.com>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
	<afdc2580349017ae26aade63c9e5ea2b4a986beb.1437271363.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 19 05:06:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGewJ-0003Dw-Cw
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 05:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbbGSDGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 23:06:51 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35406 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbbGSDGu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 23:06:50 -0400
Received: by ykdu72 with SMTP id u72so117066254ykd.2
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 20:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LAx8Ee82iijPXvIoDlsnJfTKMngTUG9fF3GmAlE0Pks=;
        b=c9NLd7zBCQqJUokU1MIbQ/08VqCMkjgteiylzLSlIY/CGeN5EDRIb/2xUdPzoHvXnF
         hXgcGmchga+Z2pNGmguaWYRcfTl1kvNhxdKSEvAQjJXgEU1bymR/Wf7vnUf0Q11m7E1i
         Y2Q+3cerniTYpW18Ox4oZlW8Xz3WL6qq/qf8/C+7+47ViWFojddd2lONB2xtVu+/xyrC
         bfUWsFyNO59Jw70eptGL5ovHBplvaKrAdr09k4Xo4qwvpbrl+y44lXOyBqVBuC49lry0
         4/Ghb8bzEWsd60D7I2yUN1Db7QdZhjz/Eys+HmiUP8LEDFRivCyv5fDcN+F0kjtBbMqH
         Q7hQ==
X-Received: by 10.129.91.87 with SMTP id p84mr22754935ywb.95.1437275209731;
 Sat, 18 Jul 2015 20:06:49 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 18 Jul 2015 20:06:49 -0700 (PDT)
In-Reply-To: <afdc2580349017ae26aade63c9e5ea2b4a986beb.1437271363.git.mhagger@alum.mit.edu>
X-Google-Sender-Auth: nlUdHUOhy-LFTh85hTWLoxL5v3o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274196>

On Sat, Jul 18, 2015 at 10:10 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> So remove it from the "BUGS" section.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Documentation/git-worktree.txt | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 6cb3877..d5aeda0 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -167,8 +167,6 @@ performed manually, such as:
>    warn if the worktree is dirty)
>  - `mv` to move or rename a worktree and update its administrative files
>  - `list` to list linked working trees
> -- `locked` to prevent automatic pruning of administrative files (for instance,
> -  for a worktree on a portable device)

This patch should be dropped. This BUGS item is not referring to the
low-level implementation of locking, but rather to the proposed user
interface command ("git worktree lock") for manipulating the 'locked'
file so that the user doesn't need detailed knowledge about the
underlying implementation.
