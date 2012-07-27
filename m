From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/4] Move initialization of Git::SVN variables into
 Git::SVN.
Date: Fri, 27 Jul 2012 22:07:53 +0000
Message-ID: <20120727220753.GA7378@dcvr.yhbt.net>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-5-git-send-email-schwern@pobox.com>
 <7vhast3hpb.fsf@alter.siamese.dyndns.org>
 <20120727053800.GC4685@burratino>
 <7v394d3ffc.fsf@alter.siamese.dyndns.org>
 <7vpq7h1z1q.fsf@alter.siamese.dyndns.org>
 <7vlii51xz4.fsf@alter.siamese.dyndns.org>
 <20120727200703.GA2034@dcvr.yhbt.net>
 <7vsjcczxgu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 00:08:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Susi7-0001V2-8M
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 00:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375Ab2G0WHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 18:07:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33483 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882Ab2G0WHy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 18:07:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4B951F5B5;
	Fri, 27 Jul 2012 22:07:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vsjcczxgu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202383>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > I'll put the following after ms/makefile-pl but before ms/git-svn-pm:
> 
> OK, it seems that you haven't pushed out the result yet (which is
> fine); how do we want to proceed?

Oops, got sidetracked into something else.  Before I got sidetracked,
my application of another patch in Michael's 3rd series failed
(even with your updated Makefile patch):

  [PATCH 7/8] Extract Git::SVN::GlobSpec from git-svn

GlobSpec.pm did not get picked up and placed into blib/ and some tests
(t9118-git-svn-funky-branch-names.sh) failed as a result

So I'll hold off until we can fix the build regressions (working on it
now)
