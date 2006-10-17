From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: What's in git.git
Date: Tue, 17 Oct 2006 11:15:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610171113450.8404@alien.or.mcafeemobile.com>
References: <7vvemjmlo2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171005370.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 20:37:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZtoI-00065K-4v
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 20:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWJQSTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 14:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWJQSTM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 14:19:12 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:10982 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750762AbWJQSTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 14:19:12 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F5701> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Tue, 17 Oct 2006 11:15:52 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610171005370.3962@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29100>

On Tue, 17 Oct 2006, Linus Torvalds wrote:

>  - while the hash function problem _can_ cause really huge slowdowns in 
>    some unlucky situations, it actually causes noticeable performance 
>    issues even for normal situations.

Yes, using a 32 bits multiplier on a 64 bits machine transform the almost 
O(1) hash performance to a crappy O(N) list performance. you notice that 
in every diff operation, independently from the content.



- Davide
