From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] stash: introduce 'git stash store'
Date: Mon, 13 May 2013 20:32:38 +0530
Message-ID: <CALkWK0kMj6q1rppzfxGWrthub4K_+C+jnvF=K4m2Fhk0pAnt7A@mail.gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
 <1368449154-21882-5-git-send-email-artagnon@gmail.com> <7vbo8fosd9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 17:03:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbuI4-00078r-3X
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 17:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401Ab3EMPDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 11:03:41 -0400
Received: from mail-ia0-f180.google.com ([209.85.210.180]:61359 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab3EMPDT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 11:03:19 -0400
Received: by mail-ia0-f180.google.com with SMTP id l27so1889558iae.11
        for <git@vger.kernel.org>; Mon, 13 May 2013 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=uCdXn+RXdXMkgFAX2eRIVovm3/EgIw3//pMS5DcKTO8=;
        b=DPi4S7nHDEmOAPYlczrfqUfb1SxN287F8rmvFGL3yVkFln9qq1boKxJgIEfZ1cy5Tq
         v8oZCK2insYxxwzl3lD9up+qmcOEq/QG+HgZ+xEnJiy+7aay8+u/3YCG8R6LkzmwJRbT
         uGkke5yMCgc1+yKDNsAyi1cTGzAZ5gz7j32G8+oMbYuTHXpiTbXlC4tLpK6LCkmrTYY6
         e45/N7SxwesrhWHoyOOyJ6MZptl3YoboOOjpdWocRyCT2ajGPvr13/Txg20x0LySJV89
         ZJYE02orEkUjWhkSs1Sggk4GKenj/3w2kGUJgtfODinNg982Vh4gOn3OF2gWcntPPPUW
         LxVQ==
X-Received: by 10.50.33.19 with SMTP id n19mr5441889igi.44.1368457398680; Mon,
 13 May 2013 08:03:18 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 13 May 2013 08:02:38 -0700 (PDT)
In-Reply-To: <7vbo8fosd9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224167>

Junio C Hamano wrote:
>  - The error message store_stash() gives should not be hardcoded in
>    that function.
>
>    Save-stash may want to keep saying 'the current status' as it
>    said before, but a caller like your rebase-autostash will not be
>    saving the "current" status and would want to have a different
>    message.

Makes sense.

Thanks.
