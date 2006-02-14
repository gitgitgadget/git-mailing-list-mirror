From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling large files with GIT
Date: Tue, 14 Feb 2006 14:30:03 -0800
Message-ID: <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
	<87slqty2c8.fsf@mid.deneb.enyo.de>
	<46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
	<Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
	<Pine.LNX.4.64.0602121939070.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602122058260.3691@g5.osdl.org>
	<43F113A5.2080506@f2s.com>
	<Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0602141108050.3691@g5.osdl.org>
	<43F249F7.5060008@vilain.net>
	<Pine.LNX.4.64.0602141357300.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:31:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F98hS-0001ja-4J
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 23:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422840AbWBNWbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 17:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422841AbWBNWbH
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 17:31:07 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:21402 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1422840AbWBNWbF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 17:31:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214222834.LZJZ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 17:28:34 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602141357300.3691@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 14 Feb 2006 14:01:33 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16188>

Linus Torvalds <torvalds@osdl.org> writes:

> If somebody is interested in making the "lots of filename changes" case go 
> fast, I'd be more than happy to walk them through what they'd need to 
> change. I'm just not horribly motivated to do it myself. Hint, hint.

In case anybody is wondering, I share the same feeling.  I
cannot say I'd be "more than happy to" clean up potential
breakages during the development of such changes, but if the
change eventually would help certain use cases, I can be
persuaded to help debugging such a mess ;-).
