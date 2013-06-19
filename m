From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: Update 'linux-2.6.git' -> 'linux.git'
Date: Tue, 18 Jun 2013 22:05:50 -0700
Message-ID: <CAJDDKr75PwVjJ-hs=1eBQEKG0O7FaZROfHRT-oujANeFN-ErMw@mail.gmail.com>
References: <cover.1371606791.git.wking@tremily.us>
	<3286ddfe2dd6cbf9c435bd7f9eb579782eb32e1f.1371606791.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Jun 19 07:05:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpAah-0003K5-6e
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 07:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab3FSFFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 01:05:51 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55752 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab3FSFFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 01:05:50 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so4762692pac.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 22:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n96BpGGubXPFtP8T/5JPqSyrKhjAObnKjT72rRvxg/Q=;
        b=Zs9b3SjAhhIm0mQjsE3KsQYR+jY0sKVZRXZhHLE7XjsuIHVGjVWgUEsdDlJgqG6kl2
         B8Tzr9s19EtQGv2EeOVLqXrDlYkQ0fiwvd6sXyGvdMN0AqEj8NBUGWKEFlTz9at1o5f3
         um/GCY87D8KgTRO39SDZymevztZL2ugjih6XsEW/rbm8Y5PDZrKCzA5zSHtx5SttLavx
         149M4MYbVEta3rGIa+b2E5puNvSOKDycqUTjEufzq7L9h8K+0Bqtf2D3VIM8EghMGEDa
         uAywx0pC6iLxTPqR7C4ZbTh9DPCTE3Et0hcC6NWmNVknJF5ibJ6lTFpt6PlbyFokZgET
         7F8A==
X-Received: by 10.66.160.101 with SMTP id xj5mr5089696pab.5.1371618350079;
 Tue, 18 Jun 2013 22:05:50 -0700 (PDT)
Received: by 10.70.20.161 with HTTP; Tue, 18 Jun 2013 22:05:50 -0700 (PDT)
In-Reply-To: <3286ddfe2dd6cbf9c435bd7f9eb579782eb32e1f.1371606791.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228339>

On Tue, Jun 18, 2013 at 6:55 PM, W. Trevor King <wking@tremily.us> wrote:
> From: "W. Trevor King" <wking@tremily.us>
>
> The 3.x tree has been out for a while now.  The -2.6 repository name
> survived the initial release [1], but kernel.org now only lists
> 'linux.git' (for aegl as well as torvalds) [2].
>
> [1]: http://article.gmane.org/gmane.linux.kernel/1147422
>   On 2011-05-30 01:47:57 GMT, Linus Torvalds wrote:
>   > ... yes, that means that my git tree is still called
>   > "linux-2.6.git" on kernel.org.
> [2]: http://git.kernel.org/cgit/
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/git-clone.txt       | 2 +-
>  Documentation/git-fast-export.txt | 2 +-
>  Documentation/user-manual.txt     | 6 +++---
>  t/perf/README                     | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index a0727d7..8e5260f 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -274,7 +274,7 @@ $ git clone --bare -l /home/proj/.git /pub/scm/proj.git
>  * Create a repository on the kernel.org machine that borrows from Linus:
>  +
>  ------------
> -$ git clone --bare -l -s /pub/scm/.../torvalds/linux-2.6.git \
> +$ git clone --bare -l -s /pub/scm/.../torvalds/linux.git \
>      /pub/scm/.../me/subsys-2.6.git

Perhaps subsys.git instead of subsys-2.6.git too?
--
David
