From: Anders Larsen <al@alarsen.net>
Subject: Re: [ANNOUNCE] GIT 1.4.3
Date: Sun, 22 Oct 2006 23:09:32 +0200
Organization: systems engineer Anders Larsen
Message-ID: <pan.2006.10.22.21.09.32.177539@alarsen.net>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org> <20061021002251.GO20017@pasky.or.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 23:10:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbkak-0007XU-Rq
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 23:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWJVVKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 17:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWJVVKd
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 17:10:33 -0400
Received: from main.gmane.org ([80.91.229.2]:33440 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750728AbWJVVKb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 17:10:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GbkaK-0007Rc-FM
	for git@vger.kernel.org; Sun, 22 Oct 2006 23:10:20 +0200
Received: from p54ac104d.dip0.t-ipconnect.de ([84.172.16.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 23:10:20 +0200
Received: from al by p54ac104d.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 23:10:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54ac104d.dip0.t-ipconnect.de
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29794>

On Sat, 21 Oct 2006 02:22:51 +0200, Petr Baudis wrote:

>> That said, "LESS=FRS" doesn't really help that much. It still clears the 
>> screen. Using "LESS=FRSX" fixes that, but the alternate display sequence 
>> is actually nice _if_ the pager is used.
> 
> Hmm, what terminal emulator do you use? The reasonable ones should
> restore the original screen.

And indeed they do.
The problem is, when the original screen is restored, the diff output that
was paged through less -FRS goes poof as well.

Cheers
 Anders
