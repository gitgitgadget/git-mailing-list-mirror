From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git stash apply usability issues
Date: Fri, 19 Oct 2007 15:27:53 +0200
Message-ID: <20071019132753.GA23765@diana.vm.bytemark.co.uk>
References: <47171A21.9030003@viscovery.net> <20071019013156.GU14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 15:28:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiru3-0007a4-7c
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 15:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757341AbXJSN22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Oct 2007 09:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756134AbXJSN22
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 09:28:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2949 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbXJSN21 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 09:28:27 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IirtJ-0006He-00; Fri, 19 Oct 2007 14:27:53 +0100
Content-Disposition: inline
In-Reply-To: <20071019013156.GU14735@spearce.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61705>

On 2007-10-18 21:31:56 -0400, Shawn O. Pearce wrote:

> Johannes Sixt <j.sixt@viscovery.net> wrote:

> > (2) when 'git stash apply' runs merge-recursive, it treats the
> > current state as 'ours' and the stash as 'theirs'. IMHO it should
> > be the other way round: I have stashed away changes to a binary
> > file. Then committed a different modification to it, and now want
> > to apply the stash. This results in a conflict that leaves the
> > current state in the working tree, but I had preferred that the
> > stashed binary file were in the working tree now.
> >
> > What do other git-stash users think about changing the order?
>
> The current order is the same order that git-rebase uses. I'm not
> saying its correct, just that its the same as rebase.

=46WIW, StGit push works the same way. The idea being that the current
HEAD is our current state ("ours"), and the patch we're pushing is
some change we want to apply ("theirs"). I always felt that this was a
very natural order of things. But I guess the philosophy in the
"stash" case is subtly different, so maybe the change is warranted
there.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
