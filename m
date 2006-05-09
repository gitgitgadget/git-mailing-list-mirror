From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 15:44:59 -0400
Message-ID: <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
	<Pine.LNX.4.64.0605081905240.6713@iabervon.org>
	<BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
	<7virogc90u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
	<7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
	<BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
	<BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
	<e3p5om$djs$1@sea.gmane.org>
	<Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 22:13:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdYZB-00053E-9u
	for gcvg-git@gmane.org; Tue, 09 May 2006 22:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWEIUMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 16:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWEIUMS
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 16:12:18 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:18965 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751115AbWEIUMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 16:12:18 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 May 2006 13:12:17 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 3C309644C28;
	Tue,  9 May 2006 15:50:08 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060509154459.40cc0d13.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 09 May 2006 20:12:17.0603 (UTC) FILETIME=[DEC6A930:01C673A4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 9 May 2006 12:24:02 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> NOTE! This patch could be applied right now, and to all the branches (to
> make 1.x, 1.2.x and 1.3.x all support the _syntax_). Even if nothing 
> actually uses it.
> 
> It just makes the syntax be
> 
> 	[section<space>+"<randomstring>"]
> 
> where the only rule for "randomstring" is that it can't contain a newline, 
> and if you really want to insert a double-quote, you do it with \".

Lightly tested here.  Looks good.

Sean
