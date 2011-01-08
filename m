From: John Griessen <john@ecosensory.com>
Subject: Re: debugging git clone  via git-daemon     "cannot handle daemon
 internally"
Date: Fri, 07 Jan 2011 20:37:06 -0600
Message-ID: <4D27CDD2.2050101@ecosensory.com>
References: <4D234FEF.2030501@ecosensory.com> <20110107234210.GB15495@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 08 03:37:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbOgG-0005OC-Ai
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 03:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab1AHChJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 21:37:09 -0500
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:50598 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab1AHChI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 21:37:08 -0500
X-Authority-Analysis: v=1.1 cv=UQuFHoD2CPQ248x8AXEbKhr4z9AaDqApxmEl3BhfZ64= c=1 sm=0 a=so3h3O80AgEA:10 a=8nJEP1OIZ-IA:10 a=hpnIzNeuzKcqG6phuHbX0Q==:17 a=rpqxwExkTnEeiUescGYA:9 a=t-QSHTpeh2nkDGwfLWxqDeXDZjsA:4 a=wPNLvfGTeEIA:10 a=hpnIzNeuzKcqG6phuHbX0Q==:117
X-Cloudmark-Score: 0
X-Originating-IP: 66.68.104.159
Received: from [66.68.104.159] ([66.68.104.159:42392] helo=[192.168.15.39])
	by hrndva-oedge02.mail.rr.com (envelope-from <john@ecosensory.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id EC/FF-00963-2DDC72D4; Sat, 08 Jan 2011 02:37:07 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <20110107234210.GB15495@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164802>

On 01/07/2011 05:42 PM, Jonathan Nieder wrote:
> Perhaps you have inetd set up to try to run git with argv[0] set
> to git-daemon?  git-daemon (daemon.c) has its own "main" so it
> would take something of that nature to produce this symptom.


Hmm..   My debian server has no control for inetd in /etc/init.d/
so I rebooted it to see if anything is different.  I was using an
inetd entry before...  maybe it was still running when I did that test.

After reboot:

--------------
john@toolbench:~/FABprojects/VRBO_apt$ telnet mail.cibolo.us 9418
Trying 76.191.252.85...
Connected to mail.cibolo.us.
Escape character is '^]'.


Connection closed by foreign host.

-----------------

So, the symptom changed.  No "cannot handle daemon internally" response.
Your powers of deduction are equal to any nefarious Moriarty-like character
out there it seems!

I'll test further soon.

JG

-- 
Ecosensory   Austin TX
