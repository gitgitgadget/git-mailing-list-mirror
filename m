From: Michael Hendricks <michael@ndrix.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 11:30:29 -0700
Message-ID: <20070221183028.GA9088@ginosko.local>
References: <20070221164527.GA8513@ginosko.local> <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 19:30:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJwEq-0007WK-1O
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 19:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422774AbXBUSad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 13:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422760AbXBUSad
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 13:30:33 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:35859 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422777AbXBUSab (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Feb 2007 13:30:31 -0500
Received: from out1.internal (unknown [10.202.2.149])
	by out1.messagingengine.com (Postfix) with ESMTP id 356061C44E1;
	Wed, 21 Feb 2007 13:31:48 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by out1.internal (MEProxy); Wed, 21 Feb 2007 13:31:48 -0500
X-Sasl-enc: yOOlMKaDF/TMWU6lzD685RVe+twBTF8MUcOXKKcQncdg 1172082707
Received: from tameion.ndrix.org (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id CCD9F16D1A;
	Wed, 21 Feb 2007 13:31:47 -0500 (EST)
Received: from [10.10.9.99] (helo=localhost)
	by tameion.ndrix.org with esmtp (Exim 4.63)
	(envelope-from <michael@ndrix.org>)
	id 1HJwEX-0007xB-CG; Wed, 21 Feb 2007 11:30:29 -0700
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40314>

On Wed, Feb 21, 2007 at 09:14:44AM -0800, Linus Torvalds wrote:
> 
>    See "cg-admin-rewritehist" from cogito for an example of a tool that 
>    would do what you need done. In fact, it has this exact thing as the 
>    first example.

That's just what I was looking for.  Thanks.

> So right now, rewriting history is an option that you can do. It will 
> effectively create a totally new branch (which you can then make into a 
> new repository) which has nothing in common with the old branch from the 
> point where it was modified. So you can never really merge the two ever 
> again, and you need to make sure that everybody who had the old repo 
> contents will destroy it.

What's a decent way to make a branch into a new repository?  My first
inclination is to "cp -a" the existing repository, checkout the branch,
delete all other branches and repack.  That seems to have worked in my
quick test, but is there a better way?

-- 
Michael
