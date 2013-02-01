From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] Use consistent links for User Manual and Everyday
 Git; Fix a quoting error
Date: Fri, 1 Feb 2013 11:51:40 -0800
Message-ID: <20130201195140.GE12368@google.com>
References: <7vzjzodfp1.fsf@alter.siamese.dyndns.org>
 <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
 <549641245.1090170.1359742373184.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 20:52:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Mej-00007g-Ez
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 20:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116Ab3BATvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 14:51:51 -0500
Received: from mail-da0-f45.google.com ([209.85.210.45]:50417 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523Ab3BATvu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 14:51:50 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so1850507dam.18
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 11:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=HT2ii8+YYoCvzflNCHwEmbvuMlgpiYjIvNkEi1d8cAg=;
        b=OBbxFsGJ3KWZx6VBHgANSwx7i+ZfEddTYlP6CgdoSk89RzaniqmhClySJu6iUUT/L9
         0VuQN4AMkPIh3wnW9m5u73I0USMknwmQbrJi+DyH7X9stFC1TdPoPPAbrFUqQS8/LEY0
         FuiTpLNv8Uu4HZEwxsLZRD83hUzNXmoabwONZhsUR0G12pP5TIUReGOLyI+wH4otNF3+
         zs5StUqaya9bkaieUzcD5IID9PQGk1jdfOpjzHImF3TL+1a5Og6y4iRlOrLmkvFUjx9W
         jJ4XJRy/kanV7836vhVKa8TgZoiZo7ZC8C9YdEINZSRQ1VXXlxWtAhnmWTPF98KnPI19
         k4ZQ==
X-Received: by 10.66.81.231 with SMTP id d7mr32763631pay.27.1359748309974;
        Fri, 01 Feb 2013 11:51:49 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id jo6sm9324730pbb.5.2013.02.01.11.51.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Feb 2013 11:51:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <549641245.1090170.1359742373184.JavaMail.ngmail@webmail18.arcor-online.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215263>

Thomas Ackermann wrote:

> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -23,7 +23,7 @@ and full access to internals.
>  
>  See linkgit:gittutorial[7] to get started, then see
>  link:everyday.html[Everyday Git] for a useful minimum set of
> -commands.  The link:user-manual.html[Git User's Manual] has a more
> +commands.  The link:user-manual.html[The Git User's Manual] has a more
>  in-depth introduction.

In the rendered version, this looks like:

	The The Git User's Manual[1] has a more in-depth introduction.

Presumably the first "The" should be dropped from either the link or
the surrounding text.

[...]
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -17,7 +17,7 @@ work with a Git repository.
>  
>  If you just need to use Git as a revision control system you may prefer
>  to start with "A Tutorial Introduction to Git" (linkgit:gittutorial[7]) or
> -link:user-manual.html[the Git User Manual].
> +link:user-manual.html[The Git User's Manual].

This comes out as

	... you may prefer to start with "A Tutorial Instruction to Git"
	(gittutorial(7)) or The Git User's Manual[1].

The capital 'T' in "The" looks a bit strange, but a lowercase 't' in
the corresponding footnote would also look strange.  We can't have
everything, I guess.

A possible fix would be to drop the "The" from the link.  The way you
have it here also seems fine.

[...]
> --- a/Documentation/gittutorial-2.txt
> +++ b/Documentation/gittutorial-2.txt
> @@ -406,7 +406,7 @@ pages for any of the git commands; one good place to start would be
>  with the commands mentioned in link:everyday.html[Everyday Git].  You
>  should be able to find any unknown jargon in linkgit:gitglossary[7].
>  
> -The link:user-manual.html[Git User's Manual] provides a more
> +The link:user-manual.html[The Git User's Manual] provides a more
>  comprehensive introduction to Git.

Doubled 'The'.

[...]
> --- a/Documentation/gittutorial.txt
> +++ b/Documentation/gittutorial.txt
> @@ -656,7 +656,7 @@ digressions that may be interesting at this point are:
>    * linkgit:gitworkflows[7]: Gives an overview of recommended
>      workflows.
>  
> -  * link:everyday.html[Everyday Git with 20 Commands Or So]
> +  * link:everyday.html[Everyday Git]

Isn't the old title more informative?

Thanks and hope that helps,
Jonathan
