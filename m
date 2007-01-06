From: Steven Grimm <koreth@midwinter.com>
Subject: Re: New way of tracking remote branches -- question
Date: Fri, 05 Jan 2007 18:11:57 -0800
Message-ID: <459F056D.8010705@midwinter.com>
References: <776323.21089.qm@web31808.mail.mud.yahoo.com>	<7vejq9c9tf.fsf@assigned-by-dhcp.cox.net> <7v8xghariv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 03:11:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3120-0005PS-CD
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 03:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbXAFCLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 21:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbXAFCLd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 21:11:33 -0500
Received: from tater.midwinter.com ([216.32.86.90]:45212 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751082AbXAFCLc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 21:11:32 -0500
Received: (qmail 3182 invoked from network); 6 Jan 2007 02:11:32 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=JXVaHpDl9/N4NWMCG9V01hGVWiSy/2ekuZGlZmPZjJ7oRtPBx1nTMiCMIYogjV5V  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 6 Jan 2007 02:11:32 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xghariv.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36071>

Junio C Hamano wrote:
> I think other poeple on the list (especially the ones who wanted
> separate remote layout) prefer not to have the automatic fork of
> all remote branches.
>   

I'm a big fan of separate remote, and while I don't necessarily think 
automatic fork should be the default behavior, it might be nice to have 
an option for it, including setting up the appropriate config entries so 
push/pull do the expected things.

If that doesn't sound palatable, maybe an option to specify which remote 
branch to check out by default -- that way you can tell someone to run a 
particular git-clone command to get a local copy of a specific branch of 
yours. We just had a need for that here today, in fact. The current 
behavior is pretty screwy when you want to tell someone to clone your 
development environment to look at what you're doing; they don't have a 
good way of knowing which of your branches they're going to end up with, 
since you might be working in any of them when they happen to run 
git-clone. You end up having to say, "Run git-clone, then run 
git-branch, and if you don't see '* xyz', then run 'git-checkout -b xyz 
origin/xyz'."

-Steve
