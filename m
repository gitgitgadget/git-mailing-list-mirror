From: Petr Baudis <pasky@suse.cz>
Subject: Re: TOPGIT: [PATCH] tg create: add --force option to resolve merge
	dependencies.
Date: Tue, 12 Aug 2008 15:38:57 +0200
Message-ID: <20080812133857.GL32184@machine.or.cz>
References: <1218546106.7264.11.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Aug 12 15:40:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSu6W-00046q-Oa
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 15:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbYHLNjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 09:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbYHLNjA
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 09:39:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59567 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbYHLNjA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 09:39:00 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1C0A9393B282; Tue, 12 Aug 2008 15:38:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218546106.7264.11.camel@heerbeest>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92098>

  Hi,

On Tue, Aug 12, 2008 at 03:01:46PM +0200, Jan Nieuwenhuizen wrote:
> I have been trying to adapt my ooo-build export to topgit
> instead of plain git and ran into the (documented and
> expected) merge conflicts in .top*.
> 
> After unsuccesfully trying to script around it in my
> gob git-export script, I found that this simple tg-create.sh
> seems to work for me: just remove any <<<,===,>>> from
> .topdeps and simply generate the new .topmgs later.
> 
> What do you think?  Is this naive way of 'auto' resolving
> dependency problems doing the right thing?

  how exactly did you get the morge conflicts? These should never happen
- I don't think we document them either? Pre-0.2 TopGit with dash as
/bin/sh had a bug that caused the conflicts to still happen, but that
should've been fixed (check if your .git/info/attributes does not
contain '-e' at the line beginnings ;-).

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
