From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 5 Jan 2007 10:37:08 +0100
Message-ID: <81b0412b0701050137g49d07c8aw2ce6938dfcef1646@mail.gmail.com>
References: <7vwt4647g0.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701041022h30cd4fcxd62dbf3ecb504ea9@mail.gmail.com>
	 <20070105025921.GA14042@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 10:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2lVy-0003YI-DZ
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 10:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbXAEJhM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 04:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbXAEJhM
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 04:37:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:52442 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161028AbXAEJhK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 04:37:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5655779uga
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 01:37:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UJEsOpPabWAN8yc61RTYPpjRVRycFI0trzXz0/ArNZcpczDCeS+Geif/YcDRw40FW1ENz31kpAEyW6MZT+Wfj2jUeD18c+Uqgbd9Hmt+N21pzWzsTRJ9nMg04CVIOQBMX8zMYHHBvfQcyraATCQlW7aQQMl/tXPbjgyWCQTwv9g=
Received: by 10.78.158.11 with SMTP id g11mr2879678hue.1167989828728;
        Fri, 05 Jan 2007 01:37:08 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Fri, 5 Jan 2007 01:37:08 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070105025921.GA14042@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35985>

On 1/5/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > >* sp/mmap (Sat Dec 30 22:13:43 2006 -0500) 25 commits
> >
> > Running this and the merge-recursive speedup I sent today locally.
> > sp/mmap needs relatively recent cygwin library (otherwise pread
> > is broken). No other ill effects noticed. Perfomance is bearable.
>
> The default on Cygwin is now NO_MMAP.  I've disabled that default

I left it at NO_MMAP: wanted to see how bad pread performs.
No worse than mmap, as it seems.

> in my own Cygwin environment and continue to use mmap() rather than
> pread(), but I'm also running my sp/mmap change there.  I haven't
> noticed a performance difference, but I also haven't tested for one.
> IOW if there is a difference its close enough to noise to not be
> visible to me as a user.

Confirm that.
