From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Local clone/fetch with cogito is glacial
Date: Tue, 23 May 2006 01:24:37 +0200
Message-ID: <20060522232437.GN11941@pasky.or.cz>
References: <4470FC21.6010104@zytor.com> <BAYC1-PASMTP11FDE05B530CFF43C043E5AE9A0@CEZ.ICE> <44722A8F.9020609@zytor.com> <20060522220206.GA10488@pasky.or.cz> <447239F0.9030705@zytor.com> <20060522225054.GL11941@pasky.or.cz> <Pine.LNX.4.64.0605221615030.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, Sean <seanlkml@sympatico.ca>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 01:24:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiJlY-0003Z7-AS
	for gcvg-git@gmane.org; Tue, 23 May 2006 01:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWEVXYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 19:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWEVXYe
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 19:24:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11912 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751037AbWEVXYd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 19:24:33 -0400
Received: (qmail 15768 invoked by uid 2001); 23 May 2006 01:24:37 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605221615030.3697@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20552>

> The git-clone script will literally special-case rsync:// and http://. 
> Everything else should work fine with git-fetch-pack.

Aha, I overlooked that what I described goes on in git-clone happens
only with git-clone -l, otherwise it indeed seems to use git-fetch-pack.
Sorry about the confusion.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
