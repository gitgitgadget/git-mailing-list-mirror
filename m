From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 23:21:12 +0200
Organization: linutronix
Message-ID: <1115932872.11872.86.camel@tglx>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	 <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
	 <1115858022.22180.256.camel@tglx> <7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
	 <1115884637.22180.277.camel@tglx> <7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net>
	 <1115930845.11872.79.camel@tglx>
	 <4776.10.10.10.24.1115932163.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 23:14:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWKzf-0005oi-Ru
	for gcvg-git@gmane.org; Thu, 12 May 2005 23:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVELVUa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 17:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVELVUa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 17:20:30 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:141
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262126AbVELVUV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 17:20:21 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 7C88A65C003;
	Thu, 12 May 2005 23:20:17 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id E5A3528204;
	Thu, 12 May 2005 23:20:16 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <4776.10.10.10.24.1115932163.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 17:09 -0400, Sean wrote:
> On Thu, May 12, 2005 4:47 pm, Thomas Gleixner said:
> 
> > As I said before timestamps can be a horrid source of information. Also
> > if you keep a list of commits merges and head forwards in timed order it
> > is simple to read the repository history, but in case of corruption you
> > have to reconstruct it manually. There is no way to do so with the
> > information available.
> >
> > Repository id's can be lost, but are simple to replace as they are
> > recorded in the commit blob.
> 
> And the time is recorded on the commit blob too. 

How do you enforce correct timestamps  ? 

tglx


Received: from simmts5-srv.bellnexxia.net (simmts5.bellnexxia.net
[206.47.199.163]) by mail.tglx.de (Postfix) with ESMTP id 623FE65C003
for <tglx@linutronix.de>; Thu, 12 May 2005 23:09:21 +0200 (CEST)
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
(InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP id
<20050512210923.CCQN11606.simmts5-srv.bellnexxia.net@linux1>; Thu, 12
May 2005 17:09:23 -0400








