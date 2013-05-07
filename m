From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v6 7/7] git-clean: update document for interactive git-clean
Date: Tue, 7 May 2013 12:20:47 +0800
Message-ID: <CANYiYbHUmRy+k5DRQnxaH-q2jMtHc1=xNDt4zfq3ZsAC6dJPJQ@mail.gmail.com>
References: <4a32eb7cc4e277fcbf4b46c13524874334bea2a3.1367867498.git.worldhello.net@gmail.com>
	<6276dc8861b40e8377586f30b85c33e92c4e68fe.1367867498.git.worldhello.net@gmail.com>
	<c77c33fe295bb8577336d5bb4fe0d8da32f69df3.1367867498.git.worldhello.net@gmail.com>
	<217e7618e9b9d50a50461959b38984ac8be88651.1367867498.git.worldhello.net@gmail.com>
	<c81cef0983760c76c2a6b92c1fcc2c49a80a8747.1367867498.git.worldhello.net@gmail.com>
	<CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com>
	<cover.1367867498.git.worldhello.net@gmail.com>
	<5353bf3a49c83ca27ad4be221b1b4856d119f8c1.1367867498.git.worldhello.net@gmail.com>
	<b35aa5d0de820e5e13da32d23a70a82d3df83521.1367867498.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 07 06:20:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZOX-0006nr-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547Ab3EGEUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:20:49 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:61823 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758419Ab3EGEUs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 00:20:48 -0400
Received: by mail-wi0-f176.google.com with SMTP id hq12so3279710wib.3
        for <git@vger.kernel.org>; Mon, 06 May 2013 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ToZ963fgTzA4r3l+MGyEsIqu7GpG1CPEGCVQiV+KEwQ=;
        b=NiLRpWz9ImZUxlvMhxkd2Bs23EszAWnAWmZBumpfKTt99YW/eRHtb6aAGBHvjkojsN
         LwNTRIiQnBcGQthKmF6m9GPcqb8V5yh8MduR8hF0tuvMDEnHDboo1ICu7sQ6pqbEBHmz
         rX85BWV7Ig+rZoJz7/kI9jZoxe7rgsbZCOSqRY+OeynOnbjQGy4FoHEtRWR+khG98Tyf
         uxNblChcgcf4Zo5MLAfTjvZS0H6I0fT/D6cSbfXUaObE7mpCDNER8qANXMuUMjO8oe8n
         eq6YusQ0RRen2rIvvHK/k3/r8E5UWy2mFwddmzro10sckWDhrg4w00I7xd/GNSGfjeT2
         DLag==
X-Received: by 10.194.59.132 with SMTP id z4mr306772wjq.57.1367900447346; Mon,
 06 May 2013 21:20:47 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Mon, 6 May 2013 21:20:47 -0700 (PDT)
In-Reply-To: <b35aa5d0de820e5e13da32d23a70a82d3df83521.1367867498.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223538>

2013/5/7 Jiang Xin <worldhello.net@gmail.com>:
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  Documentation/git-clean.txt | 70 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 63 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index f5572..56d60 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -39,13 +39,8 @@ OPTIONS
>
>  -i::
>  --interactive::
> -       Show what would be done and the user must confirm before actually
> -       cleaning. In the confirmation dialog, the user can choose to abort
> -       the cleaning, or enter into an edit mode. In the edit mode, the
> -       user can input space-separated patterns (the same syntax as
> -       gitignore), and each clean candidate that matches with one of the
> -       patterns will be excluded from cleaning. When the user feels it's
> -       OK, presses ENTER and back to the confirmation dialog.
> +       Show what would be done and clean files interactively. See
> +       ``Interactive mode`` for details.
          ^^^^^^^^^^^^^^^^^^^^ should be ``Interactive mode''


-- 
Jiang Xin
