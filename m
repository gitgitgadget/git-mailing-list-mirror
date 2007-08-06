From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: Some ideas for StGIT
Date: Mon, 6 Aug 2007 11:19:21 -0400
Message-ID: <20070806151920.GA22508@filer.fsl.cs.sunysb.edu>
References: <1186163410.26110.55.camel@dv> <20070803232351.GC30277@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0708060249h4a3f59bobfac8f9014aca82f@mail.gmail.com> <1186406768.10627.50.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 17:19:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II4N1-0006sI-JA
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 17:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbXHFPTm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 11:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764392AbXHFPTm
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 11:19:42 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:43296 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762130AbXHFPTl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 11:19:41 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l76FJLb9023838;
	Mon, 6 Aug 2007 11:19:21 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l76FJLPX023836;
	Mon, 6 Aug 2007 11:19:21 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <1186406768.10627.50.camel@dv>
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55154>

<shameless plugs>

On Mon, Aug 06, 2007 at 09:26:08AM -0400, Pavel Roskin wrote:
> On Mon, 2007-08-06 at 10:49 +0100, Catalin Marinas wrote:
> 
> > The story for the 'new -s' option was that with StGIT (not possible
> > with Quilt), one can start modifying the local tree and only create a
> > patch afterwards.
> 
> And that's what I really like about StGIT.  I like that I can edit code
> without worrying (too much) about the state of the repository.
 
guilt-new -f <patchname>

> > The newly created patch is always empty, even if
> > there were local changes and showing them was useful for writing the
> > patch description. One can use refresh for checking the changes in.
> > Indeed, the 'new' command can be improved to have part of the
> > 'refresh' functionality, though I don't really like this duplication.
> 
> It should be fine as long as the code is reused IMHO.

Agreed.

> > I think we should put some default patch description.
> 
> I agree.  Sometimes it's too early to write a description.
 
If Guilt doesn't find a description in the patch file during push, it uses
"patch $patchname" as the commit message. This makes it enough of an
eye-sore that you notice before you submit the patches upstream :)

Josef 'Jeff' Sipek.

-- 
Failure is not an option,
It comes bundled with your Microsoft product.
