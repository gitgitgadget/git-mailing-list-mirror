From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Fix git-svn for SVN 1.7
Date: Wed, 1 Aug 2012 21:30:31 +0000
Message-ID: <20120801213031.GA10847@dcvr.yhbt.net>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120730203844.GA23892@dcvr.yhbt.net>
 <7v1ujsl8ut.fsf@alter.siamese.dyndns.org>
 <5017AB63.6080909@pobox.com>
 <20120731200108.GA14462@dcvr.yhbt.net>
 <5018691A.9050904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 23:30:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwgV3-0004zD-KO
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 23:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab2HAVac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 17:30:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49328 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755725Ab2HAVac (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 17:30:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DBD9325A5;
	Wed,  1 Aug 2012 21:30:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5018691A.9050904@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202726>

Michael G Schwern <schwern@pobox.com> wrote:
> That's the part that doesn't matter.  People matter.

> What I'm trying to say is I have much less interest in doing it without the
> overloading.  It's not interesting to me.  It's no fun.  No fun means no
> patch.  No patch means no improvement.  No improvement is the worst of all
> possible options.

We want to ensure the code you contribute can be improved by others, not
just you.  I thank you for your changes so far, other developers should
find it easier to contribute to git-svn.

> I had a lot of enthusiasm for this project when I came in.  I like refactoring
> Perl code.  I like git.  That's all but sunk at how painful and slow and
> nit-picking the process has been.  We've barely talked about the content of
> the patches I've submitted, it's all process.  This is no fun.

I haven't found objections to the actual code you've contributed so far.
I'll be applying your changes once I've had a chance to reread/test
them.

Yes, we are nitpicky about process, but I think it's important to
maintain that consistency given the number of contributors we attract.

I'll also need to review/rewrite some of the Subject: lines so they make
sense when read in --pretty=oneline/shortlog output. (unless you want to
volunteer to resubmit that).
