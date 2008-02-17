From: Paul Gardiner <osronline@glidos.net>
Subject: Re: All I wanted was git-fast-export
Date: Sun, 17 Feb 2008 17:00:08 +0000
Message-ID: <47B86818.7010706@glidos.net>
References: <47ADE275.3060109@glidos.net> <alpine.LSU.1.00.0802091803580.11591@racer.site> <47AE2CDF.4090208@glidos.net> <alpine.LSU.1.00.0802100054490.11591@racer.site> <47AECCDC.3050500@glidos.net> <alpine.LSU.1.00.0802101248260.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, osronline@glidos.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 18:00:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQmsj-00027e-Dg
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 18:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289AbYBQRAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 12:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756381AbYBQRAQ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 12:00:16 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:25484
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756289AbYBQRAO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Feb 2008 12:00:14 -0500
X-Trace: 42527112/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.162.32
X-SBRS: None
X-RemoteIP: 62.241.162.32
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAKP2t0c+8aIg/2dsb2JhbACMO54s
X-IP-Direction: IN
Received: from ranger.systems.pipex.net ([62.241.162.32])
  by smtp.pipex.tiscali.co.uk with ESMTP; 17 Feb 2008 17:00:10 +0000
Received: from [10.0.0.24] (81-86-57-226.dsl.pipex.com [81.86.57.226])
	by ranger.systems.pipex.net (Postfix) with ESMTP id 6C9EDE00009D;
	Sun, 17 Feb 2008 17:00:10 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0802101248260.11591@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74139>

Johannes Schindelin wrote:
> Hi,
> 
> [please do not look the other way when you respond to me, i.e. do not cull 
> me from the Cc: list.  Thankyouverymuch]
> 
> On Sun, 10 Feb 2008, Paul Gardiner wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> The thing is, filter-branch was _written for this purpose_.  So if you 
>>> know what commit you rewrote last, you can make the process 
>>> faster/safer by issuing
>>>
>>> 	$ git filter-branch --msg-filter="<blabla>" <old-commit>..master
>> That does look just what I need, but did you see the reason I thought I 
>> couldn't use it? I need to repeatedly sync the git repository from a 
>> live cvs repository, and repeatedly filter the new commit messages.
> 
> Oh, I thought you saw why I put in that "<old-commit>...".  You do not 
> really need it, as filter-branch will come up with the _same_ commit 
> hashes, unless _something_ was changed.
> 
> IOW if you have only commits without that "Summary: " prefix, the 
> filter-branch call will be a (not so cheap) no-op.
> 
> But of course, I meant to suggest (admittedly, in a very short short-hand) 
> that you use "git filter-branch ... origin@{1}..origin" after cvsimport.

I'm still struggling a bit to understand ref specs. I'm using --all at
the moment, but that's very slow. What I need is to filter the new
commits of all branches. Will origin@{1}..origin do that, or does
it just affect master?

P.
