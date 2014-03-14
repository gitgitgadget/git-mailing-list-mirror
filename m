From: Jeff King <peff@peff.net>
Subject: Re: GSoC proposal: port pack bitmap support to libgit2.
Date: Fri, 14 Mar 2014 00:34:04 -0400
Message-ID: <20140314043404.GD31906@sigill.intra.peff.net>
References: <CAGqt0zz1W1k92B+XRWEmMEv1=iyej+zi9QUCp2EhA=g+VnCt0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, tanoku@gmail.com
To: Yuxuan Shui <yshuiv7@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:34:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOJoz-0005mC-7R
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 05:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbaCNEeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 00:34:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:39238 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750709AbaCNEeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 00:34:07 -0400
Received: (qmail 1242 invoked by uid 102); 14 Mar 2014 04:34:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Mar 2014 23:34:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 00:34:04 -0400
Content-Disposition: inline
In-Reply-To: <CAGqt0zz1W1k92B+XRWEmMEv1=iyej+zi9QUCp2EhA=g+VnCt0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244075>

On Wed, Mar 12, 2014 at 04:19:23PM +0800, Yuxuan Shui wrote:

> I'm Yuxuan Shui, a undergraduate student from China. I'm applying for
> GSoC 2014, and here is my proposal:
> 
> I found this idea on the ideas page, and did some research about it.
> The pack bitmap patchset add a new .bitmap file for every pack file
> which contains the reachability information of selected commits. This
> information is used to speed up git fetching and cloning, and produce
> a very convincing results.
> 
> The goal of my project is to port the pack bitmap implementation in
> core git to libgit2, so users of libgit2 could benefit from this
> optimization as well.
> 
> Please let me know if my proposal makes sense, thanks.

You'd want to flesh it out a bit more to show how you're thinking about
tackling the problem:

  - What are the areas of libgit2 that you will need to touch? Be
    specific. What's the current state of the packing code? What
    files and functions will you need to touch?

  - What are the challenges you expect to encounter in porting the code?

  - Can you give a detailed schedule of the summer's work? What will you
    work on in each week? What milestones do you expect to hit, and
    when?

-Peff
