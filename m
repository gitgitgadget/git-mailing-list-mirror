From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 16:06:22 +0100
Organization: At home
Message-ID: <eovvg3$i6m$1@sea.gmane.org>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net> <20070121134308.GA24090@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 16:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8eGf-0008HE-Ea
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 16:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbXAUPF4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 10:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbXAUPF4
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 10:05:56 -0500
Received: from main.gmane.org ([80.91.229.2]:36380 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbXAUPF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 10:05:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H8eGS-0000Ll-B1
	for git@vger.kernel.org; Sun, 21 Jan 2007 16:05:48 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 16:05:48 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 16:05:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37329>

Willy Tarreau wrote:
> On Sun, Jan 21, 2007 at 03:20:06AM -0800, Junio C Hamano wrote:

>> BTW, as the upcoming v1.5.0 release will introduce quite a bit of
>> surface changes (although at the really core it still is the old
>> git and old ways should continue to work), I am wondering if it
>> would help people to try out and find wrinkles before the real
>> thing for me to cut a tarball and a set of RPM packages.
>> 
>> Comments?
> 
> Anything you can do to make tester's life easier will always slightly
> increase the number of testers. Hint: how often do you try random
> software that requires that you first install CVS, SVN or arch just to
> get it, compared to how often you try random software provided as tar.gz ?
> Pre-release tar.gz and rpms coupled with a freshmeat announcement should
> get you a bunch of testers and newcomers. This will give the new doc a
> real trial, and will help discover traps in which beginners often fall.

RPMS are nicely divided into (sub)packages, so you need CVS indtalled
only if you install git-cvs package, for example to interact with CVS.
git-core has minimal dependencies.

To compile git you truly don't need other software installed (1.5.0
for example does not require RCS anymore for RCS merge).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
