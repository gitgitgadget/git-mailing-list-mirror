From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: tracking remotes with Git
Date: Fri, 9 Nov 2007 21:38:55 +0100
Message-ID: <200711092138.56277.robin.rosenberg.lists@dewire.com>
References: <b1e3a35f0711090444g3c31e862g4ef4ef8139927840@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ivan Shmakov" <oneingray@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 21:37:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqabE-0004om-Ut
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 21:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbXKIUgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 15:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbXKIUgv
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 15:36:51 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18630 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbXKIUgu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 15:36:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 468458026E9;
	Fri,  9 Nov 2007 21:27:48 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13573-02; Fri,  9 Nov 2007 21:27:48 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id F19D28026C9;
	Fri,  9 Nov 2007 21:27:47 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <b1e3a35f0711090444g3c31e862g4ef4ef8139927840@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64259>

fredag 09 november 2007 skrev Ivan Shmakov:
>         I'm using Git (1.5.3.5 debian 1) for about a day or so, and I'm
>         quite impressed that it allows tracking remote repositories
>         (I've tried CVS and SVN) so easily with `git-cvsimport' and
>         `git-svn'.  However, I've ran into a couple of problems with
>         them:
> 
>         * it looks like `git-cvsimport' uses its own CVS protocol
>           implementation which doesn't support compression; I've tried
>           to clone a repository of a project hosted in CVS since circa
>           1998 and it 20 MiB or so to obtain revisions until 2000 or so;
>           any ways to minimize traffic?

You can pass options to cvsps.  My guess is -P "-Z" will do it.

-- robin
