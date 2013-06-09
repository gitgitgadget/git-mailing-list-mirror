From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 14:22:46 -0400
Message-ID: <20130609182246.GE810@sigill.intra.peff.net>
References: <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
 <CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
 <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
 <CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
 <CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
 <CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
 <20130609043444.GA561@sigill.intra.peff.net>
 <CALkWK0kkGO8zoLSpZkaYgVr5eBX6AovYFxQZkgJKugSw0CmdXQ@mail.gmail.com>
 <20130609175554.GA810@sigill.intra.peff.net>
 <CALkWK0n0kkNZo_Xt1oT5GL-TxZP0faDExxyH3vU-+hy4uEUEtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:22:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkGU-00006B-JB
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561Ab3FISWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:22:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:37332 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab3FISWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:22:50 -0400
Received: (qmail 19325 invoked by uid 102); 9 Jun 2013 18:23:40 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 13:23:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 14:22:46 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0n0kkNZo_Xt1oT5GL-TxZP0faDExxyH3vU-+hy4uEUEtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227085>

On Sun, Jun 09, 2013 at 11:36:42PM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > I already mentioned elsewhere that I think it would be fine to massage
> > libgit.a in that direction. I even joined the conversation pointing out
> > some cases where Felipe's ruby module would break. But I do not think
> > that moving code in and out of libgit.a is an important first step at
> > all. That is simply code that no library users would want to call, and
> > is easy to deal with: move it out. The hard part is code that users
> > _would_ want to call, and is totally broken. Patches dealing with that
> > are the hard obstacle that people working in this direction would need
> > to overcome. But I do not see any such patches under discussion.
> 
> Forget the rest; this makes it clear.  Thanks, and sorry for all the confusion.
> 
> So, reorganization is not the first step.  Can you please post an
> example patch illustrating what needs to be done, so we can follow?

Sorry, I don't have patches. It is a hard problem for which I do not
have the solution, which is kind of my point.

For the record, I am not _against_ any code organization that might be
useful for lib-ification later. I just do not see it as an interesting
step to be discussing if you want to know whether such a lib-ification
effort is feasible.

-Peff
