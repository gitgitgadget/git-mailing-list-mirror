From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Sat, 26 Apr 2014 00:25:21 -0400
Message-ID: <20140426042521.GA5799@sigill.intra.peff.net>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com>
 <20140425231953.GB3855@sigill.intra.peff.net>
 <535b0db7e5e31_ba2148d310f4@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 06:25:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WduB7-0004YG-5B
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 06:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbaDZEZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 00:25:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:38827 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750729AbaDZEZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 00:25:23 -0400
Received: (qmail 20401 invoked by uid 102); 26 Apr 2014 04:25:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Apr 2014 23:25:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Apr 2014 00:25:21 -0400
Content-Disposition: inline
In-Reply-To: <535b0db7e5e31_ba2148d310f4@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247143>

On Fri, Apr 25, 2014 at 08:36:55PM -0500, Felipe Contreras wrote:

> > As for the patches themselves, I have not reviewed them carefully, and
> > would prefer not to. As I mentioned before, though, I would prefer the
> > short "@{p}" not be taken for @{publish} until it has proven itself.
> 
> Presumably you want to save it for @{push}. While I'm not against to having
> just @{publish} for now, I'm farily certain most people would be using
> @{publish} and not @{push}, as that's what `git branch -v` would show, and it
> would be closely similar to @{upstream}. Therefore it would make sense to use
> @{p} for @{publish}

No, I do not think it would be a good idea for @{push}, either. If we
have two concepts so similarly named (and especially if we add @{pull},
which has also been mentioned), then I think having @{p} just adds to
confusion. So I would much rather wait and see.  It is very easy to add
@{p} later, but it is very hard to take it back once used.

-Peff
