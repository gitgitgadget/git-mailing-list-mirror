From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Question: start mergetool with trivial differences already 
	handled?
Date: Mon, 17 May 2010 18:07:02 -0400
Message-ID: <AANLkTiliNtjh6FsGW_S2BRN_C_WjDzdlMxMg90Kekb5G@mail.gmail.com>
References: <AANLkTinYq5LKcY8EDzfCGRoEYXftcd15Dviww749uBUC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: The Git Mailing List <git@vger.kernel.org>
To: Uri Okrent <uokrent@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 18 00:07:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE8TN-0000Mz-46
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 00:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107Ab0EQWHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 18:07:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56961 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089Ab0EQWHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 18:07:05 -0400
Received: by iwn6 with SMTP id 6so793175iwn.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=jjKWd4gJ5DEAPrLMlVhgL1VIDtLa3SfN9LNz/ozpCKM=;
        b=TqAXJ/h8bHCwyL1h64jcHh21IHC+FoN5tPawBP6/+z6vX49w9xtTH9ywSTeMvaoHeb
         rvU/sKnarYo+GuEKz9rq1NXe+WRgCQQ0cPkmPaZ/erqEdQGiLLtmBTE03dpRs6D7MrGo
         zcMVfOTlRw6J1D35Yj03rnfvB97w3R7jqvpXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JEQk/N37htzwSxNUZmComhunYcWfYU3WfItTM0xGy2Hr5JI5eGQJd88KIzHWtd09L2
         HPF40t4UbxcQGb5CTB/EDysS9himllo7NPXr2pIMKN4GFECQC8M+tArLqbmPMKAp7EF6
         M+XtBjKHZEJgwY2We/DuicnaoZ3saETPML22M=
Received: by 10.231.184.16 with SMTP id ci16mr954848ibb.23.1274134022360; Mon, 
	17 May 2010 15:07:02 -0700 (PDT)
Received: by 10.231.34.8 with HTTP; Mon, 17 May 2010 15:07:02 -0700 (PDT)
In-Reply-To: <AANLkTinYq5LKcY8EDzfCGRoEYXftcd15Dviww749uBUC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147261>

On Mon, May 17, 2010 at 4:47 PM, Uri Okrent <uokrent@gmail.com> wrote:
> Basically, I'd like to be able to fire up merge tool with all the trivial
> merges already taken care of (since git is better than I am at resolving the
> trivial ones anyway).

Your merge tool of choice should already do this, if not, you need to
use a better merge tool.

> The way I understand it, mergetool populates the merge tool with the base
> file (file from the common ancestor), file from ours, and file from theirs.

Correct.

> So, when I pull up mergetool, I see all the differences in between ours and
> theirs, even if git knows how to resolve many of those.

This doesn't really have anything to do with git at this point. It's
up to whatever tool mergetool invokes to perform the 3-way diff
itself. That tool should then only ask you to resolve the conflicting
regions, and all other differences should be auto resolved.

Most of the tools that mergetool supports out-of-the-box perform 3-way
diffs, so I guess I'm curious what merge tool you're using.

j.
