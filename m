From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] New test for preserve merges and squash
Date: Thu, 20 Mar 2008 12:09:34 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803201208080.3983@racer.site>
References: <1205971432-12641-1-git-send-email-joerg@alea.gnuu.de> <7v1w661bnx.fsf@gitster.siamese.dyndns.org> <20080320101809.GA23108@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1510358137-1206011376=:3983"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Thu Mar 20 12:10:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcIf3-0007M0-FK
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 12:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbYCTLJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 07:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbYCTLJh
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 07:09:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:54200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752153AbYCTLJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 07:09:36 -0400
Received: (qmail invoked by alias); 20 Mar 2008 11:09:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 20 Mar 2008 12:09:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QXqkLJWGQyiF9IUowUBm29mU1Bu9xcykrInTbIA
	FWM1bI7UDPVY1G
X-X-Sender: gene099@racer.site
In-Reply-To: <20080320101809.GA23108@alea.gnuu.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77650>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1510358137-1206011376=:3983
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 20 Mar 2008, Jörg Sommer wrote:

> Junio C Hamano schrieb am Wed 19. Mar, 17:28 (-0700):
> > Jörg Sommer <joerg@alea.gnuu.de> writes:
> > 
> > > Signed-off-by: Jörg Sommer <joerg@alea.gnuu.de>
> > > ---
> > >  t/t3404-rebase-interactive.sh |   20 ++++++++++++++++++++
> > >  1 files changed, 20 insertions(+), 0 deletions(-)
> > >
> > > The current version of git fails this test. I think it's a bug, 
> > > because the patch is what I expect to happen. Or am I wrong?
> > 
> > Please mark such tests with test_expect_fail.
> 
> No, I expect the test succeeds. Currently, it fails. This might be, 
> because my expectations are wrong or there's a bug.

The definition of "test_expect_fail" is: this should succeed, but needs 
fixin'.

> > And also Cc: the guilty parties.
> 
> Okay, I've added Johannes the author of f09c9b8c5ff to the Cc: list.
> 
> Johannes, can you explain why this test fails?

At the moment, I can't, because I indeed missed your original mail.  Maybe 
I'll find time this afternoon to dive into gmane to find your original 
mail.

Ciao,
Dscho

--8323584-1510358137-1206011376=:3983--
