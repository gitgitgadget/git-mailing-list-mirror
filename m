From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Common setting for interoperability repo across windows and
	unix?
Date: Wed, 4 Nov 2009 15:01:22 -0800
Message-ID: <20091104230122.GK10505@spearce.org>
References: <c94f8e120911030709h29c5b8edr53df269632990e81@mail.gmail.com> <32541b130911030733i734b9f6doc366934873bf7713@mail.gmail.com> <S0ax5AE0Xf8KFwjv@thewolery.demon.co.uk> <32541b130911041459y7a2201a3r18601522187891f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Anthony W. Youngman" <wol@thewolery.demon.co.uk>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 00:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5or2-0006qm-Lo
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 00:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315AbZKDXBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 18:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756262AbZKDXBR
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 18:01:17 -0500
Received: from george.spearce.org ([209.20.77.23]:47558 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954AbZKDXBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 18:01:17 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8FE90381FE; Wed,  4 Nov 2009 23:01:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <32541b130911041459y7a2201a3r18601522187891f2@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132167>

Avery Pennarun <apenwarr@gmail.com> wrote:
> >
> > git-daemon doesn't (currently) work on msysgit. Currently I run git-daemon
> > on my linpus netbook and pull/push from windows.
> 
> I didn't know that.  Windows sockets are mercifully very nearly
> compatible with Linux ones, so hopefully this wouldn't be too hard to
> fix for someone that needs it.  (Not me; I prefer cygwin over msys in
> all cases.)

git-daemon relies on fork, do work, then later exec.  Windows lacks
this concept.  Making it hard to port.

-- 
Shawn.
