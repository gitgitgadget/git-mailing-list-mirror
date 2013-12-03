From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Fwd: [PATCH 4/5] Replace {pre,suf}fixcmp() with {starts,ends}_with()
Date: Tue, 3 Dec 2013 21:24:40 +0100
Message-ID: <CAP8UFD0By77QVH1amsh85dX6h1S3iFZcmPzs3JjPZmiD_AmOPQ@mail.gmail.com>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
	<20131201074919.3042.92026.chriscool@tuxfamily.org>
	<CAP8UFD0jg_Vr7Zf+DiMX9RG6vmmQvmk2NvmL7j=MC-x3fLOOBA@mail.gmail.com>
	<20131203124645.GB26667@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 03 21:24:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnwWU-00078G-FW
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 21:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578Ab3LCUYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 15:24:42 -0500
Received: from mail-ve0-f178.google.com ([209.85.128.178]:42295 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab3LCUYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 15:24:41 -0500
Received: by mail-ve0-f178.google.com with SMTP id c14so11200050vea.9
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 12:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2vSrFurLyX1P0aLWM47yP8td+GdK+b9H39T2TkNX1AQ=;
        b=gXIc7bLRL3z6ox/j4eJr2ED+a0Qlpc0TQ3I8TCOns1N66KgYzmDme6NUQ2LtqPpo0M
         QUN4I1vIZkm7JiGN4RWD0GA1QE4GmMMGvwmgfG8RRMOxtcHsARfTI2m4p+nXNh72N8Pg
         luwO31JROH5BA7WBkK4TAFh3pTIYDjyXwetC1mG6BOnTdBMXk31K6TMlmNkq5frC78H1
         aRPNMznio8q6MWS4OZ6e7YbVzt2UMde6BvBBb7QZtu/dPJ4dfS7iWvFt8oDg9f7iXCaX
         e78iaBskv0P33JfnCoIJiETNMTMEc6iFFVTdn+zIDb6t/8NtdhbK8GWEkze0V/k1trOP
         KyyA==
X-Received: by 10.58.232.228 with SMTP id tr4mr378755vec.34.1386102280557;
 Tue, 03 Dec 2013 12:24:40 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Tue, 3 Dec 2013 12:24:40 -0800 (PST)
In-Reply-To: <20131203124645.GB26667@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238733>

On Tue, Dec 3, 2013 at 1:46 PM, Jeff King <peff@peff.net> wrote:
>
> This made it through to me, but not the list. There are at least two
> things going on:
>
>   1. The message is 172K, which is over the 100K limit imposed by vger;
>      the list is silently dropping it.
>
>   2. In my case, the direct mail was being flagged by spam because it
>      contains the blacklisted domain "old.name". Which of course is not
>      a domain at all but rather this code:
>
>        old.name = old.path + strlen("refs/heads/");
>
>      I've tweaked my server.
>
> I can't say why it wasn't getting to Junio via direct mail. Maybe the
> same spam thing, or maybe something else.

[...]

> I skimmed the patch and didn't notice any problems. It's
> whitespace-damaged by gmail, of course. The simplest thing is probably
> to just point us at a public repo with the commit, if you have one.

Ok, the commit is in the use_starts_ends_with branch on this github repo:

https://github.com/chriscool/git.git

Thanks,
Christian.
