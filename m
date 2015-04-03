From: Stefan Beller <sbeller@google.com>
Subject: Re: GSoC 2015: students proposals submitted, selection started
Date: Fri, 3 Apr 2015 12:16:04 -0700
Message-ID: <CAGZ79kbZn9x7qXgAPi__VyrzrazDm4d+gLWbrou1DNHsYdEbsg@mail.gmail.com>
References: <1381398131.18124691.1427904503950.JavaMail.zimbra@imag.fr>
	<1644505076.18125173.1427905140837.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 03 21:16:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye74d-0006XU-RX
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 21:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbbDCTQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 15:16:07 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37077 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbbDCTQE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 15:16:04 -0400
Received: by igblo3 with SMTP id lo3so14146065igb.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=AlV3dfiqdrEXUXSUBcZRby8pbfbEf1R9wU5eV6q//3Q=;
        b=L2v+SC2gHKpE+D0Ma9HtJEC0BiK9Udo4vcjHIMm237gBdx6X4ntlSG3Jv8hAhwsMKW
         B1l/CYCXc53U9sJnWYNfpykdJ+P8iYa/8DsdBKJ+5/N8GvAsMgZnktUT4F3S7N0V9XYU
         Qq2aCKOWL+QH/L2mXpLW1LSIJ6Nl8rNcjyNlDrpWrdKV6nJ8Jtiz3cvahhLy6ypxBeBo
         23m3Kz4qBOw5iFNDFJOXNIbetN6E2DB+mHhjmebPYk4KQQW+jbgOC7wpGlo3vutBe5gg
         beu6BDKnv4JM7YXs+PSNOarW8/FFZshUQrch+OarR8lV48CWt1hRfsAireSB+kottj6+
         FBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AlV3dfiqdrEXUXSUBcZRby8pbfbEf1R9wU5eV6q//3Q=;
        b=hAFkFNOpWGyKKVNY1RNA3nqCHGagfE8XjWY5epQppjSHpDPCXc380XkL1w/yzNyv4v
         pr1cXbFLUTPMueNwh7W1pweP0pNbONNpbFGJfuG08lcIjIKwakIuaxu1Bzq5ZxSA7y59
         gh5FTLpvU/qca5eJrHH4zt5VKQfsCOTC+3Yf1geav5h0FhwQm0jaAycIcSnYDLHj1hA9
         6/Zi7V9MZwKQUhjh1FQmWsFILg20vTULEOV9Q6Nel9nhpgJKSCPAu/GMSah2FFR1R+zw
         cwdHRL0lfwhMfri8lR8it/NLY6KxJC8tO3OVQT4zaCmk64mXdxiW5brrZhnABJoOsPLn
         yGYA==
X-Gm-Message-State: ALoCoQnYoEpf7z78oI2XsnPA6ZTYdA7FAvM/lnm5Wqiq1LuaFIRrtIa79ekSOYQ8CZ5OpmHSUJ3R
X-Received: by 10.107.132.223 with SMTP id o92mr5949502ioi.49.1428088564245;
 Fri, 03 Apr 2015 12:16:04 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Fri, 3 Apr 2015 12:16:04 -0700 (PDT)
In-Reply-To: <1644505076.18125173.1427905140837.JavaMail.zimbra@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266722>

On Wed, Apr 1, 2015 at 9:19 AM, Matthieu Moy
<matthieu.moy@grenoble-inp.fr> wrote:
> Hi,
>
> Latest news from the google summer of code: students have completed their proposals. We have 2 proposals for "convert scripts to builtins", and 4 for "unify git branch, git tag and git for-each-ref" (plus some out-of-scope proposals). See http://git.github.io/SoC-2015-Ideas.html for more details about the projects.
>
> We have to request slots before April 13th.
>
> My guess is that we'll request 2 slots, and from previous discussions I don't think we will have difficulties to find enough co-mentors. Still, if you're interested in mentoring a project, now would be a good time to say so.
>
> Without committing to mentor a student, you can also join the Git organisation on https://www.google-melange.com/ if you want to see/review/rate/discuss students proposals.
>
> Stefan: you said you were interested in mentoring. If it's still the case, then please create an account on melange and request the "mentor" role for Git.

I did say that though I'd guess a Co-mentor role would fit me better.

I've seen Jeff wants to mentor the "Unifying git branch -l, git tag
-l, and git for-each-ref" where there are 4 applicants for this topic.
Though I guess we'd only accept one applicant here as the topic is
quite the same all of them proposed.

There are 2 proposals to rewrite shell scripts to builtins, which
Dscho is interested in mentoring one of them, which I'd like to
co-mentor then.

The other proposals do not look as convincing to me as I'd step up as
a main mentor.

Stefan

>
> Regards,
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
