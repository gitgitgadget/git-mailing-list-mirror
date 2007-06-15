From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT vs. guilt: What's the difference?
Date: Fri, 15 Jun 2007 22:01:39 +0200
Message-ID: <20070615200139.GS6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <4671B96A.1080202@midwinter.com> <20070615030542.GA30110@diana.vm.bytemark.co.uk> <tnx1wgds1pv.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Steven Grimm <koreth@midwinter.com>,
	'git' <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 22:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzHzC-0008Q8-Dd
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 22:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbXFOUBd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 16:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753705AbXFOUBd
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 16:01:33 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45199 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbXFOUBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 16:01:32 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id EEFAF5A279;
	Fri, 15 Jun 2007 22:01:30 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 8EE311F158; Fri, 15 Jun 2007 22:01:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <tnx1wgds1pv.fsf@arm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50275>

On Fri, Jun 15, 2007 at 03:59:24PM +0100, Catalin Marinas wrote:
> I haven't tried quilt either but, if it uses plain text patches, the
> disadvantage might be the losing of the three-way merge when pushing a
> patch onto the stack. The solution is to remember which commit the
> patch applies to, switch the tree, apply the patch and merge with
> HEAD.

Note that I haven't tried guilt either.

However, storing diffs is certainly a great way to interact with
legacy SCMs, and there are situations where guilt is certainly more
suited than stgit.  Eg, on a project where you have to use CVS, and
you have to maintain changes to a Linux kernel, and you want to store
the history of a series of patches, guilt will be much easier to use
than stgit.

We may even want to implement something in stgit to ease such
integration with legacy SCMs - eg. an option to auto-export the stack
on push/refresh should not be too hard to implement.


> StGIT might have some more features as it is older but I see a lot of
> development is going on with guilt. Another difference is that StGIT
> is written in Python and guilt uses shell scripts (some people don't
> like the dependency on Python).

Well, people may not like python, but IMHO it is a lot easier to learn
it if you don't know it (that's what I did, although I did not start
from zero), than writing a robust and maintainable software of even
moderate complexity in shell script.  Shell script may be good for
prototyping or gluing tools in a simple way, but for advanced sofware
on which to rely to store my own data, it is just not really suited.

Best regards,
-- 
Yann
