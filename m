From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 17:09:23 -0400 (EDT)
Message-ID: <4776.10.10.10.24.1115932163.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com> 
    <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com> 
    <1115858022.22180.256.camel@tglx>
    <7vekcdmd16.fsf@assigned-by-dhcp.cox.net> 
    <1115884637.22180.277.camel@tglx>
    <7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net>
    <1115930845.11872.79.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 23:02:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWKof-0004C5-NJ
	for gcvg-git@gmane.org; Thu, 12 May 2005 23:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVELVJe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 17:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVELVJe
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 17:09:34 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:12496 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262116AbVELVJY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 17:09:24 -0400
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512210923.CCQN11606.simmts5-srv.bellnexxia.net@linux1>;
          Thu, 12 May 2005 17:09:23 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4CL9N0a019383;
	Thu, 12 May 2005 17:09:23 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 May 2005 17:09:23 -0400 (EDT)
In-Reply-To: <1115930845.11872.79.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 4:47 pm, Thomas Gleixner said:

> As I said before timestamps can be a horrid source of information. Also
> if you keep a list of commits merges and head forwards in timed order it
> is simple to read the repository history, but in case of corruption you
> have to reconstruct it manually. There is no way to do so with the
> information available.
>
> Repository id's can be lost, but are simple to replace as they are
> recorded in the commit blob.

And the time is recorded on the commit blob too. In case of corruption,
restore the blobs from backup, you get everything back.  Corruption can
wipe out repoids and complete git objects too, you had better have
backups.  Repoids offer no protection from corruption or otherwise lost
blobs.

Sean


