From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] usage.c: remove unused functions
Date: Thu, 25 Sep 2008 22:43:41 +0200
Message-ID: <20080925204341.GA22708@diku.dk>
References: <20080925184104.6117@nanako3.lavabit.com> <200809251348.42789.trast@student.ethz.ch> <20080925124836.GI10360@machine.or.cz> <20080925145134.GL3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Lars Hjemli <hjemli@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 22:44:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kixhl-0006fi-8a
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 22:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbYIYUnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 16:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753639AbYIYUno
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 16:43:44 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:34952 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbYIYUno (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 16:43:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id DED9052C3E8;
	Thu, 25 Sep 2008 22:43:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dJ94TBl7ImPd; Thu, 25 Sep 2008 22:43:41 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 5C14852C3C7;
	Thu, 25 Sep 2008 22:43:41 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 216E76DFD13; Thu, 25 Sep 2008 22:43:07 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 413F31A4001; Thu, 25 Sep 2008 22:43:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080925145134.GL3669@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96796>

Shawn O. Pearce <spearce@spearce.org> wrote Thu, Sep 25, 2008:
> IMHO these are useless for a "libgit".  However both tig and
> cgit link to the non-existant libgit.a, so they may be using
> these routines.  I've CC'd their authors and am not applying this
> particular change without an ACK from them.

This is not a problem for tig since it doesn't use libgit at all.

-- 
Jonas Fonseca
