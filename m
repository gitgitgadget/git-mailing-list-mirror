From: Mike Hommey <mh@glandium.org>
Subject: Re: preserving mtime
Date: Sun, 18 Nov 2007 09:45:11 +0100
Organization: glandium.org
Message-ID: <20071118084511.GC16863@glandium.org>
References: <473D63F9.4010201@inrim.it> <473D6DC6.8040804@op5.se> <20071117182236.GD23659@blorf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Wayne Davison <wayne@opencoder.net>
X-From: git-owner@vger.kernel.org Sun Nov 18 09:47:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itfo1-0006dT-2x
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 09:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbXKRIqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 03:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbXKRIqo
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 03:46:44 -0500
Received: from vawad.err.no ([85.19.200.177]:55956 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbXKRIqn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 03:46:43 -0500
Received: from aputeaux-153-1-42-198.w82-124.abo.wanadoo.fr ([82.124.6.198] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1ItfnP-0004g9-El; Sun, 18 Nov 2007 09:46:30 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1ItfmB-00055C-Nc; Sun, 18 Nov 2007 09:45:11 +0100
Content-Disposition: inline
In-Reply-To: <20071117182236.GD23659@blorf.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 5.0): Status=No hits=4.9 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65349>

On Sat, Nov 17, 2007 at 10:22:36AM -0800, Wayne Davison wrote:
> On Fri, Nov 16, 2007 at 11:15:34AM +0100, Andreas Ericsson wrote:
> >> is it possible to tell git to preserve the file modification time in
> >> a checked out copy?
> 
> > Fabrizio Pollastri wrote:
> > No. Doing so would seriously break build-systems.
> 
> I wish that the initial clone would set the modification time to the
> commit time.  It would make the intial checkout have a more accurate
> representation of when a file was last changed instead of all files
> being set to the clone date.  Then, files that are being updated would
> get their time set as they do now.  I supposed I'll just use the handy
> git-set-file-times script (mentioned in another reply) every time I do
> a clone.

For completeness, it would make sense to do so every time you git
checkout (like, when switching branches).

Mike
