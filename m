From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: splitting off shell test framework
Date: Mon, 12 Nov 2012 17:44:11 +0100
Message-ID: <CAMP44s2n56c=k4o6wup81Hb3WNzuDLkL30GpMdivQixJX_YOsw@mail.gmail.com>
References: <CAOkDyE8KxFvM4CJhC4U=Jb95D6HQ-4qQBtKAgBMyHH15UOhvqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:44:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXx7b-0001hu-HD
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 17:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab2KLQoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 11:44:13 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39412 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab2KLQoM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 11:44:12 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so6414619obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 08:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rnCmOyJ6/+lqyQE4E63hH3ZaRToPrG31eUww5b9GoJA=;
        b=Q3214DlXJ0cYUqsi5QTkWowKPiW68I9KYe0VmJxVqGE6ZR1rAQavMBhc7dyBf/nnNZ
         0LvUp3+HktSX/Ye15WpKYWm0KX7s3IOzOCRm+Tn74ZBuUN3jzdeDZ6FWLlDpyPVDJaWd
         judf4HYQaQVzC+blej/GOLH9n2IG1htK52NvmK/T+j5jCcwnrWY4Gu0nKQVORVe47jM/
         9gWJlXAlo5zJmgGs4KA+JXTau9ZCacyvvNG5efwEaE3tc5s+6B9ldEMjMutCAA3Mh1qI
         2DY0Fsj4JZy5904l1tC8LJQ/pLP69Eau/ShJe/ektuQlfsS1Y+FnsrpcVFi5YKfw/Xsk
         Nh9A==
Received: by 10.60.12.225 with SMTP id b1mr15167988oec.96.1352738651758; Mon,
 12 Nov 2012 08:44:11 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 08:44:11 -0800 (PST)
In-Reply-To: <CAOkDyE8KxFvM4CJhC4U=Jb95D6HQ-4qQBtKAgBMyHH15UOhvqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209487>

On Mon, Nov 12, 2012 at 5:37 PM, Adam Spiers <git@adamspiers.org> wrote:

> I've been pretty impressed with git's test framework, and I'm not
> aware of many other (decent) shell-based test frameworks out there.
> (One that springs to mind is the one used by rvm, but last time I
> looked - admittedly a while ago now - it had limitations).
>
> Recently a situation arose where I craved the ability to test
> something via shell.  I did a quick proof of concept and successfully
> extracted out the non-git-specific bits of git's test framework to be
> used to test something entirely unrelated to git:
>
>     https://github.com/aspiers/shell-env/tree/master/t
>
> As it turned out to be fairly easy, I was wondering if there would be
> any interest in doing this more formally, i.e. splitting off the
> framework so that it could be used and improved outside the scope of
> git development?  Of course this would pose the question how git would
> consume this new project without any risk of destabilisation.  I'm
> guessing that simply using a git submodule would solve the problem,
> but ICBW ...

FWIW, the notmuch project seems to be doing the same; extracting and
using git's test framework.

> Just an idea.  Interesting, or terrible? :)

That I don't know :)

-- 
Felipe Contreras
