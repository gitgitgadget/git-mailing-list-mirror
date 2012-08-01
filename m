From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] git-rebase.sh: fix typo
Date: Thu, 2 Aug 2012 07:28:46 +0800
Message-ID: <CANYiYbGz9Zcyc9_k=+54nVe8bOj8aheDCZJJ5v9dFTXeAvWk4w@mail.gmail.com>
References: <1343840949-3122-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 01:28:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwiLV-0007eM-LE
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 01:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab2HAX2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 19:28:47 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40858 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab2HAX2r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 19:28:47 -0400
Received: by yhmm54 with SMTP id m54so7964167yhm.19
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EljP9Lhvaq50x18E+UmSr+j3ABicZyEw2O/4Ewu7TXg=;
        b=QxP7B2vRdYA1gNmxHzI7jNR2yqittSopFs/bpBWJ1HK/kPk5zUJBjzC5ubYbVBAzsG
         vuJxbDQiQ3ZbeSArH+nemOn+Uu1PVyTycAXt60j/Ty+xeOM/NVee09PhRBshBNhcBuAp
         bRzVIIOFA1Y8XejESlMCiYdEUluFe3YN0I3X07cwndzPaoY8ci1EOQZKyDXuw0FNo0hy
         dATwSf6CsTHoKxUFRmySzPXswzCUrz91+unvhmiS7pt4gJZZK/QXy+5GiLHSJWBFKLRi
         nz1TsgV8XfxAR+bTHcxb5oNGuvMRhi/Y7d66ey+QfSVP+HtGKvmu7dwTMYAnFCXZeM19
         k69w==
Received: by 10.50.237.34 with SMTP id uz2mr5760893igc.19.1343863726190; Wed,
 01 Aug 2012 16:28:46 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Wed, 1 Aug 2012 16:28:46 -0700 (PDT)
In-Reply-To: <1343840949-3122-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202741>

2012/8/2 Ralf Thielow <ralf.thielow@gmail.com>:
>  $(eval_gettext 'It seems that there is already a $state_dir_base directory, and
> -I wonder if you ware in the middle of another rebase.  If that is the
> +I wonder if you are in the middle of another rebase.  If that is the

It's my fault in commit c7108b. I am curious how this happened, and find out
that it comes from my copy/paste from code review this post:
http://thread.gmane.org/gmane.comp.version-control.git/202010/focus=202048

If I did a more careful diff, especially word-diff, might find it earlier.

     $ git show --word-diff c7108b | head -122 | tail -1
     I wonder if you [-are-]{+ware+} in the middle of another rebase.
If that is the

-- 
Jiang Xin
