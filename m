From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 14:49:43 -0400
Message-ID: <20130609184943.GH810@sigill.intra.peff.net>
References: <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
 <CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
 <CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
 <CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
 <20130609043444.GA561@sigill.intra.peff.net>
 <CALkWK0kkGO8zoLSpZkaYgVr5eBX6AovYFxQZkgJKugSw0CmdXQ@mail.gmail.com>
 <20130609175554.GA810@sigill.intra.peff.net>
 <CALkWK0n0kkNZo_Xt1oT5GL-TxZP0faDExxyH3vU-+hy4uEUEtQ@mail.gmail.com>
 <20130609182246.GE810@sigill.intra.peff.net>
 <CALkWK0nsJ5ds5v7auoqN7_vXhOoasJ3y99njZt5btPVqRCF2zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:49:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulkga-00006L-Hy
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab3FIStq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:49:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:37534 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3FIStq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:49:46 -0400
Received: (qmail 20806 invoked by uid 102); 9 Jun 2013 18:50:36 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 13:50:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 14:49:43 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0nsJ5ds5v7auoqN7_vXhOoasJ3y99njZt5btPVqRCF2zA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227096>

On Mon, Jun 10, 2013 at 12:14:36AM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > Sorry, I don't have patches. It is a hard problem for which I do not
> > have the solution, which is kind of my point.
> 
> So, what is the problem?  We are moving towards what we think is the
> way forward.  Nobody said that it is the theoretical best, but it's
> _much_ better than doing nothing, no?

I thought I already said: there is a lot of global state that is assumed
to be wiped between various functions and git commands. For example, you
cannot just call cmd_log twice in the same process and get the right
answers. I haven't seen a proposal for dealing with that.

> Then whom are we to ask about this feasibility?  All the core
> contributors (including Junio) are in the CC.  Nobody has said
> anything.  So, are you proposing that we sit and ponder over our
> theoretically-indeterminate-feasibility problem?  There is no magic
> bullet, Jeff.  We write code, and we fix bugs as and when they crop
> up; there's really not much else anyone can do.  Help by writing code,
> or reviewing someone else's code.

I mentioned a bug above. How are you going to fix it? Where is your
patch to review?

-Peff
