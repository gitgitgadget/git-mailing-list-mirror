From: Tim Ringenbach <tim.ringenbach@gmail.com>
Subject: Re: git svn dcommit doesn't support --username option for file:/// urls
Date: Mon, 15 Feb 2016 16:01:17 -0600
Message-ID: <CAGZMbffPYjX4g19AUPWJvknUtQ4AFeacKXpnQtuuOb1pPcOz-A@mail.gmail.com>
References: <CAGZMbfc5Oi=EOYbCbZWfM1T65AZwCEbsso+QTkAe1sa4hRC61A@mail.gmail.com>
	<20160215100636.GA5785@dcvr.yhbt.net>
	<CAGZMbfdem6YzrEUw9A6ZWAbm6zXkNxqM3myAjHz4xFDS79VYwA@mail.gmail.com>
	<20160215211413.GA1578@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 23:01:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVRCs-0008Mx-Hy
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 23:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbcBOWBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 17:01:18 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35446 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbcBOWBR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 17:01:17 -0500
Received: by mail-ob0-f172.google.com with SMTP id xk3so230329600obc.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 14:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PO5a/K+M9hw9Yp/64wBsubZFPDt7MmlmJretxEHdcSk=;
        b=MopH3UlS6VMpaJHgN780fyU//ZM831dSj2+e+YM/aWSLy4zt1eRN2dZkXKi6FRmZpX
         p5stPFUlQZ7GdA40i1Vyqe0PvdR7ZfaAN9Kpipufjb3rycJJtqZfTLU/sLkK4CDOC7VK
         Xv1koV+TI3dycEVDJ0basNcyDoPt3ebQ+QPR5ZfOVpFMu1wlqihJMqcrbxw6IyFP8dBl
         dTi3OwXX6IxsNhKpwKIM22/AU5Vjr3AbzSsWR62O+oyBgabNq6z+aFacgnIJ8Eh0i0RP
         Iwb7JPrqKM+TbGSTN17LyqlLCQ88w5qTZtkSD8wq0dAfDhaNTQ4KkOmG9mdUaJtutmjU
         mOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PO5a/K+M9hw9Yp/64wBsubZFPDt7MmlmJretxEHdcSk=;
        b=HHDqilg49tfN0j73GPTBzSX/YHjMs8KReJEvhkY29ssh05KuIdm7Wb6W4qyjnr2kkG
         QPAqdL9MWi+n4zR1czzSvO7GbtfkW44yWlGkysInLqk6gvDjdiHGskBi0Pl54tfeQMt1
         X32+QV9j+q/gA25KBCVIgpUUu3M1LgopYWZqEMIv2hwJnDcbtVRQp200ycfeaIRtqKtr
         XCEDP9I6yVJ/ZDhDuYzb5/qGSW1PrXpe07A1I6wGRpHeowSFJ1ZlW8KXDZf7i1zIWDiY
         /H60MmMIyJdLCt0mFMbmvmMSAkHxKcHv1nRAbPhn+vkp7SzOh2cKdWFp4ihFf2dOMWfq
         1rfQ==
X-Gm-Message-State: AG10YORB73dHDAKVkuLTQ4R1YaaGPl9lh9zu7JpxUtZ8z9Q3cJa1/Ip1fdK0F6UeUd4k3yAWR9zHpkgU+QV6ig==
X-Received: by 10.182.241.134 with SMTP id wi6mr13876694obc.81.1455573677394;
 Mon, 15 Feb 2016 14:01:17 -0800 (PST)
Received: by 10.202.49.193 with HTTP; Mon, 15 Feb 2016 14:01:17 -0800 (PST)
In-Reply-To: <20160215211413.GA1578@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286275>

On Mon, Feb 15, 2016 at 3:14 PM, Eric Wong <normalperson@yhbt.net> wrote:
> It might take a while for me to get around to looking at this
> more, so it would be very helpful if you poked around and tried
> some different things in the source.

Ok, I played around with it some and found something that works.
I commented out all the providers except for:

   SVN::Client::get_username_prompt_provider(
     \&Git::SVN::Prompt::username, 2)

And that seems to actually work!

Interestingly, it doesn't actually interactively prompt me for a
username. At least, not when I ran 'git svn dcommit --username test'.
It did when I later ran a 'git svn fetch'.

I don't know this API at all, and it's been a long time since I've
done any perl. (And I didn't even realize you used perl bindings to
libsvn until a few minutes ago, I just assumed you somehow implemented
everything from scratch.)

But my guess is that 'SVN::Client::get_username_provider()' is
provided by the perl binding and isn't git-svn specific, and so it
knows nothing of the --username argument, it simply is reading ~/.svn.
(Assuming git-svn reads ~/.svn at all.) (That hints at maybe I could
control the user with the files in ~/.svn, which I didn't even
consider previously.) And if it knows nothing about git-svn or any
arguments passed, then that explains why it didn't work.

Meanwhile, 'SVN::Client::get_username_prompt_provider' also looks like
a stock SVN::Client function, but it's passed in a Git::SVN::
argument, that I'm assuming is some sort of callback. So in that case
it's able to provided it with the passed in --username argument, or
failing that, it prompts me.

So I have something that I think will work for me. I'm not sure how to
turn it into a reasonable patch though. Maybe we need to eliminate
some of the auth_provides from the list if the --username option is
passed in?

> Btw, which version of SVN are you using?  I also wonder if
> there's something version-dependent.

svn --version
svn, version 1.6.12 (r955767)

I know that's pretty old.

Thanks,
Tim
