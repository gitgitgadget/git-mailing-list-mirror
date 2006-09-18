From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-repack: Outof memory
Date: Sun, 17 Sep 2006 19:47:25 -0700
Message-ID: <7v64flyjpe.fsf@assigned-by-dhcp.cox.net>
References: <450CA561.9030602@gmail.com> <20060917022534.GB7512@spearce.org>
	<4b3406f0609161946x52a89dd3q6d74127c376270e7@mail.gmail.com>
	<20060917031853.GC7512@spearce.org>
	<4b3406f0609170003t63a2f9f4pf2c42faec9746a73@mail.gmail.com>
	<4b3406f0609170543p68d96b9x9ba0c5a74d9e89e8@mail.gmail.com>
	<20060918002357.GA19727@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dongsheng Song <dongsheng.song@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 18 04:47:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP9AP-0003hg-VE
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 04:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbWIRCr1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 22:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965327AbWIRCr0
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 22:47:26 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:44516 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965326AbWIRCr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 22:47:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918024725.ESXC6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 22:47:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PenC1V00h1kojtg0000000
	Sun, 17 Sep 2006 22:47:13 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27221>

Shawn Pearce <spearce@spearce.org> writes:

> ...  I fear that
> you are going to bump up against address space limitations soon
> on 32 bit systems.  Then you will bump up against the 4 GiB pack
> file size limit.  Which means you will need to use several packs
> and avoid the '-a' flag when calling git-repack.

I presume that you are hinting that we would need to update
git-repack so that it is still useful without --all.

Which means "pack-objects --unpacked=active-pack" would need to
be pushed out so that git-repack can be updated to do the
"archived ones and repacking the active pack" we talked about
earlier.

I think pack-objects --unpacked=active-pack is ready, so I'll
push it out.
