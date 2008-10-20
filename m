From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: Feedback outside of the user survey
Date: Mon, 20 Oct 2008 19:30:03 +0200
Message-ID: <48FCC01B.8030709@jaeger.mine.nu>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com> <20081016115628.GA24836@garry-x300.arpnetworks.com> <2d460de70810160618u1803375aj913145a5060e5308@mail.gmail.com> <48F7A4F8.2080600@jaeger.mine.nu> <20081018134906.GA13894@garry-thinkpad.arpnetworks.com> <48F9EC2B.2010200@jaeger.mine.nu> <48FC55F9.3060509@op5.se> <48FC9927.5030903@jaeger.mine.nu> <48FC9D87.3010303@op5.se> <48FCA1BC.3060300@jaeger.mine.nu> <48FCADA0.4020008@op5.se> <48FCB87B.1080207@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Garry Dolley <gdolley@arpnetworks.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 20 23:42:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrybG-0005wx-Te
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 19:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbYJTRaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 13:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbYJTRaL
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 13:30:11 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:44489 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752153AbYJTRaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 13:30:09 -0400
Received: (qmail 4205 invoked from network); 20 Oct 2008 17:30:06 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 20 Oct 2008 17:30:06 -0000
Received: (qmail 28569 invoked from network); 20 Oct 2008 17:30:03 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 20 Oct 2008 17:30:03 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48FCB87B.1080207@jaeger.mine.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98712>

Christian Jaeger wrote:
> Andreas Ericsson wrote:
>> Christian Jaeger wrote:
>>> Hm, not sure whether you mean to rescue the situation with rewritten 
>>> commits here -- but hell no, I certainly don't mean to have 
>>> different commit objects for different clones/checkouts.
>>>
>>
>> Then you'll be transferring all objects over the wire anyway
>
> Why? Again, care to differentiate between technical feasibility and 
> current implementation.

I think it was this detail:

> ... lazy cloning

which I have been leaving under the carpet in my previous mails; i.e. 
when doing merges, Git may need additional objects which haven't been 
fetched by just fetching the branches's subdirectory parts, so merges 
can't generally be done offline anymore. This is certainly a departure 
from the current idea; and if you don't want to depart from that, then 
yes, you'd need basically the whole database in advance or merges 
wouldn't be possible. So I think I understand why you said "Then you'll 
be transferring all objects over the wire anyway", you did assume that 
there would be no such thing as on-demand / lazy fetching of missing 
objects.

Christian.
