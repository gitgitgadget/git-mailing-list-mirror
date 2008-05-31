From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: use Git.pm, and use its parse_rev method for
	git_get_head_hash
Date: Sat, 31 May 2008 15:04:51 +0200
Message-ID: <20080531130450.GI18781@machine.or.cz>
References: <1212188412-20479-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 15:06:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Qmk-000097-1m
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 15:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbYEaNEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 09:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbYEaNEx
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 09:04:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53604 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbYEaNEw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 09:04:52 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0B45A3939B14; Sat, 31 May 2008 15:04:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1212188412-20479-1-git-send-email-LeWiemann@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83383>

On Sat, May 31, 2008 at 01:00:12AM +0200, Lea Wiemann wrote:
> This simplifies git_get_head_hash a lot; the method might eventually
> even go away.
> 
> I haven't checked whether this causes an IO performance regression by
> instantiating a new Git repository instance, but in the end
> Git->repository will be as fast as possible and do no eager disk
> accesses.  No benchmarking yet at this stage.
> 
> Minor change: Moved the parameter shift in git_blob_plain to the top
> for readability.

Please split this to a separate patch.

> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>

Other than that,

Acked-by: Petr Baudis <pasky@suse.cz>

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
