From: Petr Baudis <pasky@suse.cz>
Subject: Re: Creating tracked branches
Date: Thu, 22 Apr 2010 16:17:21 +0200
Message-ID: <20100422141721.GK3563@machine.or.cz>
References: <v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
 <y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
 <vpqsk6omppf.fsf@bauges.imag.fr>
 <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com>
 <86tyr4v12n.fsf@red.stonehenge.com>
 <u2n3abd05a91004211657v3dcdaf40j3608f3d8f59c4c1b@mail.gmail.com>
 <20100422081055.GG3563@machine.or.cz>
 <7vy6gf52d1.fsf@alter.siamese.dyndns.org>
 <20100422114924.GH3563@machine.or.cz>
 <m2sk6n7g68.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Aghiles <aghilesk@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Apr 22 16:17:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4xDi-00016V-Lw
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 16:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab0DVOR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 10:17:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42511 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831Ab0DVORY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 10:17:24 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4713286208E; Thu, 22 Apr 2010 16:17:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m2sk6n7g68.fsf@igel.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145533>

On Thu, Apr 22, 2010 at 03:47:11PM +0200, Andreas Schwab wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > P.S.: The "--track without -b implies branch creation" sentence in
> > git-checkout(1) seems to be plain wrong?
> 
> $ git checkout -t origin/maint
> Branch maint set up to track remote branch maint from origin.
> Switched to a new branch 'maint'

Ah! I have not read all the gory details carefully enough. Wonderful,
so this would be:

>   (i) If you do `checkout B`, it will track remote branch B if it
> exists.
> 
>   (ii) If you do `checkout -b B`, it will never auto-track anything.
> 
>   (iii) If you do `git checkout -t -b B`, it will auto-track your
> current _local_ branch.

  (iv) If you do `git checkout -t R`, it will track branch R, deriving
local branch name B from it.

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
