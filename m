From: Paul Gardiner <osronline@glidos.net>
Subject: New to git: sorry for obvious question.
Date: Mon, 04 Feb 2008 09:56:00 +0000
Message-ID: <47A6E130.7090909@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 11:06:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLyDb-0002xN-Rc
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 11:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbYBDKFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 05:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbYBDKFz
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 05:05:55 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:42578
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750735AbYBDKFy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 05:05:54 -0500
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Feb 2008 05:05:54 EST
X-Trace: 33260038/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.162.31
X-SBRS: None
X-RemoteIP: 62.241.162.31
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CADtwpkc+8aIf/2dsb2JhbACqfg
X-IP-Direction: IN
Received: from galaxy.systems.pipex.net ([62.241.162.31])
  by smtp.pipex.tiscali.co.uk with ESMTP; 04 Feb 2008 09:56:04 +0000
Received: from [10.0.0.24] (80-42-19-184.dynamic.dsl.as9105.com [80.42.19.184])
	by galaxy.systems.pipex.net (Postfix) with ESMTP id E734DE0000C3
	for <git@vger.kernel.org>; Mon,  4 Feb 2008 09:56:03 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72482>

Hi,

I've moved a project from CVS on sourceforge to git on repo.or.cz.  I
want a local mirror on my own home server, so that it appears amongst
the projects shown by my own gitweb set up, and so it gets caught by
my backup system.  I've created the mirror with

   git clone --bare <remote-url> <local-dir>

and that seems fine.  But how do I now keep it up to date.  I was
guessing a cron job doing some sort of git pull, but pull doesn't
look to work on --bare proj.git type repositories.

Any help most apprecieated.

Cheers,
	Paul.
