From: Junio C Hamano <junkio@cox.net>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 15:30:20 -0800
Message-ID: <7vslp84u43.fsf@assigned-by-dhcp.cox.net>
References: <20060322133337.GU20746@lug-owl.de>
	<Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
	<Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
	<44223B90.3040500@zytor.com>
	<1143128751.6850.35.camel@neko.keithp.com>
	<Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
	<BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE>
	<Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
	<20060323204825.GE30176@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, sean <seanlkml@sympatico.ca>,
	keithp@keithp.com, hpa@zytor.com, jbglaw@lug-owl.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 00:30:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMZG8-0000d1-4K
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 00:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWCWXaY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 18:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWCWXaY
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 18:30:24 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31187 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1422634AbWCWXaX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 18:30:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060323233022.FNTD17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Mar 2006 18:30:22 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060323204825.GE30176@spearce.org> (Shawn Pearce's message of
	"Thu, 23 Mar 2006 15:48:25 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17884>

Shawn Pearce <spearce@spearce.org> writes:

> I'm not trying to bash Windows users.  I'm just saying that there's
> definately a large user base for SCMs such as CVS who just want
> to check in the latest version of a file they have to maintain.
> Many of these people are afraid of a command prompt.  Asking them
> to install Cygwin just to check in a file is a difficult challenge.

Export your git repository via git-cvsserver and have them use
TortoiseCVS.  Such "maintain the tip and that is the only thing
what interest me" people do not even need to know the backend is
git.
