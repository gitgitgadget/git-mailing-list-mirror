From: Willy Tarreau <w@1wt.eu>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 09:56:34 +0100
Message-ID: <20080223085634.GW8953@1wt.eu>
References: <200802221837.37680.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Chase Venters <chase.venters@clientec.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 09:57:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSqCB-0004MP-1g
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 09:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbYBWI4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 03:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbYBWI4p
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 03:56:45 -0500
Received: from 1wt.eu ([62.212.114.60]:2099 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbYBWI4o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 03:56:44 -0500
Content-Disposition: inline
In-Reply-To: <200802221837.37680.chase.venters@clientec.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74806>

On Fri, Feb 22, 2008 at 06:37:14PM -0600, Chase Venters wrote:
> It seems to me that having multiple working trees (effectively, cloning 
> the "master" repository every time I need to make anything but a trivial 
> change) would be most effective under git as well as it doesn't require 
> creating messy, intermediate commits in the first place (but allows for them 
> if they are used). But I wonder how that approach would scale with a project 
> whose git repo weighed hundreds of megs or more. (With a centralized rcs, of 
> course, you don't have to lug around a copy of the whole project history in 
> each working tree.)

Take a look at git-new-workdir in git's contrib directory. I'm using it a
lot now. It makes it possible to set up as many workdirs as you want, sharing
the same repo. It's very dangerous if you're not rigorous, but it saves a lot
of time when you work on several branches at a time, which is even more true
for a project's documentation. The real thing to care about is not to have
the same branch checked out at several places.

Regards,
Willy
