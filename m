From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] git-submodule - Add 'foreach' subcommand
Date: Mon, 11 Aug 2008 00:22:33 +0200
Message-ID: <200808110022.33696.johan@herland.net>
References: <1218386647-2348-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 00:23:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSJKM-0007oY-F4
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 00:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbYHJWWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 18:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbYHJWWw
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 18:22:52 -0400
Received: from smtp.getmail.no ([84.208.20.33]:62623 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952AbYHJWWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 18:22:51 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K5E00G09OU1KR00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 11 Aug 2008 00:22:49 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5E008NKOTM0J60@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 11 Aug 2008 00:22:34 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5E009MHOTLDY72@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 11 Aug 2008 00:22:34 +0200 (CEST)
In-reply-to: <1218386647-2348-1-git-send-email-mlevedahl@gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91892>

On Sunday 10 August 2008, Mark Levedahl wrote:
> submodule foreach <command-list> will execute the list of commands in
> each currently checked out submodule directory. The list of commands
> is arbitrary as long as it is acceptable to sh. The variables '$path'
> and '$sha1' are availble to the command-list, defining the submodule
> path relative to the superproject and the submodules's commitID as
> recorded in the superproject (this may be different than HEAD in the
> submodule).
>
> This utility is inspired by a number of threads on the mailing list
> looking for ways to better integrate submodules in a tree and work
> with them as a unit. This could include fetching a new branch in each
> from a given source, or possibly checking out a given named branch in
> each. Currently, there is no consensus as to what additional commands
> should be implemented in the porcelain, requiring all users whose needs
> exceed that of git-submodule to do their own scripting. The foreach
> command is intended to support such scripting, and in particular does
> no error checking and produces no output, thus allowing end users
> complete control over any information printed out and over what
> constitutes an error.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>

Hi,

I was about to send an equivalent patch, but you beat me to it. Yours is 
shorter and more elegant as well, so thanks for saving me the 
embarrasment ;)

So, FWIW:

Liked-by: Johan Herland <johan@herland.net>

-- 
Johan Herland, <johan@herland.net>
www.herland.net
