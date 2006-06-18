From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] gitweb configuration
Date: Sun, 18 Jun 2006 12:05:36 +0200
Organization: At home
Message-ID: <e738h3$e74$1@sea.gmane.org>
References: <e720r0$qdv$1@sea.gmane.org> <20060617232358.GK2609@pasky.or.cz> <e72j53$1m1$1@sea.gmane.org> <46a038f90606180042w7b4d11dbvbea28b750ddbc6e2@mail.gmail.com> <e731ai$su1$1@sea.gmane.org> <20060618113052.660e1017.tihirvon@gmail.com> <e735d7$6dq$1@sea.gmane.org> <7v8xnu3iol.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jun 18 12:06:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FruAc-00023D-TD
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 12:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWFRKGO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 06:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWFRKGO
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 06:06:14 -0400
Received: from main.gmane.org ([80.91.229.2]:24485 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750824AbWFRKGN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 06:06:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FruAS-00020Q-81
	for git@vger.kernel.org; Sun, 18 Jun 2006 12:06:08 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 12:06:08 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 12:06:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22067>

Junio C Hamano wrote:

> So I am with Timo on this one, except that in some cases munging
> gitweb.cgi script itself might be needed if the installation
> chose to hide git somewhere inaccessible from ordinary users.
                                                ^^^^^^^^^^^^^^

The problem is with webserver user (nobody, web, apache, ...),
which might have nonstandard PATH and/or be run from jail/chroot.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
