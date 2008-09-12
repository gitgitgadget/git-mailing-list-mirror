From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Fri, 12 Sep 2008 13:00:17 +0200
Message-ID: <20080912110017.GW10360@machine.or.cz>
References: <20080909231009.GD10544@machine.or.cz> <1221120192.8962.7.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Sep 12 13:01:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6P3-00051F-Rf
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 13:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbYILLAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 07:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbYILLAU
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 07:00:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35723 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167AbYILLAT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 07:00:19 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 90E19393A816; Fri, 12 Sep 2008 13:00:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221120192.8962.7.camel@heerbeest>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95710>

On Thu, Sep 11, 2008 at 10:03:12AM +0200, Jan Nieuwenhuizen wrote:
> The last implementation would just recreate a branch with all new
> dependencies, which is quite inefficient when you're just removing
> or adding one (and the list of dependencies is long, say ~100).

But this is rewriting history, isn't it? This would make your work
completely different from others' and that violates one of main TopGit's
design goals. Or am I missing something obvious?

Currently, I'm thinking that something like .topundeps (or !-prefixing
dependencies in .topdeps) is the only way to implement this...

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
