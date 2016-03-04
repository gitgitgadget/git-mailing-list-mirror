From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v3 3/3] Documentation/git-pull: document --[no-]autostash option
Date: Fri, 4 Mar 2016 10:34:27 +0530
Message-ID: <CA+DCAeS90-mbyPVqpJJ6LwRwgN2rWycDtuENsCKuu6ktGpDC_A@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-3-git-send-email-mehul.jain2029@gmail.com>
	<xmqqbn6v32ms.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 06:04:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abhuj-0007mS-Fp
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 06:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbcCDFE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 00:04:28 -0500
Received: from mail-qg0-f67.google.com ([209.85.192.67]:36771 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbcCDFE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 00:04:28 -0500
Received: by mail-qg0-f67.google.com with SMTP id 14so2804073qgg.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 21:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=FPJQAhNc7/zXPdxWOegtnaJJ12ARExLx8l1f0n/3Lxc=;
        b=tqN0ZpMMQmhEKFFhgWF+9E2jHtpVqH9A+83O6j214vUoUdGNo6QVtvli7erEhWZVNI
         TdAN2EfsZk719G9qsJht8esJR1CoM/l/Z90YUGN/0yOtglJpYdFlM4/5cniuvefnx2ZN
         WVoUs1FaptrPDFIS5DF3BN5ZOJvcMCLn+xqQsLOrSORc8mptOnxD3t9xYn5IdH0DHEmn
         VuoUdJli3LQK+p+9F5r84lsmDgURUh5TjjIZg2u3vfSLCko04xEkBXpHKGraZQc8jj/r
         lG8QPwBrm0tQrlGbWW6pC8BAIAM5h2enmv9wjbcVwNkqHWUlT/zYViCFy71o2yTiJXmT
         8S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=FPJQAhNc7/zXPdxWOegtnaJJ12ARExLx8l1f0n/3Lxc=;
        b=LuH/RR+CdxMy268rZnfWtlAImTzsw4QIF335v7e9Vn9OL7AaBZ+85Xl43zQ34xo6ey
         NKr5UJd6L6eVOUFINKPM/7DzF7DeMzJV/8Bve36wRRi5wA83NymzzKnace4Iyu/l10dk
         KhOd+tZ5aHS+i95FdSBv+pBvyxHgxrs2PnY6/HJzF9kNg6THH248FyxWs/KnFSwAXfPf
         IQVUOG3UZRl/Esq36/SlGkMfM5l0oQzU5yWvwR7NmC+dnWeYPcCUc04e9pr+sjf7u2du
         /2H3XK2LGSo+/vvTEU9EuUjuHkl1bIFR9KAkdXsoVxZAVgUaAp7n3t9DS3Z+5rDOefdD
         lExw==
X-Gm-Message-State: AD7BkJKTr3EPY0xrB1VtaJD6aDXu1gfTxuWOhVKTrhlwa0KiR88baWAkgrzmtUNCn5TA8t3nMJdeg0tKB6N8Cg==
X-Received: by 10.140.169.9 with SMTP id p9mr8234607qhp.50.1457067867171; Thu,
 03 Mar 2016 21:04:27 -0800 (PST)
Received: by 10.55.188.7 with HTTP; Thu, 3 Mar 2016 21:04:27 -0800 (PST)
In-Reply-To: <xmqqbn6v32ms.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288230>

On Thu, Mar 3, 2016 at 10:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Should this entry this verbose?
>
>  - Is there a non-temporary stash?
>
>  - I think "This means that ..." is totally unnecessary.
>
>  - It probably makes sense to have "This option is only valid..." as
>    a separate second paragraph as you did.
>
>  - "The default is..." is misleading.  Even if rebase.autostash is
>    set to false, we won't autostash, but that is different from the
>    default being "--no-autostash".
>
>    Think of "--[no-]autostash" option as *ONE* way to affect the
>    auto-stashing behaviour, and treat "options" and "behaviours" two
>    different things.
>
> There is no default "option" for this.  It is that "autostash"
> behaviour defaults to what is given to rebase.autostash if
> exists, and can be explicitly set by --[no-]autostash if given.
>
> But that is the norm for any configuration and option that overrides
> the configuration, so it probably is a better use of the ink to say
> something like this perhaps?
>
>         --autostash::
>         --no-autostash::
>                 Before starting "pull --rebase", create a stash to save
>                 local modifications, and apply the stash when done (this
>                 option is only valid when "--rebase" is used).

OK, but according to the definition of --[no-]autostash given in
git-rebase documentation (https://git-scm.com/docs/git-rebase),
temporary stash is created. So shouldn't we be consistent with this
definition by writing "... , create a temporary stash ..." instead of
"... , create a stash ...".

>         +
>         '--no-autostash' is useful to override the 'rebase.autoStash'
>         configuration variable (see linkgit:git-config[1]).

Thanks,
Mehul
