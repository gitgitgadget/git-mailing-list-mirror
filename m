From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: commiting while the current version is in conflict
Date: Thu, 16 Oct 2008 16:23:32 -0700
Message-ID: <20081016232332.GD9877@spearce.org>
References: <2d460de70810161510ha220593g4615a55b2c3e3b25@mail.gmail.com> <20081016224808.GO536@genesis.frugalware.org> <2d460de70810161607n470e9479h8f7885040cbf5428@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 01:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqcD1-00070w-9Y
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 01:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786AbYJPXXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 19:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757246AbYJPXXd
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 19:23:33 -0400
Received: from george.spearce.org ([209.20.77.23]:47273 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321AbYJPXXd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 19:23:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7D3743835F; Thu, 16 Oct 2008 23:23:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2d460de70810161607n470e9479h8f7885040cbf5428@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98434>

Richard Hartmann <richih.mailinglist@gmail.com> wrote:
> On Fri, Oct 17, 2008 at 00:48, Miklos Vajna <vmiklos@frugalware.org> wrote:
> 
> > Not sure, but in general blocking conflict markers by default would be a
> > bad idea IMHO, several markup language (asciidoc, for example) makes use
> > of the >>>, === and such character sequences.
> 
> Doesn't git keep metadata about conflicts, as well?

Yes, in the index.  But it erases it when you stage the file with
"git add".

Go look at my prior message about how "git commit -a" is staging
the files prior to commit.  That makes git commit think everything
has been resolved, because you've told git, everything is resolved.

-- 
Shawn.
