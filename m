From: Petr Baudis <pasky@suse.cz>
Subject: Re: Merging submodules
Date: Mon, 4 Aug 2008 16:06:39 +0200
Message-ID: <20080804140639.GL10151@machine.or.cz>
References: <8aa486160807310824h25c9630dxc25b156e80fcdb29@mail.gmail.com> <20080731201530.067be667@pc09.procura.nl> <8aa486160807311203o3fb4deb8u4a5ae57818c76fab@mail.gmail.com> <20080801090422.55c6a45f@pc09.procura.nl> <8aa486160808010252j540a28cdw6e48027396da5248@mail.gmail.com> <20080801123523.33c37e08@pc09.procura.nl> <8aa486160808010434g7f3c187arc107b994e737cd74@mail.gmail.com> <20080804152443.4418b3e0@pc09.procura.nl> <20080804134053.GK10151@machine.or.cz> <20080804155733.46fd3982@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?iso-8859-2?Q?B=E9jar?= <sbejar@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>,
	Lars Noschinski <lars-2008-1@usenet.noschinski.de>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Aug 04 16:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ0iv-0007ka-7A
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 16:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbYHDOGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 10:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbYHDOGm
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 10:06:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54908 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753382AbYHDOGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 10:06:41 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 064A5393B489; Mon,  4 Aug 2008 16:06:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080804155733.46fd3982@pc09.procura.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91355>

On Mon, Aug 04, 2008 at 03:57:33PM +0200, H.Merijn Brand wrote:
> We already changed the approach for converting projects from SCCS to
> create a recursive repo from all SCCS repo's. And that *is* perfect.

Yes, but that's orthogonal to whether to separate the imported history
from the pure history? (Not that I'd want to force it upon you. If you
have a lot of nested repositories, the grafting can get a bit obnoxious
if you don't automate it well, I suppose.)

> Problem with the current join/merge is that there already have been
> commits to the git repo after the SCCS convert that I do not want to
> loose.

You could rebase these to the new initial commit. But if you already use
Git intensively and rewriting history would create big headache for you
at this point already, it's too late, I guess.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
