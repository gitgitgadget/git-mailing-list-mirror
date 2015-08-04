From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] Documentation/git-worktree: fix duplicated 'from'
Date: Tue, 4 Aug 2015 14:27:26 -0400
Message-ID: <CAPig+cSghsmoEcmJnmO48GyF_VDpKPuOCafm4n+YFCwRE7+D-Q@mail.gmail.com>
References: <1438691278-31609-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Tue Aug 04 20:27:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMgvz-0004aQ-Ro
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 20:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbbHDS11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 14:27:27 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35795 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbbHDS11 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 14:27:27 -0400
Received: by ykcq64 with SMTP id q64so10462212ykc.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Yi4O9o7QI5jyUq8XuLGmi015B0Z4lGjI0rrqyYR6YXs=;
        b=gF4CwYv+SJxghQvBpRa9oH4/obDhRc3POkJzG73uw+lE/NO+oF+siKMM0l0C7qQZos
         HiBNtWi7jmQEfwbdOklNy1rDOOzN4xBuBuWR/7gEOG/T9lW5RbEZX9Pg0iNURDBBE+71
         dc0Fg8/eSXfKKj5u4YXHfvecvQasGcYGfABitCRL6ZELhlpwsvlntNcc/1sHluF1GAP9
         uN1q7tztvnRWucrztYHeNgPZqyggQyobeZj6kVsKjfPRoyRnuDXz2PLfcjHgko6qpyTn
         7cESbCzpXSFposyLANwSsH1Rq9PaysfI9DO/zg76ppOIaaZ9ez+8ALDztwRpBupdlNQ6
         JLVw==
X-Received: by 10.129.76.140 with SMTP id z134mr5265608ywa.17.1438712846668;
 Tue, 04 Aug 2015 11:27:26 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 4 Aug 2015 11:27:26 -0700 (PDT)
In-Reply-To: <1438691278-31609-1-git-send-email-ps@pks.im>
X-Google-Sender-Auth: F_MP4NEpjAssCAPnDdM8ElUBqQE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275331>

On Tue, Aug 4, 2015 at 8:27 AM, Patrick Steinhardt <ps@pks.im> wrote:
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 3387e2f..566ca92 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -124,7 +124,7 @@ thumb is do not make any assumption about whether a path belongs to
>  $GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
>  inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
>
> -To prevent a $GIT_DIR/worktrees entry from from being pruned (which
> +To prevent a $GIT_DIR/worktrees entry from being pruned (which

Thanks. I vaguely recall spotting this repetition when preparing to
move this chunk of text from git-checkout.txt to git-worktree.txt[1],
and planned on fixing it in a follow-on patch (such as [2,3,4,5]), but
forgot about it. For what it's worth (though certainly not necessary
for such an obviously correct path):

Acked-by: Eric Sunshine <sunshine@sunshineco.com>

[1]: 93a3649 (Documentation: move linked worktree description from
checkout to worktree, 2015-07-06)
[2]: 6d3824c (Documentation/git-worktree: add BUGS section, 2015-07-06)
[3]: af189b4 (Documentation/git-worktree: split technical info from
general description, 2015-07-06)
[4]: a8ba5dd (Documentation/git-worktree: add high-level 'lock'
overview, 2015-07-06)
[5]: 9645459 (Documentation/git-worktree: add EXAMPLES section, 2015-07-06)

>  can be useful in some situations, such as when the
>  entry's working tree is stored on a portable device), add a file named
>  'locked' to the entry's directory. The file contains the reason in
> --
> 2.5.0
