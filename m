From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn pulling down duplicate revisions
Date: Sun, 1 Jun 2008 22:00:51 -0700
Message-ID: <20080602050050.GC9904@hand.yhbt.net>
References: <1AD7D1A1-EC3B-450D-A648-04ADB8180E46@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 07:01:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K32Az-00080g-6v
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 07:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbYFBFAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 01:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbYFBFAx
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 01:00:53 -0400
Received: from hand.yhbt.net ([66.150.188.102]:57492 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbYFBFAw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 01:00:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id B65F57DC026;
	Sun,  1 Jun 2008 22:00:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1AD7D1A1-EC3B-450D-A648-04ADB8180E46@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83488>

Kevin Ballard <kevin@sb.org> wrote:
> I started a git-svn clone on a large svn repository, and I noticed  
> that for various branches, it kept pulling down the exact same  
> revisions (starting at r1). In other words, if I had 4 branches that  
> shared common history, their common history all got pulled down 4  
> times. I double-checked, and the created commit objects were identical.
> 
> Why was git-svn pulling down the same revisions over and over, when it  
> already knows it has a commit object for those revisions?

Can you give me an example if a repository and command-line you used
that does this?   Did you use 'git svn clone -s' or did you manually
specify the branch locations in the repo?

It could even be a lack of read permissions to the repository root
that would cause things like this.

Thanks,

-- 
Eric Wong
