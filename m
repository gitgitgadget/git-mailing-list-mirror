From: Jeff King <peff@peff.net>
Subject: Re: libgit api & external integration
Date: Thu, 16 Jul 2009 06:03:34 -0400
Message-ID: <20090716100334.GB6742@coredump.intra.peff.net>
References: <b086760e0907111409w602f4338u868729dcfa188908@mail.gmail.com>
 <b086760e0907111417o4b249676jc821e8733d340c9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: devzero2000 <pinto.elia@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 12:03:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRNoX-0001PC-I8
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 12:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912AbZGPKDj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 06:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbZGPKDj
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 06:03:39 -0400
Received: from peff.net ([208.65.91.99]:47561 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807AbZGPKDi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 06:03:38 -0400
Received: (qmail 19756 invoked by uid 107); 16 Jul 2009 10:05:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Jul 2009 06:05:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jul 2009 06:03:34 -0400
Content-Disposition: inline
In-Reply-To: <b086760e0907111417o4b249676jc821e8733d340c9d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123395>

On Sat, Jul 11, 2009 at 11:17:20PM +0200, devzero2000 wrote:

> We, the rpm5 community, would like to incorporate in the rpm package
> manager (rpm5 branch) a=C2=A0 VCS - the history is lonk and probably =
not of
> interest. I personally have recommend git, for too much reason that
> everyone on this list can agreed. Unfortunately there seems to be no
> clear API or usable libgit to do this now: some comment on this ?
> Thanks in advance.

No, there is currently no linkable libgit. The official stable interfac=
e
for interacting with git is the set of plumbing commands.

-Peff
