From: sean <seanlkml@sympatico.ca>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 21:43:07 -0500
Message-ID: <BAYC1-PASMTP0804299A4D3C5C1973FF6CAE260@CEZ.ICE>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
	<7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
	<43C6CFC5.5010902@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 03:47:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExEyZ-00046u-9H
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 03:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161396AbWAMCra (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 21:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161450AbWAMCra
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 21:47:30 -0500
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:35958 "EHLO
	BAYC1-PASMTP08.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1161396AbWAMCr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 21:47:29 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP08.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jan 2006 18:49:06 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id E0F38644C23;
	Thu, 12 Jan 2006 21:47:27 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Message-Id: <20060112214307.174f5719.seanlkml@sympatico.ca>
In-Reply-To: <43C6CFC5.5010902@op5.se>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 Jan 2006 02:49:06.0296 (UTC) FILETIME=[EB882780:01C617EB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 12 Jan 2006 22:53:09 +0100
Andreas Ericsson <ae@op5.se> wrote:

> Junio C Hamano wrote:
> > 
> > If you typed that line, why somebody else's change ended up in
> > your working tree is a mystery to me, but let's say an
> > office-mate edited things for you and said "this should work.
> > test it out and if it is OK commit it for me."  I have seen this
> > kind of thing done in real life.
> > 
> This happens from time to time where I work, but I think it would be 
> more useful to have
> 
> 	--from="Some User <some.user@theoffice.org>"
> 
> which would save even more typing.
> 
> I had thought of coupling this with some translation-scheme thingie, so 
> that "--from=jd" would be automagically converted to the proper name and 
> email address. I first came to think about this when I imported most of 
> our projects from CVS, but I ended up doing a quick-hack to 
> git-cvsimport instead.

Yeah, this might be the way to go; however if you are cutting and pasting
the commit message already, this might be slightly less convenient because
now you have to copy-n-paste to the command line instead of just to your
commit editor.   Hopefully it would help to avoid the need for others
to hack the scripts ;o)   Also it would be nice if it could help simplify
the git-am script as Junio suggested too.

Sean
