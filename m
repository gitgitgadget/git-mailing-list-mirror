From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: StGIT vs. guilt: What's the difference?
Date: Sat, 16 Jun 2007 23:59:23 -0400
Message-ID: <20070617035923.GI7025@filer.fsl.cs.sunysb.edu>
References: <4671B96A.1080202@midwinter.com> <20070615030542.GA30110@diana.vm.bytemark.co.uk> <tnx1wgds1pv.fsf@arm.com> <20070615200139.GS6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Steven Grimm <koreth@midwinter.com>,
	"'git'" <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Jun 17 05:59:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzlvI-0007Oh-Ck
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 05:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758441AbXFQD7b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 23:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758679AbXFQD7b
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 23:59:31 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:59385 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758432AbXFQD7a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 23:59:30 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l5H3xO9b021720;
	Sat, 16 Jun 2007 23:59:24 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l5H3xNm6021718;
	Sat, 16 Jun 2007 23:59:23 -0400
Content-Disposition: inline
In-Reply-To: <20070615200139.GS6992@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50333>

On Fri, Jun 15, 2007 at 10:01:39PM +0200, Yann Dirson wrote:
> On Fri, Jun 15, 2007 at 03:59:24PM +0100, Catalin Marinas wrote:
...
> However, storing diffs is certainly a great way to interact with
> legacy SCMs, and there are situations where guilt is certainly more
> suited than stgit.  Eg, on a project where you have to use CVS, and
> you have to maintain changes to a Linux kernel, and you want to store
> the history of a series of patches, guilt will be much easier to use
> than stgit.

Then there is the psychological effect. If I have a directory full of
patch(1) compatible diff files, I can forget about guilt and just use the
diff files directly. With stgit's way of storing the patches, I'd assume
things can get a bit harder if you just want to give up on stgit.

Btw, does git-prune & friends do the right thing and not destroy the
patch-related objects?

...
> Well, people may not like python, but IMHO it is a lot easier to learn
> it if you don't know it (that's what I did, although I did not start
> from zero), than writing a robust and maintainable software of even
> moderate complexity in shell script.  Shell script may be good for
> prototyping or gluing tools in a simple way, but for advanced sofware
> on which to rely to store my own data, it is just not really suited.

So, why do you use git? ;)

Josef "Jeff" Sipek.

-- 
The box said "Windows XP or better required". So I installed Linux.
