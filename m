From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Thu, 9 Jan 2014 17:03:51 -0500
Message-ID: <20140109220351.GD32069@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
 <20140108093716.GE15720@sigill.intra.peff.net>
 <02F63E901C46405BAAEEFBC48870A7C2@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Jan 09 23:04:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1NiN-0003Ve-3N
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 23:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757730AbaAIWD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 17:03:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:58036 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757692AbaAIWDx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 17:03:53 -0500
Received: (qmail 9336 invoked by uid 102); 9 Jan 2014 22:03:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jan 2014 16:03:53 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jan 2014 17:03:51 -0500
Content-Disposition: inline
In-Reply-To: <02F63E901C46405BAAEEFBC48870A7C2@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240278>

On Thu, Jan 09, 2014 at 08:39:44AM -0000, Philip Oakley wrote:

> From: "Jeff King" <peff@peff.net>
> Sent: Wednesday, January 08, 2014 9:37 AM
> >In a triangular workflow, you may have a distinct
> >@{upstream} that you pull changes from, but publish by
> >default (if you typed "git push") to a different remote (or
> >a different branch on the remote).
> 
> One of the broader issues is the lack of _documenation_ about what
> the 'normal' naming convention is for the uspstream remote.
> Especially the implicit convention used within our documentation (and
> workflow).
> 
> This is especially true for github users who will normally fork a
> repo of interest and then clone it from their own copy/fork. This
> means that the 'origin' remote is _not_ the upstream. See
> https://help.github.com/articles/fork-a-repo In my case 'origin' is
> my publish repo (as suggested by Github) while 'junio' is the
> upstream (as do some others). There are similar results from the
> likes of Stackoverflow.

Sure, and I have done the same thing (though I tend to clone from the
other person as "origin", and only fork my own repo when I am ready to
push). But it shouldn't matter, should it? The whole point of the
upstream config is that "git checkout -b topic junio/master" does the
right thing, without caring about your naming convention.

So I'm not sure what you think should be said (or where). Telling me in
patch form is preferred. :)

-Peff
