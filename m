From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git / Subversion Interoperability
Date: Fri, 23 Mar 2007 11:34:26 +0100
Message-ID: <20070323103426.GA15923@diana.vm.bytemark.co.uk>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org> <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk> <20070323012422.GC17773@spearce.org> <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Mar 23 11:35:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUh7U-0007WD-1B
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 11:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbXCWKfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Mar 2007 06:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbXCWKfd
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 06:35:33 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1226 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422777AbXCWKfc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 06:35:32 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HUh6I-0004An-00; Fri, 23 Mar 2007 10:34:26 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42926>

On 2007-03-23 01:36:11 +0000, Julian Phillips wrote:

> On Thu, 22 Mar 2007, Shawn O. Pearce wrote:
>
> > I thought about the properties, but didn't bother to write
> > anything on that subject as we may just be able to say "look,
> > properties are not supported in git-svnserver, so don't try to use
> > them".
>
> Indeed. That's what I was aiming at with the the last sentence (not
> very clearly unfortunately). It would be nice if the server could
> tell the client that properties are not supported ... but I doubt
> that it can, since they are fundamental part of Subversion.
>
> In particular it's how the client finds out about things like
> symlinks and line ending conversion. It may be necessary to provide
> some basic support for some of the properties in the svn:...
> namespace in order for the Subversion repo access library not to
> refuse to talk to the git server.

Maybe the pragmatic solution would be to have built-in handling of a
few properties such as svn:executable and svn:ignore that have git
equivalents, and just emulate all other properties with files.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
