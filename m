From: Stefan Beller <sbeller@google.com>
Subject: Re: weird diff output?
Date: Thu, 14 Apr 2016 14:05:03 -0700
Message-ID: <CAGZ79ka8pgPNZKaVWnsa_S07esxkN9nJfhcMZvCfd5U6MtsrYQ@mail.gmail.com>
References: <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
	<CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
	<20160330045554.GA11007@sigill.intra.peff.net>
	<CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
	<CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
	<CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com>
	<20160331134750.GA29790@sigill.intra.peff.net>
	<CA+P7+xpX_xR9wVdRPgymXe0wRjDY2USRx2PyWJMKTjAepWpP+A@mail.gmail.com>
	<CAGZ79kZ+JgVNSvJ+tZwGqP-L-NVUv8hmd1jsbh71F08F5AqsjA@mail.gmail.com>
	<alpine.DEB.2.10.1604140639230.8340@zino>
	<20160414183405.GE22068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:05:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqoRt-0006Rl-Ev
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 23:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbcDNVFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 17:05:06 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36446 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbcDNVFE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 17:05:04 -0400
Received: by mail-io0-f179.google.com with SMTP id u185so116501814iod.3
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=qFx6jTwkvJwsy191I2sbzsTed7tDi2XxH6Ko6Z2bPhw=;
        b=YLK8BjBaUaSYlybxiLOVj8YAy9lKX5dkXV/ycYJCxBOiLfgrUHVIYurtvYY+goNeBf
         vplT4AKK0isLmZspOLcJrPJzE1rPebQfqu5M6lh9hWp3uvj5fNsN3nJwTPYZZ13rkcN9
         +XaXGNDj9c8khqzKacpqvfUacCOw8Kyyrs/qIt0fBKXzq+pdoqLwyfinvh+J5Tgf5exx
         Hz2xbCry6fHxbxjldFUI38E/72OE9U8iF9ENcWhnVprQnwEe1XPQ7PC98VElY9WsH9+6
         nlp1LxLtr//BFIqik2KeF5dUXQqRzoXLx+GUCxW1DGvb54d+HQSDeWS5d5W/DwZnU2BV
         7GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qFx6jTwkvJwsy191I2sbzsTed7tDi2XxH6Ko6Z2bPhw=;
        b=cu28HRUcaOKw+YofdBHE+WePI9gLn6rk3+Hiyv0t+KjVvT2c2nKZvBNE/p+HWeAHFo
         ZLV7m2zb6sa95BvasisaHw/cub6c6WspHzpXnyyWXiCAeTtz8qttRH6A7m8dJTE2PEoU
         eD/VzEC0V0+HnTdFwy2s7GvSE0HNHZt9e8mGErySod3++cXwC1fk8GzEcw32mEH+rkrc
         Zj0K5WcSVeomKxfuRkpzdoQqMu3/qifzK3e6tcLUt0JuKqc3aBWrcjmmhZ7hmynf90ii
         lCbo3+Am1LRrzLL9eD6KbfCkDwi0DwzFB5W7STwohmLoMPse87cfs8lxM8kkYBVGrhXu
         LtWg==
X-Gm-Message-State: AOPr4FUq/pRXPifixqvqtkVqPwNDOT83m/SrXzZZSIqzfnWphJ2DcxbsToEzNmOVJBUW2zxQafMvLXPz/qSOuHAU
X-Received: by 10.107.161.68 with SMTP id k65mr21136835ioe.110.1460667903680;
 Thu, 14 Apr 2016 14:05:03 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 14 Apr 2016 14:05:03 -0700 (PDT)
In-Reply-To: <20160414183405.GE22068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291565>

On Thu, Apr 14, 2016 at 11:34 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 14, 2016 at 06:56:39AM -0700, Davide Libenzi wrote:
>
>> That was a zillions of years ago :) , but from a quick look at email
>> thread, if you want to do it within xdiff, xdi_change_compact would be
>> the place.  The issue is knowing in which situations one diff look
>> better than another, and embedding an if-tis-do-tat logic deep into
>> the core diff machinery.  In theory one could implement the same thing
>> higher up, working with the unified diff text format, where maybe a
>> user can provide its own diff post-process hook script.  In any case,
>> that still leaves open the issue on what to shift in the diff chunks,
>> and in which cases. Which is likely going to be language/format
>> dependent. IMHO, it gets nasty pretty quickly.
>
> Thanks, that's helpful. Stefan already came up with a heuristic that I
> implemented as a post-processing script in perl. It _seems_ to work
> pretty well in practice across multiple languages, so our next step was
> to implement it in an actual usable and efficient way. :)

To reiterate the heuristic for Davide (so you can avoid reading the
whole thread):

    If there are diff chunks, which can be shifted around, shift it such that
    the last empty line is below the chunk and the rest above.

Example:
(indented, shiftable part marked with Xs)

        diff --git a/test.c b/test.c
        index 2d7f343..2a14d36 100644
        --- a/test.c
        +++ b/test.c
        @@ -8,6 +8,14 @@ void A()
         }

         /**
        + * This is text.
        + */
        +void B()
        +{
        +  text text
X1      +}
X2      +
X3      +/**
          * This does 'foo foo'.
          */
         void C()

The last empty line is X2, so that's where we wrap:
(X2 is the last line of the diff)

        diff --git a/test.c b/test.c
        index 2d7f343..2a14d36 100644
        --- a/test.c
        +++ b/test.c
        @@ -8,6 +8,14 @@ void A()
         }

X3      +/**
        + * This is text.
        + */
        +void B()
        +{
        +  text text
X1      +}
X2      +
         /**
          * This does 'foo foo'.
          */
         void C()


>
> Looking over the code, I agree that xdl_change_compact() is the place we
> would want to put it. We'd probably tie it to a command-line option and
> let people play around with it, and then consider making it the default
> if there's widespread approval.

I just stumbled upon
http://blog.scoutapp.com/articles/2016/04/12/3-git-productivity-hacks
which advertises git config --global pager.diff "diff-so-fancy | less
--tabs=4 -RFX"

Would you consider your perl script good enough to put that instead of
diff-so-fancy?

>
> -Peff
