From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit PATCH] Remove most ASSERT warnings in Git::setStatus
Date: Sun, 20 May 2007 14:53:05 +0200
Message-ID: <e5bfff550705200553q757c334el7aa5aed393052616@mail.gmail.com>
References: <200705201401.35991.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Michael <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sun May 20 14:53:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpkuV-0001C8-7T
	for gcvg-git@gmane.org; Sun, 20 May 2007 14:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660AbXETMxK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 08:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755716AbXETMxK
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 08:53:10 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:49404 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660AbXETMxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 08:53:09 -0400
Received: by nz-out-0506.google.com with SMTP id z3so47275nzf
        for <git@vger.kernel.org>; Sun, 20 May 2007 05:53:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D70qULnVtuqwjg3x0C1iOhIssv+sZzyDSTqiVGps0QMbSrLjeFMti4TLckT4STnc3XynZZn5x9yGDYaEOJRFnrZQSQl6MUL2AobV3+0zTzSwyAZe3XwtMuJhXesizglYtg1cKVknwuGkktwYJZgweuB90wiyyuMEuJwzjRuaXCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SyOQmFNX9iuyIw1wDRQIo/plW8Lt/NDgqHZYRRx/L10ZXdxJQcqFkHZrKuF0v9qRdAj/zOT/+g3M1Isn5FAsfUfFJcZNGduDAwQGCjfDt5zbYFjaK/B3rHgyyBcDZQrM03JYmuR925RroxsOlrB4OoPSMyirAfGRAZjL+s2i07w=
Received: by 10.114.36.1 with SMTP id j1mr2019508waj.1179665585166;
        Sun, 20 May 2007 05:53:05 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 20 May 2007 05:53:05 -0700 (PDT)
In-Reply-To: <200705201401.35991.barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47834>

On 5/20/07, Michael <barra_cuda@katamail.com> wrote:
> Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
> ---
>
> ...is this correct?
>
>  src/git_startup.cpp |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/src/git_startup.cpp b/src/git_startup.cpp
> index a99edba..17312f9 100644
> --- a/src/git_startup.cpp
> +++ b/src/git_startup.cpp
> @@ -329,7 +329,7 @@ void Git::parseDiffFormatLine(RevFile& rf, SCRef line, int parNum) {
>
>                 // TODO rename/copy is not supported for combined merges
>                 appendFileName(rf, line.section('\t', -1));
> -               setStatus(rf, line.section(' ', 6, 6).left(1));
> +               setStatus(rf, line.section('\t', -2, -2).right(1));
>                 rf.mergeParent.append(parNum);
>         } else { // faster parsing in normal case
>
> --
> 1.5.1.2
>

Where do you see the ASSERT? could  you link me to the test repository
when you see that warnings?

I would like to understand better what causes the warnings.

Thanks
Marco
