From: Jeff King <peff@peff.net>
Subject: Re: move files between disparate repos and maintain version history
Date: Tue, 3 Mar 2009 14:27:43 -0500
Message-ID: <20090303192743.GA3530@coredump.intra.peff.net>
References: <0d8965bb-e2ed-4f49-b323-c110f605ae2c@33g2000yqm.googlegroups.com> <20090303041300.GA18136@coredump.intra.peff.net> <f95d47890903030858xb398b5fy1aeabb19166e6077@mail.gmail.com> <20090303171835.GB454@coredump.intra.peff.net> <f95d47890903031008s36873f6ex94c7096f79cd6de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Copeland <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 20:29:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeaIn-0006BP-28
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbZCCT1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 14:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbZCCT1t
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:27:49 -0500
Received: from peff.net ([208.65.91.99]:54348 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324AbZCCT1s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 14:27:48 -0500
Received: (qmail 19464 invoked by uid 107); 3 Mar 2009 19:27:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 14:27:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 14:27:43 -0500
Content-Disposition: inline
In-Reply-To: <f95d47890903031008s36873f6ex94c7096f79cd6de@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112153>

On Tue, Mar 03, 2009 at 01:08:17PM -0500, David Copeland wrote:

> The patch file looks correct.  I'm wondering if this is a result of
> both repos being connected to svn?
> 
> my process was:
> 
> - format patch
> - go to other repo
> - git svn rebase
> - apply patch
> - git svn dcommit
> 
> Could dcommit change the dates since, to svn, they are appear as
> commits right now?

I know very little about git-svn. But you could test your theory by
checking the dates between the penultimate and ultimate steps.

-Peff
