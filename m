From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Add hint for translators for y/n reply.
Date: Sun, 1 Mar 2015 08:18:48 +0800
Message-ID: <CANYiYbGuRjNZARc278py=MzDDXukAfLJv3kWdnBa6_ia7WDvRg@mail.gmail.com>
References: <xmqq1tlfqcd8.fsf@gitster.dls.corp.google.com>
	<1425137944-13667-1-git-send-email-jn.avila@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jean-Noel Avila <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Sun Mar 01 01:18:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRraw-0003jl-Id
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 01:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbbCAASu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 19:18:50 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:41588 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbbCAASt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 19:18:49 -0500
Received: by wevm14 with SMTP id m14so26841877wev.8
        for <git@vger.kernel.org>; Sat, 28 Feb 2015 16:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/ZUYBImQOUNl/d5dt+IIuidzz1x5PuoWjjHWGmemt8Y=;
        b=lW77S/tfoWNLg+3sVgi4m3Z7vXa6Du6rtwIltIRwJurZOvaHrK3cO6L7TJGacObqre
         RifUzc6co+8CsSkP7p4Zzut7ggcgQ6cb1j++2lVS/tK5JdKLnQ2zpw9w3Yya4/Am2w72
         FLUrV15fXWf+8y5q5uLgW77DE26KdwKR4lT/SfRrPgZU8xosr16KtxKX40pM/8ykc4wY
         NjvUBDvSAyZbDGaR5OxkIvCYObLzSw38rtvOyp9iRgziPqf1lsznBA01e/RhgxIorGHB
         1HkUP4Yu0dr0GAzbhIGPov+zi+quwIn1jRAwRYc+RuA13jOxaf1araIgYjs9/6zU/F2J
         gwTw==
X-Received: by 10.194.185.9 with SMTP id ey9mr43730467wjc.135.1425169128413;
 Sat, 28 Feb 2015 16:18:48 -0800 (PST)
Received: by 10.194.80.131 with HTTP; Sat, 28 Feb 2015 16:18:48 -0800 (PST)
In-Reply-To: <1425137944-13667-1-git-send-email-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264540>

2015-02-28 23:39 GMT+08:00 Jean-Noel Avila <jn.avila@free.fr>:
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>  builtin/clean.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 7e7fdcf..2c98661 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -754,6 +754,9 @@ static int ask_each_cmd(void)
>                 /* Ctrl-D should stop removing files */
>                 if (!eof) {
>                         qname = quote_path_relative(item->string, NULL, &buf);
> +                       /*TRANSLATORS: Make sure to include [Y] and [n] in your
> +                       translation. The program will only accept English input
> +                       at this point. */
>                         printf(_("remove %s? "), qname);

Yes, it may confuse.  In order to let the translators notice this and update,
you'd better change the code like this:

        printf(_("remove %s [y/N]? "), qname);


-- 
Jiang Xin
