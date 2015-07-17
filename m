From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Documentation/git: fix stale "MULTIPLE CHECKOUT MODE" reference
Date: Thu, 16 Jul 2015 20:19:17 -0400
Message-ID: <CAPig+cShY2Op9ET9xcbvvQmM33fnrbDLR2ft2SELzqJTdg-D4w@mail.gmail.com>
References: <1437092222-11131-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 17 02:19:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFtNE-0007WB-3r
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 02:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756408AbbGQATS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 20:19:18 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34892 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032AbbGQATR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 20:19:17 -0400
Received: by ykdu72 with SMTP id u72so77798472ykd.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 17:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hUXJnuuCbTgIe3YNaPsWbp90ULTlgu2toHAqMUPqk+4=;
        b=vlMEqp0wu9aMHhzP5pHHb+bX6UwZj5uXIAGbJBRgLqRVfKBwiOenvLog3nyef0PM6E
         q47vuKHnkC26DSXVWyhde6zgbaQQt/WZ6JVRelMKRzEXAySck1uza4HZ94RZ8uFPw7lj
         kqZ8gNmDeWRotjDZXxl2IoFJGM1YYi7X0kyI+hH2nNDTYgbK7LW7l1hiAFfaGXhjFmpw
         A7SXQIWQZL5gDV0oWZhxZM/J61qpJq2dV0FoMEtRmOxBhPFSUICse+B4M1fQLLbr7ycl
         3+j01l+kv3NUjktHZBm8Av7GMoylmCv8v2C3YL40wMH3yOuF3wqZq1ppxe/EeDLMs7KK
         lBRw==
X-Received: by 10.129.76.140 with SMTP id z134mr13343883ywa.17.1437092357100;
 Thu, 16 Jul 2015 17:19:17 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 16 Jul 2015 17:19:17 -0700 (PDT)
In-Reply-To: <1437092222-11131-1-git-send-email-sunshine@sunshineco.com>
X-Google-Sender-Auth: kVQ6Wrbb3UBgvYzO0uboZkQmnXE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274053>

On Thu, Jul 16, 2015 at 8:17 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> This should have been changed by 93a3649 (Documentation: move linked
> worktree description from checkout to worktree, 2015-07-06).
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index d4aa3f6..eb38027 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -845,7 +845,7 @@ Git so take care if using Cogito etc.
>         normally in $GIT_DIR will be taken from this path
>         instead. Worktree-specific files such as HEAD or index are
>         taken from $GIT_DIR. See linkgit:gitrepository-layout[5] and
> -       the section 'MULTIPLE CHECKOUT MODE' in linkgit:checkout[1]
> +       the linkgit:git-worktree[1] for

s/the//

>         details. This variable has lower precedence than other path
>         variables such as GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY...
