From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: dangling commits
Date: Mon, 16 Jan 2006 12:33:32 +0100
Message-ID: <20060116113332.GA5356@fiberbit.xs4all.nl>
References: <7vslrp2nw0.fsf@assigned-by-dhcp.cox.net> <20060115221108.3ED2E352659@atlas.denx.de> <20060116085238.GA3768@fiberbit.xs4all.nl> <7vr778wmj3.fsf@assigned-by-dhcp.cox.net> <20060116101722.GB5196@fiberbit.xs4all.nl> <43CB753D.2030706@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Marco Roeland <marco.roeland@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 12:33:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyScM-0004UA-Ir
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 12:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWAPLdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 06:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWAPLdj
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 06:33:39 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:19646 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1750919AbWAPLdj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 06:33:39 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1EySc8-0001S2-Ox; Mon, 16 Jan 2006 12:33:32 +0100
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <43CB753D.2030706@op5.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14741>

On Monday January 16th 2006 Andreas Ericsson wrote:

> Since "pu" = "proposed updates" it only makes sense to keep it on top of 
> the current master, otherwise the effort required for anyone to test it 
> in conjunction with the latest master branch would simply be too great.

Certainly. And it probably is a good testbed for testing the rebasing
routines as well.

But couldn't (in theory) the new "rebased" versions of blobs in the "pu"
branch be first committed as the old not yet rebased version and then
as the new version. Not the fact that the blobs in "pu" are constantly
based on the latest master was the problem if I recollect, but the fact
that blobs sometimes disappeared. In comparing this with Linus' recent
explanation how git-bisect works in terms of light cones this might be
understood as the inherent problems with tachyons I think...

Anyway this is now solved I understand. Thanks.

> >I since removed it from the "Pull" list, but understand that "+pu"
> >should do the trick. I'll retry using it one of these days.
> 
> It does. I also remember seeing lots of errors on that one when I first 
> started with git (around 0.99b), but that was fixed quite some time ago.

Ok, thanks very much for explaining.
-- 
Marco Roeland
