From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add contrib/stg-gitk: helper script to run gitk
Date: Fri, 12 Jan 2007 23:09:22 +0000
Message-ID: <b0943d9e0701121509t6d3ca059v9b7389ff3242c06b@mail.gmail.com>
References: <20070108220918.18329.30083.stgit@gandelf.nowhere.earth>
	 <b0943d9e0701090202v7951076cg7c86c0f5499c7d60@mail.gmail.com>
	 <20070109220332.GD17093@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701101547v5e18bdf8xcc34cf78ea5f1f9f@mail.gmail.com>
	 <20070112224733.GA9761@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 13 00:09:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5VWi-0003HG-J9
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 00:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbXALXJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 18:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbXALXJ2
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 18:09:28 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:8240 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161144AbXALXJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 18:09:27 -0500
Received: by wr-out-0506.google.com with SMTP id i30so731836wra
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 15:09:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GsuhtjT9xNeWYPbljtS+ftpr7XQ5ujWwIqxYv22Mj8JOAbNw/AvPRRqredpMWAAqb4hT0hcTBH7gNacNOwBoENvkrKXIJfhWwLNSb4ag4DCzbCPl+fBSXmaE7XIrsE0JBL4ik20bAMSKZWlz1ZKbSMfjNvpXVtAr7N9QGm9DF7I=
Received: by 10.65.188.4 with SMTP id q4mr1806480qbp.1168643362483;
        Fri, 12 Jan 2007 15:09:22 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Fri, 12 Jan 2007 15:09:22 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070112224733.GA9761@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36725>

On 12/01/07, Yann Dirson <ydirson@altern.org> wrote:
> Indeed "stg series -g" may differ too much from "stg-gitk" to plug the
> functionnality at this place: "stg series" is a command acting on one
> stack, whereas stg-gitk is a repository-wide command, allowing to draw
> several stacks, and also includes anything below stack base, which
> looks also out of the scope of "stg series -g".  Maybe a new command
> is called for - possibly as something like
> "stg repo graph [<branch>...]" ?

Maybe repo --graph at the moment (until we add some unified support
for subcommands) but not sure what other options would go into 'repo'.
Anyway, I haven't had time to try any of your scripts yet and I don't
know what stg-gitk shows.

> OK, the command names were borrowed from tools which provide a
> fraction of the functionnality stgit (not exactly so in the case of
> GIT, OK ;).  That makes it easy for people used to those commands that
> served as inspiration to the stgit ones, I know that (I used quilt
> before stgit).  But I do feel that having a more consistent command
> set would help - remember quilt has no idea of branches, multiple
> repositories and history, stgit is in many ways a very different beast :)

StGIT probably got enough advertisement as being a Quilt replacement
for GIT. It would be OK to re-organize the commands (and use aliases
to still have the current functionality).

As I said in a different e-mail, I'd first like to get StGIT in a
feature-freeze state (well, mainly not changing major things) and fix
the remaining bugs to get 1.0 out. After that, we can redefine the
commands, repository structure or whatever has a bad design.

> There are already aliases in GIT itself, they are quite simple to
> understand, and would probably require very little code in python.
> I'll have a look at that, unless you would veto integration of such a
> patch.

I'd like this patch (though I haven't used aliases in GIT yet).

-- 
Catalin
