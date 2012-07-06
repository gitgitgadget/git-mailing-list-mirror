From: David Michael Barr <davidbarr@google.com>
Subject: Re: [GIT PULL] vcs-svn housekeeping
Date: Sat, 7 Jul 2012 05:41:51 +1000
Message-ID: <CAFfmPPOWfYhZyrsvg8eeisdNLb4gyEMJ5kYfVhcSR3KNa-QjCQ@mail.gmail.com>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
	<CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
	<20120607003904.GB4065@burratino>
	<7vtxynk81p.fsf@alter.siamese.dyndns.org>
	<20120706171040.GA31001@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 21:41:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnEPe-0000SB-W3
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 21:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758029Ab2GFTly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 15:41:54 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54301 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757763Ab2GFTlw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 15:41:52 -0400
Received: by yenl2 with SMTP id l2so8964163yen.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=z6RZFIfivnr16WKMmZmacJ6ef59I4IsT0Z60GLB/RxY=;
        b=ei/gXzphI6XykD7qslMGeMG1g+EI+go6XiE246xUn5tsDre58ErK3DTXksLySjJvM8
         hczysIN1NrsQrdHhqobk16ig3sATzTuuINcGUfKMppa4qE/dsYHERbIVRKKzfGM2LR3T
         A0W8paoq90yONWrgwbPU7JjPAS7sgvpRnMVbvfjjZqetBxrH6HRjyhhukCVGYpY8JfJa
         b2e9G8qXWn4vf5fL+w7t4eRAslGLIy7TR+iFG+5ZHybwAg6rcDIMiOT8cEJpiwge/jkv
         hXfu5GLa8oYmaTO6pN4MnYi6Z8HJgQhCyv5U8bW87bsYpq3hQXyKwxlZprxU66N8FezG
         VBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=z6RZFIfivnr16WKMmZmacJ6ef59I4IsT0Z60GLB/RxY=;
        b=fhv+PmnwrzXjq9WcGDWpWUjR//CQVDCsqByEY5uYZNwTZ0m1bxWvvUDTN4SUXB7ajt
         Sn/Y53+KaKd0/eW1PMZ1McJFyYWhXEqx+I3dcAWwjs1zM1pcgfWuHH6odLTC/Uegrdqg
         QF39vb0lzQ0JYiEw9RY5+ieoE1Eyy6B/yfdWfB2W7JZ3F74VM7G7jLkAw80UCskKbarL
         p7JaNfBDb1gZuHDjcGD/GNPt8O/cA5lmiq9QZpYu+cU3gXL57bTgidupO5F3qQdhYo7s
         bgGtVH9hjllvHvLE/rABa2BTJnTtljjbTtnB6S3/j3e8JEb6eYnR+5ilnk8on5ZZKf2L
         D4nw==
Received: by 10.236.78.36 with SMTP id f24mr37367131yhe.20.1341603712185;
        Fri, 06 Jul 2012 12:41:52 -0700 (PDT)
Received: by 10.236.78.36 with SMTP id f24mr37367115yhe.20.1341603712043; Fri,
 06 Jul 2012 12:41:52 -0700 (PDT)
Received: by 10.101.157.2 with HTTP; Fri, 6 Jul 2012 12:41:51 -0700 (PDT)
In-Reply-To: <20120706171040.GA31001@burratino>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQnOhLXYpOXJWA11MByU98PbsZfoFLy1jDtvWWeMpHsEI7mOxpYatN16wFyDc1gbIZLWMA2s2mSptY39l9PArvqt2xbkJm3mIYIexrnregBM3git6TVNHqvxrvNUdZuY9LBOv1YzYB/R7wv3ZADp6cnXDrLNGYPY2LV+d91XrRYTqJvF+GJQmTJ+fxakTt7PLepoYbR5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201143>

On Sat, Jul 7, 2012 at 3:10 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Junio,
>
> The following changes since commit 58ebd9865d2bb9d42842fbac5a1c4eae49e92859:
>
>   vcs-svn/svndiff.c: squelch false "unused" warning from gcc (2012-01-27 11:58:56 -0800)
>
> are available at:
>
>   git://repo.or.cz/git/jrn.git svn-fe
>
> The first three commits duplicate changes that are already in master
> but were committed independently on the svn-fe branch last February.
> The rest are David's db/vcs-svn series which aims to address various
> nits noticed when merging the code back into svn-dump-fast-export:
> unnecessary use of git-specific functions (prefixcmp, memmem) and
> warnings reported by clang.
>
> Some of the patches had to change a little since v2 of db/vcs-svn, so
> I'll be replying with a copy of the patches for reference.
>
> David has looked the branch over and acked and tested it.
>
> Thoughts welcome, as usual.  I think these are ready for pulling into
> master.  Sorry to be so slow at this.
>
> David Barr (7):
>       vcs-svn: drop no-op reset methods
>       vcs-svn: avoid self-assignment in dummy initialization of pre_off
>       vcs-svn: simplify cleanup in apply_one_window
>       vcs-svn: use constcmp instead of prefixcmp
>       vcs-svn: use strstr instead of memmem
>       vcs-svn: suppress signed/unsigned comparison warnings
>       vcs-svn: suppress a signed/unsigned comparison warning
>
> Jonathan Nieder (4):
>       vcs-svn: allow import of > 4GiB files
>       vcs-svn: suppress -Wtype-limits warning
>       vcs-svn: suppress a signed/unsigned comparison warning
>       vcs-svn: allow 64-bit Prop-Content-Length
>
> Ramsay Allan Jones (1):
>       vcs-svn: rename check_overflow and its arguments for clarity

Thank you Jonathan for doing this. Definitely the result of
collaborating on a series is gorgeous. I do wish I could absorb your
flair for polish.

--
David Barr
