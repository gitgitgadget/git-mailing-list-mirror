From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: auto gc
Date: Thu, 15 Nov 2007 03:20:04 -0500
Message-ID: <20071115082004.GL14735@spearce.org>
References: <20071115081025.GC638@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:20:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsZxj-00020M-NS
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753AbXKOIUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbXKOIUM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:20:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33683 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbXKOIUL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:20:11 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IsZxI-0007pS-Fv; Thu, 15 Nov 2007 03:20:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E44D920FBAE; Thu, 15 Nov 2007 03:20:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071115081025.GC638@kernel.dk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65085>

Jens Axboe <jens.axboe@oracle.com> wrote:
...
> Packing your repository for optimum performance. You may also
> run "git gc" manually. See "git help gc" for more information.
> Generating pack...
> [...]
> 
> This is extremely annoying behaviour! If I'm on battery or just in a bit
> of a hurry, I defeinitely don't want git second guessing me and deciding
> that it's time to run git gc.
> 
> I'd suggest just printing a hint that running git gc would increase
> performance, doing it automatically is definitely bad style (even more
> so when then yet again changed git refs layout even breaks old scripts,
> when git gc has run).

Set the following and it won't run automatically anymore for you:

	git config --global gc.auto 0
	git config --global gc.autopacklimit 0

More recently this message has been changed to:

  Packing your repository for optimum performance. You may also
  run "git gc" manually. See "git help gc" for more information.

The two options noted above are described in the manual for git-gc.

- 
Shawn.
