From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: dangling commits
Date: Mon, 16 Jan 2006 13:40:20 +0100
Message-ID: <20060116124020.GB5356@fiberbit.xs4all.nl>
References: <7vslrp2nw0.fsf@assigned-by-dhcp.cox.net> <20060115221108.3ED2E352659@atlas.denx.de> <20060116085238.GA3768@fiberbit.xs4all.nl> <7vr778wmj3.fsf@assigned-by-dhcp.cox.net> <20060116101722.GB5196@fiberbit.xs4all.nl> <43CB753D.2030706@op5.se> <20060116113332.GA5356@fiberbit.xs4all.nl> <43CB8BFC.8050900@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Marco Roeland <marco.roeland@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 13:40:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyTet-0001Sl-2T
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 13:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWAPMkY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 07:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWAPMkY
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 07:40:24 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:18123 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1750740AbWAPMkX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 07:40:23 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1EyTem-0001XW-OI; Mon, 16 Jan 2006 13:40:20 +0100
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <43CB8BFC.8050900@op5.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14743>

On Monday January 16th 2006 Andreas Ericsson wrote:

> The blobs are immutable and never change for a rebase, unless the 
> file(s) it applies to is changed in master as well. It's the commits 
> that do because they get new parents.

Ah, I need to rebase my mental picture of what a "rebase" is. ;-) And
the fact that each commit _does_ have sort of a blob (well in my mind I
called it so, the file under .git/objects, although its proper name is
indeed "commit") in the repository doesn't make it any easier!

Current documentation about git-rebase(1) is technically correct of
course then: "rebases local commits to the new head of the upstream
tree" but rather sparse for the less initiated. In Dutch we have an
expression for this, to "not be able to see the wood because of the
trees", which is rather appropriate here. Perhaps we can introduce
"liana" as an alternative for commit.

<Nice young men in clean white coats come in to take me away>

Seriously, yours and other peoples comments make the picture much
clearer to me and help out enormously to me and hopefully other lurkers
in working with git and more advanced SCM in general. Thanks,
-- 
Marco Roeland
