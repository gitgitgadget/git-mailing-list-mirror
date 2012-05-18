From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Making git history strictly time safe
Date: Fri, 18 May 2012 11:49:04 +1000
Message-ID: <CAH5451mwy51DjNM49ywDX5XHyLNMJSKk_NGiiQwydjgqyBzcNw@mail.gmail.com>
References: <2EDEF5ABBE208442B7547C8D36B9D8840C4A03@nawespscez09v.nadsuswe.nads.navy.mil>
 <CAH5451m33+4Y6sRzeji-Zvh2meN12ZxHKQMGRZ0Zwid8uGOyBw@mail.gmail.com> <2EDEF5ABBE208442B7547C8D36B9D8840C4A04@nawespscez09v.nadsuswe.nads.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Jones, Brian P CTR SPAWARSYSCEN-PACIFIC, 63600" 
	<brian.p.jones4.ctr@navy.mil>
X-From: git-owner@vger.kernel.org Fri May 18 03:49:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVCJy-0005Ik-A2
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 03:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967783Ab2ERBt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 21:49:28 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48977 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966571Ab2ERBt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2012 21:49:26 -0400
Received: by weyu7 with SMTP id u7so1515100wey.19
        for <git@vger.kernel.org>; Thu, 17 May 2012 18:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iN5y8kdbU8dLuSt174SyXr/JL4KkQx9c8I9npbOrLfg=;
        b=BW//59dE3b4OvzS8UiibFdmIAkxQgPEcBbP4v2tliD7qFpHEoe8lr7k51LPEqknCfu
         lp58sSkYlWAqaC8jjnccXWUsKTYbdZDI6oTQqJ6+P5loerGi3avPfCPBTqdzGkaUFpxR
         2AoZpanqThWjQ5J8RDG9Z4sLWOOp18CATjQW91Czz/7o6qbcaOmNfsS5SN/D72du2J+P
         0CTRdD4cHQzKf/RXkBVapm3i4gfGjyssadEzLOPmShdMl7tQvdjRXyzzGb5RN6S81gRA
         Ee5WwXY1P/MdmjVqYHDLdxb0v0y6RBPx55D5kK4Jm9+QYcW0O0FK9ys7VcMmDz0PF65x
         NjmQ==
Received: by 10.180.84.4 with SMTP id u4mr23584952wiy.2.1337305764652; Thu, 17
 May 2012 18:49:24 -0700 (PDT)
Received: by 10.223.86.80 with HTTP; Thu, 17 May 2012 18:49:04 -0700 (PDT)
In-Reply-To: <2EDEF5ABBE208442B7547C8D36B9D8840C4A04@nawespscez09v.nadsuswe.nads.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197934>

On 18 May 2012 01:51, Jones, Brian P CTR SPAWARSYSCEN-PACIFIC, 63600
<brian.p.jones4.ctr@navy.mil> wrote:
> Andrew,
>
> If I had a tag pointing to a commit that was so latter hidden could I easily return to the commit and say build it by referencing that tag without having to do any git magic?

Exactly, as long as the tag wasn't moved for some reason (it is quite
hard to move tags, but not /impossible/).

If you wanted to be even more sure, you can write the sha-1 of the
correct commit down on a piece of paper, and hide it in your wallet so
no one is able to change it on you.

Of course, if you have a local checkout of the repository there is
nothing forcing you to accept changes someone else has made. This is
what the flags on the server do, automatically rejecting changes that
rewrite history. There is nothing stopping someone rewriting their own
history on their local repository, all we can do is control what we
have, which is the server and your local copy.

In the end, as long as someone knows what the 'correct' reference is
to the correct history, you won't lose anything.

Regards,

Andrew Ardill
