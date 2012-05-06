From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: Arguments to git hooks
Date: Mon, 7 May 2012 00:48:35 +0530
Message-ID: <CAH-tXsBpfXkr-qWdSBhPu6CcSZbm3f=3i1xJVtk6OkHz1NKCfA@mail.gmail.com>
References: <CAH-tXsB4PBS_YjW4DCjT6ORmNPomQ8XMPbKx3hxVNH=FyB2u3g@mail.gmail.com>
 <20120506191202.GB5725@moj>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: Marcus Karlsson <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Sun May 06 21:19:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR6zp-0006AZ-9s
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 21:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425Ab2EFTTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 15:19:17 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48317 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab2EFTTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 15:19:16 -0400
Received: by werb10 with SMTP id b10so870399wer.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W7sFNzInK9kNGRfgUJl4vQmb1Vt/bXhd3bAlvcNgr6w=;
        b=c42G8FDDmsLUKdxO9RSYqPCK6FftDJ3r9uIskoDqJfdtzPeTQZ299fcAD/vgBBtUQI
         9KPog8SRS3IZj3EtnDhE6pov0yIQ2rAp5aD9TVGeJIjSzzrhsEqoqYO20YNKJzvdGWVr
         jrvwcZ3GJax+E5rRWOH86CTpd+5O8Fw5qHsYSvsKH0p8Q7pTAGh34sdiLBfOBRcGnudA
         N5fK4BtXaIZ08Lu0xso/Ou6VIYumtNohed0mjfq6FGdESWKZY14lfbTUopx6YfKHzr2K
         GJE0/8H+Xz8F1jy2qr81YX8UY7OkifJp5DlN6T3Js5t0R8tRKjTkquMkq09LVHaea3Fe
         3wRg==
Received: by 10.180.98.8 with SMTP id ee8mr29321870wib.14.1336331955717; Sun,
 06 May 2012 12:19:15 -0700 (PDT)
Received: by 10.227.39.96 with HTTP; Sun, 6 May 2012 12:18:35 -0700 (PDT)
In-Reply-To: <20120506191202.GB5725@moj>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197207>

On Mon, May 7, 2012 at 12:42 AM, Marcus Karlsson <mk@acc.umu.se> wrote:
> As far as I can see that's the only argument that git-commit passes on
> to the commit-msg hook. Can't you just call something like git-status
> from the hook or do you need the information passed specifically as an
> argument?

I can always get last commit from `.git/COMMIT_EDITMSG'` - a fixed
file. Isn't passing that as an argument a bit pointless? I want files
I tried to commit specifically passed in as an argument.

Are you suggesting me to run some plumbing command, parse the result
and get the required data ? Is there an easier way to get this done?


-- 
Jaseem Abid
http://jaseemabid.github.com
