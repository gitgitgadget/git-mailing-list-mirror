From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: dangling commits
Date: Mon, 16 Jan 2006 09:52:38 +0100
Message-ID: <20060116085238.GA3768@fiberbit.xs4all.nl>
References: <7vslrp2nw0.fsf@assigned-by-dhcp.cox.net> <20060115221108.3ED2E352659@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 09:52:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyQ6Y-0005HV-AJ
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 09:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWAPIwo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 03:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWAPIwo
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 03:52:44 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:22473 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751039AbWAPIwn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 03:52:43 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1EyQ6Q-00017e-Oh; Mon, 16 Jan 2006 09:52:38 +0100
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20060115221108.3ED2E352659@atlas.denx.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14730>

On Sunday January 15th 2006 Wolfgang Denk wrote:

> Is ther eany way to clean up such a situation and really get  rid  of
> the  dangling  commits?  I understand that I'd first need some way to
> "unpack" the packs, but how to do this? 

Note that apart from the disk space they use up, dangling commits don't
do any harm.

However you can easily get rid of them by using "git prune".

As far as I know although packs are used in transferring the commits to
your local repository they are stored there as separate objects, so you
certainly don't have to unpack things yourself for using "git prune".
Git is quite smart, fast and safe on its own I find each time! It really
is a wonderful tool by giving you every possibility to work with it
without inflicting policy on you.

If wanted you can use "git repack -a -d" followed by "git prune-packed"
to create a tight packed repository (all commits and blobs in one pack)
but there is no specific need to.
-- 
Marco Roeland
