From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: faster egit history page and a pure java "gitk"
Date: Tue, 25 Mar 2008 02:07:42 -0300
Message-ID: <47E8889E.6090403@intelinet.com.br>
References: <20080324092726.GQ8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 06:11:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je1Ra-0006nE-CX
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 06:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbYCYFKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 01:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbYCYFKw
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 01:10:52 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1034 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754112AbYCYFKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 01:10:51 -0400
Received: (qmail 58817 invoked by uid 0); 25 Mar 2008 02:13:13 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.431579 secs); 25 Mar 2008 05:13:13 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 25 Mar 2008 05:13:12 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20080213)
In-Reply-To: <20080324092726.GQ8410@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78147>

Shawn O. Pearce escreveu:
> OK, so I decided a few weeks back that the history page was not fast
> enough.  I think I've spent the past 3 weeks writing true revision
> machinary for jgit, and now connecting it up to a UI visualizer.
>
>   git://repo.or.cz/egit/spearce.git plotter
>
> The history page has been completely replaced.  I saw Roger has
> some patches against the current history page.  :-|
>   
Hi Guys,

I saw it running now, here are my initial comments/impressions:

I have a git.git clone on my eclipse and now egit can open it, cool! :) 
But it wasn't that fast, it took some minutes to finish building the 
whole tree. Also, changing projects (different git repos) makes the cpu 
go very high, and what opened fast the first time takes minutes after...

When reading the email I thought the new history page would have the 
same features from the current, but it doesn't. It looks promissing thought.

My first impression is that I like the current way of showing files in 
the strutucture compare better. In the future I would like the option to 
make it open on the left pane (where package explorer is) and have the 
options to collapse/expand directories, present in flat/hierarchical 
modes, have the fast view, etc.

Comments now can't be automatically wrapped. I actually prefer to leave 
wrapping to the computer, I don't like having to manually fix line 
lenghts when amending a comment, I think eclipse should do it. Also, 
currently, the history page usually has little space allocated for it 
and currently the first lines of the comment are visible. In the new 
page I have to scroll to see the comment when the history page is not 
maximized.

[]s,
Roger.
