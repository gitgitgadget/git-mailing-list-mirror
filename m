From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 11:18:33 +0000
Organization: linutronix
Message-ID: <1115896713.22180.314.camel@tglx>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	 <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
	 <1115858022.22180.256.camel@tglx> <7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
	 <1115884637.22180.277.camel@tglx>
	 <1895.10.10.10.24.1115890333.squirrel@linux1>
	 <1115890792.22180.306.camel@tglx>
	 <3656.10.10.10.24.1115891188.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 13:10:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWBZw-0001or-C2
	for gcvg-git@gmane.org; Thu, 12 May 2005 13:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVELLRl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 07:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVELLRl
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 07:17:41 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:19848
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261430AbVELLRk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 07:17:40 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 52B6A65C003;
	Thu, 12 May 2005 13:17:37 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 5DEFB28284;
	Thu, 12 May 2005 13:17:40 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <3656.10.10.10.24.1115891188.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 05:46 -0400, Sean wrote:
> On Thu, May 12, 2005 5:39 am, Thomas Gleixner said:
> 
> > Please do the complete test. Sync test2 with test1 and show me the
> > picture there. It will be the same as you see in test1, which is wrong
> 
> It will get the fast forward head from test1, and so it _should_ show the
> exact same thing!  The repositories are in sync, they should display the
> exact same way.  What is the problem?

What you see is a clone and not a sync / merge. 

tglx


