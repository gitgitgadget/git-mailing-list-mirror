From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH, take 2] Linear-time/space rename logic (exact renames
	only)
Date: Tue, 23 Oct 2007 00:54:55 +0200
Message-ID: <20071022225455.GH23714@steel.home>
References: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org> <20071022070750.GM1179MdfPADPa@greensroom.kotnet.org> <alpine.LFD.0.999.0710220932150.10525@woody.linux-foundation.org> <alpine.LFD.0.999.0710221009580.10525@woody.linux-foundation.org> <alpine.LFD.0.999.0710221207300.30120@woody.linux-foundation.org> <alpine.LFD.0.999.0710221241560.30120@woody.linux-foundation.org> <20071022211706.GD23714@steel.home> <alpine.LFD.0.999.0710221437030.30120@woody.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
	Sven Verdoolaege <skimo@liacs.nl>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 00:55:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik6Ax-0001pb-Bp
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 00:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbXJVWy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 18:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbXJVWy7
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 18:54:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:48122 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbXJVWy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 18:54:58 -0400
Received: from tigra.home (Fab70.f.strato-dslnet.de [195.4.171.112])
	by post.webmailer.de (mrclete mo55) (RZmta 13.6)
	with ESMTP id y060fbj9MHLMQA ; Tue, 23 Oct 2007 00:54:56 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 16E4D277AE;
	Tue, 23 Oct 2007 00:54:56 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E714B56D22; Tue, 23 Oct 2007 00:54:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710221437030.30120@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKf+sU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62052>

Linus Torvalds, Mon, Oct 22, 2007 23:37:55 +0200:
> On Mon, 22 Oct 2007, Alex Riesen wrote:
> > 
> > It breaks t3402-rebase-merge.sh
> 
> Hmm. Works for me here. But I will check if there is some incomplete 
> dependency in the makefile or something...
> 

Ok, resolved. Turns out I completely missed the last two patches
