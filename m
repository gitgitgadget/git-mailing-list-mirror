From: sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Add --continue and --abort options to git-rebase.
Date: Thu, 27 Apr 2006 01:42:37 -0400
Message-ID: <BAYC1-PASMTP08831D3D326017F52485CCAEBD0@CEZ.ICE>
References: <BAYC1-PASMTP0659C709B7FFCB63182FE1AEBC0@CEZ.ICE>
	<e2np4p$b9a$1@sea.gmane.org>
	<BAYC1-PASMTP025110BEB495EC4F07CDE2AEBC0@CEZ.ICE>
	<7v3bg0nlvb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 07:47:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYzLL-000158-I2
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 07:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWD0FrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 01:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWD0FrF
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 01:47:05 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:15045 "EHLO
	BAYC1-PASMTP08.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S964940AbWD0FrD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 01:47:03 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP08.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 26 Apr 2006 22:51:17 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 6423F644C28;
	Thu, 27 Apr 2006 01:47:01 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060427014237.6f7e5f8b.seanlkml@sympatico.ca>
In-Reply-To: <7v3bg0nlvb.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Apr 2006 05:51:17.0531 (UTC) FILETIME=[9A043EB0:01C669BE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 26 Apr 2006 13:05:28 -0700
Junio C Hamano <junkio@cox.net> wrote:

> sean <seanlkml@sympatico.ca> writes:
> 
> >   git rebase [--onto <newbase>] <upstream> [<branch>]
> >   git rebase --continue
> >   git rebase --abort
> >
> > ---
> >
> > Take 2.  Must simpler patch which doesn't trying to 
> > rejigger the command line too much.
> 
> This second round seems to make more sense.  Sign-off?
> 

Sure,

    Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

Sean
