From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git on 64bit windows - state of the art?
Date: Tue, 19 Jun 2012 10:57:31 +0200
Message-ID: <CABPQNSY_1adwYb2yhahpbFjdBBzygz+u6fNVnrXpwA7RsdZOCw@mail.gmail.com>
References: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 10:58:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SguGP-0005hq-Tx
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 10:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760Ab2FSI6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 04:58:13 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36675 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab2FSI6M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 04:58:12 -0400
Received: by pbbrp8 with SMTP id rp8so9379951pbb.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hK4ZMHes0zw5oMxjxKprx2WvxggmYn+moxVvpsKb2Wo=;
        b=tNTnO/r5iruJdVyEzi6iXtd0dCh4vBSIRkWapDUSAa723F4gt9NLxG0+bIi4FujA+7
         YU/UM+X8kS5+4gRN5Q7GIThnrMrJnkb3LSDCwXSyM3KFhgaWmjIXKqIVqe2h+44Iyqhc
         5Qu8TOixXkezZvRU+Oh7jZe1zOXW3P0IKEw9T9+friKKUansYgvT13pCZIYl341U43Rc
         MqASL2FVdnuotHoxn3rijbfCVx5hcsxAl1FP7xhwSNB85sVz+LMya3W8pYffmnIMYfij
         gPp+JY2bRnwIAkUMe8QVIM3298BbFrlJq6BQAK0f/xXvHI85Q5a+ZRtjwHZAZSn0yOak
         nLwA==
Received: by 10.68.241.8 with SMTP id we8mr61514596pbc.130.1340096291701; Tue,
 19 Jun 2012 01:58:11 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 19 Jun 2012 01:57:31 -0700 (PDT)
In-Reply-To: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200185>

On Tue, Jun 19, 2012 at 10:40 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> Hi,
>
> I was wondering what the state of the art for running git on 64 bit Windows is?

Git for Windows. That goes both for 32 and 64-bit Windows.

> We tried msysgit to see if this
> provided any relief, but it had similar issues (perhaps because cygwin
> was also active at the time - I haven't had a chance to diagnose this
> particular more thoroughly yet).
>

I'm running Git for Windows (msysgit is the development environment
for Git for Windows) on all my development-systems (which are all
64-bit) without any rebase-problems. I do not have Cygwin installed,
though.

Git for Windows is pretty heavily tested on 64-bit.
