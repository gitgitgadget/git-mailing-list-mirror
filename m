From: Marcus Karlsson <mk@acc.umu.se>
Subject: Re: Arguments to git hooks
Date: Sun, 6 May 2012 21:12:02 +0200
Message-ID: <20120506191202.GB5725@moj>
References: <CAH-tXsB4PBS_YjW4DCjT6ORmNPomQ8XMPbKx3hxVNH=FyB2u3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 21:12:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR6t6-0001zh-Kz
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 21:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab2EFTMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 15:12:21 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:44941 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754039Ab2EFTMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 15:12:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id C621272;
	Sun,  6 May 2012 21:12:18 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from moj (c-0971e155.122-2-64736c10.cust.bredbandsbolaget.se [85.225.113.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mk)
	by mail.acc.umu.se (Postfix) with ESMTPSA id 0027170;
	Sun,  6 May 2012 21:12:17 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <CAH-tXsB4PBS_YjW4DCjT6ORmNPomQ8XMPbKx3hxVNH=FyB2u3g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197206>

On Mon, May 07, 2012 at 12:05:51AM +0530, jaseem abid wrote:
> Hello all,
> 
> I am trying to write a hook '.git/hooks/commit-msg' to be run before
> every commit.
> 
> How can I pass arguments to the script? Now by default the only arg I
> am getting is `.git/COMMIT_EDITMSG'`. I would love to get the list of
> files I tried to commit also into the script so that I can run a lint
> program on it before committing it. How can I get this done?
> 
> V/r,

As far as I can see that's the only argument that git-commit passes on
to the commit-msg hook. Can't you just call something like git-status
from the hook or do you need the information passed specifically as an
argument?

	Marcus
