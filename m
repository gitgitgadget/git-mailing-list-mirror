From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH 1/4] Add a simple option parser for use by builtin-commit.c.
Date: Mon, 1 Oct 2007 12:31:48 +0200
Message-ID: <20071001103148.GC8315@diku.dk>
References: <1190868632-29287-1-git-send-email-krh@redhat.com> <20070930131133.GA11209@diku.dk> <Pine.LNX.4.64.0710011114310.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 12:34:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcIbH-0005iD-Ma
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 12:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbXJAKd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 06:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbXJAKd7
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 06:33:59 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:46131 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbXJAKd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 06:33:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id B885C60008D;
	Mon,  1 Oct 2007 12:33:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EuZSKowP5iYX; Mon,  1 Oct 2007 12:33:55 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 62909600090;
	Mon,  1 Oct 2007 12:31:48 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 24B8E6DFC31; Mon,  1 Oct 2007 12:26:37 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 42DDC632B7; Mon,  1 Oct 2007 12:31:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710011114310.28395@racer.site>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59598>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote Mon, Oct 01, 2007:
> Hi,
> 
> On Sun, 30 Sep 2007, Jonas Fonseca wrote:
> 
> > Also, I think for this to be more usable for other built-in programs it 
> > shouldn't modify argv, but instead take both argc and argv (so we don't 
> > need to have code like "*++(*argv)" ;), parse _all_ options in one go, 
> > and return the index (of argv) for any remaining options.
> 
> We _have_ to modify argv.  For example, "git log master -p" is perfectly 
> valid.

Ah, yes this could be nice to also finally have (more universally) in
git. But for this to be possible I don't see any reason for it to modify
the pointer to argv. Instead, it can just reshuffle entries in argv.

-- 
Jonas Fonseca
