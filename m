From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Mon, 1 Oct 2007 19:17:14 -0400
Message-ID: <20071001231714.GB5556@fieldses.org>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org> <7vejgeqxd1.fsf@gitster.siamese.dyndns.org> <87bqbisae6.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Barry Fishman <barry_fishman@acm.org>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 01:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcUW0-0006kV-5Y
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 01:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbXJAXRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 19:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbXJAXRT
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 19:17:19 -0400
Received: from mail.fieldses.org ([66.93.2.214]:35671 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbXJAXRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 19:17:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IcUVm-0001eT-TB; Mon, 01 Oct 2007 19:17:14 -0400
Content-Disposition: inline
In-Reply-To: <87bqbisae6.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59647>

On Mon, Oct 01, 2007 at 04:06:09PM -0700, Carl Worth wrote:
> Another example is "refs/heads". I avoided this partially by inly
> documenting how to push all branches with "--all", but I'd much rather
> be able to say that the user could git push URL branch
> another-branch..." or "git push URL --all" for convenience. Finally,
> git-push itself spews quite a bit of output with "refs/heads" in it
> that I don't think is useful at all. For talking with the user, git
> should say "branch master" not "refs/heads/master".

I'd be nervous about skipping discussion of the refs/ namespace.  Sure,
introduce branch heads and tags on their own first, but you've got to
mention the rest pretty early on.  Eventually anyone can find themselves
with a tags, heads, and remotes with the same names, and then it's easy
to get stuck if you don't have a way to disambiguate.

And, really, it doesn't take that much space to explain this stuff.

--b.
