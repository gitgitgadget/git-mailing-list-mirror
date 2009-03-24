From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [bug?] git-format-patch produces a 0-byte long patch for the
 first commit
Date: Tue, 24 Mar 2009 09:02:43 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0903240901570.4451@axis700.grange>
References: <Pine.LNX.4.64.0903231119110.4871@axis700.grange>
 <20090324075424.GC32400@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 09:04:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1cL-0005vs-B0
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbZCXICn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754434AbZCXICm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:02:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:48833 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753807AbZCXICk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:02:40 -0400
Received: (qmail invoked by alias); 24 Mar 2009 08:02:37 -0000
Received: from p57BD2955.dip0.t-ipconnect.de (EHLO axis700.grange) [87.189.41.85]
  by mail.gmx.net (mp047) with SMTP; 24 Mar 2009 09:02:37 +0100
X-Authenticated: #20450766
X-Provags-ID: V01U2FsdGVkX1/kHe184NHksRDIhZWuAJyaPOaGCIuA6hFgtJ4eJA
	mbCjIUwCEgzv67
Received: from lyakh (helo=localhost)
	by axis700.grange with local-esmtp (Exim 4.63)
	(envelope-from <g.liakhovetski@gmx.de>)
	id 1Lm1at-0001EL-TR; Tue, 24 Mar 2009 09:02:43 +0100
In-Reply-To: <20090324075424.GC32400@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114412>

On Tue, 24 Mar 2009, Jeff King wrote:

> On Mon, Mar 23, 2009 at 11:34:07AM +0100, Guennadi Liakhovetski wrote:
> 
> > mkdir x
> > cd x
> > git-init
> > echo hi > greating
> > git-commit -a
> > git-format-patch -1
> > 
> > produces a 0-byte long patch. git-format-patch HEAD^ produces an error, 
> > whereas with more than one commit it produces tha last patch. Yes, I know 
> > about "--root" and that it does allow to extract the very first commit.
> 
> What version of git are you using? I believe the 0-byte diff has been
> fixed since git 1.6.1.1.

Mine is still 1.5.4, if it's already fixed in the meantime - all the 
better!

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
