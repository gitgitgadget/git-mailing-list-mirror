From: Jeff King <peff@peff.net>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 05:24:51 -0400
Message-ID: <20070805092451.GB12507@coredump.intra.peff.net>
References: <854pjfin68.fsf@lola.goethe.zz> <85tzrfh3yg.fsf@lola.goethe.zz> <8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com> <85k5sbh129.fsf@lola.goethe.zz> <8c5c35580708040703w44781498t7396588a3f8c81c8@mail.gmail.com> <854pjfgzit.fsf@lola.goethe.zz> <85y7grfkbe.fsf@lola.goethe.zz> <8c5c35580708040735l54d1b9c7i40cd80d7d11e2961@mail.gmail.com> <85odhnfiau.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 11:25:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHcM3-0002q3-Sf
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 11:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbXHEJYx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 05:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbXHEJYx
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 05:24:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4035 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbXHEJYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 05:24:52 -0400
Received: (qmail 15266 invoked from network); 5 Aug 2007 09:24:56 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 09:24:56 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 05:24:51 -0400
Content-Disposition: inline
In-Reply-To: <85odhnfiau.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54970>

On Sat, Aug 04, 2007 at 05:09:13PM +0200, David Kastrup wrote:

> Ok, so a remote tracking branch is a forcefully merged branch, so we
> put it into a separate category where we won't get tempted to have a
> branch head which will get overwritten.

I would hesitate to use the word "merge" here at all. You really are
just throwing away the old value, and overwriting it with the new value.
See my other email for more details.

> This whole "remote tracking" appears to be more a matter of _policy_
> rather than inherent design.  It would appear that local and remote
> tracking branches have no fundamental differences, they just get
> different defaults which make it less likely for the first to lose
> local changes, and less likely for the second to miss remote changes
> (in particular where those involve messing up the history).

Yes, I think that's fair to say.

> But it would be easy to create chimeras when working outside of the
> porcelain, right?

Sure, but then you are responsible for the mess it creates. :)

-Peff
