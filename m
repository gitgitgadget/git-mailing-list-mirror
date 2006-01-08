From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: git-format-patch Date header
Date: Sun, 8 Jan 2006 17:37:36 +0200
Message-ID: <20060108173736.199df297.tihirvon@gmail.com>
References: <20060108141457.8C4E85BE8F@nox.op5.se>
	<20060108164038.89e4439f.tihirvon@gmail.com>
	<43C12DE9.8010906@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 16:37:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evcc6-00076K-Fm
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 16:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbWAHPhl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 10:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752640AbWAHPhl
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 10:37:41 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:15629 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752639AbWAHPhl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 10:37:41 -0500
Received: by uproxy.gmail.com with SMTP id s2so37464uge
        for <git@vger.kernel.org>; Sun, 08 Jan 2006 07:37:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=lE1o1Fg9xgQhbj74rODQyMBJs75sx1mvlzIW+SPElAL9jnIQfmbOn3EC/lwOgMI6mj0bmxZASz3M38LDvNa4xrC2QaMtNrsRnV/XEWfOSmjerGS+hKY7hAI9qRXk9nPI8zSAzAtzAlWMuv447FYTrOAa27SKAHWiBBO16Ks+WdY=
Received: by 10.67.40.15 with SMTP id s15mr725243ugj;
        Sun, 08 Jan 2006 07:37:39 -0800 (PST)
Received: from garlic.home.net ( [82.128.203.84])
        by mx.gmail.com with ESMTP id j3sm11161808ugd.2006.01.08.07.37.38;
        Sun, 08 Jan 2006 07:37:38 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C12DE9.8010906@op5.se>
X-Mailer: Sylpheed version 2.2.0beta2 (GTK+ 2.8.9; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14322>

On Sun, 08 Jan 2006 16:21:13 +0100
Andreas Ericsson <ae@op5.se> wrote:

> Timo Hirvonen wrote:
> > git-format-patch uses "date '+%s %z'" format for the Date header.
> > Sylpheed does not understand this format.  How common this convention
> > is?  Should we change git-format-patch to use more standard date format?
> > 
> > OTOH, I like the %s format because it is so simple and easy to parse :)
> > 
> 
> Actually, that's what's printed in the commit message, so any change 
> would have to be put there and that would break backwards compatibility 
> for new tools that might want to use it.

So fixing Sylpheed (and maybe other email clients too) is the right
solution...

> On an unrelated note, please don't start a new thread by replying to an 
> old message. It's very confusing to follow and people may not see your 
> message. This time it was doubly so because the next mail in my inbox is 
> a patch for git-format-patch, to which I thought you replied.

Sorry.  I replied to your message because it was the message having Date
header in the "%s %z" format.

-- 
http://onion.dynserv.net/~timo/
