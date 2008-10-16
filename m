From: Jeff King <peff@peff.net>
Subject: Re: [Q] "status" of files in (a part of) the working tree
Date: Thu, 16 Oct 2008 14:44:34 -0400
Message-ID: <20081016184434.GA14707@coredump.intra.peff.net>
References: <200810150953.42279.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 20:45:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqXr3-0001Ek-5w
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 20:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbYJPSoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 14:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753350AbYJPSoh
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 14:44:37 -0400
Received: from peff.net ([208.65.91.99]:4095 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985AbYJPSog (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 14:44:36 -0400
Received: (qmail 8989 invoked by uid 111); 16 Oct 2008 18:44:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 16 Oct 2008 14:44:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2008 14:44:34 -0400
Content-Disposition: inline
In-Reply-To: <200810150953.42279.brian.foster@innova-card.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98402>

On Wed, Oct 15, 2008 at 09:53:42AM +0200, Brian Foster wrote:

>  For every file in a directory of my working tree,
>  I want to obtain a quick "status" summary (ideally,
>  recursively, i.e. descending into each sub-directory):
>  E.g., not-tracked, latest modification is not in
>  the index, latest modification is in the index,
>  not-modified, and so on.  As a hypothetical example
>  (`# comments' added to explain what the line means):
> 
>     $ git some-cmd
>     ? foo      # not-tracked
>     - bar      # tracked, not-modified
>     M xyzzy    # tracked, last modification not-in-index
>     I plover   # tracked, last modification in-the-index
>      ...
>     $ 

Check out this thread:

  http://thread.gmane.org/gmane.comp.version-control.git/97830/focus=98041

Hopefully Shawn will unveil his tool soon, and I expect there may be
some discussion about the preferred format.

-Peff
