From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 1/2] stash bug: stash can lose data in a file removed
 from the index
Date: Mon, 12 Apr 2010 22:44:03 +0100
Message-ID: <20100412214403.GA27958@hashpling.org>
References: <v2w918f64e01004101104xd4f1b4eciec01d2e87691ee72@mail.gmail.com>
 <1270923241-14383-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 23:44:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1RQU-0007sh-0b
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 23:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066Ab0DLVoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 17:44:08 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:22253 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753757Ab0DLVoG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 17:44:06 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AisFAHYxw0tUXebz/2dsb2JhbACPYotacb0dhQwE
Received: from relay02.plus.net ([84.93.230.243])
  by relay.pcl-ipout02.plus.net with ESMTP; 12 Apr 2010 22:44:03 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by relay02.plus.net with esmtp (Exim) id 1O1RQJ-0002Uv-Od
	for git@vger.kernel.org; Mon, 12 Apr 2010 22:44:03 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.69)
	(envelope-from <charles@hashpling.org>)
	id 1O1RQJ-0007Qw-JH
	for git@vger.kernel.org; Mon, 12 Apr 2010 22:44:03 +0100
Content-Disposition: inline
In-Reply-To: <1270923241-14383-1-git-send-email-charles@hashpling.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Plusnet-Relay: 0b2398a479b9ab2fd56c7044b4a61e2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144770>

On Sat, Apr 10, 2010 at 07:14:00PM +0100, Charles Bailey wrote:
> If a file is removed from the index and then modified in the working
> tree then stash will discard the working tree file with no way to
> recover the changes.
> 
> This can might be done in one of a number of ways.
> 
> git rm file
> vi file              # edit a new version
> git stash
> 
> or with git mv
> 
> git mv file newfile
> vi file              # make a new file with the old name
> git stash

I just wanted to give this issue a bit more visibility. To me it would
seem to be fairly important as it's a potential loss of user data with
no easy recovery.

If I'm wrong about it, perhaps someone can put me right.

Thanks,

Charles.
