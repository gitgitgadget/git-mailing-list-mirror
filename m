From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/18] advice: Introduce error_resolve_conflict
Date: Fri, 22 Jul 2011 16:35:57 -0600
Message-ID: <20110722223555.GB19620@sigill.intra.peff.net>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
 <1311095876-3098-2-git-send-email-artagnon@gmail.com>
 <4E284750.4040104@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 00:36:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkOKN-0006cp-0e
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 00:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab1GVWgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 18:36:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43636
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab1GVWgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 18:36:09 -0400
Received: (qmail 24069 invoked by uid 107); 22 Jul 2011 22:36:38 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 18:36:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 16:35:57 -0600
Content-Disposition: inline
In-Reply-To: <4E284750.4040104@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177678>

On Thu, Jul 21, 2011 at 11:35:44AM -0400, Phil Hord wrote:

> >error: 'commit' is not possible because you have unmerged files.
> >hint: Please, fix them up in the work tree ...
> >hint: ...
> >fatal: Exiting because of an unresolved conflict.
> 
> This is a tiny grammar nit, but "Please," sounds superfluous now that
> it's preceded by "hint:".  "Hint" sounds like I'm doing you a favor
> by telling you something to do.  "Please" sounds like you're doing me
> a favor by doing something.  Together they just sound like a typo.

Agreed.

> In either case, the comma after "Please" is wrong.  (There are other
> messages in the git code which make this same mistake, but there are
> more which use "Please <imperative-verb>..." correctly.)

I don't know that I'd go so far as to say it's wrong, exactly. Clearly
by traditional rules of written grammar it is, but I think the attempt
was to convey the pause that one might include if one were speaking the
sentence.

Still, I think I find it more readable without the comma, and better
still if every spot were converted to "hint: ". This question has come
up once or twice before, too, so I don't know that a patch removing the
commas would be out of line.

-Peff
