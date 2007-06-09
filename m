From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT PATCH 0/2] Fix issues with series deletion
Date: Sat, 9 Jun 2007 20:43:17 +0200
Message-ID: <20070609184317.GM6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070606205852.7657.69286.stgit@gandelf.nowhere.earth> <b0943d9e0706071450u1587d109x1e592bfa453c0c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 20:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5u8-0007hz-8x
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbXFISnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753919AbXFISnP
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:43:15 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58527 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621AbXFISnO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:43:14 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 152A35A166;
	Sat,  9 Jun 2007 20:43:13 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id CD21F1F157; Sat,  9 Jun 2007 20:43:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0706071450u1587d109x1e592bfa453c0c0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49605>

On Thu, Jun 07, 2007 at 10:50:00PM +0100, Catalin Marinas wrote:
> On 06/06/07, Yann Dirson <ydirson@altern.org> wrote:
> >I am however not happy at all with the way we delete patches and
> >series, starting with an existence check and then deleting.  If any
> >error occurs midway, then we are left with an inconsistent state that
> >the user has to cleanup by hand.  IMHO, we should have those methods
> >be as robust as possible, maybe starting by removing the formatversion
> >item, and printing a "cleaning up zombie stack" if does not find it.
> >So at least after fixing a "delete" bug, we could rerun the same
> >command and get to a sane state again.
> 
> This sounds OK for a quick fix. Longer term, I think we should support
> some kind of transactions. One idea is to put the StGIT metadata in a
> single file (or maybe two if we include the config) that gets checked
> in after every operation.

Speaking of transactions, did you have a chance to read the proposal I
posted some time ago ?  As stated in another mail, I fear that
approach does generalize easily to core git - but for lack of a better
solution, we may want to go this way anyway...

Best regards,
-- 
Yann
