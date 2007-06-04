From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-p4import.py robustness changes
Date: Mon, 4 Jun 2007 01:56:00 -0400
Message-ID: <20070604055600.GE4507@spearce.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <0EDF1E14-3682-4B1E-A7D2-F82388F752AA@slamb.org> <7vzm3inisa.fsf@assigned-by-dhcp.cox.net> <200706031511.31157.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Mon Jun 04 07:56:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv5Y3-00084g-MH
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 07:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbXFDF4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 01:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbXFDF4I
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 01:56:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44721 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbXFDF4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 01:56:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hv5Xt-0003aX-RL; Mon, 04 Jun 2007 01:56:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F0E4820FBAE; Mon,  4 Jun 2007 01:56:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200706031511.31157.simon@lst.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49064>

Simon Hausmann <simon@lst.de> wrote:
> On the topic of git integration with perforce, what are the chances of getting 
> git-p4 ( http://repo.or.cz/w/fast-export.git ) into git's contrib/fast-export 
> area? :)
> 
> git-p4 can do everything git-p4import can do plus a lot more (it can track 
> multiple branches, it's a hell of a lot faster, it can export back to p4 and 
> it also works on Windows!).

I was sort of hoping we could fold the fast-export Git repository
on repo.or.cz into core Git at some point.  Right now the only
thing in contrib/fast-export is the import-tars.perl script that
I maintain in my fastimport repository...  ;-)

Like Junio I don't use Perforce, and can't test against it, but
if you can maintain git-p4 (and I think the history on repo.or.cz
shows that you do) then it may be a good idea to add it to core Git.

Send a patch to add it.  Worst that happens is both Junio and I
decide not to apply it.  Or I apply it, but Junio refuses to pull
from me afterwards.  ;-)

-- 
Shawn.
