From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GSoC git-add--interactive improvements
Date: Wed, 4 Apr 2012 10:26:52 +0200
Message-ID: <CAP8UFD0V17Gag3esFd=ZDocZZoiN_4a1bjQ8rFwbBZoJEiasBA@mail.gmail.com>
References: <4F7BC8FE.4060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Corey F <coyotebush22@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 10:27:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFLYR-0001Cl-VI
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 10:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab2DDI0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 04:26:54 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63047 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab2DDI0x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 04:26:53 -0400
Received: by obbtb18 with SMTP id tb18so14338obb.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AcoqxkpdZP05tgSRp/+de6h31KPd850bLSA+EBBnJFM=;
        b=ensmLPY44eRwxqpiczfJaIe6Qhzi8hIyrCK1uN675BBwzJ02BfyG78tkFAlgfo8AWS
         pU/wgmM/DKk+UAY84lwApMg2XsE3a5nVROKjiMRygYd3z/VZeco8n8F3EWKaAJtZOMGc
         afkrpAIpvx/d1sKqgOStfD1UKOdavB9cakMjbeqeUjKFneAOyG+7YUzak/k05aynIhxh
         Fl9QG8uER5ZJj681GC+Z+04EAMYIXvpwgeRVXeeJcTpA1wjSH1dcBshbgvMV3VhIKQ1c
         ouOAS4ZUenQoBMibbxJgceHyu0Z75gY3Uj4sEgotN/7jzfFnooReBviwk/s2kfh3R5v9
         Awgg==
Received: by 10.182.72.71 with SMTP id b7mr23397497obv.11.1333528012481; Wed,
 04 Apr 2012 01:26:52 -0700 (PDT)
Received: by 10.182.175.98 with HTTP; Wed, 4 Apr 2012 01:26:52 -0700 (PDT)
In-Reply-To: <4F7BC8FE.4060808@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194687>

Hi,

On Wed, Apr 4, 2012 at 6:07 AM, Corey F <coyotebush22@gmail.com> wrote:
> Hi all,
>
> I'd be interested in making improvements to the git add -p (etc.) interface
> as a Google Summer of Code project, as suggested on the ideas page [1].
>
> The page lists some interesting ideas for both larger architectural changes
> and smaller interface improvements, though I agree that getting lots of
> community input during the project will be important. So at this point I'm
> wondering how much I should plan out in my proposal -- maybe pin down a few
> important features and a process for getting more input?
>
> Last year's SoC ideas page included rewriting some commands in C, including
> this one. I'm at least as comfortable with C as with Perl, but I'm guessing
> that incorporating a rewrite into the project would be an ambitious and/or
> dangerous idea.

It depends how you plan to do it. In builtin/apply.c and perhaps
elsewhere there is already some C code that is duplicated in
git-add--interactive.perl.
Maybe you can first make add--interactive use the C code by creating a
helper command and then move more and more stuff from add--interactive
to the helper command.
Hopefully in the end the code in the helper could be used to add an
interactive mode to git apply.

Thanks,
Christian.

PS: Sorry I replied to you only first.
