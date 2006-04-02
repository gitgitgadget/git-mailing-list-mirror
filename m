From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Sun, 2 Apr 2006 15:18:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021517350.30205@alien.or.mcafeemobile.com>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
 <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604021411300.23419@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 00:19:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQAuT-0002Ef-Hw
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 00:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWDBWS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 18:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWDBWS6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 18:18:58 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:30892 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932405AbWDBWS6
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 18:18:58 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C8349> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sun, 2 Apr 2006 15:18:55 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604021411300.23419@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18292>

On Sun, 2 Apr 2006, Linus Torvalds wrote:

> On Sun, 2 Apr 2006, Junio C Hamano wrote:
>>
>> I should have tried your pristine xdiff code myself before
>> bothering you, but I haven't (sorry).
>
> It definitely happens with plain libxdiff-0.17 too.
>
> In general, unless it's related to the "\ No newline" or the extra stuff
> on the "@@"-line, I'd be very surprised if we have any differences in the
> diff output wrt libxdiff-0.17. I was really pretty careful, and didn't
> change the code at all, just removed unnecessary files and functions.

So it does 0.18, that contains the "\ No newline" handling for text diff 
and patch. See my reply to Junio also.



- Davide
