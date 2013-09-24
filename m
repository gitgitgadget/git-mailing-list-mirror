From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 00:53:25 -0400
Message-ID: <20130924045325.GD2766@sigill.intra.peff.net>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 06:53:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOKcv-0000CF-EL
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 06:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757Ab3IXEx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 00:53:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:52863 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab3IXEx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 00:53:29 -0400
Received: (qmail 30626 invoked by uid 102); 24 Sep 2013 04:53:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Sep 2013 23:53:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 00:53:25 -0400
Content-Disposition: inline
In-Reply-To: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235257>

On Sat, Sep 21, 2013 at 02:20:21PM -0500, Felipe Contreras wrote:

> For now simply add a few common aliases.
> 
>   co = checkout
>   ci = commit
>   rb = rebase
>   st = status

Are these the best definitions of those shortcuts? It seems[1] that some
people define "ci" as "commit -a", and some people define "st" as
"status -s" or even "status -sb".

You are making things more consistent for people who already define
those aliases in the same way (they are available everywhere, even if
they have not moved their config to a new installation), but less so for
people who define them differently. Rather than get an obvious:

  git: 'co' is not a git command. See 'git --help'.

the result will be subtly different (especially so in the case of
"commit" versus "commit -a").

-Peff

[1] https://github.com/search?q=%22ci+%3D+commit+-a%22+path%3A.gitconfig&type=Code

    https://github.com/search?q=%22st+%3D+status+-s%22&type=Code

    https://github.com/search?q=%22st+%3D+status+-sb%22&type=Code
