From: Junio C Hamano <junkio@cox.net>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 09 May 2006 15:42:25 -0700
Message-ID: <7vu07y252m.fsf@assigned-by-dhcp.cox.net>
References: <1147037659.25090.25.camel@dv>
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
	<BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
	<BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, junkio@cox.net, Johannes.Schindelin@gmx.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 00:42:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fdauc-0005iO-Qh
	for gcvg-git@gmane.org; Wed, 10 May 2006 00:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWEIWma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 18:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWEIWma
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 18:42:30 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:17321 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751321AbWEIWm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 18:42:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509224227.LRXE24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 May 2006 18:42:27 -0400
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Tue, 9 May 2006 18:09:55 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19859>

sean <seanlkml@sympatico.ca> writes:

> The syntax is:
>
>   [<random string>]

Does this mean you can have anything other than LF and ']'?

> Here's how your example would look in this style:
>
>   [email.torvalds@osdl.org]
>         name = Linus Torvalds

How does a program (not a script, but git_config() users) get
that value and parse it?  
