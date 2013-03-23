From: David Aguilar <davvid@gmail.com>
Subject: Re: [FEATURE-REQUEST] difftool --dir-diff: use the commit names as
 directory names instead of left/right
Date: Fri, 22 Mar 2013 21:56:17 -0700
Message-ID: <CAJDDKr6fmvb8AN8AcyO+t=7wqte+6ryhtt_o0CN92Vm-xSdn+A@mail.gmail.com>
References: <1363971156.20287.5.camel@heisenberg.scientia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Christoph Anton Mitterer <calestyo@scientia.net>
X-From: git-owner@vger.kernel.org Sat Mar 23 05:56:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJGVa-00015H-T7
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 05:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528Ab3CWE4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 00:56:19 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34079 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465Ab3CWE4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 00:56:18 -0400
Received: by mail-wi0-f178.google.com with SMTP id ez12so420633wid.5
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 21:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AJN2hPkp9FCablmIgFaiEvuoPz3bNE0yiyOYqTKW4Ss=;
        b=xyc8KFzn5l6rbDDwgthF08Sxd5F8usblQW/54iuSw2F+4TiPiwnzK0lOHS93EWdF87
         mbvSC/E00or2xbH5rZtJm0sOURteOYRJMiYrJQfc9D8rAjnMtVS3EDggYMz3YGmI8EUI
         mjNr9Jj2kaDPblXvZKiWd716glsMNgbcazLuYR2dbSTHVmW59wXh8JsRjJgLOyb6T3TB
         B6uHxYUOT4qp4Okik4uDGiIqeICszhtKpphAfCzyxKoGyxwSqRq5o7IT6PGLR8mDxu9e
         iE7P+u0ckWJL1fI0y2PGkLPCSbqcJ3Fvbs4t77qP984dkkZit3xEIM9lzRDGI42Ts2za
         meRQ==
X-Received: by 10.194.91.211 with SMTP id cg19mr7027518wjb.43.1364014577526;
 Fri, 22 Mar 2013 21:56:17 -0700 (PDT)
Received: by 10.194.13.129 with HTTP; Fri, 22 Mar 2013 21:56:17 -0700 (PDT)
In-Reply-To: <1363971156.20287.5.camel@heisenberg.scientia.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218886>

On Fri, Mar 22, 2013 at 9:52 AM, Christoph Anton Mitterer
<calestyo@scientia.net> wrote:
> Hi.
>
> Right now, when I use difftool --dir-diff, the temp dirs are creates as
> e.g.:
> /tmp/git-difftool.QqP8x/left
> /tmp/git-difftool.QqP8x/right
>
> Wouldn't it be nice, if instead of left/right... the specified commit
> name would be used?
>
> e.g.
> /tmp/git-difftool.QqP8x/r1.1.1
> /tmp/git-difftool.QqP8x/HEAD
> or
> /tmp/git-difftool.QqP8x/fd4e4005a4b7b3e638bc405be020b867f8881e72
> /tmp/git-difftool.QqP8x/ce0747b74fccd20707b6f495068503e69e5473df
>
> Cause then, one would see in the difftool which side is what, without
> the need to remember how git difftool was invoked.
>
>
> Of course one might probably need to escape the commit names if they
> contain stuff like "/" or "..", etc.

I can see that being pretty helpful.
If we do it we should go all the way.

What do you all think about something like the output of
"git describe --always" instead of the SHA-1?


BTW there are some patches in-flight around difftool so
you'll probably want to apply them first if you're going to
give it a try.  patches very much appreciated! ;-)
If no one beats me to it, I can give it a try after the weekend.
-- 
David
