From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: StGIT (or guilt) + git-svn?
Date: Tue, 24 Jul 2007 07:27:06 -0400
Message-ID: <20070724112706.GA9540@dervierte>
References: <46A5D279.7060601@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'git' <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDIXp-0004LS-Re
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764221AbXGXL1L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764128AbXGXL1L
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:27:11 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:24123 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764104AbXGXL1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:27:10 -0400
Received: by py-out-1112.google.com with SMTP id d32so3632147pye
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 04:27:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=IM9HN5nzBm5ePnTs+2YTqd3rYOuTcbCoIdTWerDPHn9ftkUFraDbsMNmLulMbrmCxE1F2CCyPKqfP+lQ30xMbGbSr3XLUwFhQZMu3I6JVr4CvG+Qu6Lv40taCcqWyzeglhcOTzObqvLCluXMXgrh0PXVfP36WGYo9jicnnd3fd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=s9Q0UsZBTkeyDRpr84eWwsXQrz47gmrxFvygZ74phfkTUDoEoClT+ZfkiKd9UxedyrAxAGVGp6Pl5u57/mi+K1PY0mk13NCPMIM+INSjrc1vzkfqaOx2Yq+DZ+eD65MX/Ax+61tWp0UKOTDnqa8YtLU7PKcy2f3elYBVAJnVdLE=
Received: by 10.35.49.1 with SMTP id b1mr7697972pyk.1185276429229;
        Tue, 24 Jul 2007 04:27:09 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [74.131.192.220])
        by mx.google.com with ESMTPS id w67sm11823628pyg.2007.07.24.04.27.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2007 04:27:08 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id E4DF1CC30F6; Tue, 24 Jul 2007 07:27:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46A5D279.7060601@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53573>

On Tue, Jul 24, 2007 at 06:20:41PM +0800, Steven Grimm wrote:
> Anyone have experience mixing git-svn with either StGIT or guilt? A 
> coworker of mine was asking if he could do local versioning of files he 
> has no intention of committing to svn. He wanted a ".git-svnignore" kind 
> of scheme but I think his use case sounds like the sort of thing StGIT 
> and guilt are designed for. What I'm not sure about is whether git-svn 
> will confuse those tools or vice versa. I don't think I've ever seen 
> that combo discussed on the list.
> 
> -Steve

Well, I can say that stgit and git-svn in no way interfere with each
other.  I tend to use stgit to clean up my patch sets before commiting
them, and have never had a problem.  Thinking about what the tools do, I
can't imagine that it would cause a problem.

That said, I'm not sure that stgit will help you with "local versioning"
of files (I'm not even sure what you mean).  Perhaps you can elaborate
on this point.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
   -Robert Heinlein
