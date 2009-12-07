From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (Dec 2009, #02; Sat, 05)
Date: Mon, 7 Dec 2009 07:37:36 -0800
Message-ID: <20091207153736.GC17173@spearce.org>
References: <7vpr6siki5.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0912061738580.5582@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rctay89@gmail.com
To: Martin Storsj? <martin@martin.st>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 16:37:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHfeq-0000sC-M9
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 16:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935345AbZLGPhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 10:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935342AbZLGPhe
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 10:37:34 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:51095 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932577AbZLGPhe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 10:37:34 -0500
Received: by ywh36 with SMTP id 36so4374936ywh.15
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 07:37:40 -0800 (PST)
Received: by 10.101.4.36 with SMTP id g36mr295080ani.75.1260200260470;
        Mon, 07 Dec 2009 07:37:40 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 7sm2573979yxd.26.2009.12.07.07.37.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 07:37:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912061738580.5582@cone.home.martin.st>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134760>

Martin Storsj? <martin@martin.st> wrote:
> On Sun, 6 Dec 2009, Junio C Hamano wrote:
> > 
> > * tr/http-updates (2009-12-01) 3 commits
> >  - Allow curl to rewind the RPC read buffer
> >  - Add an option for using any HTTP authentication scheme, not only basic
> >  - http: maintain curl sessions
> > 
> > There was a discussion on a better structure not to require rewinding in
> > the first place?  I didn't follow it closely...
> 
> I think the conclusion is: Rewinding support isn't strictly necessary, 
> there's a number of mechanisms in both git and curl that should make sure 
> that those cases shouldn't surface. A few of them in curl have an 
> unfortunate conincidence of bugs up until the latest version, though, 
> leaving much fewer mechanisms in place to avoid this.
> 
> Since that patch is quite non-intrusive I think it's a good safeguard, 
> though. What do you think, Tay, keep it or leave it?

I think the conclusion of the thread was that what you have queued
in tr/http-updates is OK as-is.  The patch to grow the postbuffer
to store the entire request wasn't a good idea and got dropped.

-- 
Shawn.
