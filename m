From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] git-prompt.sh: colorize ZSH prompt
Date: Sat, 11 May 2013 17:29:52 -0500
Message-ID: <CAMP44s1B+FfdKebpTq+AwHP3YCiiVc++rtc8wqOn8EOy1dyLwA@mail.gmail.com>
References: <CAMP44s1pO+ytNWEV6ykRn671yf50+oMZQMnrcTN+s5ykPRpumg@mail.gmail.com>
	<1368310739-24099-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 12 00:30:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbIIp-0002h1-Lh
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 00:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab3EKW3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 18:29:55 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:45340 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482Ab3EKW3y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 18:29:54 -0400
Received: by mail-la0-f45.google.com with SMTP id fp12so5058830lab.18
        for <git@vger.kernel.org>; Sat, 11 May 2013 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=k68n+LWoCxNtkZQGwHZkIgNG4bsHY/KnJ72JuN4IGjk=;
        b=USrAqAmHtLGoFJgaRVlxiYyuHqYIjQRMpfjJGaU/xCJC/ISUNezCOUqWUP4KL5+0bs
         QuJhJpVNmBDiOtbuEnOZr9sarGtXW7wg9SwjcwMQcxyN8cClTLOyMqXqbCSlsqMDCOvO
         aAPYkO3jumviSVHAdJnZgtx3BwkwkWmUJGE1dcUC7WUHO0y9S2JSnXzh3YTuZgxpCJtQ
         ABQW5JvvptCLqH6kWITrSYnLpHgMNL7/Xmk+Dq+615Wx+sruNYc0Dr/YyQxRtvRjxR2U
         IlnWYTz6GaWpN8fLWRqgzJpcViQYq7iLyi1P29bOFE9feyI6Rao0nV0cUIYud+knFY3N
         8mgQ==
X-Received: by 10.112.146.133 with SMTP id tc5mr10075042lbb.88.1368311392895;
 Sat, 11 May 2013 15:29:52 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 11 May 2013 15:29:52 -0700 (PDT)
In-Reply-To: <1368310739-24099-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224016>

On Sat, May 11, 2013 at 5:18 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Add colors suitable for use in the ZSH prompt.  Having learnt that the
> ZSH equivalent of PROMPT_COMMAND is precmd (), you can now use
> GIT_PS1_SHOWCOLORHINTS with ZSH.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  You like this more?  I don't mind going either way.

Not really. If we need to avoid the \[\], it makes sense to have a
separate function, but what I meant is that this function should be
initially on the same file, and created in a separate patch.

-- 
Felipe Contreras
