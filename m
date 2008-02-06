From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] git-rebase.sh: Use POSIX/Susv command substitution instead of backticks
Date: Wed, 6 Feb 2008 09:23:06 +0000 (UTC)
Message-ID: <loom.20080206T092136-104@post.gmane.org>
References: <lk5zxdix.fsf@blue.sea.net> <alpine.LSU.1.00.0802052226340.8543@racer.site> <abmfxbg3.fsf@blue.sea.net> <alpine.LSU.1.00.0802052305080.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 10:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMgXH-0001KA-JM
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 10:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760310AbYBFJZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 04:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760182AbYBFJZK
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:25:10 -0500
Received: from main.gmane.org ([80.91.229.2]:42997 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759976AbYBFJZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 04:25:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JMgWc-0000nq-UM
	for git@vger.kernel.org; Wed, 06 Feb 2008 09:25:03 +0000
Received: from gibraltar.iam.uni-bonn.de ([131.220.223.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 09:25:02 +0000
Received: from Ralf.Wildenhues by gibraltar.iam.uni-bonn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 09:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 131.220.223.4 (Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72779>

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:
> > > On Wed, 6 Feb 2008, Jari Aalto wrote:
> > >
> > >> Use redable $(<command>) syntax instead of backtics in code.  See The 
> > >> Open Group Base Specifications Issue 6, IEEE Std 1003.1, 2004 Edition

> And then you have to do it for all scripts in one go.  Mind you, it is not 
> really complicated: just one call to perl.

You still have to check all backslashes within the changed command; some you
may now have to remove.

Cheers,
Ralf
