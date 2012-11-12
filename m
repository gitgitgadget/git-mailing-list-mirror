From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: splitting off shell test framework
Date: Mon, 12 Nov 2012 13:18:53 -0500
Message-ID: <CAM9Z-n=ypt_fyFcPjYD28NNoxnJ2ZSovd1TbERdA8RJY1Va=kA@mail.gmail.com>
References: <CAOkDyE8KxFvM4CJhC4U=Jb95D6HQ-4qQBtKAgBMyHH15UOhvqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, felipe.contreras@gmail.com,
	"Jason J Pyeron CTR (US)" <jason.j.pyeron.ctr@mail.mil>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 19:19:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXybF-0005D3-7T
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 19:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478Ab2KLSSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 13:18:55 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39389 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab2KLSSz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 13:18:55 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so215083bkw.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 10:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1Kz3mX7D+IH1RzGv3r57dZ7Un2Bttb0FhZjkbMq80zo=;
        b=slxBqJA3cW+s5HeyQ3SbCAfdpvXXTpMLCHKZZCs2ZBxLHzqbhCdKBgzzPki+Z0LB8e
         HsMIU+9odBvdwHh83/9QRarTXcjtOtSeaQXcbMrsWNNigR2r+EpbQsnJNCH7uYSS/AYr
         M7BMjgSlt4JJ17KPDuGHKjyvN7xoO/9vROZRG/9sM7vUk69A7m1QrIGWNt9uCvg1f5k0
         FrYAAxD+ldbTnGB2DEuRWqZ7X9E/KUHdo+Uk3Htpiwpt3wF/vzPAhvBWeTDAi6zxVMS4
         xY8Bk2Xr6OG35UH5500A/dq5W9zPHXyplQjnMG+AyccpxMXz2cSSCZuKrPlqx7KFiqqC
         42mQ==
Received: by 10.204.151.21 with SMTP id a21mr4864562bkw.124.1352744333531;
 Mon, 12 Nov 2012 10:18:53 -0800 (PST)
Received: by 10.205.122.144 with HTTP; Mon, 12 Nov 2012 10:18:53 -0800 (PST)
In-Reply-To: <CAOkDyE8KxFvM4CJhC4U=Jb95D6HQ-4qQBtKAgBMyHH15UOhvqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209507>

On Mon, Nov 12, 2012 at 11:37 AM, Adam Spiers <git@adamspiers.org> wrote:
> Hi all,
>
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
>
> Just an idea.  Interesting, or terrible? :)

Done at least once already:

http://comments.gmane.org/gmane.comp.version-control.git/201591

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
