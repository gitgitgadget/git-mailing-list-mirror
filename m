From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Mon, 3 Apr 2006 12:42:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604031240120.30048@alien.or.mcafeemobile.com>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
 <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604021454560.30205@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0604021749580.23419@g5.osdl.org>
 <Pine.LNX.4.64.0604022022390.10401@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0604022116060.3781@g5.osdl.org>
 <Pine.LNX.4.64.0604022124440.10401@alien.or.mcafeemobile.com>
 <7v4q1bglkp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604031222360.30048@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 21:43:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQUx0-0005Jc-C1
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 21:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWDCTmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 15:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWDCTmu
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 15:42:50 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:60844 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S964848AbWDCTmu
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 15:42:50 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C85D7> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 3 Apr 2006 12:42:47 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604031222360.30048@alien.or.mcafeemobile.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18349>

On Mon, 3 Apr 2006, Davide Libenzi wrote:

> On Mon, 3 Apr 2006, Junio C Hamano wrote:
>> 
>> I've tried this patch but it is not right; the diff between the
>> attached two files show a 47-line hunk that inserts at line 400,
>> then the next 6-line hunk inserts at line 401 which is obviously
>> bogus.

That's fine, since that's orig file position *before* the insert. Try the 
same with GNU diff and you should see the same. Also try to create a diff 
with libxdiff (with the fix) and feed it to GNU patch.



- Davide
