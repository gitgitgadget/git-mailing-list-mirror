From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] doc: show usage of branch description
Date: Sat, 12 Sep 2015 16:44:46 -0700
Message-ID: <CA+P7+xqh0e+2aMZf8i-1hBc0fMgaz0UjVdboLv+L9+rBYBR85w@mail.gmail.com>
References: <74514591d4cd502eee06cde3e099e656@dscho.org> <1442098288-3316-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Sep 13 01:45:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZauTr-000089-27
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 01:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbbILXpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 19:45:08 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34148 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbbILXpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 19:45:07 -0400
Received: by igcpb10 with SMTP id pb10so68213186igc.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 16:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CWDKsxSTOdZwJ61CloEwHyjy70n9UdyHVzyzHYljSjw=;
        b=bR1k7yqfCwnp1nD2Aj0FRcyTD0cNM3bilrY70+IT0Cj+58HM4MYFVujSkBVvKgGHMn
         AiT5rKO233uJBwxqaw2HzZOsTifHJpnu3D4+W4GXpBHQhgzTc63kp/LIyk7RJ8Muiucw
         QbgY9arPrEJm0+trs2yEqNOpqsmHwPZD5VV03NZ7RzsnUMInAdWjkctIie0L8JUHZJHL
         MAJpEJxPahQgP8lnYfIV6JLgtJeKeKYbdvmkEuyRQTfz4Un28mKL7Hh9b2HTozoFI10C
         +3RRhbbL5jXNt3+JaUGvt/oPWUDh825pFfu2J+sQIxYI1Y9dg/6jGKcXAn5gRWjhGm7X
         aU3g==
X-Received: by 10.50.107.68 with SMTP id ha4mr7564203igb.35.1442101505946;
 Sat, 12 Sep 2015 16:45:05 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Sat, 12 Sep 2015 16:44:46 -0700 (PDT)
In-Reply-To: <1442098288-3316-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277741>

Hi,

On Sat, Sep 12, 2015 at 3:51 PM, Philip Oakley <philipoakley@iee.org> wrote:
> The branch description will be included in 'git format-patch
> --cover-letter' and in 'git pull-request' emails. Tell the reader.
>
> While here, clarify that the description may be a multi-line
> explanation of the purpose of the branch's patch series.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>
> This is a short doc patch to follow up $gmane/277628 where Johannes
> Schindelin noted this otherwise undocumented feature.
>

Thanks for this.

>
>  Documentation/git-branch.txt       | 3 ++-
>  Documentation/git-format-patch.txt | 2 +-
>  Documentation/git-request-pull.txt | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index a67138a..79ad1c7 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -197,7 +197,8 @@ start-point is either a local or remote-tracking branch.
>
>  --edit-description::
>         Open an editor and edit the text to explain what the branch is
> -       for, to be used by various other commands (e.g. `request-pull`).
> +       for, to be used by various other commands (e.g. `format-patch`
> +       and `request-pull`). Multi-line explanations may be used.
>

Are these the only locations? Just want to make sure while we're updating it.

Otherwise, for what it's worth...

Acked-by: Jacob Keller <jacob.keller@gmail.com>

Regards,
Jake
