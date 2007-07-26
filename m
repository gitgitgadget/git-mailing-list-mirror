From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 23:39:35 +0200
Organization: At home
Message-ID: <f8b4ak$8pe$1@sea.gmane.org>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com> <7vps2fc196.fsf@assigned-by-dhcp.cox.net> <20070726031838.GO32566@spearce.org> <7v6447bxc1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707260614500.14781@racer.site> <46A8378A.6050201@xs4all.nl> <Pine.LNX.4.64.0707260737170.14781@racer.site> <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com> <20070726071316.GE18114@spearce.org> <f329bf540707260018u21ad8e16h75cc9c3351fe0fc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 23:39:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEB3n-0002Va-Dr
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 23:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765072AbXGZVjs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 17:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764931AbXGZVjs
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 17:39:48 -0400
Received: from main.gmane.org ([80.91.229.2]:51199 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763658AbXGZVjr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 17:39:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IEB3e-0005aY-0L
	for git@vger.kernel.org; Thu, 26 Jul 2007 23:39:42 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 23:39:41 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 23:39:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53869>

Han-Wen Nienhuys wrote:

> 2007/7/26, Shawn O. Pearce <spearce@spearce.org>:
>> Han-Wen Nienhuys <hanwenn@gmail.com> wrote:

>>> I would suggest to making a clear
>>> decision of what are recommended languages, and move everything else
>>> to contrib/ .. Currently, C and bash seem the most reasonable choice,
>>> but you could decide for perl, but then the consequence should be that
>>> the bash scripts are translated into perl. Having both bash and perl
>>> serves no purpose, and will lead to duplication of library code to
>>> interact with the git binary.
>>
>> Sure, but there's some stuff that shell is good at, and other stuff
>> that Perl is good at.  Forcing everything into one mold while we
>> prototype new features is really limiting.
> 
> I'm not contradicting that, but merely suggesting that they go into
> contrib/ and are not recommended as standard git commands, and don't
> need to be packaged for windows.

They can be not packaged for windows, but for example git-send-email
(which is written in Perl) is IMHO important enough to be in git proper
and not delegated to contrib/; but it is packaged in separate RPM,
git-email. Same with git-svn package...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
