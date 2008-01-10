From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Revert git push
Date: Thu, 10 Jan 2008 15:12:50 +0100
Message-ID: <478627E2.4060808@viscovery.net>
References: <6zve61q0t3.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Markus Korber <korbse@gmx.at>
X-From: git-owner@vger.kernel.org Thu Jan 10 15:13:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCy9q-0002si-SS
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 15:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627AbYAJOMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 09:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149AbYAJOMy
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 09:12:54 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54263 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbYAJOMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 09:12:53 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JCy9K-00070u-CI; Thu, 10 Jan 2008 15:12:50 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B49FB546; Thu, 10 Jan 2008 15:12:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <6zve61q0t3.fsf@odpc25.int.ondemand.co.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70073>

Markus Korber schrieb:
> Hi,
> 
> I've got two local git repositories, linux and mplayer, where I push to
> from a local directory.  Now I accidentally pushed from mplayer into the
> linux repository (via a not updated URL[1]).  Is it somehow possible to
> revert this push if nobody has pushed something since my last pull from
> the linux repository?

Sure.

$ cd /the/linux/repo
$ git checkout 94545baded
$ git branch -f master 94545baded
$ git checkout master

Omit the two checkouts if the repo is bare or if it did not have 'master'
checked out.

-- Hannes
