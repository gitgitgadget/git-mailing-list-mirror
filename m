From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 13:38:06 +0200
Organization: At home
Message-ID: <ehaceq$he7$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <45355CBB.80108@utoronto.ca> <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE> <eh64tk$rug$2@sea.gmane.org> <BAYC1-PASMTP069C473B2E79389E5BFC92AE0F0@CEZ.ICE> <eh6dgr$pu8$1@sea.gmane.org> <Pine.LNX.4.63.0610190144450.14200@wbgn013.biozentrum.uni-wuerzburg.de> <4536DBB1.6050701@spamcop.net> <Pine.LNX.4.63.0610191250400.14200@wbgn013.biozentrum.uni-wuerzburg.de> <45375D16.90204@spamcop.net> <Pine.LNX.4.63.0610191321090.14200@wbgn013.biozentrum.uni-wuerzburg.de> <453761D5.80306@spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 20 13:38:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gasho-0004q5-IQ
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 13:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423099AbWJTLi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 07:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423148AbWJTLiZ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 07:38:25 -0400
Received: from main.gmane.org ([80.91.229.2]:8922 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423099AbWJTLiY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 07:38:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GashY-0004nC-OL
	for git@vger.kernel.org; Fri, 20 Oct 2006 13:38:12 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 13:38:12 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 13:38:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29451>

Charles Duffy wrote:

> Johannes Schindelin wrote:
>>> Shell scripts allow for a fragile system because they could include C
code
>>> snippets which they then compile and LD_PRELOAD.
>>>     
>>
>> Well, I do not expect people to misbehave. You do not compile a nasty 
>> C-program from a shell script _by mistake_.
> 
> You also don't replace bzrlib functionality (in your terms, plumbing) in 
> a plugin by mistake.

Perhaps the cause for not having plugins in GIT (besides the fact that
it follows OSS + Unix guidelines) is that git is not libified, yet. It
is "scriptified", i.e. it has many helper programs, and has options for
pipelining that it is really easy to use in scripts (Cogito, pg, StGit),
but the libification effort is [only] ongoing.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
