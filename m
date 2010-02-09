From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v2 6/6] receive-pack: Send hook output over side band #2
Date: Tue, 9 Feb 2010 12:33:07 -0500
Message-ID: <20100209173307.GA1115@cthulhu>
References: <1265403462-20572-1-git-send-email-spearce@spearce.org>
 <1265403462-20572-7-git-send-email-spearce@spearce.org>
 <20100209165207.GA12030@cthulhu>
 <20100209172027.GC26964@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:33:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Netxd-0001ds-QR
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 18:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab0BIRdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 12:33:10 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:49385 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab0BIRdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 12:33:09 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id A649682200F; Tue,  9 Feb 2010 12:33:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20100209172027.GC26964@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139421>

* Shawn O. Pearce (spearce@spearce.org) [100209 12:20]:
> Larry D'Anna <larry@elder-gods.org> wrote:
> > 
> > This breaks t5401.  See <7v4olqlva7.fsf@alter.siamese.dyndns.org> in another thread.
> 
> No.  Your patch causes t5401 to break.  If you apply this series on
> top of maint, its fine.  If you merge this series into master, and
> correctly fix the Win32 merge conflict in run-command.c, its fine.

Well, the version of this commit that's in pu is defiantly failing t5401 on my
machine.  Just tested it again with a clean build.  My series isn't an ancestor
of it either.  Did you notice the failure is intermittent?  You have to run it a
few times before it fails.

       --larry
