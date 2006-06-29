From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Makefile: set USE_PIC on Linux x86_64 for linking with Git.pm
Date: Fri, 30 Jun 2006 00:22:37 +0200
Organization: At home
Message-ID: <e81jr5$l1c$1@sea.gmane.org>
References: <20060628183557.GA5713@fiberbit.xs4all.nl> <7vr719159v.fsf@assigned-by-dhcp.cox.net> <7virml14za.fsf@assigned-by-dhcp.cox.net> <20060628192145.GD5713@fiberbit.xs4all.nl> <1151527945.1619.17.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 30 00:23:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw4ub-0008QG-Qg
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 00:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059AbWF2WW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 18:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933060AbWF2WW6
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 18:22:58 -0400
Received: from main.gmane.org ([80.91.229.2]:52189 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S933059AbWF2WW5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 18:22:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fw4uP-0008OA-7O
	for git@vger.kernel.org; Fri, 30 Jun 2006 00:22:49 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 00:22:49 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 00:22:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22920>

Pavel Roskin <proski@gnu.org> wrote:

> On Wed, 2006-06-28 at 21:21 +0200, Marco Roeland wrote:
>> I certainly do not know cases outside Linux where this might break on
>> x86-64. I just tried to limit it to the case I could test. But perhaps
>> someone with an x86-64 BSD or Solaris might try it?
>> 
>> To paraphrase Dave Jones: I type 'make', it fails. Some 'git log' later
>> I realise I have to manually define 'USE_PIC'. Hey, why doesn't it work
>> automagically?
> 
> Automagically?  You should search the archives for "Autoconf".  When I
> proposed using it, the hell broke loose.  Now let me indulge in
> Schadenfreude :-)

If I remember correctly everybody agreed that autoconf is least evil of the
whole autotools package. pasky suggested to write ./configure script by
hand on #git...

I'm trying to do inobtrusive _optional_ autoconf support in the patch series
beginning with
  Message-ID: <200606290301.51657.jnareb@gmail.com>
  http://permalink.gmane.org/gmane.comp.version-control.git/22832

Please wait for the patch moving ./autoconf output away from config.mak
(as some people here requested), and do contribute! My autoconf/m4
experience is nonexistent (I'm learning it as I go). See comments in the
third [PATCH/RFC] in series.

BTW. patches are against master.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
