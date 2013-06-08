From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] rm: introduce advice.rmHints to shorten messages
Date: Sat, 8 Jun 2013 19:31:42 +0530
Message-ID: <CALkWK0==9aN1wVoSXENvTJHOT8bd2SYrEFxrmTdhzMxB3mHPCQ@mail.gmail.com>
References: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <1370680434-2709-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 16:02:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJis-00054D-T1
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 16:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813Ab3FHOCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 10:02:23 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:60998 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab3FHOCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 10:02:22 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so13399082ied.28
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3tB/uV1AH7jvvbu4f4dE7TbnM4I1K87olO5geu0J9XI=;
        b=tg25t7zMKSTbqzGRQc3x+x70rBMPhGCKOR8dTS87kujqL+JNVE1xt+ydNlqlZUMBxP
         rCEmJSek/cYDDOYGVxF6EZIQhRcPs9ELkGBhNWPdebai78ZS2wrh45e1HOzIj9tcNoJ8
         F+fwJEDndWRY6AaiEy+R3wvdN+PnZn2iIiuNNLPHEsz5L1H4UYWdCpX5q/wJ7dDLDC9I
         4Nf1eW2dtj/m+vi9rmBxq1Yc7FWI8Y5wTt7CNgiXSwEPUIjMshXFgykzMZ9clZEjqgmH
         lgS+/V0CJW/EKQzcYHxvz6Xx9my9uOrnhYvdoRQ9wpIzXT9Rh/GqnSwdHMtDRqaEsci1
         /qyQ==
X-Received: by 10.50.79.231 with SMTP id m7mr923366igx.40.1370700142333; Sat,
 08 Jun 2013 07:02:22 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 8 Jun 2013 07:01:42 -0700 (PDT)
In-Reply-To: <1370680434-2709-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226825>

Mathieu Lienard--Mayor wrote:
> As an example, the message:
>         error: 'foo.txt' has changes staged in the index
>         (use --cached to keep the file, or -f to force removal)
>
> would look like, with advice.rmHints=true:
>         error: 'foo.txt' has changes staged in the index

Um, have you switched the true with false?  advice.* variables are
true by default, and I turn off all of them.

Also, I think you can extend this to also remove add-advice.  Why
would someone want to turn off advice from rm, but not add?  (Unsure
about this)

> Similarly to advice.*, advice.rmHints has been added
> to the config variables. By default, it is set to false, in order to
> keep the messages the same as before. When set to true,  advice
> are no longer included in the error messages.

Ugh, why this roundabout-passive-past tone?  Use imperative tone like this:

Introduce advice.rmHints to control the whether to display advice when
using 'git rm'.  Defaults to true, preserving current behavior.
