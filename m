From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: rebase, file permissions and removed file
Date: Mon, 27 Oct 2008 15:38:46 +0100
Message-ID: <4905D276.9020308@viscovery.net>
References: <a2633edd0810270702x416bb659ke183b0cc6266071@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 15:40:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuTGp-0006sL-Kg
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 15:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbYJ0Oiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 10:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbYJ0Oit
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 10:38:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30162 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbYJ0Ois (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 10:38:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KuTF0-0000Zq-Ev; Mon, 27 Oct 2008 15:38:46 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2BB456EF; Mon, 27 Oct 2008 15:38:46 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <a2633edd0810270702x416bb659ke183b0cc6266071@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99234>

Pascal Obry schrieb:
> # At this point there is a conflict as expected
> # file1 has been removed on master, and file1 had its permissions changed
> # on fixperms branch.
> #
> # What I find confusing is that:
> #    $ git diff
> # and
> #    $ git diff --cached
> #
> # are reporting nothing.
> #
> # Ok, file1 has been removed, let's then remove it as it is right:
> #
> #   $ git rm file1
> #   fatal: pathspec 'file1' did not match any files
> #
> # Ok, so what's the proper way to fix that! What should I do to be able to
> # continue the rebase:

Since you don't have any content to lose, you can always just

 $ touch file1
 $ git add file1
 $ git rm file1

-- Hannes
