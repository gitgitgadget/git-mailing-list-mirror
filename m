From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Latest cogito broken with bash-3.1
Date: Mon, 12 Dec 2005 12:02:22 +0100
Message-ID: <1134385342.1468.27.camel@blade>
References: <1134220724.15125.4.camel@blade>
	 <20051211001106.GV22159@pasky.or.cz> <1134289867.9541.9.camel@blade>
	 <20051212002631.GW22159@pasky.or.cz> <1134379801.1468.5.camel@blade>
	 <20051212104039.GJ10680@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 12:02:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EllRx-0002kX-8y
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 12:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVLLLC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 06:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVLLLC2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 06:02:28 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:61572 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751224AbVLLLC2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 06:02:28 -0500
Received: from blade (p5487FBB4.dip.t-dialin.net [84.135.251.180])
	by mail.holtmann.net (8.13.4/8.13.4/Debian-3) with ESMTP id jBCB2N1Y018356
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Mon, 12 Dec 2005 12:02:24 +0100
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051212104039.GJ10680@pasky.or.cz>
X-Mailer: Evolution 2.5.2 
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24 
	autolearn=no version=3.0.3
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on coyote.holtmann.net
X-Virus-Scanned: ClamAV 0.84/1208/Mon Dec 12 09:51:58 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13518>

Hi Petr,

> > > > There exists also another problem with the new bash. It is the broken
> > > > pipe error from cg-log.
> > > > 
> > > > cg-log: line 141: echo: write error: Broken pipe
> > > > 
> > > > The line number varies depending how much you scrolled and when you
> > > > scrolled to the end no broken pipe error comes up. Do you have any idea
> > > > on how to deal with this. I saw your comment about that bash is broken
> > > > and the extra trap command, but it doesn't help. I never saw that
> > > > problem with older versions of bash.
> > > 
> > >   Then that's quite funny, one-line broken pipe message has been always
> > > there (in the past it looked much worse, we thankfully managed to bring
> > > it down to this at least).
> > 
> > I have some machines where I stopped installing the latest bash version
> > and they don't have this problem. With bash-2.05b.0 and bash-3.00.16 I
> > never (and really mean never) saw this problem.
> 
>   this might be some Debian patches then. Indeed, with bash-3.00.16 on
> both systems, the line is shown on my home Gentoo system but not on my
> Debian machine at work. On RHEL at kernel.org the line is not printed
> either. Hmm. So either it's not really bash what emits this (but what
> then?) or most of the distributions override that stupid bash behaviour
> with a patch already. And Debian didn't foreport the patch to bash-3.1.

I just verified that on my Ubuntu Dapper system where I had a copy of
the old bash package lying around. The bash-3.0 works fine, but the
bash-3.1 produces this error. So it is definitely bash related.

Regards

Marcel
