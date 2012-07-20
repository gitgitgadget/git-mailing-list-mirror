From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: pushing branches
Date: Fri, 20 Jul 2012 08:46:39 -0700
Message-ID: <CAJsNXTk33zN_cWcyyvPz4-FKzGZDB0CBp=YtSDVNix-ynP4-7g@mail.gmail.com>
References: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:46:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFPh-0005lR-Nj
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202Ab2GTPql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:46:41 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46441 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599Ab2GTPqk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:46:40 -0400
Received: by bkwj10 with SMTP id j10so3523716bkw.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=fWOAhUXr+rofyrYiLWx2r2sD28gemTaFDSYkxg01zmA=;
        b=vkVV3UEvItFC8Dcih2alCon244S6z+Q1e2R+rqsKa7gahzzFPOJegj382vufIrtE0R
         HL5aEK45E7S/eRg/osapwkeEug7O69lgyIMvoBEUIdzKZdyidvDJ/g5GkWMKxCXCdttw
         Wq8FIzq3eM1AzuOE/ZY++YEMx3odrH03TNy2LVYx3fm39Wb63wmh4Agzd/oWupqKpvef
         00ZRIBAIrK2ahPwLY4uv3ViC3UFA0FI3G/8wAtlfh6+HC1MGrNsUDw2okOhhzDIldICp
         GaDaRym9ZaH0MQmnLLQUNoW6BLioBMmrh3gmevBZq2ycc3yXcmYasEFghQ98SOmlWQgW
         k/1A==
Received: by 10.152.103.109 with SMTP id fv13mr6819830lab.33.1342799199179;
 Fri, 20 Jul 2012 08:46:39 -0700 (PDT)
Received: by 10.112.5.102 with HTTP; Fri, 20 Jul 2012 08:46:39 -0700 (PDT)
In-Reply-To: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
X-Google-Sender-Auth: VK2ylZR29lmVixPRcA-BBPFTM6U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201778>

On Fri, Jul 20, 2012 at 8:26 AM, Thiago Farina <tfransosi@gmail.com> wrote:
> Hi,
>
> How can I push a working branch to github inside it?
>
> E.g:
>
> # On master:
> $ git checkout -b feature-work
>
> # On feature-work
> # vi, hack, commit, ready to push
> $ git push origin master # here I expected it would working pushing my
> commits to a feature-work branch in github. Or if I omit master it
> gives me a [rejected] error.
> Everything up-to-date.
>
> $ git checkout master
> $ git push origin feature-work # Now the branch is pushed.

???

I must be missing something.  It looks like the reason it didn't push
feature-work the first time is because you told it to push master
instead.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
