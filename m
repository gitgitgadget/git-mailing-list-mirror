From: Christof =?iso-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: importing history
Date: Wed, 29 Jun 2011 16:25:50 +0200 (CEST)
Message-ID: <348bd65ad7c7690bcce553fe3c8e0bfb.squirrel@mail.localhost.li>
References: <20110629164514.58175480.mihamina@bbs.mg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Mihamina Rakotomandimby" <mihamina@bbs.mg>
X-From: git-owner@vger.kernel.org Wed Jun 29 16:26:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbviS-0003R1-AZ
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 16:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192Ab1F2OZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 10:25:58 -0400
Received: from vserver.localhost.li ([85.214.46.152]:54084 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756124Ab1F2OZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 10:25:56 -0400
Received: from localhost ([127.0.0.1]:48584 helo=mail.localhost.li)
	by mail.localhost.li with esmtp (Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1QbviA-0000P0-5g; Wed, 29 Jun 2011 16:25:50 +0200
Received: from 194.39.218.10
        (SquirrelMail authenticated user mail@christof-krueger.de)
        by mail.localhost.li with HTTP;
        Wed, 29 Jun 2011 16:25:50 +0200 (CEST)
In-Reply-To: <20110629164514.58175480.mihamina@bbs.mg>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176443>

Hi,

> Then I created an account in a forge (like github or so...), where I
> had to clone an empty GIT repository in order to begin to work.
> I dont have admin access to the forge, so no "scp" to the repo
> hosting possible.
Why did you have to clone an empty repository? It should be enough to add
the correct remote config directly in your "from-svn" repository and just
push it.

> Now, I have 2 "local" repos:
> - the one from the SVN
> - the empty one from the forge

Now that you already have cloned the empty repository you can just look at
the remote configuration in it:

 git config --list|grep remote

You should see something like the following:

remote.origin.url=user@example.com/path/to/repository.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*

Go to your from-svn repository and add the above configuration, then "git
push origin master".

Good luck!

Regards,
  Chris
