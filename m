From: chris <jugg@hotmail.com>
Subject: Re: error with $ git push origin HEAD:newbranch
Date: Thu, 5 May 2011 10:06:21 +0000 (UTC)
Message-ID: <loom.20110505T114511-660@post.gmane.org>
References: <loom.20110505T103708-225@post.gmane.org> <20110505093752.GB29595@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 12:06:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHvSC-0003Pp-Vd
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 12:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496Ab1EEKGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 06:06:35 -0400
Received: from lo.gmane.org ([80.91.229.12]:56248 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424Ab1EEKGf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 06:06:35 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QHvS5-0003N1-F7
	for git@vger.kernel.org; Thu, 05 May 2011 12:06:33 +0200
Received: from 114-38-73-8.dynamic.hinet.net ([114.38.73.8])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 May 2011 12:06:33 +0200
Received: from jugg by 114-38-73-8.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 May 2011 12:06:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 114.38.73.8 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.24 (KHTML, like Gecko) Ubuntu/10.04 Chromium/11.0.696.57 Chrome/11.0.696.57 Safari/534.24)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172825>

Jeff King <peff <at> peff.net> writes:
> On Thu, May 05, 2011 at 08:47:39AM +0000, chris wrote:
> 
> > $ git push origin HEAD:newbranch
> > error: unable to push to unqualified destination: newbranch
> > The destination refspec neither matches an existing ref on the remote nor
> > begins with refs/, and we are unable to guess a prefix based on the source 
ref.
> > error: failed to push some refs to 'ssh://example.com/srv/git/project.git'
> > 
... 
> However, you may see that message if you are on a detached head instead
> of a branch. Might that be the case here?

Yes, indeed.  I suppose it must be the situation that I've never done that
before then.  While I certainly I have pushed a detached head before, it must 
have always been to an existing branch.

Thanks for clarifying this.

It is slightly surprising that git-push doesn't default to assuming one means 
refs/heads/newbranch in this case.  I don't see a reason not to?

chris
