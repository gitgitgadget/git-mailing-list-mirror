From: Jeff King <peff@peff.net>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Tue, 17 Mar 2009 20:40:56 -0400
Message-ID: <20090318004056.GB25454@coredump.intra.peff.net>
References: <200903171953.23650.ogoffart@kde.org> <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Olivier Goffart <ogoffart@kde.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 01:42:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljjrw-0007YE-86
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 01:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbZCRAlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 20:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbZCRAlF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 20:41:05 -0400
Received: from peff.net ([208.65.91.99]:34288 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594AbZCRAlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 20:41:05 -0400
Received: (qmail 9110 invoked by uid 107); 18 Mar 2009 00:41:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 20:41:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 20:40:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113544>

On Tue, Mar 17, 2009 at 11:31:19PM +0100, Johannes Schindelin wrote:

> > I was told on IRC that this has been discussed already not so long ago, 
> > and looking on the archive[1], all i seen was bikesheeding .  Here is a 
> > patch :-)
> 
> Unfortunately, the implementation is not the problem, but picking the best 
> name.  The first letter "m" will be taken in a short while by the "merge" 
> command for "rebase -i -p", so "message" is out, sadly.
> 
> But the "rephrase" command will be part of the "rebase -i -p" series when 
> I will finally be able to submit it.

Also, I thought the general plan was to add such features to the
git-sequencer work which will (hopefully) eventually replace "rebase
-i". Dscho, can you give a brief update on how that is coming? Are
rebase patches worth thinking about?

-Peff
