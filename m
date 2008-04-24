From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Excruciatingly slow git-svn imports
Date: Thu, 24 Apr 2008 12:57:24 -0700
Message-ID: <2C39C19D-0B81-4879-92DC-C0436DB6E84E@midwinter.com>
References: <CC0F600D-71F3-493A-AA9C-AF901C1A58C4@adacore.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 22:04:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp7gd-0004WO-BX
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 22:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761194AbYDXUEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 16:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761000AbYDXUEH
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 16:04:07 -0400
Received: from tater.midwinter.com ([216.32.86.90]:47864 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760874AbYDXUEG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 16:04:06 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Apr 2008 16:04:06 EDT
Received: (qmail 31116 invoked from network); 24 Apr 2008 19:57:24 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=jRDyBfhcmCBnGq/mrP8LzGoKs0VZVCK6PZ+3uslHdzFRvvbiG9qzEA0qvGuLQqH1  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 24 Apr 2008 19:57:24 -0000
In-Reply-To: <CC0F600D-71F3-493A-AA9C-AF901C1A58C4@adacore.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80315>

On Apr 24, 2008, at 11:54 AM, Geert Bosch wrote:

> I'm trying to import a 9.7G, 130K revision svn repository
> but it seems to only import about 6K revisions per day on fast  
> hardware
> using a recent git (1.5.5).

I've found that git-svn gets slower as it runs. Try interrupting the  
clone and running "git svn fetch" -- it should pick up where it left  
off and will be MUCH faster if my experience is any indication. When I  
clone the big svn repository at work I usually restart it every 1000  
revisions or so and it finishes in a fraction of the time it takes if  
I let it do everything in a single run.

-Steve
