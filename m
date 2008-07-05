From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: "make test" works again (sort-of) on cygwin.
Date: Sat, 05 Jul 2008 21:09:31 +0100
Message-ID: <486FD4FB.6070803@ramsay1.demon.co.uk>
References: <486D0FFC.5090308@ramsay1.demon.co.uk> <20080703202637.GC3546@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 00:36:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFGNA-00089U-5t
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 00:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbYGEWfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 18:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbYGEWfw
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 18:35:52 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:3587 "EHLO
	anchor-post-36.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751655AbYGEWfv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jul 2008 18:35:51 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jul 2008 18:35:51 EDT
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-36.mail.demon.net with esmtp (Exim 4.67)
	id 1KFGDk-000JFV-Jr; Sat, 05 Jul 2008 22:27:08 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20080703202637.GC3546@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87472>

Alex Riesen wrote:
> Ramsay Jones, Thu, Jul 03, 2008 19:44:28 +0200:
> 
>> Anyhow, the "sort-of" in the subject line, relates to the fact that
>> I am seeing some test failures.  In particular, all tests in
>> t0004-unwritable.sh and tests 21->24 in t3700-add.sh. All of these
>> tests involve chmod/permissions ...
> 
> Don't run "make test" as root (or "backup operator" on windows).
> OTOH, a windows machine is almost useless, unless you're a member of
> local administrators group (which includes "backup" permission).
> 

Ah, yes... I am a "Computer administator" aren't I ;-) I totally forgot!

Hmm, but is that really the reason for these failures? After all, (referring
to the example you snipped) the permissions are respected for creating
files in the directory, just not directories.  Is the "root" user on
windows only selectively omnipotent?


ATB,

Ramsay Jones
