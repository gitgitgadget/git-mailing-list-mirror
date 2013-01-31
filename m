From: =?UTF-8?B?wqA=?= <porpen+git@gmail.com>
Subject: Re: [feature request] git-daemon http connection filtering of client types
Date: Thu, 31 Jan 2013 13:11:18 -0500
Message-ID: <CAANzHtRVn0FndXaw4TECPbBR6bF5LY63KNLR_H4YsjtUzBdY=Q@mail.gmail.com>
References: <CAANzHtT83JXhQ8XRifdK5ah7NrnD6hvrCjBO4PnPx=qC=DTT9A@mail.gmail.com>
	<CABPQNSYq-OO0CrEPjEcH5v+OSTqxYfRbdtaoSER3v+dCHzgyUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 31 19:11:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0ybu-0005t0-IR
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821Ab3AaSLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:11:21 -0500
Received: from mail-bk0-f42.google.com ([209.85.214.42]:63642 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab3AaSLU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:11:20 -0500
Received: by mail-bk0-f42.google.com with SMTP id jk7so1504448bkc.1
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 10:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=tjsQyD2T0cUYe13kpgae3ghecveTV95Uyzbpvnt3VYs=;
        b=ozK4sPASkB8ypMXafMwOBoGggtlimnMs3E+ID+B46tkRCMA7OJpfsRF7wxlNxXuc/K
         lb74kI6acwrlGRXOlT0P9B0ojeyxYqnXuGH9gMoeIPCsCfP8wUandlPbEl8QkE7KTj2a
         0/EPWXoqBDvDgJC6vjbZpuNSYNAStEu0dr3HYxCDqQ2lsnqjI6PBEkbvHm0hEFODvw6E
         gjSGAf/R2slsDcQgsEqgG3uBxWyIPwPdT/wYauMw1PsJ0YewMD8i/6mc9IfeJfoY5ma0
         5d1iFWeuen6ffX0kdA4wbLJ+jFWcMz0rwN+rS8R2GM3vBuk6+z1BolYo/Ed1ooHk9hES
         wr/w==
X-Received: by 10.204.8.212 with SMTP id i20mr2543514bki.14.1359655878562;
 Thu, 31 Jan 2013 10:11:18 -0800 (PST)
Received: by 10.205.39.9 with HTTP; Thu, 31 Jan 2013 10:11:18 -0800 (PST)
In-Reply-To: <CABPQNSYq-OO0CrEPjEcH5v+OSTqxYfRbdtaoSER3v+dCHzgyUA@mail.gmail.com>
X-Google-Sender-Auth: aiOIauP1edl3zS05Hfg3JNhOrYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215137>

Hey folks,

On 31 January 2013 08:22, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>
> This isn't a running instance of git-daemon, it's a web front-end for
> the mailing list. It seems nabble allows image-attachments, and that's
> what you're seeing; an attached image to a spam-email that was sent to
> the git-mailing list through nabble.

oops.. yes, I see it now.  I should have spotted that earlier.  Sorry
about the list noise.

> The message contains HTML to display the image, and the git mailing
> list rejects HTML messages. So the only ones who should be able to get
> these spam-emails are users who subscribe through nabble. If you
> subscribe through vger instead
> (http://vger.kernel.org/vger-lists.html#git), you should get less
> spam.

I have never subscribed to anything via nabble.  ^Zcat blessings | wc -l

> Git-daemon doesn't have an http-feature. You are probably thinking
> about git-http-backend, but that's an CGI; the http-daemon invoking it
> should already be able to filter connections. So, I don't think
> there's anything that needs to be done to be able to block spammers
> from git-servers. Blocking spammers from nabble is a different manner,
> and is something you'll have to take up with the nabble staff.

Agreed.. and I won't waste my time with nabble.  I'll just set
procmeil to file new threads from nabble into a "penalty box" for now
and start a whitelist.  Perhaps I'll come up with something more
elegant/automated later.

So, I guess my "feature request" is "resolved".

Cheers!
-phil
