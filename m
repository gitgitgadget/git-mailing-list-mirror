From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: fatal: serious inflate inconsistency
Date: Fri, 8 Jun 2007 20:24:12 +0200
Message-ID: <20070608182412.GQ2335@cip.informatik.uni-erlangen.de>
References: <20070608110536.GD2335@cip.informatik.uni-erlangen.de> <alpine.LFD.0.99.0706080931330.12885@xanadu.home> <20070608135054.GK2335@cip.informatik.uni-erlangen.de> <20070608153722.GL2335@cip.informatik.uni-erlangen.de> <alpine.LFD.0.98.0706080959570.4205@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, GIT <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 20:24:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwj8h-0000P1-68
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 20:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969069AbXFHSYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 14:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968937AbXFHSYP
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 14:24:15 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:44972 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752121AbXFHSYO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 14:24:14 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id A93F33F41F; Fri,  8 Jun 2007 20:24:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706080959570.4205@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49490>

Hello Linus,

> Could you compile your own git? If so, please try this patch on top of 
> current git, to make the error message a bit more informative.

        (tomcat-05) [/usr/src] scp 131.188.30.102:/var/tmp/sithglan/git-core-1.5.2.1/../git-core_1.5.2.1-1_i386.deb .
        Warning: Permanently added '131.188.30.102' (RSA) to the list of known hosts.
        git-core_1.5.2.1-1_i386.deb                                                    100% 3511KB   1.7MB/s   00:02
        (tomcat-05) [/usr/src] / dpkg -i git-core_1.5.2.1-1_i386.deb
        (Reading database ... 13273 files and directories currently installed.)
        Preparing to replace git-core 1:1.5.2.1-1 (using git-core_1.5.2.1-1_i386.deb) ...
        Unpacking replacement git-core ...
        Setting up git-core (1.5.2.1-1) ...
        (tomcat-05) [/usr/src] git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
        Initialized empty Git repository in /usr/src/linux-2.6/.git/
        remote: Generating pack...
        remote: Done counting 496911 objects.
        remote: Deltifying 496911 objects...
        remote:  100% (496911/496911) done
        Indexing 496911 objects...
        remote: Total 496911 (delta 401539), reused 493712 (delta 398653)
        100% (496911/496911) done
        Resolving 401539 deltas...
        fatal: serious inflate inconsistency: -3 (invalid distance too far back)
        fatal: index-pack died with error code 128
        fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed.

I talked to Michael and he is certain that the machine has a memory
corruption the next thing I am going to do is compiling a kernel in an
endless loop. Again if somone needs shell access just send me your ssh
key.

The complete build log is on (well not the complete log the first line is
missing because my screen backlog has _only_ 10000 lines (a memory issue)):

The first line is:
wget http://ftp.debian.org/debian/pool/main/g/git-core/git-core_1.5.2.1-1.dsc

The rest is here:

http://wwwcip.informatik.uni-erlangen.de/~sithglan/screen-exchange.bz2 (32k)

Thanks,
        Thomas
