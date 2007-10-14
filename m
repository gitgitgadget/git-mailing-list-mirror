From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 14 Oct 2007 22:22:30 +0200
Message-ID: <47127A86.2040607@op5.se>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com> <Pine.LNX.4.64.0710130130380.25221@racer.site> <853awepyz6.fsf@lola.goethe.zz> <20071013202713.GA2467@fieldses.org> <Pine.LNX.4.64.0710140135020.25221@racer.site> <alpine.LFD.0.999.0710131810550.6887@woody.linux-foundation.org> <20071014014445.GN27899@spearce.org> <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com> <47125BF7.2070503@midwinter.com> <20071014184050.GB31260@fieldses.org> <471272F5.2000902@op5.se> <Pine.LNX.4.64.0710142117220.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Steven Grimm <koreth@midwinter.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 22:22:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih9z4-0004Sq-Fp
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 22:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758489AbXJNUWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 16:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758411AbXJNUWg
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 16:22:36 -0400
Received: from mail.op5.se ([193.201.96.20]:43555 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758110AbXJNUWf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 16:22:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 3E2561730708;
	Sun, 14 Oct 2007 22:22:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wLY-58ngqRlZ; Sun, 14 Oct 2007 22:22:32 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id BE5C617306F0;
	Sun, 14 Oct 2007 22:22:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710142117220.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60902>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 14 Oct 2007, Andreas Ericsson wrote:
> 
>> J. Bruce Fields wrote:
>>
>>> Though actually the quickest way to checkout an arbitrary revision is 
>>> with detached heads, and that doesn't require learning git-branch 
>>> right away.
>> But the *easiest* way, where "easiest" means "involves the fewest 
>> commands with smallest risk of fscking up your own repo", is to do
>>
>>
>> git clone <other-devs-repo> other-devs-repo
>> cd other-devs-repo
>> git checkout -b thebug <the-bug-hash>
> 
> I'd just do
> 
> 	git checkout <the-bug>^{commit}
> 
> and be done...
> 

So:

	if (have_bug_in_repo)
		do_the_dscho_way()
	else ...

See what I mean?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
