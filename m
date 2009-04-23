From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [doc] User Manual Suggestion
Date: Thu, 23 Apr 2009 13:57:17 -0400
Message-ID: <20090423175717.GA30198@fieldses.org>
References: <m24owgqy0j.fsf@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 19:58:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx3CG-0003ar-G7
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 19:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbZDWR5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 13:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbZDWR5T
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 13:57:19 -0400
Received: from mail.fieldses.org ([141.211.133.115]:52085 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZDWR5S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 13:57:18 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1Lx3Aj-00082j-KV; Thu, 23 Apr 2009 13:57:17 -0400
Content-Disposition: inline
In-Reply-To: <m24owgqy0j.fsf@boostpro.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117352>

On Wed, Apr 22, 2009 at 03:38:52PM -0400, David Abrahams wrote:
> 
> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#how-to-check-out
> covers "git reset" way too early, IMO, before one has the conceptual
> foundation necessary to understand what it means to "modify the current
> branch to point at v2.6.17".  If this operation must be covered this
> early in the manual, it should probably not be until
> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#manipulating-branches

I agree; we should suggest just a git-checkout (to a detached HEAD)
instead, though that needs a little explanation so people aren't scared
by the warning message it gives.

I also have a longstanding todo to experiment with rewriting the
beginning to use detached heads more and defer branch management till
later.

--b.
