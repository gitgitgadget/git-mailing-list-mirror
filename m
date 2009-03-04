From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: can not clone via git:// anymore
Date: Wed, 04 Mar 2009 13:59:15 +0100
Message-ID: <49AE7B23.1070008@drmicha.warpmail.net>
References: <49AE64F2.1090405@cetrtapot.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
X-From: git-owner@vger.kernel.org Wed Mar 04 14:00:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeqiU-0006RG-G2
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 14:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbZCDM70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 07:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbZCDM70
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 07:59:26 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48586 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750752AbZCDM70 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 07:59:26 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 03EE82D8605;
	Wed,  4 Mar 2009 07:59:24 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 04 Mar 2009 07:59:24 -0500
X-Sasl-enc: nBbksDrIAlvM2J2twKYGLIOgOC0WX5aJENjMYEkc51L/ 1236171563
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6BBA925B33;
	Wed,  4 Mar 2009 07:59:23 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090303 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49AE64F2.1090405@cetrtapot.si>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112209>

Hinko Kocevar venit, vidit, dixit 04.03.2009 12:24:
> Hi,
> 
> I've recently discovered that my GIT repository is not letting me clone it via git clone git://.
> It works using git clone git@.. (SSH) but with GIT protocol..
> 
> Here is the case:
> hinkok@alala /tmp $ git --version
> git version 1.6.0.6
> hinkok@alala /tmp $ git clone git://zidar/sdk.git
> Initialized empty Git repository in /tmp/sdk/.git/
> fatal: The remote end hung up unexpectedly
> 
> My earlier clone (few months old) has this in .git/config:
> hinkok@alala /work/git/sdk.git $ cat .git/config 
> [core]
> 	repositoryformatversion = 0
> 	filemode = true
> 	bare = false
> 	logallrefupdates = true
> [remote "origin"]
> 	url = git@zidar:repositories/sdk.git
> 	fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
> 	remote = origin
> 	merge = refs/heads/master
> 
> 
> But I remember cloning via SSH that time, because I needed git push to work,
> but now other developer do not need the SSH access, but only GIT read-only -
> they can only clone, not push.
> 
> I do not administer the server git repos is located on, so I must have some
> information before I attack the admin..

Sorry in case this is trivial, but has git: access ever worked? It
requires a git daemon running on the server, whereas ssh access does not
require that. git@zidar:repositories/sdk.git uses ssh access.

Michael
