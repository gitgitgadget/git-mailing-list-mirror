From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] worktree: usage: denote <branch> as optional with 'add'
Date: Sun, 18 Oct 2015 23:35:54 -0700
Message-ID: <xmqqr3kr9xh1.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cRXq9qonwPpWQdnrFkJgQQW0zDokXQhSvw5n07d7OpqdQ@mail.gmail.com>
	<1445229893-4179-1-git-send-email-tigerkid001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 08:36:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo436-0001lA-Hn
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 08:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbbJSGf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 02:35:56 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36173 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbbJSGf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 02:35:56 -0400
Received: by pacfv9 with SMTP id fv9so85446175pac.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 23:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=976HIrNda3wsrAHMmas9xj4n49X3atPDnoSpZiInmXY=;
        b=IaRs+eKY8PDkUtI4b+hTa1d0wVxSMi0kefjlU4Ob89eDdfX4RxJndvF+5OZbeN1IWR
         S97CBJPr8N7lMald8G/7XuVW3eucm78QKLmQFzAc7IJ54Tkfj6yGb/ii7rnLZluW8QOy
         e79Nvmz4EO5cV44GRLHCSTapEjwne76uBTtDKBulRlZlxNRftfDpgKSU8XzwwapndeT9
         MsyPBL55S1FJZspbIA1TDr9Iyqdc1Nelsvi59JUb36QphkI57HfmGJmVVN/wBtFb2ILD
         +0d98aZHDNQ+DHUKLcIBD8P4poWERtD87NpM5S0fs2QustZXKBvd/ghK65qcNeRmdnjj
         rpXw==
X-Received: by 10.66.139.201 with SMTP id ra9mr32841002pab.153.1445236555621;
        Sun, 18 Oct 2015 23:35:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id lo9sm34510719pab.19.2015.10.18.23.35.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Oct 2015 23:35:55 -0700 (PDT)
In-Reply-To: <1445229893-4179-1-git-send-email-tigerkid001@gmail.com> (Sidhant
	Sharma's message of "Mon, 19 Oct 2015 10:14:53 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279830>

Sidhant Sharma <tigerkid001@gmail.com> writes:

> Although 1eb07d8 (worktree: add: auto-vivify new branch when
> <branch> is omitted, 2015-07-06) updated the documentation when
> <branch> became optional, it neglected to update the in-code
> usage message. Fix this oversight.
>
> Reported-by: ch3cooli@gmail.com
> Signed-off-by: Sidhant Sharma <tigerkid001@gmail.com>
> ---

Thanks.

I'll add "Helped-by: Eric Sunshine <sunshine@sunshineco.com>" and
queue.

>  builtin/worktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 71bb770..33d2d37 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -10,7 +10,7 @@
>  #include "refs.h"
>
>  static const char * const worktree_usage[] = {
> -	N_("git worktree add [<options>] <path> <branch>"),
> +	N_("git worktree add [<options>] <path> [<branch>]"),
>  	N_("git worktree prune [<options>]"),
>  	NULL
>  };
> --
> 2.6.2
