From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: post-checkout hook not run on clone
Date: Mon, 2 Mar 2009 21:04:51 -0800
Message-ID: <20090303050451.GA26459@spearce.org>
References: <20273.1236033817@relay.known.net> <20090303042848.GC18136@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: layer <layer@known.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 06:07:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeMqw-00073J-MS
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 06:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbZCCFEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 00:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbZCCFEy
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 00:04:54 -0500
Received: from george.spearce.org ([209.20.77.23]:45718 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbZCCFEx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 00:04:53 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D4A0738210; Tue,  3 Mar 2009 05:04:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090303042848.GC18136@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111997>

Jeff King <peff@peff.net> wrote:
> On Mon, Mar 02, 2009 at 02:43:37PM -0800, layer wrote:
> 
> > I realize this might be a feature, but when I switch to the master
> > branch with "git checkout master" it is, and I would think that a
> > clone that gets the master branch would also does a sort of "checkout
> > master" and would run the hook.
> 
> Right. Hooks are not cloned with the repo.

I think the original poster was talking about a hook installed via
their template directory.  In which case the hook is trusted, and is
coming from a known source, its just not being called during clone.
 
-- 
Shawn.
