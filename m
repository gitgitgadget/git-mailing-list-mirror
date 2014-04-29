From: Jeff King <peff@peff.net>
Subject: Re: Reference to a commit inside a commit message
Date: Mon, 28 Apr 2014 23:41:28 -0400
Message-ID: <20140429034128.GD11979@sigill.intra.peff.net>
References: <20140428183552.GA9709@workstation.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 05:41:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeyvJ-0006bY-70
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 05:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbaD2Dla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 23:41:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:40939 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751460AbaD2Dla (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 23:41:30 -0400
Received: (qmail 9397 invoked by uid 102); 29 Apr 2014 03:41:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 22:41:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 23:41:28 -0400
Content-Disposition: inline
In-Reply-To: <20140428183552.GA9709@workstation.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247516>

On Mon, Apr 28, 2014 at 08:35:52PM +0200, enzodicicco@gmail.com wrote:

> For example, thinking about it, I've imagined to add this feature to `git commit`:
> 
>     git commit --see-also <commit1> <commit2> ...

Jonathan mentioned already that we typically just do this by hand[1],
though look on the list for the "interpret-trailers" work being done by
Christian. It would make it very easy to add:

  See-also: ....

lines to the bottom of your commit using a command like the above. I
don't know if it would be easy to convert refnames into commit ids with
it or not. You'd have to look.

-Peff

[1] I do not know about others, but I typically cut and paste from
    another terminal, and use the following alias in my config:

      [alias]
      ll = "!git --no-pager log -1 --pretty='tformat:%h (%s, %ad)' --date=short"
