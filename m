From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/4] Add a basic test case for git send-email, and fix some real bugs discovered.
Date: Tue, 30 May 2006 18:00:20 +0200
Message-ID: <81b0412b0605300900l7530792dqcea6d812602b9176@mail.gmail.com>
References: <7v8xok3vhj.fsf@assigned-by-dhcp.cox.net>
	 <7v1wuc3t9y.fsf@assigned-by-dhcp.cox.net>
	 <7vu0782e33.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0605300623h4f915829yb388c8fdc062c009@mail.gmail.com>
	 <20060530152103.GB8931@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 18:00:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl6dt-0006z2-98
	for gcvg-git@gmane.org; Tue, 30 May 2006 18:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWE3QAW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 12:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWE3QAW
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 12:00:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:43061 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751524AbWE3QAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 12:00:21 -0400
Received: by wr-out-0506.google.com with SMTP id i5so13884wra
        for <git@vger.kernel.org>; Tue, 30 May 2006 09:00:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cNbIPTo9kFSiwTL/XDqCJJl0vjucdyZvr+XMscyF69P8x5F1+PlRCbkXcWKueuCj2g+mzvp6tNxkMSD9W4cY9/MICcYBHoNIR346lWbtYnk9HW+m5lEAndJFUMMHRU92Sse2Q9eGMsxMW92JeTw8MdG/8tt/4G5wU0J4MAozGzc=
Received: by 10.54.151.7 with SMTP id y7mr396051wrd;
        Tue, 30 May 2006 09:00:20 -0700 (PDT)
Received: by 10.54.67.11 with HTTP; Tue, 30 May 2006 09:00:20 -0700 (PDT)
To: "Christopher Faylor" <me@cgf.cx>
In-Reply-To: <20060530152103.GB8931@trixie.casa.cgf.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21035>

On 5/30/06, Christopher Faylor <me@cgf.cx> wrote:
> >froze afterwards anyway, as "wc" or "perl" did. Besides, it the
> >command often freezes that poor imitation of xterm windows has.
>
> I assume that "the poor imitation of xterm" is referring to cygwin's
> xterm here.  It's really too bad that you can't get into the mindset of
> reporting problems to the cygwin mailing list when you notice them.

Actually, I was referring to windows console. And no, I don't think you
could do something about it.

But honestly, I don't think it's worth supporting windows in general
and cygwin in particular. And before anyone (again) asks why am
_I_ doing it: I'd have to do my job with Perforce otherwise (as if
windows wasn't bad enough...)

> I can't comment on the proposed patch since, AFAIK, using cat, wc, and
> (cygwin's) perl should all work just fine but I don't think it is ever
> correct to complain about a platform in released software.

If you actually read the message, you'd probably notice ActiveState Perl.

I have no idea why have you taken my post as an attempt to insult cygwin;
IF I had that in mind I'd dedicate a whole long post just to that.
