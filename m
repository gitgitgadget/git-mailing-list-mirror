From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 05:27:27 -0500
Message-ID: <20070115102727.GC12257@spearce.org>
References: <200701151000.58609.andyparkins@gmail.com> <20070115101529.GB12257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:33:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVr-0000SO-KK
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:51 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9b-0003eK-Jv
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbXAOK1c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbXAOK1c
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:27:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46689 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187AbXAOK1b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:27:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6P3m-00049I-SY; Mon, 15 Jan 2007 05:27:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 14AA420FBAE; Mon, 15 Jan 2007 05:27:28 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <20070115101529.GB12257@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36837>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Andy Parkins <andyparkins@gmail.com> wrote:
> > Of course my favourite is git, but we were talking about the certificates 
> > needed by monotone for each developer.

One problem here is a certificate does not make a security system.
Obviously anyone can generate a certificate and claim anything they
want within it, just the same as you can claim anything you want in
a Git commit or tag.  What's needed is some external method that
all interested parties trust to verify a given certificate is
associated with a given entity.

> What I'm actually doing in one particular environment is checking
> the committer string against a database of known committer strings
> associated with the current UNIX uid.

In this particular case access to the UNIX system is tightly
controlled.  Much paperwork must be filled out and signed by multiple
people, all of whom recognize the user on sight and know why they
need access to that system.  They also have checked the user's
identity through multiple background checks, fingerprinting, etc.

In other words the entire authentication problem was already solved,
trusting the UNIX uid just let Git plug into that seamlessly.

The problem is obviously harder on the Internet.  I've never
met anyone on this mailing list in person, but the quality (or
lack thereof sometimes) is evident in my work, and since its all
peer-reviewed anyway Junio finds little risk in incorporating the
good stuff into git.git.  No certificate required.

-- 
Shawn.
