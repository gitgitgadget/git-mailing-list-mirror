From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Mon, 19 May 2014 17:10:38 +0700
Message-ID: <CACsJy8C5xvs1ouO=1P8i61i1QCWNu67NAebFpC8F3M91qq2AVw@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
 <CACsJy8DVVpfYEmE8pSZNyXy1m5WRkdm08deW3EXgAy_0Gn72zw@mail.gmail.com>
 <1400024691.14179.40.camel@stross> <CACsJy8C49EDwjtv_L2pTRy3XbPptp7+nNzT=Jp4BaH_TOZtvnQ@mail.gmail.com>
 <1400182971.14179.49.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 19 12:11:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmKXN-00084o-Og
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 12:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbaESKLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 06:11:12 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:46149 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbaESKLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 06:11:09 -0400
Received: by mail-qc0-f169.google.com with SMTP id e16so8637193qcx.14
        for <git@vger.kernel.org>; Mon, 19 May 2014 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nleQcC0TVEBq4dwfgdoBx0tkXdaOliygk+eBTRGs+5w=;
        b=W+HRt7TqRjrPQq0VnNl53rMl+K8dtsymDXNsitbyPM2dIPJ1FOunv5PAtGp21v1fO0
         Hyraev7U7HibL41Vp8ZIXTcrXSy/rcxA72IbVERnAm8ihDT0GD8Nh7S4KsKH+0L2psQw
         lzkHbF77qLljdgXzKqvx3o6pkMORRn5uMVK6qpEonpyEAOElIqUlridr8BNoCSCyscrE
         6ORqUZ7ZpNSd+En4zkoj5zAYThRzMnVmZ3L0lrcIjnLnVmJjYo1nN4zMrSc5o43QQds/
         JK3zknOOUCiw2JVz1ImIczW1UMn2XKRwEy7eV0AUu4psWGe22vdJ6UWG8fIqXcl74+e2
         UXuA==
X-Received: by 10.140.91.161 with SMTP id z30mr44773871qgd.65.1400494268519;
 Mon, 19 May 2014 03:11:08 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Mon, 19 May 2014 03:10:38 -0700 (PDT)
In-Reply-To: <1400182971.14179.49.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249572>

On Fri, May 16, 2014 at 2:42 AM, David Turner <dturner@twopensource.com> wrote:
>> I assume you won't change your mind about this. Which is fine to me. I
>> will still try out my approach with your libwatchman though. Just
>> curious about its performance and complexity, compared to your
>> approach.
>
> I am open-minded here. This code is really the first time I have looked
> at git's internals, and I accept that your way might be better.  If
> you're going to try the watchman version of your approach, then we do a
> direct comparison.  Let me know if there is something I can do to help
> out on that.

You already helped by publishing your patches (and letting me know
about libwatchman) so I can steal bits here and there ;-)

>> A bit off topic, but msys fork has another "fscache" in compat/win32.
>> If you could come up with a different name, maybe it'll be less
>> confusing for them after merging. But this is not a big deal, as this
>> fscache won't work on windows anyway.
>
> Does wtcache sounds like a better name?
>

Heh i'm bad at naming. But that sounds a bit cryptic. Maybe
watchman-cache.c (with funtions starting with prefix wmc_)? Should not
worry too much about this though, unless some msysgit guys yell up.
-- 
Duy
