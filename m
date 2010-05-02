From: Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@spoerlein.net>
Subject: Re: Import of svn rep has path issues
Date: Sun, 2 May 2010 10:15:10 +0200
Message-ID: <20100502081510.GF92627@acme.spoerlein.net>
References: <8439yblorn.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Paulo J. Matos" <pocmatos@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 10:15:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8UKi-0001Wx-DO
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 10:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab0EBIPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 04:15:16 -0400
Received: from acme.spoerlein.net ([188.72.220.29]:20494 "EHLO
	acme.spoerlein.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab0EBIPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 04:15:14 -0400
Received: from acme.spoerlein.net (localhost.spoerlein.net [IPv6:::1])
	by acme.spoerlein.net (8.14.4/8.14.4) with ESMTP id o428FAwC077856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 2 May 2010 10:15:10 +0200 (CEST)
	(envelope-from uqs@spoerlein.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoerlein.net;
	s=dkim200908; t=1272788110;
	bh=0uXaI4NxYW1te9Yo2IRZfzJqoU9uQzeQELrUUs3KXHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=q4A83sO8WFkXs+FQWOsXMFai1ORBuB5kcfEzHf5Jm3UoTFZTZpAf01u2g8TeNrtPY
	 WAae+MNLiTRszqCSjcxcjn+5bTabedQxVHOL+MDfcA7/9SGP0766Y6ltuobrn+552v
	 HnmfP8/ZkOEfOCy0fw9VzVTqO+m9j/X9DJCYPgUU=
Received: (from uqs@localhost)
	by acme.spoerlein.net (8.14.4/8.14.4/Submit) id o428FAfg077855;
	Sun, 2 May 2010 10:15:10 +0200 (CEST)
	(envelope-from uqs@spoerlein.net)
Content-Disposition: inline
In-Reply-To: <8439yblorn.fsf@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146141>

On Sat, 01.05.2010 at 14:45:00 +0100, Paulo J. Matos wrote:
> Hi all,
> 
> I just tried to import a svn project into git using git-svnimport.
> I followed:
> http://weblog.redlinesoftware.com/2008/2/24/converting-subversion-repositories-to-git
> 
> The line was:
> git-svnimport -C projname -r -v -A authors https://your-repo-host.com/projname
> 
> Interestingly some revisions resulted in a lot of errors with:
> 91: Unrecognized path: /main.cc
> 
> This seems to occur in the first revisions where I hadn't adopted a tree
> format of /branches, /tags, /trunk. 
> On the other hand, git-svnimport returned 0 to the environment, so I
> would assume that those 'Unrecognized path' issues are just warnings and
> everything went fine. I would like to have some confirmation of this if
> possible and if these files were not imported into my new git rep, how
> can I solve these issues?

Well, just look at your git-repo then and see if the logs indicate this
file made it (I doubt it).

Please have a look at svn2git, which can take rules for what to do with
specific paths at specific revisions. This should make it possible to go
from

/ is master in git

to

/trunk is master in git

with little effort

Regards,
Uli
