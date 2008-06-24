From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 14:41:38 +0200
Message-ID: <4860EB82.8030504@viscovery.net>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>	 <1214306517.6441.10.camel@localhost>	 <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>	 <alpine.DEB.1.00.0806241246500.9925@racer> <ce513bcc0806240507q58c2a3y5fe8f0e8033353ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthias Kestenholz <mk@spinlock.ch>, git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:43:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB7rI-0003Ii-LF
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 14:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbYFXMln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 08:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbYFXMln
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 08:41:43 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:42665 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbYFXMlm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 08:41:42 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KB7q6-0003vx-HI; Tue, 24 Jun 2008 14:41:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 42A9569F; Tue, 24 Jun 2008 14:41:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <ce513bcc0806240507q58c2a3y5fe8f0e8033353ad@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86048>

Erez Zilber schrieb:
> [root@kd001 my_test.git]# git-push --all
> ssh://erez.zilber@kites/pub/git/erez.zilber/my_test.git
> erez.zilber@kites's password:
> Counting objects: 9, done.
> Compressing objects: 100% (5/5), done.
> Writing objects: 100% (9/9), 740 bytes, done.
> Total 9 (delta 0), reused 0 (delta 0)
> To ssh://erez.zilber@kites/pub/git/erez.zilber/my_test.git
>  * [new branch]      master -> master
> 
> Now, on the server side:
> 
> -sh-3.1$ cd my_test.git/
> -sh-3.1$ ls info/
> exclude
> -sh-3.1$ git-update-server-info
> -sh-3.1$ ls info/
> exclude  refs
> 
> looks like git-update-server-info did some work (added the refs file).
> 
> Back to the client:
> 
> [root@kd001 t]# git-clone http://kites/pub/git/erez.zilber/my_test.git
> Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_test/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?
> 
> The path is the same path that was used for pushing the repository.

No, it's not. You pushed via ssh, but you clone via http.

When you point your web browser to

 http://kites/pub/git/erez.zilber/my_test.git

what do you see? Error 404 or a directory listing?

-- Hannes
