From: Jeff King <peff@peff.net>
Subject: Re: Test that every revision builds before pushing changes?
Date: Thu, 26 Mar 2009 05:49:00 -0400
Message-ID: <20090326094900.GC14292@coredump.intra.peff.net>
References: <87myb8aja1.fsf@rimspace.net> <49CB39E5.5060000@op5.se> <87ljqs7ioz.fsf@rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel Pittman <daniel@rimspace.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 10:51:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmmFP-00016S-4f
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756389AbZCZJtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 05:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbZCZJtO
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:49:14 -0400
Received: from peff.net ([208.65.91.99]:53160 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457AbZCZJtN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 05:49:13 -0400
Received: (qmail 13202 invoked by uid 107); 26 Mar 2009 09:49:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Mar 2009 05:49:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Mar 2009 05:49:00 -0400
Content-Disposition: inline
In-Reply-To: <87ljqs7ioz.fsf@rimspace.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114762>

On Thu, Mar 26, 2009 at 08:10:52PM +1100, Daniel Pittman wrote:

> For example, the responsible person for that testing could use the
> hypothetical (until someone tells me where to find it):
> 
>     git test public..test make test
> 
> Which would then effectively wrap:
> 
>     for each revision between public and private:
>          git checkout revision
>          make test
>          # report if that fails, allow fixing the commit or whatever
>          # then 'git test continue' to carry on...
> 
> That turn the process from a manual one to an automated one: it runs
> that command for every revision until it fails, or until they all pass.

I don't think such a script exists. There are continuous integration
systems that support git, but I don't know if they actually check every
commit.

-Peff
