From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 09:17:30 +0000
Organization: linutronix
Message-ID: <1115889450.22180.301.camel@tglx>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	 <1115854733.22180.202.camel@tglx>
	 <200505111941.04104.dtor_core@ameritech.net>
	 <1115858670.22180.259.camel@tglx> <4282ACD3.50009@zytor.com>
	 <4282ADC9.2010900@zytor.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 11:12:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW9i6-0006y6-7r
	for gcvg-git@gmane.org; Thu, 12 May 2005 11:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVELJRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 05:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVELJRV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 05:17:21 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:25735
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261357AbVELJQq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 05:16:46 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 3F9FE65C003;
	Thu, 12 May 2005 11:16:34 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 3717428204;
	Thu, 12 May 2005 11:16:37 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4282ADC9.2010900@zytor.com>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 18:13 -0700, H. Peter Anvin wrote:
> > You shouldn't be rsyncing the .git directory, only .git/objects anyway. 
> >   Some people seem to have merely copied Linus' entire tree, and that's 
> > what causing problems. 
> > That one you can't win.

:)

> What I meant with that is I think .git/repoid is the right thing, if the 
> file doesn't exist a new ID file is generated.

Yep, convinced. 
The only thing I'd like to see is some thing which is human readable and
maybe helpful to deduce the context of this. 
Adding a dev/random number to make it unique is not bad.

So what about
repoid 'pwd' 'random' ?

> If people are copying their repoid file explicitly it's up to them to 
> know what they're doing.

True. I makes sense for maintainers doing updates to their public
repositories to keep the same repoid in their working copy at home/work.

tglx



