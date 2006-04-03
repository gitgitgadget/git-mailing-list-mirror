From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Sun, 2 Apr 2006 21:30:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604022124440.10401@alien.or.mcafeemobile.com>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
 <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604021454560.30205@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0604021749580.23419@g5.osdl.org>
 <Pine.LNX.4.64.0604022022390.10401@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0604022116060.3781@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 06:30:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQGho-0000as-Tu
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 06:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWDCEaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 00:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWDCEaJ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 00:30:09 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:38828 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750859AbWDCEaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 00:30:07 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C83B5> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sun, 2 Apr 2006 21:30:04 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604022116060.3781@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18313>

On Sun, 2 Apr 2006, Linus Torvalds wrote:

> On Sun, 2 Apr 2006, Davide Libenzi wrote:
>>
>> Tomorrow I'll take a look at it.
>
> Thanks. I've made the first "release" (2.6.17-rc1) with the new built-in
> diff, let's see if somebody has any issues.

No problem. That's only an eye-issue though, since the diff is still a 
valid diff according to its definition where D=A-B => B+D==A && A-D==B
From the day I released 0.18, xregression is continuosly running w/out any 
issue. I'll check it out though ...



- Davide
