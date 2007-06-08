From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: fatal: serious inflate inconsistency
Date: Fri, 8 Jun 2007 17:37:22 +0200
Message-ID: <20070608153722.GL2335@cip.informatik.uni-erlangen.de>
References: <20070608110536.GD2335@cip.informatik.uni-erlangen.de> <alpine.LFD.0.99.0706080931330.12885@xanadu.home> <20070608135054.GK2335@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 17:37:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwgWn-0006wm-JB
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 17:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbXFHPh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 11:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969744AbXFHPhZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 11:37:25 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:34052 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S969736AbXFHPhX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 11:37:23 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 1E7873F3FB; Fri,  8 Jun 2007 17:37:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070608135054.GK2335@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49479>

Hello,

> I give it a try and come back to you. I am off the net for 1 hour.

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
        fatal: serious inflate inconsistency
        fatal: index-pack died with error code 128
        fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed.

yes, it is reproducable. Again I am off the net for an hour.

        Thomas
