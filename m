From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: bug in checkout/status ?
Date: Thu, 5 Mar 2009 12:53:13 -0800
Message-ID: <20090305205313.GB16213@spearce.org>
References: <20090305204801.GA16213@spearce.org> <20090305205126.GA19800@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 21:54:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfKaZ-00011P-Hz
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 21:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224AbZCEUxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 15:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754051AbZCEUxP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 15:53:15 -0500
Received: from george.spearce.org ([209.20.77.23]:46718 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbZCEUxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 15:53:15 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id BD7CF38211; Thu,  5 Mar 2009 20:53:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090305205126.GA19800@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112340>

Jeff King <peff@peff.net> wrote:
> On Thu, Mar 05, 2009 at 12:48:01PM -0800, Shawn O. Pearce wrote:
> 
> Hmm. I get the same behavior here. I notice there is a "libelf" subtree
> before "libelf-po"; maybe it's a sorting bug? I'll try to investigate
> more.

Yup, that must be it.

JGit created the resulting tree during a merge.

It sorted "libelf/" before "libelf-po/".  Wrong.  Bad JGit.  Bad!

-- 
Shawn.
