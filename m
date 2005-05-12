From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 18:24:57 -0400 (EDT)
Message-ID: <4084.10.10.10.24.1115936697.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com> 
    <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com> 
    <1115858022.22180.256.camel@tglx>
    <7vekcdmd16.fsf@assigned-by-dhcp.cox.net> 
    <1115884637.22180.277.camel@tglx>
    <7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net>  
    <1115930845.11872.79.camel@tglx> 
    <4776.10.10.10.24.1115932163.squirrel@linux1> 
    <1115932872.11872.86.camel@tglx> 
    <2477.10.10.10.24.1115933520.squirrel@linux1>
    <1115935604.11872.97.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 00:17:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWLzc-0005sb-9X
	for gcvg-git@gmane.org; Fri, 13 May 2005 00:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVELWZA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 18:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVELWZA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 18:25:00 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:62434 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262156AbVELWY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 18:24:58 -0400
Received: from linux1 ([69.156.111.46]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512222458.YXDM23474.simmts7-srv.bellnexxia.net@linux1>;
          Thu, 12 May 2005 18:24:58 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4CMOtkk020696;
	Thu, 12 May 2005 18:24:56 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 May 2005 18:24:57 -0400 (EDT)
In-Reply-To: <1115935604.11872.97.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 6:06 pm, Thomas Gleixner said:

Thomas,

> That limits the usefulness to a local place, which makes no sense in a
> distributed development scenario.

I don't think that is true, the only time you'd use this time is when
comparing against other commits from the same repository.  As you download
the commits you're interested in from a remote repository, you compare
them to each other to get the order.

Sean


