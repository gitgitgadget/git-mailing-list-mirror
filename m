From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Makefile checks for DarwinPorts / Fink
Date: Sun, 23 Jul 2006 15:00:25 +0200
Organization: At home
Message-ID: <e9vrsf$foc$1@sea.gmane.org>
References: <f3d7535d0607210758m4410cddfw16329ce473404fd8@mail.gmail.com> <7vhd19itu2.fsf@assigned-by-dhcp.cox.net> <20060722161914.GA10754@spearce.org> <20060723054531.GA12559@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jul 23 15:00:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4dZZ-0001Sd-L2
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 15:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWGWNAO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 09:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWGWNAO
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 09:00:14 -0400
Received: from main.gmane.org ([80.91.229.2]:64701 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751203AbWGWNAM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Jul 2006 09:00:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G4dYy-0001Kd-BI
	for git@vger.kernel.org; Sun, 23 Jul 2006 15:00:04 +0200
Received: from host-81-190-27-170.torun.mm.pl ([81.190.27.170])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 Jul 2006 15:00:04 +0200
Received: from jnareb by host-81-190-27-170.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 Jul 2006 15:00:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-170.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24095>

Shawn Pearce wrote:

> This is a slightly cleaner version of my prior patch.  :-)
> 
> -->8--
> Disable linking with Fink or DarwinPorts.
> 
> It may be desirable for the compiler to disable linking against Fink
> or DarwinPorts, especially if both are installed on the system and
> the user wants GIT to be linked specifically to only one of them.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

Could you _please_ document this option in commentary part in main Makefile?
TIA. 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
