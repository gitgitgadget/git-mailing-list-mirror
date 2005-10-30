From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Tracking few files among many
Date: Sun, 30 Oct 2005 16:52:44 +0100
Message-ID: <20051030155243.GA28021@ebar091.ebar.dtu.dk>
References: <20051030130001.GA26652@ebar091.ebar.dtu.dk> <4364E6D7.9010707@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 30 17:13:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWFmT-00044b-W0
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 17:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVJ3QLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 11:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbVJ3QLe
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 11:11:34 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:13012 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1750801AbVJ3QLd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 11:11:33 -0500
Received: (qmail 28067 invoked by uid 5842); 30 Oct 2005 15:52:44 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4364E6D7.9010707@op5.se>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10822>

On Sun, Oct 30, 2005 at 04:29:27PM +0100, Andreas Ericsson wrote:
> Peter Eriksen wrote:
> >Hello,
> >
> >There's something I can't figure out.  I'm tracking a few
> >configuration files in $HOME, but some operations are really
> >slow.  Let's take git-status as example: 
...
> OTOH, since you *know* git-status (precisely because it looks for files 
> not added to the index) to be slow, you should use git-diff* instead. I 
> imagine you know what files you're tracking anyways since it's just a 
> subset of 25000-something.

I understand now, I just didn't think about this behavior before.
What I could do is add all my files to .gitignore, but that would
be insane.

Perhaps I was just confused about it calling those files "not tracked".
I know, I know, it was changed recently to this exactly because it
was confusing before.

Thanks for clearing that up for me.

Peter
