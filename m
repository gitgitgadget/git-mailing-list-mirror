From: Rudolf Polzer <divVerent@alientrap.org>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 08:01:08 +0100
Message-ID: <20100114070108.GB1528@rm.endoftheinternet.org>
References: <op.u6g8jnixg402ra@nb-04> <871vht7cs2.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 08:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVK1r-0004uD-BT
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 08:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360Ab0ANHVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 02:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756336Ab0ANHVu
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 02:21:50 -0500
Received: from rm.endoftheinternet.org ([94.23.21.40]:56178 "EHLO
	r23604.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756316Ab0ANHVs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 02:21:48 -0500
Received: from rpolzer by r23604.ovh.net with local (Exim 4.69)
	(envelope-from <divVerent@alientrap.org>)
	id 1NVJhc-0003nW-LH; Thu, 14 Jan 2010 08:01:08 +0100
Content-Disposition: inline
In-Reply-To: <871vht7cs2.fsf@catnip.gol.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136958>

On Thu, Jan 14, 2010 at 09:25:49AM +0900, Miles Bader wrote:
> "Rudolf Polzer" <divVerent@alientrap.org> writes:
> > I'd like a feature to automatically "transform" a non-tracking local
> > branch into a tracking branch on push. A patch to do that is attached.
> 
> Yay!!
> 
> I've wanted this for a long time, but discussions about it always seem
> to end up petering out...
> 
> > git branch mybranch
> > git checkout mybranch
> > ...
> > git push --track origin mybranch:mybranch
> 
> Does it default to the current branch so you can just say "git push --track origin"?

It does the very same decisions as push. Basically, it is "whatever got pushed,
mark as tracking".

Best regards,

Rudolf
