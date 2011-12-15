From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: How to commit incomplete changes?
Date: Thu, 15 Dec 2011 12:22:52 +0400
Message-ID: <20111215122252.584d1003@ashu.dyn1.rarus.ru>
References: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
	<20111215104444.783303cf@ashu.dyn1.rarus.ru>
	<7e1ccfac8c47e8877c0438086bd1d91b@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Thu Dec 15 09:23:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb6ak-00011B-77
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 09:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab1LOIW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 03:22:57 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54763 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab1LOIW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 03:22:57 -0500
Received: by eaaj10 with SMTP id j10so1630389eaa.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 00:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=A/sVWqUMrrDYhIloTZFcx+XMENNT2LWa21jUWCj93aE=;
        b=FE0en1mUBAfNC8iMUIDKqsX5GOLSykVrGTxFnnoPQ6EYXU0BeciSVaSZOIRdOGo+H2
         oa1phfM6VmhR0hXUIbQLq6iucPlHuUgUwUG97+WpQegb3V9MBMlOrhKzHhh+VJGi5L/r
         jeO/jZmCXNKP8iiYVHQs5QUShglEt4BhfCKPM=
Received: by 10.205.122.147 with SMTP id gg19mr496358bkc.20.1323937375882;
        Thu, 15 Dec 2011 00:22:55 -0800 (PST)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id d2sm12372156bky.11.2011.12.15.00.22.55
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 00:22:55 -0800 (PST)
In-Reply-To: <7e1ccfac8c47e8877c0438086bd1d91b@ulrik.uio.no>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187198>

Oh! I got it. I missed "generated changes".
Well, unfortunately (or fortunately ;) ), I did not meet such a workflow
when changes are "generated" without my hands.
In your case it may sound reasonable to make separate fixup commit.
But Git allows you to make your own (more flexible than SVN,
for instance) workflow, which suits you. It's up to you ;)
You decide.
If you plan cherry-picking that fixups, do separate fixups. Just
publish them together.
If you want every commit is "clear" and "workable", squash fixup into
a single commit.
I do not know what exactly is "generated changes" you're talking
about ), so, maybe I'd do separate fixups, maybe not. ))
There is no single solution. ))) TIMTOWTDI
That is why you hesitate :) Do your own decision. And feel free to
change it later. ))

>  To expand on that: To review the change, review the hand-edited 
>  commits,
>  which is easier when these do not drown in generated changes.  Review
>  the *commands* which generated the rest - I'd put those in the commit
>  message - and glance at the actual changes.  Cherry-pick: Possbly you
>  need to run the commands instead of cherry-picking the generated
>  changes.  That's easier with a commit with only generated changes.
> 
>  I know it also can cause problems.  Would you make a single big
> commit anyway, and describe carefully in the commit message which
> parts are hand-edits?  (We don't auto-test commits yet, but I'll sure
> this issue will crop up again later when we do.)
> 
