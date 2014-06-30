From: John Keeping <john@keeping.me.uk>
Subject: Re: `git log --graph` with multiple roots is confusing
Date: Mon, 30 Jun 2014 09:08:29 +0100
Message-ID: <20140630080829.GB13153@serenity.lan>
References: <CALygMcDXjMUcq=8ERVTES+5qNjLMe_OFPbmeqAosU7qmk=QuUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gary Fixler <gfixler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 10:08:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1Wdm-0008FB-W2
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 10:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbaF3IIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 04:08:38 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:47486 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbaF3IIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 04:08:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id D5B8221AD1;
	Mon, 30 Jun 2014 09:08:35 +0100 (BST)
X-Quarantine-ID: <32hD0qzVMD7g>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32hD0qzVMD7g; Mon, 30 Jun 2014 09:08:35 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 082701FEEB;
	Mon, 30 Jun 2014 09:08:34 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id C287B161E515;
	Mon, 30 Jun 2014 09:08:34 +0100 (BST)
X-Quarantine-ID: <JmDZOl9os-Lb>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JmDZOl9os-Lb; Mon, 30 Jun 2014 09:08:34 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 59564161E248;
	Mon, 30 Jun 2014 09:08:30 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALygMcDXjMUcq=8ERVTES+5qNjLMe_OFPbmeqAosU7qmk=QuUQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252659>

On Sun, Jun 29, 2014 at 11:40:40PM -0700, Gary Fixler wrote:
> I sometimes pull things in from unrelated repositories to rebase or
> cherry-pick items from a different line of development. I've done this
> to bring isolated features into a project in their own feature
> branches with their full development histories, and also to extract
> lines of development out to their own project, with their histories
> intact. These are usually not connected commits, but things I have to
> track down across time with `git log -S` and friends.
> 
> When I `git remote add otherrepo <url>`, then view things with my
> aliased `git log --oneline --all --graph --decorate` alias, I'm
> usually immediately straining to figure out what's what, as the two
> trees stack onto each other with no separation. It would be nice if
> root commits used something other than *, and/or if they could be
> colored differently by default, or via some option to make them stand
> out as parent-less commits.
> 
> Is this feasible, or already possible?

Have you tried `git log --boundary`?
