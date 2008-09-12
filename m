From: Petr Baudis <pasky@suse.cz>
Subject: CGit and repository list
Date: Fri, 12 Sep 2008 16:58:04 +0200
Message-ID: <20080912145804.GF10544@machine.or.cz>
References: <19449377.post@talk.nabble.com> <8e04b5820809120533o1e7da548l6868660767a5435d@mail.gmail.com> <m3vdx1o72x.fsf@localhost.localdomain> <8c5c35580809120736x4170b2dbq3438bd619326ae00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 16:59:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeA78-0007OL-J0
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 16:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbYILO6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 10:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbYILO6G
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 10:58:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60041 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbYILO6G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 10:58:06 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 21951393BEAD; Fri, 12 Sep 2008 16:58:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8c5c35580809120736x4170b2dbq3438bd619326ae00@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95730>

  Hi,

On Fri, Sep 12, 2008 at 04:36:11PM +0200, Lars Hjemli wrote:
> <plug>
> Current cgit also allows cloning over http using the same url as for
> browsing the repo, i.e. you may
> 
>   $ git clone http://hjemli.net/git/cgit
> 
> This has one advantage over just publishing the repo; you don't have
> to run `git-update-server-info` (thanks to the work done by Shawn O.
> Pearce on git-http-backend, which is shamelessly reimplemented in
> cgit).
> </plug>

  this finally tripped me over and I wanted to quickly add cgit as an
alternate viewing interface at repo.or.cz. But it seems that cgit
requires all the repositories explicitly listed in the config file.
Do you plan to remove this limitation in the future?

  Thanks,

				Petr "Pasky" Baudis
