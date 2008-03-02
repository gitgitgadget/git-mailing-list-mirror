From: John Goerzen <jgoerzen@complete.org>
Subject: Re: git-rebase dirty index and email address bug?
Date: Sun, 2 Mar 2008 07:44:36 -0600
Message-ID: <200803020744.36591.jgoerzen@complete.org>
References: <slrnfsjfpo.3fl.jgoerzen@katherina.lan.complete.org> <slrnfsjim1.5e0.jgoerzen@katherina.lan.complete.org> <20080302073016.GC3935@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 02 15:14:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVoxO-0003KI-3g
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 15:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbYCBONu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 09:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753583AbYCBONu
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 09:13:50 -0500
Received: from b01s02mr.corenetworks.net ([64.85.160.192]:58793 "EHLO
	glockenspiel.complete.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbYCBONt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 09:13:49 -0500
X-Greylist: delayed 1744 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Mar 2008 09:13:49 EST
Received: from 63-245-179-205.kitusa.com ([63.245.179.205] helo=erwin.lan.complete.org)
	by glockenspiel.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(TLS peer CN erwin.complete.org, certificate verified)
	(Exim 4.63)
	id 1JVoUa-0000AI-Ce; Sun, 02 Mar 2008 07:44:44 -0600
Received: from katherina.lan.complete.org ([10.200.0.4])
	by erwin.lan.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(No TLS peer certificate)
	(Exim 4.67)
	id 1JVoUW-0007Qz-Sf; Sun, 02 Mar 2008 07:44:36 -0600
Received: from jgoerzen by katherina.lan.complete.org with local (Exim 4.69)
	(envelope-from <jgoerzen@complete.org>)
	id 1JVoUW-0006Zx-KW; Sun, 02 Mar 2008 07:44:36 -0600
User-Agent: KMail/1.9.7
In-Reply-To: <20080302073016.GC3935@coredump.intra.peff.net>
Content-Disposition: inline
X-Spam-Status: No (score 0.0): AWL=0.000
X-Virus-Scanned: by Exiscan on glockenspiel.complete.org at Sun, 02 Mar 2008 07:44:44 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75782>

On Sunday 02 March 2008 1:30:16 am Jeff King wrote:
> On Sat, Mar 01, 2008 at 03:29:37PM -0600, John Goerzen wrote:
> > Two things to add:
> >
> > 1) This was a clean branch prior to rebase (git status was empty)
> >
> > 2) Adding -i to the rebase command, then making no changes to the
> > list, caused the rebase to work perfectly.
>
> Yes, "rebase -i" works somewhat differently than an ordinary rebase. It
> uses a series of cherry-picks rather than "format-patch | am". And the
> bug is, I think, in "git-am".
>
> It probably would also have worked using "git rebase -m" which uses
> merge strategies to rebase.

I did try that.  The resulting error message was slightly different, but not 
significantly so, if I remember correctly.

-- John
