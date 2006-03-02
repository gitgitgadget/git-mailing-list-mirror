From: linux@horizon.com
Subject: Re: impure renames / history tracking
Date: 2 Mar 2006 17:24:35 -0500
Message-ID: <20060302222435.11534.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Thu Mar 02 23:25:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEwE5-0002HG-J7
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 23:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWCBWYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 17:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWCBWYq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 17:24:46 -0500
Received: from science.horizon.com ([192.35.100.1]:17465 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750867AbWCBWYp
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 17:24:45 -0500
Received: (qmail 11535 invoked by uid 1000); 2 Mar 2006 17:24:35 -0500
To: git@vger.kernel.org, paul@clubi.ie
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17115>

>> Yes, but imo a poor one, as you're losing all the history.
>
> Well, not per se. You might keep the original 'detail' branch. It's a 
> terminal branch obviously, you can't pull master's changes to it once 
> the aggregate patch goes into master. But you can keep it around.

Actually, you can!  That's what the "ours" merge stratgy is for!
It creates a merge whose result is a verbatim copy of the first parent.

The intended use is for when you've cherry-picked or otherwise manually
merged everything interesting from a branch and want to tie up the loose
end so you can delete the branch name.
