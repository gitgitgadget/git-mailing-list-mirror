From: Pavel Roskin <proski@gnu.org>
Subject: Re: Some ideas for StGIT
Date: Mon, 06 Aug 2007 09:26:08 -0400
Message-ID: <1186406768.10627.50.camel@dv>
References: <1186163410.26110.55.camel@dv>
	 <20070803232351.GC30277@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0708060249h4a3f59bobfac8f9014aca82f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 15:26:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II2bZ-0002DO-Sh
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 15:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933399AbXHFN0Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 09:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933401AbXHFN0P
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 09:26:15 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:48861 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933399AbXHFN0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 09:26:13 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1II2dn-0007n0-05
	for git@vger.kernel.org; Mon, 06 Aug 2007 09:28:59 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1II2b3-00034q-5H; Mon, 06 Aug 2007 09:26:09 -0400
In-Reply-To: <b0943d9e0708060249h4a3f59bobfac8f9014aca82f@mail.gmail.com>
X-Mailer: Evolution 2.10.3 (2.10.3-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55147>

On Mon, 2007-08-06 at 10:49 +0100, Catalin Marinas wrote:

> The story for the 'new -s' option was that with StGIT (not possible
> with Quilt), one can start modifying the local tree and only create a
> patch afterwards.

And that's what I really like about StGIT.  I like that I can edit code
without worrying (too much) about the state of the repository.

> The newly created patch is always empty, even if
> there were local changes and showing them was useful for writing the
> patch description. One can use refresh for checking the changes in.
> Indeed, the 'new' command can be improved to have part of the
> 'refresh' functionality, though I don't really like this duplication.

It should be fine as long as the code is reused IMHO.

> > Especially confusing is that if there are already applied patches, the
> > diff shown is the one of the previous top patch
> 
> Are you sure it doesn't only show the local changes (which you might
> want to add in a new patch)?

I confirm this bug.

> I think we should put some default patch description.

I agree.  Sometimes it's too early to write a description.

-- 
Regards,
Pavel Roskin
