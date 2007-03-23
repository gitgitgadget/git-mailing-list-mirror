From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Git / Subversion Interoperability
Date: Fri, 23 Mar 2007 15:00:22 -0700
Message-ID: <46044DF6.6070902@midwinter.com>
References: <20070322224829.GA7048@c3sl.ufpr.br>	<20070323004335.GA17773@spearce.org>	<Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk> <20070323233036.77325e5a@athlon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Wiese <morfoh@opensde.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 23:00:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUroE-0000Z8-6q
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 23:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934322AbXCWWA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 18:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934324AbXCWWA1
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 18:00:27 -0400
Received: from tater.midwinter.com ([216.32.86.90]:55816 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934322AbXCWWA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 18:00:26 -0400
Received: (qmail 10781 invoked from network); 23 Mar 2007 22:00:25 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=kfO2vRqaHnT/cXNGX1UxzyyhmiiESt2sLmHTNBm1+ABhu5QQSuTkGzoSCwY8DCtd  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 23 Mar 2007 22:00:25 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <20070323233036.77325e5a@athlon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42965>

Christian Wiese wrote:
> I'm currently facing this issue while trying to migrate from svn to git
> within my local working environment to gather experience while working
> with git to be able to effectively "sell" git to the other people of
> our project and provide a smooth migration path for them.
>   

Would a git svn server be of interest in such a situation, though? 
That's exactly the situation I'm in, and git-svn is doing an admirable 
job of integrating the two environments without disrupting the folks who 
are happy with svn. It seems like the git svn server would be useful in 
the opposite environment, where you have a git project that people want 
to access with svn tools (e.g. because there's no git integration in an 
IDE or whatever.)

Maybe I'm just misunderstanding what the server in question would do, 
but it seems like it's not likely to be that useful in cases where you 
already have a real svn server running and holding the canonical copy of 
the project.

-Steve
